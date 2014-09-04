zsh-completion-generator
========================

Generating zsh completion function from getopt-style help text.


Motivation
----------
Writing completion functions is boring, plus they deprecate when
the software updates the CLI. This plugin tries to read list of options
from help text of the program and generate completion function automatically.

It's a best-effort service, not guaranteed to work in all cases.
Completion functions already defined (that somebody actually took time to write)
are not overridden by this plugin.


How to install
--------------
### Using antigen

After installing antigen put `antigen bundle RobSis/zsh-completion-generator`
into your `.zshrc`.

### Manually
* Download the script or clone this repository:

    `$ cd ~/.zsh/`
    
    `$ git clone git://github.com/RobSis/zsh-completion-generator.git`

* Source the script **before compinit** in your `~/.zshrc`:

    `source $HOME/.zsh/zsh-completion-generator/zsh-syntax-highlighting.plugin.sh`
    
    `...`
    
    `compinit`

#### Custom zsh completion folder
If you want to use a different folder than the default one for completion files, you can export the GENCOMPL_FPATH variable before sourcing the plugin :

    $ GENCOMPL_FPATH = $HOME/.zsh/complete
    $ source $HOME/.zsh/zsh-completion-generator/zsh-syntax-highlighting.plugin.sh



#### Custom python version
If you ant to use a specific python interpreter name, you can export the GENCOMPL_PY variable before sourcing the plugin :

    $ GENCOMPL_PY = python2
    $ source $HOME/.zsh/zsh-completion-generator/zsh-syntax-highlighting.plugin.sh

Please note that currently python 3 is not supported.

How to use
----------
You must edit the plugin to change the list of programs, or you can
generate them from the shell:

    $ gencomp nl
    $ source ~/.zshrc


Licence
-------

GNU GPLv2
