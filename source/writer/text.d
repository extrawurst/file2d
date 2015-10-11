module file2d.writer.text;

import std.array:appender;
import std.format;
import std.conv;

private string escaped(in char c) pure
{
	switch(c)
	{
	case '\n':
		return "\\n";
	case '\r':
		return "\\r";
	case '\t':
        return "\\t";
	case '\\':
        return "\\\\";
	case '"':
        return "\\\"";
	default:
        return to!string(c);
	}
}

string convertToText(in ubyte[] content, in string variableName) pure
{
    auto ap = appender!string();

	ap.put(format("static immutable string %s = \"", variableName));
	foreach(i, ubyte b; content)
	{
		ap.put(escaped(cast(char) b));
	}
	ap.put("\";\n");

    return ap.data;
}