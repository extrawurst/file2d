module app;

import std.string:format;

import file2d.writer.binary;
import file2d.writer.text;

///
enum FileType
{
    binary, text
}

///
string createModule(FileType fileType, in ubyte[] content, string moduleName, string variableName, int bytesPerLine, bool trailingComma) pure
{
    import std.array;

    auto ap = appender!string;

    ap.put(format("module %s;\n\n", moduleName));
    switch(fileType) with(FileType)
    {
        case binary:
            ap.put(convertToBinary(content, variableName, bytesPerLine, trailingComma));
            break;
        case text:
            ap.put(convertToText(content, variableName));
            break;
        default:
            assert(0, "Invalid File Type");
    }

    return ap.data;
}

unittest
{
    import std.file;

    auto input = readText("test/example.txt");
    auto correctRes = readText("test/generatedText.d");
    auto generatedRes = createModule(FileType.text, cast(ubyte[])input, "generatedText", "data", 20, false);

    assert(generatedRes == correctRes);
}

unittest
{
    import std.file;
    
    auto input = readText("test/example.txt");
    auto correctRes = readText("test/generatedBinary.d");
    auto generatedRes = createModule(FileType.binary, cast(ubyte[])input, "generatedBinary", "dataBin", 20, false);
    
    assert(generatedRes == correctRes, format("%s",generatedRes));
}