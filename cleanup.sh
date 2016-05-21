#!/bin/bash
echo Cleanup old directories
for dir in work; do
	rm -rf ${dir}
done
