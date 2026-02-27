-- patto.yazi -- yazi previewer plugin for .pn (patto note) files.
--
-- Renders patto notes using `patto-cli-renderer` with ANSI colour output.
--
-- Installation:
--   cp -r patto.yazi ~/.config/yazi/plugins/
--
-- Then add to ~/.config/yazi/yazi.toml:
--   [plugin]
--   prepend_previewers = [
--     { url = "*.pn", run = "patto" },
--   ]

--- @since 26.1.22

local M = {}

-- Resolve patto-cli-renderer: probe $HOME/.cargo/bin as fallback for shells
-- where yazi does not inherit the full user PATH.
local function renderer_cmd()
	local home = os.getenv("HOME") or ""
	local cargo_bin = home .. "/.cargo/bin/patto-cli-renderer"
	local f = io.open(cargo_bin, "r")
	if f then
		f:close()
		return cargo_bin
	end
	return "patto-cli-renderer"
end

local CMD = renderer_cmd()

function M:peek(job)
	local child = Command(CMD)
		:arg({ tostring(job.file.path), "--width", tostring(job.area.w) })
		:stdout(Command.PIPED)
		:stderr(Command.NULL)
		:spawn()

	if not child then
		return require("code"):peek(job)
	end

	local limit = job.area.h
	local i, lines = 0, ""
	repeat
		local line, event = child:read_line()
		if event ~= 0 then
			break
		end
		i = i + 1
		if i > job.skip then
			lines = lines .. line
		end
	until i >= job.skip + limit

	child:start_kill()

	if job.skip > 0 and i < job.skip + limit then
		ya.emit("peek", { math.max(0, i - limit), only_if = job.file.url, upper_bound = true })
	else
		ya.preview_widget(job, ui.Text.parse(lines):area(job.area))
	end
end

function M:seek(job)
	local h = cx.active.current.hovered
	if not h or h.url ~= job.file.url then
		return
	end
	ya.emit("peek", {
		math.max(0, cx.active.preview.skip + job.units),
		only_if = job.file.url,
	})
end

return M
