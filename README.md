# Dotfiles

Dependencies
------------
[ag](https://github.com/ggreer/the_silver_searcher)

[asdf-vm](https://github.com/asdf-vm/asdf)

[bat](https://github.com/sharkdp/bat)

[fd](https://github/sharkdp/fd)

[fzf](https://github.com/junegunn/fzf)

[hub](https://github.com/github/hub)

[neovim](https://neovim.io/) (The config does not support Vim only NeoVim >= 0.7)

[rcm](https://github.com/thoughtbot/rcm)

[ripgrep](https://github.com/BurntSushi/ripgrep)

[rust](https://www.rust-lang.org/)

[sqllite](https://www.sqlite.org/index.html) (for completion)

[tpm](https://github.com/tmux-plugins/tpm)

[wget](https://www.gnu.org/software/wget/)

[zsh](https://www.zsh.org/)

[zsh-completions](https://github.com/zsh-users/zsh-completions)

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

(See Brewfile if on MacOS or bin/laptop if on Fedora)

Install
-------
Clone: `git clone git://github.com/devinrm/dotfiles.git ~/dotfiles`

Make sure you have [rcm](https://github.com/thoughtbot/rcm) installed

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
