-- ##########################################################
-- # Maintainer: Mr. Charkuils                              #
-- # URL:        https://github.com/charkuils/nvim-spinetta #
-- ##########################################################

-- NOTE: To interrupt the job being executed, press Ctrl-C

local spinetta = require'spinetta'

-- To simulate a process that takes 5 seconds
local my_job = "sleep 5"

-- Create spinner with values
local spinetta_default = spinetta:new {
    main_msg = "Job working ",
    on_success = function()
        print("Job finished!")
    end,
    on_interrupted = function()
        vim.cmd("redraw")
        print("Job interrupted by user")
    end
}

-- Run job and spinner
spinetta_default:start(spinetta.job_to_run(my_job))

