zsh-completion-generator
========================

Plugin that generates completion functions automatically from getopt-style help texts.


Motivation
----------
Writing completion functions is boring, plus they can break when
the software updates the CLI. This plugin tries to parse the help text
of the given commands and generate a completion function automatically.

It's a best-effort service, not guaranteed to work in all cases.
Completion functions which are already present (and most likely better)
are not overridden by this plugin.


How to install
--------------
### Using antigen

After installing antigen put `antigen bundle RobSis/zsh-completion-generator`
into your `.zshrc`.

### Using zinit

```
zinit load RobSis/zsh-completion-generator
```

### Using Fig

[Fig](https://fig.io) adds apps, shortcuts, and autocomplete to your existing terminal.

Install `zsh-completion-generator` in just one click.

<a href="https://fig.io/plugins/other/zsh-completion-generator_RobSis" target="_blank"><img src="https://fig.io/badges/install-with-fig.svg" /></a>

### Manually
* Download the script or clone this repository:

    `$ cd ~/.zsh/`
    
    `$ git clone git://github.com/RobSis/zsh-completion-generator.git`

* Source the script **before compinit** in your `~/.zshrc`:

    `source $HOME/.zsh/zsh-completion-generator/zsh-completion-generator.plugin.zsh`
    
    `...`
    
    `compinit`

#### Custom zsh completion folder
If you want to use a different folder than the default one (`completions/` within the plugin directory) for completion files, you can export the GENCOMPL_FPATH variable before sourcing the plugin :

    $ GENCOMPL_FPATH=$HOME/.zsh/complete
    $ source $HOME/.zsh/zsh-completion-generator/zsh-completion-generator.plugin.zsh



#### Custom python version
If you want to use a specific Python interpreter name, you can export the
GENCOMPL_PY variable before sourcing the plugin :

    $ GENCOMPL_PY=python2
    $ source $HOME/.zsh/zsh-completion-generator/zsh-completion-generator.plugin.zsh

How to use
----------
Provide default program list by (example):

```zsh
zstyle :plugin:zsh-completion-generator programs   ggrep tr cat
```

The plugin will create completions for those programs at load time, once.
You can also generate completions from the shell, by using provided `gencomp`
function:

    $ gencomp ggrep
    $ source ~/.zshrc # or run `compinit'
    $ ggrep -*[TAB]* -> magic

Licence
-------

GNU GPLv2
