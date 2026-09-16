--- @since 26.9.1

local hovered_path = ya.sync(function()
	local hovered = cx.active.current.hovered
	if not hovered or hovered.cha.is_dir then
		return nil
	end
	return tostring(hovered.url)
end)

local current_directory = ya.sync(function()
	return tostring(cx.active.current.cwd)
end)

local function notify(message, level)
	ya.notify({
		title = "Gedent",
		content = message,
		level = level or "warn",
		timeout = 5,
	})
end

local function generate_input()
	local target = hovered_path()
	if not target then
		notify("Hover an XYZ file first")
		return
	end

	if not target:lower():match("%.xyz$") then
		notify("Gedent input generation expects an .xyz file")
		return
	end

	local script = [=[
set -o pipefail

template_root="${XDG_CONFIG_HOME:-$HOME/.config}/gedent/templates"
if [[ ! -d "$template_root" ]]; then
	printf 'Gedent template directory not found: %s\n' "$template_root" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit 1
fi

mapfile -t templates < <(find "$template_root" -mindepth 2 -maxdepth 2 -type f -printf '%P\n' | sort)
if (( ${#templates[@]} == 0 )); then
	printf 'No Gedent templates found in %s\n' "$template_root" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit 1
fi

choices=()
for template in "${templates[@]}"; do
	name="${template##*/}"
	count=0
	for candidate in "${templates[@]}"; do
		[[ "${candidate##*/}" == "$name" ]] && ((count += 1))
	done
	if (( count == 1 )); then
		choices+=("$name")
	else
		choices+=("$template")
	fi
done

template=$(printf '%s\n' "${choices[@]}" | fzf \
	--prompt='Gedent template > ' \
	--layout=reverse \
	--border \
	--preview='gedent template print {} 2>&1' \
	--preview-window='right,60%,wrap') || exit 0

[[ -n "$template" ]] || exit 0
if gedent gen "$template" "$target"; then
	:
else
	status=$?
	printf '\nGedent failed (exit %d).\n' "$status" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit "$status"
fi
]=]

	script = "target=" .. ya.quote(target) .. "\n" .. script
	local permit = ui.hide()
	local status, err = Command("bash")
		:arg({ "-c", script })
		:stdin(Command.INHERIT)
		:stdout(Command.INHERIT)
		:stderr(Command.INHERIT)
		:status()
	permit:drop()

	if not status then
		notify("Could not run the template picker: " .. tostring(err), "error")
	elseif not status.success and status.code ~= 130 then
		notify("Gedent exited with status " .. tostring(status.code), "error")
	end
	ya.emit("refresh", {})
end

local function initialize_project()
	local cwd = current_directory()
	local script = [=[
set -o pipefail

global_config="${XDG_CONFIG_HOME:-$HOME/.config}/gedent/gedent.toml"
if [[ ! -f "$global_config" ]]; then
	printf 'Gedent global config not found: %s\n' "$global_config" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit 1
fi

if [[ -e gedent.toml ]]; then
	printf 'gedent.toml already exists in %s\n' "$PWD" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit 1
fi

mapfile -t parameters < <(
	awk '
		/^\[parameters\][[:space:]]*$/ { inside = 1; next }
		/^\[/ { if (inside) exit }
		inside && /^[[:space:]]*[A-Za-z0-9_-]+[[:space:]]*=/ {
			sub(/^[[:space:]]*/, "")
			print
		}
	' "$global_config"
)

if (( ${#parameters[@]} == 0 )); then
	printf 'No assignments found under [parameters] in %s\n' "$global_config" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit 1
fi

selected=$(printf '%s\n' "${parameters[@]}" | fzf \
	--multi \
	--prompt='Gedent parameters > ' \
	--layout=reverse \
	--border \
	--header='Tab: toggle  Ctrl-A: all  Ctrl-D: none  Enter: create' \
	--bind='ctrl-a:select-all,ctrl-d:deselect-all') || exit 0

[[ -n "$selected" ]] || exit 0
if ! gedent init; then
	read -r -p 'Press Enter to return to Yazi...'
	exit 1
fi

printf '%s\n' "$selected" >> gedent.toml

editor="${VISUAL:-${EDITOR:-vi}}"
eval "$editor \"\$PWD/gedent.toml\""
]=]

	local permit = ui.hide()
	local status, err = Command("bash")
		:arg({ "-c", script })
		:cwd(cwd)
		:stdin(Command.INHERIT)
		:stdout(Command.INHERIT)
		:stderr(Command.INHERIT)
		:status()
	permit:drop()

	if not status then
		notify("Could not initialize the project: " .. tostring(err), "error")
	elseif not status.success and status.code ~= 130 then
		notify("Initializer exited with status " .. tostring(status.code), "error")
	end
	ya.emit("refresh", {})
end

return {
	entry = function(_, job)
		if job.args[1] == "init" then
			initialize_project()
		else
			generate_input()
		end
	end,
}
