# file2d [![Build Status](https://api.travis-ci.org/Extrawurst/file2d.png)](https://travis-ci.org/Extrawurst/file2d)
Simple tool to create embedable files in #dlang

Usage:

```sh
$ file2d someaudiofile.wav > mod.d
```

This will read `someaudiofile.wav` and write it as a ubyte array literal into a dlang compatible module file `mod.d`.
`mod.d` will look like this:

```D
module mod;

static immutable ubyte[1234] = [0x12, ...];
```

It's also possible to use stdin instead:

```sh
$ date | file2d > date.d
```

This will read the output of date and output it to date.d
