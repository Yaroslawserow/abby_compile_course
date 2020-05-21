#!/bin/bash
#!/usr/bin/env bash

rm -rf ./build
mkdir build
cd build
cmake ..
pwd
make
rm -rf ../output
mkdir ../output
touch ../output/$2
touch ../output/$3

./javacompiler ../$1 ../output/$2
dot -Tsvg ../output/$2 -o ../output/$3
