rm -rf ./build
mkdir build
cd build
cmake ..
pwd 
make
rm -rf ../answers
mkdir ../answers

touch ../answers/1.svg
touch ../answers/graphiz_output.dot
./Simplejavacompiler ../tests/auto_tests/1.java ../answers/graphiz_output.dot
dot -Tsvg ../answers/graphiz_output.dot -o ../answers/1.svg
rm ../answers/graphiz_output.dot

touch ../answers/2.svg
touch ../answers/graphiz_output.dot
./Simplejavacompiler ../tests/auto_tests/2.java ../answers/graphiz_output.dot
dot -Tsvg ../answers/graphiz_output.dot -o ../answers/2.svg
rm ../answers/graphiz_output.dot

touch ../answers/3.svg
touch ../answers/graphiz_output.dot
./Simplejavacompiler ../tests/auto_tests/3.java ../answers/graphiz_output.dot
dot -Tsvg ../answers/graphiz_output.dot -o ../answers/3.svg
rm ../answers/graphiz_output.dot

touch ../answers/4.svg
touch ../answers/graphiz_output.dot
./Simplejavacompiler ../tests/auto_tests/4.java ../answers/graphiz_output.dot
dot -Tsvg ../answers/graphiz_output.dot -o ../answers/4.svg
rm ../answers/graphiz_output.dot






