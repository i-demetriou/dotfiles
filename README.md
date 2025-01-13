# Dotfiles

Dotfiles, are configuration files for your applications. They are called "dot files"
because they usually start with a `.` to signal to \*NIX systems that they should
be hidden. Since these configuration files are simply files, they are quite easy to backup
and maintain with tools like `git`.

This is exactly the motivation behind this repo; it holds my personal configuration
for some commonly used utilities. However, this repo responsibility has expanded
to (re-)deploy everything to a fresh device. This includes installing packages
via `apt`, cloning some particular repos, and establishing connecting to my servers.

This is a good place to mention that it is a very **bad idea** to store in version
control applications things like passwords, app tokens, API keys, or SSH (private) keys.
Ideally these should not be required in configuration files, but if they are, consider
declaring it as an environment variable. This way, the committed configuration file
will hold `${SERVICE_PASSWORD}`, while the `SERVICE_PASSWORD` variable would be exported
in the profile. More on this later.

## Implementation

After considering many different approaches on managing dot files, the
[bare repo](https://www.atlassian.com/git/tutorials/dotfiles) approach seemed the
most elegant. In this approach, the user's whole home directory is a git repository.

Basically, all the `.git` files needed for version control admin are stored in a
folder in `$HOME`, while the working directory is set to be `$HOME`.

In particular,

    git init --bare $HOME/.local/share/dotfiles/bare/
    alias .f='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/bare.repo/ --work-tree=$HOME'
    .f config --local status.showUntrackedFiles no

This way, one can perform `git` style commands for any file in `$HOME`.

For example,

    .f status

will return if any tracked files have been modified, while

    .f log

will return the commit logs.

## Initalization

You can get the initialization script from an git server. This will
configure your new PC, and clone the dotfiles in your home folder.

In particular, `init.sh` will:

- generate `ssh` keys,
- authenticate with known git servers,
- clone the bare repo in user's `$XDG_DATA_DIR`,
