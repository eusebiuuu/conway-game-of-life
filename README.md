# Conway's game of life and encryption
This project is a simulator based on the [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life) divided into 2 tasks: in the first one I am interested on what's the k-th state of the game and in the second one I am both encrypting and decrypting a text using the k-th state of the game and the binary obtained from the concatenation of the ASCII codes of the text's characters, using `XOR` operation. The code was written in assembly x86-32, CISC architecture, the other programs having a role only in the stress testing of tasks.

## Description
#### Task 1
This part intends to find the k-th state of the [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life) starting from a predefined state given as an input. To implement this I used an array that represents the matrix in which the game is played, but bordered with dead cells that cannot turn alive so that the code is cleaner and will less cases to handle. Also, I used position arrays to go through all the 8 direction around a cell in a simple manner.

#### Task 2
In this part I implemented an ecryption and decryption based on the same game. Basically, given an initial state of the game matrix and a text to ecrypt, I firstly get the k-th state using a method similar to the task 1's, then convert the text into binary format (each character is being converted into the corresponding byte from the ASCII table), and then I XOR the matrix written in a single line format (eventually concatenated with itself) with the binary of the text. The result is the encoding of the text. Decoding is similar due to XOR's associativity.

## Installation and usage
1. Clone the repo locally
```sh
git clone https://github.com/eusebiuuu/conway-game-of-life.git
```
2. Run the automated tests
```sh
make run_task_1
```
or
```sh
make run_task_2
```
> Ctrl + C to end the testing

3. Run custom tests
- Assemble and link the program
```sh
gcc -m32 './task_1/code.S' -o './task_1/code'
```
or
```sh
gcc -m32 './task_2/code.S' -o './task_2/code'
```
- Fill in the `<file_name>.txt`
- Run the program with the input
```sh
./task_1/code < <file_name>.txt
```
or
```sh
./task_2/code < <file_name>.txt > output.txt
```

For each task, each number is written on a new line in input file
For task 1, the input is as follows: number of lines, number of columns, number of alive cells, coordinates of each alive cells (row and column), number k.   
For task 2, the input format is the same, except that, after number k, comes a number t (0 - encryption, 1 - decryption) and a string (if t = 0 it is a text, otherwise it is a hex string).