-- ##########################################################
-- # Maintainer: Javier Orfo                                #
-- # URL:        https://github.com/whiskoder/nvim-spinetta #
-- ##########################################################

local logger = require'spinetta.logger'
local spinners = require'spinetta.spinners'
local Logger = logger:new("Spinetta")

local M = {
    DEFAULT_SPINNER      = spinners.DEFAULT_SPINNER,
    ARROW_SPINNER        = spinners.ARROW_SPINNER,
    EQUALS_SPINNER       = spinners.EQUALS_SPINNER,
    PING_PONG_SPINNER    = spinners.PING_PONG_SPINNER,
    POINT_SPINNER        = spinners.POINT_SPINNER,
    PROGRESS_BAR_SPINNER = spinners.PROGRESS_BAR_SPINNER
}

function M:new(params)
    local table = {}
    self.__index = self
    table = params or {}
    setmetatable(table, self)
    return table
end

function M:get_speed_ms()
    return self.speed_ms
end

function M:get_main_msg()
    return self.main_msg
end

function M:get_spinner()
    return self.spinner
end

-- Function to start the spinner
-- @param a function to check the state of a job
-- @return a boolean that represents if the job was interrupted
function M:start(fn_to_stop_spinner)
    if not fn_to_stop_spinner then
        Logger:error("A function is required as parameter to stop the spinner.")
        return
    end

    local speed_ms = self.speed_ms or 200
    local main_msg = self.main_msg or ""
    local spinner = self.spinner or spinners.DEFAULT_SPINNER
    local internal_logger = logger:new()

    local index = 1
    while true do
        local _, error = pcall(function()
            internal_logger:info(main_msg .. spinner[index])
            if index < #spinner then
                index = index + 1
            else
                index = 1
            end

            vim.cmd(string.format("sleep %dms", speed_ms))
            vim.cmd("redraw")
        end)

        if fn_to_stop_spinner() or error then
            if error then
                if self.on_interrupted then
                    self.on_interrupted()
                end
            else
                if self.on_success then
                    self.on_success()
                end
            end
            break
        end
    end
end

-- Function to check the state of a job
-- @param a number of a job pid. Ex: 8843 
-- @return a boolean value representing the active state of the job
function M.break_when_pid_is_complete(pid)
    return function()
        local job_status = string.format("[ -f '/proc/%d/status' ] && echo 1 || echo 0", pid)
        return tonumber(vim.fn.system(job_status)) == 0
    end
end

-- Function to run a job
-- @param a string of a job. Ex: "curl https://host/get"
-- @return a function
function M.job_to_run(job_string)
    local pid = vim.fn.jobpid(vim.fn.jobstart(job_string))
    return M.break_when_pid_is_complete(pid)
end

return M

