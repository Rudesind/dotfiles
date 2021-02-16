# My Dotfiles

```
.___  ________  __________  ________  ___.
|   \ \       \ \        / /       / /   |
|    \ \       \ \      / /_______/ /    |
|     \ \       \ \    / ________  /     |
|      \ \       \ \  / /       / /      |
|_______\ \_______\ \/ /_______/ /_______|
```

Welcome to my dotfiles. Here I keep the configuration for (most) everything I use.

If you're interested how my setup is configured, take a gander.

## Requirements

Obviously the only primary requirement is that you install the software of the dotfile you wish to use.

I try to keep my configs for OS agnostic software (such as Alacritty) universal, but in some cases keeping the same configuration causes too many issues (such as with vim). In these instances I create a seperate config file for the problem OS.

## Included Software

I maintain specific configurations for the following software:

* [Alacritty](https://github.com/alacritty/alacritty)
* [Fish](https://fishshell.com/)
* [Git](https://git-scm.com/)
* [PowerShell](https://docs.microsoft.com/en-us/powershell/)
* [Starship](https://starship.rs/)
* [Vim](https://www.vim.org/)
* [Vifm](https://vifm.info/)
* [Xmobar](https://hackage.haskell.org/package/xmobar)
* [Xmonad](https://xmonad.org/)

## Use

Clone the dotfiles down to your machine:

```git
git clone https://github.com/Rudesind/dotfiles.git
```

From here you can either copy the files out of the repository into your own dotfiles repository, copy the files directly to their respective config locations, or create symbolic links directly from the repository.
