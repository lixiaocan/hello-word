#!/bin/sh


echo "test begain!"

:<<Block
echo '1'
echo '2'
echo "3"
echo "4"
Block


VALUE=123456

echo "5" 
if false
then
	echo '6' 
fi

echo "$VALUE"
