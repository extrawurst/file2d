module file2d.writer.binary;

import std.stdio;

void writeBinary(ref ubyte[] content, in string variableName, in int bytesPerLine, in bool trailingComma)
{
	writefln("static immutable ubyte[%s] %s = [", content.length, variableName);
	write("\t");
	foreach(i, ubyte b; content)
	{
		if(i>1 && (i)%bytesPerLine==0)
			write("\t");

		writef("0x%.2x",b);
		if(!trailingComma && i<content.length-1) // Will not do this check when trailingComma is true
			write(",");
		if(trailingComma)
			write(",");

		if(i>0 && (i+1) % bytesPerLine == 0)
			write("\n");
	}
	writefln("\n];");
}
