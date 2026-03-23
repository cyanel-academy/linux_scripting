#!/bin/bash

names='Stan Kyle Cartman'

for name in $names
do
	echo $name
done

print_return () {
	echo Hello $1
	return 5
}
print_return John
