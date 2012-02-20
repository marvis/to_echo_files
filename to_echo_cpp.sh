#! /bin/sh

if [ "$#" = "0" ]
then
	echo "usage : to_echo_cpp.sh <file1> [<file2> ...]"
	exit 0
fi

echo "#include <iostream>"
echo "#include <string>"
echo "#include <fstream>"
echo ""
echo "using namespace std;"
echo ""

echo "int main(int argc, char ** argv)"
echo "{"
echo -e "\tif(argc == 1){cerr<<\"Usage : \"<<argv[0]<<\" <dir>\"<<endl; return 0;}"
echo -e "\tofstream ofs;"
echo -e "\tstring dir = argv[1];"
echo -e "\tstring filename;"

while [ "$#" -gt "0" ]
do
	FILENAME=$1
	shift

	echo ""
	echo -e "\tfilename = dir + \"/$FILENAME\";"
	echo -e "\tcout<<\"output \"<<filename<<endl;"
	echo ""
	echo -e "\tofs.open((char*)filename.c_str());"
	# 1. delete ^M ; 2. replace \ to \\,  3. replace " to \" 
	tr "\r" "\n" < $FILENAME | sed 's/\\//g' |  sed 's/"/"/g' | sed 's/^/ofs<<"/' | sed 's/$/"<<endl;/' | tr '' '\\\t'
	echo -e "\tofs.close();"
done

echo "}"
