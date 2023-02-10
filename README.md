# nvim-spinetta
### :tornado: spinning...
*nvim-spinetta is a Neovim plugin written in Lua for using a spinner during a job process.*

## Caveats
- This plugin has been developed on and for Linux following open source philosophy.

## Installation
`Vim Plug`
```vim
Plug 'javio7/nvim-spinetta'
```
`Packer`
```lua
use 'javio7/nvim-spinetta'
```

## Overview
- Includes 6 spinners (It's possible to set your own)
- In **start** function you can construct it three different ways
- Open to apply not only for a job
- Interruption option is available

## Usage
- By default the values by parameters are:
```lua
{
    spinner = DEFAULT_SPINNER, -- List of figures to use in the spinner
    speed_ms = 200,            -- Speed of the spinner in miliseconds
    main_msg = "",             -- Initial message in spinner
    final_mst = nil,           -- Message when the job is finished
    interrupted_msg = nil      -- Message when the job is interrupted
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
- Check the spinners availables in [this file](https://github.com/javio7/nvim-spinetta/blob/master/lua/spinetta/spinners.lua)
- You can add your own spinner if you like. Further information in `:help spinetta`

## Screenshots
#### Examples of the differents spinners included in this plugin. Run `:luafile %` in [this file](https://github.com/javio7/nvim-spinetta/blob/master/tests/test_spinners.lua)

<img src="https://github.com/javio7/img/blob/master/nvim-spinetta/spinetta-spinners.gif?raw=true" alt="spinetta" style="width:800px;"/>

#### Examples of interruption message included in this plugin. Run `:luafile %` and interrupt the process with `Ctrl-C` in [this file](https://github.com/javio7/nvim-spinetta/blob/master/tests/test_interruption.lua)
<img src="https://github.com/javio7/img/blob/master/nvim-spinetta/spinetta-interrupt.gif?raw=true" alt="spinetta" style="width:800px;"/>

**NOTE:** The colorscheme **umbra** from [nvim-nyctovim](https://github.com/javio7/nvim-nyctovim) is used in this image.

## Support
- [Paypal](https://www.paypal.com/donate/?hosted_button_id=DT5ZGHRJKYJ8C)
