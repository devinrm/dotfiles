# Dotfiles

Dependencies
------------
[ag](https://github.com/ggreer/the_silver_searcher)

[asdf-vm](https://github.com/asdf-vm/asdf)

[bat](https://github.com/sharkdp/bat)

[fzf](https://github.com/junegunn/fzf)

[fd](https://github/sharkdp/fd)

[hub](https://github.com/github/hub)

[neovim](https://neovim.io/) (The config does not support Vim only NeoVim >= 0.5)

[rcm](https://github.com/thoughtbot/rcm) (or some other symlink manager)

[ripgrep](https://github.com/BurntSushi/ripgrep)

[zsh](https://www.zsh.org/)

[zsh-completions](https://github.com/zsh-users/zsh-completions)

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

(See Brewfile if on MacOS or bin/laptop if on Fedora)

Install
-------
Clone: `git clone git://github.com/devinrm/dotfiles.git ~/dotfiles`

Install: `env RCRC=$HOME/dotfiles/rcrc rcup`

This will create symlinks for config files in your `$HOME` directory.

You can safely run `rcup` multiple times to update.

If your plugins aren't installed run `PackerInstall`, `PackerCompile`, and `PackerSync`

Contributing
------------
Pull-requests are welcome, but it would probably make more sense just to fork them and make them your
own unless your PR is for a bug fix.

License
-------
This software is free and distributable under the MIT license.
