module file2d.writer.text;

import std.stdio;

void writeEscaped(in char c)
{
	switch(c)
	{
	case '\n':
		write("\\n");
		break;
	case '\r':
		write("\\r");
		break;
	case '\t':
		write("\\t");
		break;
	case '\\':
		write("\\\\");
		break;
	case '"':
		write("\\\"");
		break;
	default:
		write(c);
		break;
	}
}

void writeText(ref ubyte[] content, in string variableName)
{
	writef("static immutable string %s = \"", variableName);
	foreach(i, ubyte b; content)
	{
		writeEscaped(cast(char) b);
	}
	writefln("\";");
}
