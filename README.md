# devtools Neovim Plugin

## Overview

The `devtools` plugin enhances Neovim with utilities for various development tasks, including JSON parsing, IP address fetching, and more.

## Features

- **JSON Parsing:** Convert selected JSON text into a Lua table and replace it in the buffer.
- **IP Address Fetching:** Fetch your public IP address using the `curl` command and display it in Neovim.
- **Find selection visual:** Find text from visual selection text.

## Requirement

- Install `swagger-ui-watcher` for serve `openapi.yaml` or `openapi-spec.yaml`

```bash
 npm install swagger-ui-watcher -g
```

## Installation

Install the `devtools` plugin using your favorite plugin manager:

```vim
" Using vim-plug
Plug 'muhfaris/devtools.nvim'

" Using packer.nvim
use 'muhfaris/devtools.nvim'
```

Replace `'muhfaris/devtools.nvim'` with the actual path to your plugin.

## Usage

### Setup

In your Neovim configuration (e.g., `init.lua`), setup `devtools` with optional key mappings:

```lua
require('devtools').setup({
    keymaps = {
        jsonparse = "<Leader>k",       -- Default: <Leader>k
        visual_fuzzy_find = "<Leader>f"  -- Default: <Leader>f
    }
})
```

or using lazy.nvim

```lua
return {
  "muhfaris/devtools.nvim",
  opts = {
    keymaps = {
      jsonparse = "<Leader>j",
      visual_fuzzy_find = "<Leader>h",
    },
  },
}
```

### Default Key Mappings

- **`<Leader>k`:** JSON Parse

  - Convert selected JSON text into a Lua table.
  - Replace the selected text with the parsed JSON.

- **`<Leader>f`:** Visual Fuzzy Find
  - Perform a fuzzy find within the current buffer using the selected text as the default search term.

### Commands

Use `:DevTools <tool>` to execute specific tools:

- **`:DevTools fetch_ip`**

  - Fetch your public IP address and display it in the Neovim message area.

- **`:Devtools jsonparse`**
  - Convert the selected JSON text into a Lua table and replace it in the buffer.

### Autocompletion

After typing `:DevTools`, press `<Tab>` to autocomplete available tools:

```vim
:DevTools <Tab>
```

### Customization

Customize key mappings by specifying them in the `setup()` function call:

```lua
require('devtools').setup({
    openapi = {
      port = 4000,
    },
    keymaps = {
        jsonparse = "<Leader>j",       -- Custom key mapping for JSON parse
        visual_fuzzy_find = "<Leader>g"  -- Custom key mapping for Visual Fuzzy Find
    },
    swagger_patterns = {
    "openapi.yaml",
    "openapi-spec.yaml",
  }
})
```

## Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests [here](https://github.com/username/devtools).

## License

This plugin is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
