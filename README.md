# .dotfiles

Please refer to the docs for explanations on how to set everything up.

## Quickstart

For starters I will be using Windows Subsystem for Linux (WSL) and Ubuntu as my
main Linux distribution, if you are using a Unix-based system everything should
still work after following the explanations in the docs.

This quickstart ensures you have Ubuntu properly setup before following the
instructions in the docs. Now to start, we need to install Ubuntu from the
Microsoft store - search for Ubuntu and click get, once installed click Open,
after that a terminal will open follow the instructions.

Once your done setting up Ubuntu run `sudo apt update && sudo apt upgrade -y`
to the command line this will update and upgrade Ubuntu to the latest version.

> [!NOTE]
> running the command will not update Ubuntu itself to it's latest version but
> the files that Ubuntu uses. A good example to understand this would be windows
> updates for Windows 10 are different from the windows updates for Windows 11.

### (Optional) Upgrade to latest version of Ubuntu

To check the version of Ubuntu you are using run the command
`cat etc/os-release`. You can also use neofetch but first you'll have install
it first using the command `sudo apt install neofetch`, after installing type
the `neofetch` command in the terminal.

To check for the latest release for Ubuntu run the command
`sudo do-release-upgrade`, after running this command it will tell you if there
are available upgrades or not, if there is a prompt telling you to upgrade just
type "yes" and check for prompts while in the installation process, right after
the installation is finished restart Ubuntu and check if the installation was a
success.

## Requirement:

- stow
- fzf
- ripgrep
- node
- tmux
