module file2d.writer.binary;

import std.array:appender;
import std.format;

string convertToBinary(in ubyte[] content, in string variableName, in int bytesPerLine, in bool trailingComma) pure
{
    auto ap = appender!string();

    ap.put(format("static immutable ubyte[%s] %s = [\n", content.length, variableName));
    ap.put("\t");
	foreach(i, ubyte b; content)
	{
		if(i>1 && (i)%bytesPerLine==0)
            ap.put("\t");

        ap.put(format("0x%.2x",b));
		if(!trailingComma && i<content.length-1) // Will not do this check when trailingComma is true
            ap.put(",");
		if(trailingComma)
            ap.put(",");

		if(i>0 && (i+1) % bytesPerLine == 0)
            ap.put("\n");
	}
    ap.put(format("\n];\n"));

    return ap.data;
}