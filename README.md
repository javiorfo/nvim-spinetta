# nvim-spinetta
*nvim-spinetta is a Neovim plugin written in Lua for using a spinner during a job process.*

## Caveats
- This plugin has been developed on and for Linux following open source philosophy.

## Installation
`Vim Plug`
```vim
Plug 'javiorfo/nvim-spinetta'
```
`Packer`
```lua
use 'javiorfo/nvim-spinetta'
```

## Overview
| Feature | nvim-spinetta | NOTE |
| ------- | ------------- | ---- |
| Spinners | :heavy_check_mark: | Includes 6 spinners |
| Set your own spinner | :heavy_check_mark: |  |
| Set a job | :heavy_check_mark: |  |
| Set a another process not only a job | :heavy_check_mark: |  |
| **start** function | :heavy_check_mark: | Several overloads |
| On success option | :heavy_check_mark: | By the user |
| On interruption option | :heavy_check_mark: | By the user or by an internal error |

## Usage
- By default the values by parameters are:
```lua
{
    spinner = DEFAULT_SPINNER, -- List of figures to use in the spinner
    speed_ms = 200,            -- Speed of the spinner in miliseconds
    main_msg = "",             -- Initial message in spinner
    on_success = nil,          -- Function to implement when the job is finished
    on_interrupted = nil       -- Function to implement when the job is interrupted
}
```

- First, create a instance:
```lua
    local spinetta = require'spinetta'
    local my_spinner = spinetta:new()
```

- Second, start the spinner and the job:
```lua
    local my_job = "curl https://host/path" -- This is ilustrative, change it by your job to run
    my_spinner:start(spinetta.job_to_run(my_job))
```

#### SPINNERS
- Check the spinners availables in [this file](https://github.com/javiorfo/nvim-spinetta/blob/master/lua/spinetta/spinners.lua)
- You can add your own spinner if you like. Further information in `:help spinetta`

## Screenshots
#### Examples of the differents spinners included in this plugin. Run `:luafile %` in [this file](https://github.com/javiorfo/nvim-spinetta/blob/master/tests/test_spinners.lua)

<img src="https://github.com/javiorfo/img/blob/master/nvim-spinetta/spinetta.gif?raw=true" alt="spinetta" style="width:500px;"/>

#### Examples of interruption message included in this plugin. Run `:luafile %` and interrupt the process with `Ctrl-C` in [this file](https://github.com/javiorfo/nvim-spinetta/blob/master/tests/test_interruption.lua)
<img src="https://github.com/javiorfo/img/blob/master/nvim-spinetta/interrupt.gif?raw=true" alt="spinetta" style="width:500px;"/>

**NOTE:** The colorscheme **smoky** from [nvim-whisky](https://github.com/javiorfo/nvim-whisky) is used in this image.
