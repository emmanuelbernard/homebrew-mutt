# homebrew-mutt

This tap contains the mutt 1.5.24 formula with updated versions of patches no longer included in the official homebrew repository:

- trash_folder patch
- sidebar patch
- indexcolor patch

Tested with the following options:

```
brew install [.../ see below /...] --with-sidebar-patch --with-trash-patch --with-gpgme --with-s-lang
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
