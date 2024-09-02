#!/usr/bin/bash

for((i = 1; ; ++i)); do
    ./task_2/gen $(($i % 2)) > ./task_2/input_file
    ./task_2/code < ./task_2/input_file > ./task_2/myAnswer
    ./task_2/brute < ./task_2/input_file > ./task_2/correctAnswer
    diff ./task_2/myAnswer ./task_2/correctAnswer > /dev/null || break # diff -Z for ignoring trailing spaces, find more
    echo "Passed test: "  $i
done
echo "WA on the following test:"
cat ./task_2/input_file
echo "Your answer is:"
cat ./task_2/myAnswer
echo "Correct answer is:"
cat ./task_2/correctAnswer
