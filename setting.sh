#!/bin/sh

# setting
PROJECT_DIR=`pwd`
VENDOR_DIR_NAME=vendor
GTEST_DIR_NAME=gtest
SRC_DIR_NAME=src
VENDOR_DIR=${PROJECT_DIR}/${VENDOR_DIR_NAME}
GTEST_DIR=${VENDOR_DIR}/${GTEST_DIR_NAME}
SRC_DIR=${PROJECT_DIR}/${SRC_DIR_NAME}

# download
mkdir ${VENDOR_DIR}
wget https://googletest.googlecode.com/files/gtest-1.6.0.zip
unzip gtest-1.6.0.zip
mv gtest-1.6.0/fused-src/gtest/ vendor
rm -f gtest-1.6.0.zip
rm -rf gtest-1.6.0

# compile
cd ${VENDOR_DIR}
g++ -I./ -c ${GTEST_DIR_NAME}/gtest-all.cc
g++ -I./ -c ${GTEST_DIR_NAME}/gtest_main.cc
mv gtest*.o gtest

# gtest execution shell
echo 'g++ -g '"-I${VENDOR_DIR} -I${SRC_DIR}"' -c $1 -o $1.o \n' >> gtest-exec.sh
echo 'g++ -g -o $1-test $1.o'" ${GTEST_DIR}/gtest-all.o ${GTEST_DIR}/gtest_main.o \n" >> gtest-exec.sh
echo './$1-test \n' >> gtest-exec.sh
echo 'if [ $# -ne 2 ]; then' >> gtest-exec.sh
echo '	rm -f $1.o $1-test' >> gtest-exec.sh
echo '	echo "remove compile file."' >> gtest-exec.sh
echo 'fi' >> gtest-exec.sh

