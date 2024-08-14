.data
  rows: .space 4
  cols: .space 4
  alive: .space 4
  iter: .space 4
  outputN: .asciz "%ld\n"
  outputS: .asciz "%ld "
  input1: .asciz "%ld"
  input2: .asciz "%ld %ld"
  input3: .asciz "%ld %ld %ld"
  matrix: .space 2000
  oldMatrix: .space 2000
  auxR: .space 4
  auxC: .space 4
  dirR: .long -1, -1, -1, 0, 0, 1, 1, 1
  dirC: .long -1, 0, 1, -1, 1, -1, 0, 1
  dirSz: .long 8
  count: .space 4
  counter: .space 4
  len: .space 4
  inputFileName: .asciz "in.txt"
  outputFileName: .asciz "out.txt"
  outputFile: .space 4
  inputFile: .space 4
  readMode: .asciz "r"
  writeMode: .asciz "w"
  newLine: .asciz "\n"
.text
getCount:
  pushl %ebp
  movl %esp, %ebp
  xor %ecx, %ecx
  mov %ecx, count
  checkNeighbours:
    movl 8(%ebp), %edx
    movl 12(%ebp), %ebx
    lea dirR, %edi
    lea dirC, %esi
    mov dirSz, %eax
    cmp %eax, %ecx
    je end
    mov (%edi, %ecx, 4), %eax
    addl %edx, %eax
    mov %eax, auxR
    mov (%esi, %ecx, 4), %eax
    add %ebx, %eax
    mov %eax, auxC
    mov cols, %eax
    mov auxR, %esi
    mull %esi
    mov auxC, %esi
    add %esi, %eax
    lea oldMatrix, %edi
    mov (%edi, %eax, 4), %esi
    mov count, %eax
    add %esi, %eax
    mov %eax, count
    inc %ecx
    jmp checkNeighbours
  end:
    mov count, %eax
    popl %ebp
    ret

getType:
  pushl %ebp
  movl %esp, %ebp
  movl 8(%ebp), %ecx
  movl 12(%ebp), %ebx
  xor %eax, %eax
  mov $2, %edx
  cmp %ecx, %edx
  je countIs2
  mov $3, %edx
  cmp %ecx, %edx
  je countIs3
  jmp endGetType
  countIs2:
    mov %ebx, %eax
    jmp endGetType
  countIs3:
    xor $1, %eax
  endGetType:
    popl %ebp
    ret
.global main
main:
  pushl $writeMode
  pushl $outputFileName
  call fopen
  popl %ebx
  popl %ebx
  mov %eax, outputFile
  pushl $readMode
  pushl $inputFileName
  call fopen
  popl %ebx
  popl %ebx
  mov %eax, inputFile
  lea matrix, %edi
  readDimensions:
    pushl $alive
    pushl $cols
    pushl $rows
    pushl $input3
    pushl inputFile
    call fscanf
    popl %eax
    popl %eax
    popl %eax
    popl %eax
    popl %eax
    movl rows, %ecx
    add $2, %ecx
    movl %ecx, rows
    movl cols, %ecx
    add $2, %ecx
    movl %ecx, cols
    xor %ecx, %ecx
  readMatrix:
    movl alive, %eax
    cmp %eax, %ecx
    je readK
    pushl %ecx
    pushl $auxC
    pushl $auxR
    pushl $input2
    pushl inputFile
    call fscanf
    popl %eax
    popl %eax
    popl %eax
    popl %eax
    popl %ecx
    movl auxR, %eax
    movl auxC, %esi
    add $1, %eax
    add $1, %esi
    movl cols, %ebx
    mull %ebx
    add %esi, %eax
    mov $1, %edx
    mov %edx, (%edi, %eax, 4)
    inc %ecx
    jmp readMatrix
  readK:
    pushl $iter
    pushl $input1
    pushl inputFile
    call fscanf
    popl %eax
    popl %eax
    popl %eax
  iterateMatrix:
    xor %esi, %esi
    kLoop:
      mov iter, %eax
      cmp %eax, %esi
      je finalCleanup
      xor %ecx, %ecx
      mov %esi, counter
      lea oldMatrix, %esi
      copyMatrix:
        mov rows, %eax
        mov cols, %ebx
        mull %ebx
        cmp %ecx, %eax
        je rowsLoopPreparation
        mov (%edi, %ecx, 4), %eax
        mov %eax, (%esi, %ecx, 4)
        inc %ecx
        jmp copyMatrix
      rowsLoopPreparation:
        mov counter, %esi
        mov $1, %ecx
      rowsLoop:
        mov rows, %eax
        sub $1, %eax
        cmp %ecx, %eax
        je endKLoop
        mov $1, %ebx
        colsLoop:
          mov cols, %eax
          sub $1, %eax
          cmp %eax, %ebx
          je endRowsLoop
          mov %ecx, counter
          pushl %edi
          pushl %esi
          pushl %ebx
          pushl %ebx
          pushl %ecx
          call getCount
          popl %ecx
          popl %ebx
          popl %ebx
          popl %esi
          popl %edi
          mov counter, %ecx
          mov %eax, count
          mov cols, %eax
          mull %ecx
          add %ebx, %eax
          mov (%edi, %eax, 4), %edx
          mov %eax, len
          mov %ecx, counter
          mov count, %ecx
          pushl %edi
          pushl %esi
          pushl %ebx
          pushl %edx
          pushl %ecx
          call getType
          popl %ecx
          popl %edx
          popl %ebx
          popl %esi
          popl %edi
          mov counter, %ecx
          mov %ebx, counter
          mov len, %ebx
          mov %eax, (%edi, %ebx, 4)
          mov counter, %ebx
          inc %ebx
          jmp colsLoop
      endRowsLoop:
        inc %ecx
        jmp rowsLoop
    endKLoop:
      inc %esi
      jmp kLoop
  finalCleanup:
    mov $1, %ecx
  printMatrix:
    mov rows, %eax
    sub $1, %eax
    cmp %ecx, %eax
    je exit
    mov $1, %ebx
    printRow:
      movl cols, %eax
      sub $1, %eax
      cmp %eax, %ebx
      jge loopEnd
      movl cols, %eax
      mull %ecx
      add %ebx, %eax
      mov (%edi, %eax, 4), %edx
      pushl %ecx
      pushl %ebx
      pushl %edx
      pushl $outputS
      pushl outputFile
      call fprintf
      popl %eax
      popl %eax
      popl %eax
      popl %ebx
      popl %ecx
      pushl %ecx
      pushl %ebx
      pushl $0
      call fflush
      popl %eax
      popl %ebx
      popl %ecx
      inc %ebx
      jmp printRow
    loopEnd:
      pushl %ecx
      pushl %edx
      pushl $newLine
      pushl outputFile
      call fprintf
      popl %edx
      popl %edx
      popl %edx
      popl %ecx
      inc %ecx
      jmp printMatrix
exit:
  pushl $0
  call fflush
  popl %eax
  mov $1, %eax
  xor %ebx, %ebx
  int $0x80