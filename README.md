# sha256

A minimal command line tool for computing SHA 256 digests.

I created this tool for myself because I wanted to be able to test and use my
SHA 256 implementation from [libsha256](https://github.com/tobybell/libsha256).
As a bonus, I also find it easier to remeber than `shasum -a 256`, the
alternative on macOS.

You're welcome to use it if you like.

## Usage

This tool has only a single usage mode, in which a message is read from
standard in and the digest is written to standard out.

```shell
cat my_file.txt | sha256
```

The 256-bit digest is output directly in binary; if you want to display it in
a more human-readable form, you'll need to pipe the output through a formatting
tool such as [hex](https://github.com/tobybell/hex).

## Installation

You're on your own here. I built this project usng `clang` and `make`, so if
you have those installed, it-will-probably-just-work. Shouldn't be too hard to
be build it yourself using other tools, though.

## License

This software is provided under the [MIT License](LICENSE). Go wild.
