#!/bin/bash
# Install mlpack on CentOS 7
yum -y groupinstall "Development Tools"
yum -y install epel-release
yum -y install boost-devel boost-test boost-program-options boost-math libxml2-devel armadillo-devel
yum -y install txt2man
yum -y install cmake

wget http://www.mlpack.org/files/mlpack-2.0.1.tar.gz
tar xzvf mlpack-2.0.1.tar.gz 
cd mlpack-2.0.1
mkdir build
cd build
cmake ../
make
make install

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH

cat << EOF > demo.cpp
#include <mlpack/core.hpp>
using namespace mlpack;

int main(int argc, char** argv){
  CLI::ParseCommandLine(argc, argv);
  Log::Debug << "Compiled with debugging symbols." << std::endl;
  Log::Info << "Some test informational output." << std::endl;
  Log::Warn << "A warning!" << std::endl;
  Log::Warn << "Made it!" << std::endl;
}
EOF

g++ -std=c++11 -L/usr/local/lib -I/usr/local/include -lmlpack -o demo demo.cpp

./demo
