module writer.main;

///
void main(string[] args)
{
    // only using getopt functions from phobos 2.066
    getopt(
        args,
        config.passThrough,
        "help|h", &helpWanted,
        "bytesPerLine|l", &bytesPerLine,
        "type|t", &fileType,
        "variable|v", &variableName,
        "module|m", &moduleName,
        "trailingComma", &trailingComma,
        "force|f", &force
        );
    
    if(helpWanted)
    {
        writeln("file2d");
        writeln("Simple tool to create embedable files in #dlang");
        writeln();
        writeln("        --help");
        writeln("            -h  Shows this help text.");
        writeln("--bytesPerLine=<arg>");
        writeln("            -n  How many bytes are appended to the array before starting a new line. (Defaults to 20)");
        writeln("        --type={binary|text}");
        writeln("            -t  Sets the file type to interpret. (Defaults to binary)");
        writeln("    --variable=<arg>");
        writeln("            -v  Sets the variable name. (Defaults to data)");
        writeln("      --module=<arg>");
        writeln("            -m  Sets the module name. (Defaults to mod)");
        writeln("--trailingComma Array will end with a comma if this is set");
        writeln("       --force");
        writeln("            -f  Forces output to stdout even if it is a terminal.");
        return;
    }
    
    ubyte[] content;
    if(args.length == 1) // No file given; read from stdin instead
    {
        // This allows neat piping like
        // date | file2d
        // file2d < README.md > readme.d
        
        if(isTTY(0)) // Checks if stdin is terminal or piped
        {
            writeln("Can't read from terminal. Use pipe instead or give a file argument!");
            return;
        }
        
        string s;
        while(!stdin.eof)
        {
            stdin.readf("%s", &s);
            content ~= cast(ubyte[]) s;
        }
    }
    else
        content = cast(ubyte[])read(args[1]);
    
    if(!force && content.length > 10_000 && isTTY(1)) // Give a warning for files with more than 10000 bytes of size
    {
        writeln("stdout is a terminal. Pipe to a file or use --force instead!");
        return;
    }
    
    write(createModule(fileType, content, moduleName, variableName, bytesPerLine, trailingComma));
}