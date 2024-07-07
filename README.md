# DevTools Neovim Plugin

## Overview

The `devtools` plugin enhances Neovim with utilities for various development tasks, including JSON parsing, IP address fetching, and more.

## Features

- **JSON Parsing:** Convert selected JSON text into a JSON object and replace it in the buffer.
- **IP Address Fetching:** Fetch your public IP address using the `curl` command and display it in Neovim.

## Installation

Install the `devtools` plugin using your favorite plugin manager:

```lua
" Using lazy.nvim
return {
  "muhfaris/devtools.nvim",
  opts =  {}
}
```

## Usage

### Customize key mappings

Using lazy.nvim

```lua
return {
  "muhfaris/devtools.nvim",
  opts = function()
    local actions = require "devtools.actions"
    return {
      mappings = {
        v = {
          ["<Leader>jp"] = {
            func = actions.json.parse.func,
            desc = "Parse json string from selection visual text",
          },
        },
        n = {
          ["<Leader>mip"] = {
            func = actions.net.my_ip.func,
            desc = "Get my public IP address",
          },
        },
      },
    }
  end,
,
}
```

### Default Key Mappings

- **`<Leader>jp`:** JSON Parse
- **`<Leader>mip`:** My Public IP

## Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests [here](https://github.com/username/devtools).

## License

This plugin is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
