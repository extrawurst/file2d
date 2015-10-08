import std.stdio;

import std.file;

int bytesPerLine = 20;

void main(string[] args)
{
    ubyte[] content = cast(ubyte[])read(args[1]);

    writefln("module mod;\n",content.length);
    writefln("static immutable ubyte[%s] = [",content.length);
    write("\t");
    foreach(i, ubyte b; content)
    {
        if(i>1 && (i)%bytesPerLine==0)
            write("\t");

        writef("0x%.2x",b);
        if(i<content.length-1)
            write(",");

        if(i>0 && (i+1) % bytesPerLine == 0)
            write("\n");
    }
    writefln("\n];");
}
