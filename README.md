# Macroman

Macroman is a Vim plugin to easily save and manage your Vim macros.

## Usage

The `:MacroSave` command will let you save your macro. By default this
plugin will use the `q` register for this. This command expects you to
pass a name which will allow you to identify this macro later. These
macros are saved as files in the `~/.vim-macroman` directory.

    :MacroSave your-macro-name

Viewing your macros is done using the `:MacroList` command. This command
will open a new split containing a list of your saved macros.

Pressing `q` will close this split and return you to your previous
buffer.

Pressing `dd` will delete the macro for the current line.

Finally, pressing `Enter` will run the currently selected macro. The
`:MacroList` command can also be run while visually selecting multiple
lines. This will make the selected macro run for each of the lines the
visual selection.

    :MacroList
    :'<,'>MacroList

## Configuration

By default the `:MacroSave` command will save the contents of the `q`
register. This can be configured by adding the option below into your
`vimrc` file.

    let g:macroman_register = "q"

## Mappings

There are no main mappings setup by default. Here are some example
mappings that you might want to use to quickly save or list your
macros.

    noremap <leader>l :MacroList<cr>
    nnoremap <leader>s :MacroSave<space>

## Installation

Install the plugin using your favourite plugin manager.

**Pathogen**

     git clone https://github.com/jonasbleyl/macroman ~/.vim/bundle/macroman

**Vundle**

      Plugin 'jonasbleyl/macroman'
