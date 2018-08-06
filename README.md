# My Dotfiles


## Requirement

Please install GNU `stow`.


## Usage

Follow the steps:

1. Type `ls` to see all the packages.
1. Choose what package you want to install, e.g. `vim`.
1. Type `stow <package>`, e.g. `stow vim`.
1. Done.


## Troubleshooting

If you see the following warning when `stow vim`:

```
WARNING! stowing vim would cause conflicts:
  * existing target is neither a link nor a directory: .vimrc
All operations aborted.
```

You should move your original dotfile (`~/.vimrc`) to somewhere else first, and then try `stow vim` again.
