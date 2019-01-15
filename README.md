# homebrew-mutt

This tap contains the mutt 1.11.2 formula with options no longer provided by
the official homebrew formulae:

- `--with-gettext` Build with gettext support
- `--with-gpgme` Build with gpgme support
- `--with-libidn` Build with libidn support
- `--with-s-lang` Build against slang instead of ncurses

I personally need s-lang and (I think) gettext to get some shortcuts working.
`CTRL+O` does not work otherwise for some reason.

Tested with the following options:

```
brew install [.../ see below /...] --with-gettext --with-gpgme --with-libidn --with-s-lang
```

## How do I install this formula?

Just `brew tap emmanuelbernard/mutt` and then `brew install emmanuelbernard/mutt/mutt`.

You can also install via URL:

```
brew install https://raw.githubusercontent.com/emmanuelbernard/homebrew-mutt/master/Formula/mutt.rb
```

## Troubleshooting

First, please run `brew update` and `brew doctor`.

Second, read the [Troubleshooting Checklist](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Troubleshooting.md#troubleshooting).

**If you don’t read these it will take far longer to help you with your problem.**

## More Documentation

`brew help`, `man brew` or check [the documentation](https://github.com/Homebrew/homebrew/tree/master/share/doc/homebrew#readme).

## License

Code is under the [BSD 2 Clause (NetBSD) license](https://github.com/emmanuelbernard/homebrew-mutt/tree/master/LICENSE.txt).
