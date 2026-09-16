local synced_jobs_file = (os.getenv("HOME") or "") .. "/.synced_jobs"

local function synced_job_count()
	local file = io.open(synced_jobs_file, "r")
	if not file then
		return 0
	end

	local count = 0
	for line in file:lines() do
		if line:match("%S") then
			count = count + 1
		end
	end
	file:close()
	return count
end

Status:children_add(function()
	local count = synced_job_count()
	if count == 0 then
		return ""
	end

	local label = count == 1 and " job " or " jobs "
	return ui.Line(ui.Span(" 💼 " .. count .. label):fg("#a6e3a1"):bold())
end, 500, Status.RIGHT)
