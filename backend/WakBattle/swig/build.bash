#!/bin/bash
rm *.o
rm *.cpp
rm bc_wrap.cxx
rm bc.bundle
rm Makefile
cp ../WakBattle/*.cpp .
cp ../WakBattle/util/*.cpp .
rm main.cpp
swig -ruby -c++ bc.i
ruby extconf.rb --with-bcdir-include=../WakBattle
make
rm *.o
rm *.cpp
rm bc_wrap.cxx
rm Makefile
#g++ -c ../WakBattle/UnitClass.cpp -I../WakBattle
#g++ -c bc_wrap.cxx -I../WakBattle -I/System/Library/Frameworks/Ruby.framework/Headers -L/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby
#g++ -shared UnitClass.o bc_wrap.o -o bc.so
