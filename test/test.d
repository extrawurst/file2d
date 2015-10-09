import generatedText;
import generatedBinary;
import std.file : read, readText;
import std.stdio : writeln;

void main()
{
	assert(readText("example.txt") == data);
	assert(cast(ubyte[]) read("example.txt") == dataBin);
	writeln("Tests ran successfully");
}
