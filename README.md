# Dotfiles

Dependencies
------------
[rcm](https://github.com/thoughtbot/rcm) (or some other symlink manager)

[zsh](https://www.zsh.org/)

[neovim](https://neovim.io/) (The config does not support Vim only NeoVim >= 0.5)

[Ag](https://github.com/ggreer/the_silver_searcher)

[ripgrep](https://github.com/BurntSushi/ripgrep)

[hub](https://github.com/github/hub)

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

[fzf](https://github.com/junegunn/fzf)

[bat](https://github.com/sharkdp/bat)

[asdf-vm](https://github.com/asdf-vm/asdf)

(See Brewfile if on MacOS)

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
