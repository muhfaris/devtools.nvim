# DevTools Neovim Plugin

## Overview

The plugin [muhfaris/devtools.nvim](https://github.com/muhfaris/devtools.nvim) is in active development. The purpose of this plugin is to be swiss army knife for developers.

## Features

- Configurable key mappings
- Eased automatic word wrapping and custom file type
- Parse and escape JSON
- Fetch my public IP address
- Encode and decode base64

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
}
```

### Custom automatic word wrapping

```lua
return {
  "muhfaris/devtools.nvim",
  opts = function()
    return {
      word_wrap= {
        markdown = {
          wrap = true,
          textwidth = 30,
          linebreak = true,
        },
      },
    }
  end,
}
```

### Custom automatic word wrapping with custom file type

```lua
return {
  "muhfaris/devtools.nvim",
  opts = function()
    return {
      word_wrap = {
        markdown = {
          wrap = true,
          textwidth = 30,
          linebreak = true,
        },
        tpl = {
          wrap = true,
          textwidth = 30,
          linebreak = true,
          pattern = "*.tpl,*.tmpl",
        },
      },
    }
  end,
}
```

### Default Key Mappings

| Mode | Key         | Function                                     | Description                                |
| ---- | ----------- | -------------------------------------------- | ------------------------------------------ |
| `v`  | <Leader>jp  | `devtools.actions.json.parse.func`           | Parse escaped json string into json object |
| `v`  | <Leader>je  | `devtools.actions.json.escape.func`          | Parse json object into escaped json string |
| `v`  | <Leader>be  | `devtools.actions.encode.base64_encode.func` | Encode base64 string                       |
| `v`  | <Leader>bd  | `devtools.actions.encode.base64_decode.func` | Decode base64 string                       |
| `n`  | <Leader>mip | `devtools.actions.net.my_ip.func`            | Get my public IP address                   |

## Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests [here](https://github.com/username/devtools).

## License

This plugin is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
