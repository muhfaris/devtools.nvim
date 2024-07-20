# DevTools Neovim Plugin

## Demo

| Get My Public IP                                                                                                         | Escape JSON                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| [![asciicast](https://asciinema.org/a/9Gs6j4HPcbXYdmVgR97f13I0J.svg)](https://asciinema.org/a/9Gs6j4HPcbXYdmVgR97f13I0J) | [![asciicast](https://asciinema.org/a/wdd7vhRRuBNT2Yi3j6Om8DgGx.svg)](https://asciinema.org/a/wdd7vhRRuBNT2Yi3j6Om8DgGx) |

| Parse JSON                                                                                                               | Decode JWT Token                                                                          |
| ------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- |
| [![asciicast](https://asciinema.org/a/5bTwLmv5TCffq4xgGrkOIQYiP.svg)](https://asciinema.org/a/5bTwLmv5TCffq4xgGrkOIQYiP) | ![image](https://github.com/user-attachments/assets/3bb9f0f7-7423-4b86-92b3-c19405021565) |
|                                                                                                                          |

## Overview

The plugin [muhfaris/devtools.nvim](https://github.com/muhfaris/devtools.nvim) is in active development. The purpose of this plugin is to be swiss army knife for developers.

## Features

- Configurable key mappings
- Eased automatic word wrapping and custom file type
- Parse and escape JSON
- Fetch my public IP address
- Encode and decode base64
- Decode JWT token

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
            func = actions.call "json.parse",
            desc = "Parse json string from selection visual text",
          },
        },
        n = {
          ["<Leader>mip"] = {
            func = actions.call "net.my_ip",
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

| Mode | Key         | Actions Name           | Description                                |
| ---- | ----------- | ---------------------- | ------------------------------------------ |
| `v`  | <Leader>jp  | `json.parse`           | Parse escaped json string into json object |
| `v`  | <Leader>je  | `json.escape`          | Parse json object into escaped json string |
| `v`  | <Leader>be  | `encode.base64_encode` | Encode base64 string                       |
| `v`  | <Leader>bd  | `encode.base64_decode` | Decode base64 string                       |
| `n`  | <Leader>mip | `net.my_ip`            | Get my public IP address                   |
| `n`  | <Leader>jwt | `jwt.decode_token`     | Decode JWT token                           |

### Available Commands

- `json.parse`
- `json.escape`
- `encode.base64_encode`
- `encode.base64_decode`
- `net.my_ip`
- `jwt.decode`

![image](https://github.com/user-attachments/assets/f7cb4898-b929-47fc-8416-ebd1fa03e795)

## Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests [here](https://github.com/username/devtools).

## License

This plugin is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
