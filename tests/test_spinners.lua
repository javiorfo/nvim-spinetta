-- ###########################################################
-- # Maintainer: System Malt                                 #
-- # URL:        https://github.com/systemmalt/nvim-spinetta #
-- ###########################################################

local spinetta = require'spinetta'

-- To simulate a process that takes 3 seconds
local my_job = "sleep 3"

-- To test a real case with a curl command
-- local my_job = "curl https://httpbin.org/get"

-- Default values are { main_msg = "", final_msg = nil, interruptec_msg = nil, spinner = spinetta.DEFAULT_SPINNER, speed_ms = 200}
local spinetta_default = spinetta:new()
spinetta_default:start(spinetta.job_to_run(my_job))


-- Values speed_ms, spinner, main_msg and final_msg set by parameters
local spinetta_arrow = spinetta:new {
    speed_ms = 400,
    spinner = spinetta.ARROW_SPINNER,
    main_msg = "Arrows ",
    on_success = function()
        print("Arrows finished!")
    end
}
spinetta_arrow:start(spinetta.job_to_run(my_job))


--Values speed_ms, spinner and final_msg set by parameters
local spinetta_equals = spinetta:new {
    speed_ms = 100,
    spinner = spinetta.EQUALS_SPINNER,
    final_msg = "Equals finished!"
}
-- This is optional to use spinetta.jab_tu_run(my_job) which has this line implicit
local pid = vim.fn.jobpid(vim.fn.jobstart(my_job))
spinetta_equals:start(spinetta.break_when_pid_is_complete(pid))


-- Values spinner and speed_ms set by parameters
local spinetta_ping_pong = spinetta:new {
    spinner = spinetta.PING_PONG_SPINNER,
    speed_ms = 50
}
local pid2 = vim.fn.jobpid(vim.fn.jobstart(my_job))
-- This is optional to use spinetta.jab_tu_run(pid) or spinetta.break_when_pid_is_complete(pid) which has this line implicit
-- If a function is passed to 'start' it has to be a function that return a boolean value to break the spinner process
-- like this:
spinetta_ping_pong:start(function()
    local job_status = string.format("[ -f '/proc/%d/status' ] && echo 1 || echo 0", pid2)
    return tonumber(vim.fn.system(job_status)) == 0
end)


-- Values spinner, main_msg, final_msg and interrupted_msg are set by parameters
local spinetta_bar = spinetta:new {
    spinner = spinetta.PROGRESS_BAR_SPINNER,
    on_success = function()
        print("Done!")
    end,
    main_msg = "Loading ",
    on_interrupted = function()
        vim.cmd("redraw")
        print("Interrupted!")
    end
}
spinetta_bar:start(spinetta.job_to_run(my_job))
