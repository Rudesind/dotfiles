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

## How I Manage my Dotfiles

I maintain my dotfiles using the **git bare repository method**. This was inspired by **DistroTube**.
For creating you're own dotfiles using this method, see: https://www.atlassian.com/git/tutorials/dotfiles

## Usage

To use my dotfiles, clone the files down to any location on your machine:

```
git clone https://github.com/Rudesind/dotfiles.git
```

Once cloned, copy and replace any files on your system with the files cloned. Assuming you're managing your own dotfiles through git, you would then add the new files to your repository:

```
config add <dotfile>
```

After you've taken all the files you want, you can delete the cloned repository, or keep for later updates.
