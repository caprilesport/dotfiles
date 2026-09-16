--- @since 26.9.1

local hovered_path = ya.sync(function()
	local hovered = cx.active.current.hovered
	if not hovered or hovered.cha.is_dir then
		return nil
	end
	return tostring(hovered.url)
end)

local function notify(message, level)
	ya.notify({
		title = "Q-Chem jobs",
		content = message,
		level = level or "warn",
		timeout = 6,
	})
end

local function validate_input()
	local target = hovered_path()
	if not target then
		notify("Hover an ORCA input file first")
		return nil
	end

	if not target:lower():match("%.inp$") then
		notify("Job submission expects an .inp file")
		return nil
	end
	return target
end

local function submit_local()
	local target = validate_input()
	if not target then
		return
	end

	local parent = target:match("^(.*)/[^/]+$") or "."
	local filename = target:match("([^/]+)$") or target
	local output, err = Command("pueue")
		:arg({ "add", "--", "job", filename })
		:cwd(parent)
		:output()

	if not output then
		notify("Could not start pueue: " .. tostring(err), "error")
	elseif not output.status.success then
		local message = output.stderr:gsub("%s+$", "")
		notify(message ~= "" and message or "pueue add failed", "error")
	else
		local message = output.stdout:gsub("%s+$", "")
		notify(message ~= "" and message or "Local job added to Pueue", "info")
	end
end

local function submit_jupiter()
	local target = validate_input()
	if not target then
		return
	end

	local parent = target:match("^(.*)/[^/]+$") or "."
	local script = "set -o pipefail\n"
		.. "target=" .. ya.quote(target) .. "\n"
		.. [=[
if qprep "$target" -r jupiter | bash; then
	printf '\nSubmitted %s to Jupiter.\n' "$target"
	read -r -p 'Press Enter to return to Yazi...'
else
	status=$?
	printf '\nSubmission failed (exit %d).\n' "$status" >&2
	read -r -p 'Press Enter to return to Yazi...'
	exit "$status"
fi
]=]

	local permit = ui.hide()
	local status, err = Command("bash")
		:arg({ "-c", script })
		:cwd(parent)
		:stdin(Command.INHERIT)
		:stdout(Command.INHERIT)
		:stderr(Command.INHERIT)
		:status()
	permit:drop()

	if not status then
		notify("Could not start qprep: " .. tostring(err), "error")
	elseif not status.success then
		notify("Submission exited with status " .. tostring(status.code), "error")
	else
		notify("Job submitted to Jupiter", "info")
	end
	ya.emit("refresh", {})
end

local function fetch_jobs()
	local script = [=[
recli fetch
status=$?
printf '\n'
read -r -p 'Press Enter to return to Yazi...'
exit "$status"
]=]

	local permit = ui.hide()
	local status, err = Command("bash")
		:arg({ "-c", script })
		:stdin(Command.INHERIT)
		:stdout(Command.INHERIT)
		:stderr(Command.INHERIT)
		:status()
	permit:drop()

	if not status then
		notify("Could not start recli fetch: " .. tostring(err), "error")
	elseif not status.success then
		notify("Recli fetch exited with status " .. tostring(status.code), "error")
	else
		notify("Recli job statuses updated", "info")
	end
end

local function next_job()
	local output, err = Command("next-job")
		:arg("next")
		:output()

	if not output then
		notify("Could not start next-job: " .. tostring(err), "error")
		return
	end

	local detail = output.stderr
		:gsub("\27%[[0-9;]*m", "")
		:gsub("%s+$", "")
	if not output.status.success then
		notify(detail ~= "" and detail or "No synced jobs are waiting", "warn")
		return
	end

	local directory = output.stdout:gsub("%s+$", "")
	if directory == "" then
		notify("next-job returned no working directory", "error")
		return
	end

	if detail ~= "" then
		notify(detail, "info")
	else
		notify("Opened the next synced job", "info")
	end
	ya.emit("cd", { directory })
end

return {
	entry = function(_, job)
		if job.args[1] == "next" then
			next_job()
		elseif job.args[1] == "fetch" then
			fetch_jobs()
		elseif job.args[1] == "local" then
			submit_local()
		else
			submit_jupiter()
		end
	end,
}
