cd test
../file2d -ttext -mgeneratedText example.txt > generatedText.d
../file2d -mgeneratedBinary -vdataBin example.txt > generatedBinary.d
rdmd test.d
cd ..
