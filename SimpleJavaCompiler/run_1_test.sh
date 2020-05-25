rm -rf ./build
mkdir build
cd build
cmake ..
pwd 
make
rm -rf ../answers
mkdir ../answers

touch ../answers/graphiz_output.dot
touch ../answers/out.svg
./Simplejavacompiler ../$1 ../answers/graphiz_output.dot
dot -Tsvg ../answers/graphiz_output.dot -o ../answers/out.svg
rm ../answers/graphiz_output.dot
