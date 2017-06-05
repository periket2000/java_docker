#!/bin/sh
echo --- Tests ---

echo -n "Git installed... "
git --version > /dev/null
[ "$?" -ne 0 ] && echo nope && exit 1
echo ok

echo -n "Java installed... "
java -version > /dev/null
[ "$?" -ne 0 ] && echo nope && exit 1
echo ok

echo -n "Maven installed... "
mvn -version > /dev/null
[ "$?" -ne 0 ] && echo nope && exit 1
echo ok
