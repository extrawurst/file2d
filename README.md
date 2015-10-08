# file2d
simple tool to create embedable files in #dlang

usage:

```
$ file2d someaudiofile.wav > mod.d
```

this will read `someaudiofile.wav` and write it as a ubyte array literal into a dlang compatible module file `mod.d`.
`mod.d` will look like this:

```D
module mod;

static immutable ubyte[1234] = [0x12, ...];
```