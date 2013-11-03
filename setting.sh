#!/bin/sh

# setting
PROJECT_DIR=`pwd`
VENDOR_DIR_NAME=vendor
GTEST_DIR_NAME=gtest
SRC_DIR_NAME=src
TEST_DIR_NAME='test'
VENDOR_DIR=${PROJECT_DIR}/${VENDOR_DIR_NAME}
GTEST_DIR=${VENDOR_DIR}/${GTEST_DIR_NAME}
SRC_DIR=${PROJECT_DIR}/${SRC_DIR_NAME}
TEST_DIR=${PROJECT_DIR}/${TEST_DIR_NAME}
COMPILE_GCC='g++'
COMPILE_CLANG='clang++'
COMPILE_COMMAND=''
STDLIB_OPT=''
SCRIPT_NAME='gtest-exec.sh'

if [ ! -e ${SRC_DIR} ]; then
  mkdir ${SRC_DIR}
fi

if [ ! -e ${TEST_DIR} ]; then
  mkdir ${TEST_DIR}
fi

# options
usage_exit() {
	echo "Usage: $0 [-c (clang|gcc)]"
	echo "-c is compile command."
	echo "-h is this help."
	exit 1
}
while getopts c:h OPT
do
	case $OPT in
		c)  COMPILE_TYPE="$OPTARG"
			if [ "$COMPILE_TYPE" = "clang" ] ; then
				COMPILE_COMMAND=${COMPILE_CLANG}
			elif [ "$COMPILE_TYPE" = "gcc" ] ; then
				COMPILE_COMMAND=${COMPILE_GCC}
			else
				usage_exit
			fi
			;;
		h)  usage_exit
			;;
		\?) usage_exit
			;;
	esac
done

shift $((OPTIND - 1))
if [ -z "${COMPILE_COMMAND}" ] ; then
	usage_exit
else
	echo "Do you use C++11? [y/n]"
	read USE
	if [ "$USE" = "y" -o "$USE" = "yes" -o "$USE" = "Y" ] ; then
		if [ "$COMPILE_COMMAND" = ${COMPILE_GCC} ] ; then
			STDLIB_OPT='-std=C++11'
		elif [ "$COMPILE_COMMAND" = ${COMPILE_CLANG} ] ; then
			STDLIB_OPT='-std=C++11 -stdlib=libc++'
		fi
	else
		echo "You don't use C++11."
	fi
fi

# download
mkdir ${VENDOR_DIR}
wget https://googletest.googlecode.com/files/gtest-1.6.0.zip
unzip gtest-1.6.0.zip
mv gtest-1.6.0/fused-src/gtest/ vendor
rm -f gtest-1.6.0.zip
rm -rf gtest-1.6.0

# compile
cd ${VENDOR_DIR}
${COMPILE_COMMAND} -I./ -c ${GTEST_DIR_NAME}/gtest-all.cc
${COMPILE_COMMAND} -I./ -c ${GTEST_DIR_NAME}/gtest_main.cc
mv gtest*.o gtest

# gtest execution shell
echo "${COMPILE_COMMAND} ${STDLIB_OPT} -g -I${VENDOR_DIR} -I${SRC_DIR}"' -c $1 -o $1.o'" \n" >> ${SCRIPT_NAME}
echo "${COMPILE_COMMAND} ${STDLIB_OPT} -g -o "'$1-test $1.o '"${GTEST_DIR}/gtest-all.o ${GTEST_DIR}/gtest_main.o \n" >> ${SCRIPT_NAME}
echo './$1-test \n' >> ${SCRIPT_NAME}
echo 'if [ $# -ne 2 ]; then' >> ${SCRIPT_NAME}
echo '	rm -f $1.o $1-test' >> ${SCRIPT_NAME}
echo '	echo "remove compile file."' >> ${SCRIPT_NAME}
echo 'fi' >> ${SCRIPT_NAME}

