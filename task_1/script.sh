#!/usr/bin/bash

set -e
for((i = 1; ; ++i));
do
    ./task_1/gen $i > ./task_1/input_file
    ./task_1/code < ./task_1/input_file > ./task_1/myAnswer
    ./task_1/brute < ./task_1/input_file > ./task_1/correctAnswer
    diff ./task_1/myAnswer ./task_1/correctAnswer > /dev/null || break # diff -Z for ignoring trailing spaces, find more
    echo "Passed test: "  $i;
done
echo "WA on the following test:"
cat ./task_1/input_file
echo "Your answer is:"
cat ./task_1/myAnswer
echo "Correct answer is:"
cat ./task_1/correctAnswer
