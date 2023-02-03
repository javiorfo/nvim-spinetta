-- ########################################################
-- # Maintainer:  Javier Orfo                             #
-- # URL:         https://github.com/javio7/nvim-spinetta #
-- ########################################################

local logger = require'spinetta.logger'
local spinners = require'spinetta.spinners'

local M = {
    DEFAULT_SPINNER      = spinners.DEFAULT_SPINNER,
    ARROW_SPINNER        = spinners.ARROW_SPINNER,
    EQUALS_SPINNER       = spinners.EQUALS_SPINNER,
    PING_PONG_SPINNER    = spinners.PING_PONG_SPINNER,
    POINT_SPINNER        = spinners.POINT_SPINNER,
    PROGRESS_BAR_SPINNER = spinners.PROGRESS_BAR_SPINNER
}

function M:new(values, fn_to_stop_spinner)
    if not fn_to_stop_spinner then
        logger:new("Spinner"):error("A function is required as second parameter to stop the spinner.")
        return
    end

    local table = {}
    self.__index = self
    table.values = values
    table.fn_to_stop_spinner = fn_to_stop_spinner
    setmetatable(table, self)
    return table
end

function M:get_sleep_ms()
    return self.values.sleep_ms
end

function M:get_starting_msg()
    return self.values.starting_msg
end

function M:get_spinner()
    return self.values.spinner
end

function M:start()
    local sleep_ms = self.values.sleep_ms or 200
    local starting_msg = self.values.starting_msg or ""
    local spinner = self.values.spinner or M.DEFAULT_SPINNER
    local internal_logger = logger:new()

    local index = 1
    local is_interrupted = false
    while true do
        local _, error = pcall(function()
            internal_logger:info(starting_msg .. spinner[index])
            if index < #spinner then
                index = index + 1
            else
                index = 1
            end

            vim.cmd(string.format("sleep %dms", sleep_ms))
            vim.cmd("redraw")
        end)

        if self.fn_to_stop_spinner() or error then
            if error then is_interrupted = true end
            break
        end
    end
    return is_interrupted
end

function M.break_when_pid_is_complete(pid)
    return function()
        local job_status = string.format("[ -f '/proc/%d/status' ] && echo 1 || echo 0", pid)
        return tonumber(vim.fn.system(job_status)) == 0
    end
end

function M.job_to_run(job_string)
    local pid = vim.fn.jobpid(vim.fn.jobstart(job_string))
    return M.break_when_pid_is_complete(pid)
end

return M

