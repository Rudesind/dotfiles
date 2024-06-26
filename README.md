# Dotfiles

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
***
Obviously the only primary requirement is that you install the software of the dotfile you wish to use.

Most of the configuration files are not specific to a single operating system, but note that you may need to make slight modifications to have them work correctly, and the location of the file may change from system to system. This is especially true if the managed software doesn't even function on a specific operating system.

In these instances, I create an entirely separate branch for managing dotfiles on that operating system. Currently I manage a separate branch for the following operating systems:

- Windows
- Linux [master]
- Mac

## Included Software
***
I maintain specific configurations for the following software:

- [Alacritty](https://alacritty.org/)
- [Fish](https://fishshell.com/)
- [Git](https://git-scm.com/)
- [iTerm2](https://iterm2colorschemes.com/)
- [Neovim](https://neovim.io/)
- [Starship](https://starship.rs/)
- [Vifm](https://vifm.info/)
- [Vim](https://www.vim.org/)
- [Xmobar](https://github.com/jaor/xmobar)
- [Xmonad](https://xmonad.org/)

> [!tip]
> Looking for my **Windows** configuration? Switch branchs to the `windows` branch.

## How I manage my Dotfiles
***
I maintain my dotfiles using the [[Bare Git Repository]] method. This was inspired by **DistroTube.** For creating you're own dotfiles using this method, see: https://www.atlassian.com/git/tutorials/dotfiles.

## Setup and Usage
***
I highly recommended that you review the guide for setting up *dotfiles* from **Atlassian**, but I provide a summarized version with some of my own additions below.

### Initializing New Repository
***
This section covers initializing a **bare** repository for the first time.

To initialize a **bare** repository, use the `init` command with the `--bare` flag:

**Bash or PowerShell**
```shell
git init --bare $HOME/.dotfiles
```

> [!note]
> If you are using Mac or Linux, I recommend setting your dotfile folder as `.config`; however, your entire home folder can be used as your dotfiles, as you may have files in other locations.

The configuration repository can be named whatever you like, but in this example it is called **.dotfiles**.

Next, an **alias** can be created. This alias is used to specifically reference are configuration files.

**Bash**
```shell
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

If you are installing on Mac using **Fish** or **Zsh** via [Homebrew](https://brew.sh/), you may need to make some alterations to the alias:

**Fish or Zsh**
```bash
alias config='/opt/homebrew/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME' 
```

Note that **PowerShell** requires slightly different steps, as aliases don't work quite the same. Instead, we need to create an entirely new function and alias to use `config`.

**PowerShell**
```powershell
function gitConfig {git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $args}
New-Alias -Name config -Value gitConfig
```

After we've created our alias, we want to hide any untracked files. This will be helpful as running `config status` won't show a list different files we aren't interested in tracking. Since our working tree is set to our `$HOME` directory, running `status` will show files in our `$HOME` directory.

**Bash or PowerShell**
```shell
config config --local status.showUntrackedFiles no
```

To reuse this alias, it is recommended that you add it to your `.bashrc` or `profile.ps1` file. Simply add one of the above lines depending on your shell to the appropriate configuration file.

> [!note]
> If you already manage your configuration files using a git repository (I.e. Symlinks), find more information on how to migrate to this method under the **Installing your dotfiles onto a new system (or migrate to this setup)** at the following link:
> - https://www.atlassian.com/git/tutorials/dotfiles

### Initializing Existing Repository
***
This section describes initializing an existing **bare** repository on a new system.

> [!warning]
Prior to performing any of the below steps, make sure you've added the `config` alias to your `.bashrc` or `profile.ps1` config as described in the **Initializing New Repository** section.
> 
> Also ensure that your **.dotfiles** or config director is listed in your **.gitignore** to avoid recursion problems.

First step is to clone our existing git repository as a **bare** repository. Make sure to use the same name of the configuration folder specified in the alias.

**Bash or PowerShell**
```shell
git clone --bare <\git-repo-url> $HOME/.dotfiles
```

Next, we checkout the repository. If you use a specific branch for different OS configurations, make sure to checkout the appropriate branch first.

The checkout step will attempt to add and overwrite all files in your home directory, so keep this in mind before running this command.

**Bash or PowerShell**
```shell
config checkout windows
```

Otherwise, if you wish to user the **master** branch, just checkout.

**Bash or PowerShell**
```shell
config checkout
```

If you receive a warning such as the following:

```shell
error: The following untracked working tree files would be overwritten by checkout:
	.bashrc     
	.gitignore 
Please move or remove them before you can switch branches. Aborting
```

You will need to backup (optional) and delete the files before the repository can be checked out. This will replace the deleted files by a managed copy from the dotfiles repository.

> [!note]
> Because we've initialed this as a new local repository, you will also need to rerun the command to ensure that new local files are untracked:
> ```shell
> config config --local status.showUntrackedFiles no
> ```

### Managing Separate OS/Computer Configs
***
In certain instances you may wish to manage separate computer or OS configurations for your files. This is especially true if you share files or work between different operating systems, such as Linux, MacOS or Windows. Often times the configuration files cannot be shared 1-1 between them, and you risk corrupting the configuration if you accidentally push the wrong alterations to the master branch.

Using the **bare** repository method, we can manage these different configurations using different branches. You can manage a completely separate branch for every computer/OS, or maintain master as a primary OS (E.g. Linux) and create other branches for any alterations.

> [!note]
> In my dotfiles, the **master** branch represents the **Linux** operating system.

To began managing a new configuration for a computer, first initialize the repository.

**Bash or PowerShell**
```shell
git clone --bare <\git-repo-url> $HOME/.dotfiles
```

Before we checkout the repository, we need to create a new branch. Please ensure the alias has been defined as seen in the **Initializing New Repository** section.

```shell
config checkout -b windows
```

> [!note]
> Because we've initialed this as a new local repository, you will also need to rerun the command to ensure that new local files are untracked:
> ```shell
> config config --local status.showUntrackedFiles no
> ```

Now in our new branch we can remove any files we don't want from **master**. More than likely if you ran `config status` you will see a bunch of files already "deleted." Simply commit these changes, as we won't be tracking them here.

Now we can add any files we won't to track. Once all files have been added, they can be pushed to the new branch.

## Other Settings and Notes
---

### Font
To make the most of my config, I recommend installing a [NerdFont](https://www.nerdfonts.com/font-downloads), this will allow icons to appear in certain commands and applications, such as [LSD](https://github.com/lsd-rs/lsd), or [Neovim](https://neovim.io/). I personally use [MesloLG Nerd Font]([MesloLG](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip).

### MacOS Issues and Troubleshooting
When setting up my configuration on a Mac, you may encounter several permissions issues. I expect that these issues occur when installing certain applications via a package manager. To solve them, you may need to take ownership of both the `.config` and `.local` folders:

```bash
sudo chown -R <username> ~/.local
```

```bash
sudo chown -R <username> ~/.config
```

Normally since these are already under your user directory, you should have ownership of them.

### Fish: Unknown Command
When using **Fish** you may encounter the following issue:

```bash
fish: Unknown command: brew
```

This occurs when certain commands are installed through a package manager and not in the expected location (Such as **Homebrew** on **Mac**). This can be solved by adding a path to **Fish**:

```bash
fish_add_path /opt/homebrew/bin
```

> [!note]
> To ensure you don't encounter this issue for each session, you will need to add it to your Bash or Fish config.
