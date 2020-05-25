rm -rf ./build
mkdir build
cd build
cmake ..
pwd 
make
rm -rf ../answers
mkdir ../answers
touch ../answers/$2
touch ../answers/$3

./Simplejavacompiler ../$1 ../answers/$2
dot -Tsvg ../answers/$2 -o ../answers/$3
rm ../answers/$2
