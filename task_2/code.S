.data
  rows: .space 4
  cols: .space 4
  alive: .space 4
  iter: .space 4
  type: .space 4
  outputN: .asciz "%ld\n"
  outputS: .asciz "%ld "
  input2: .asciz "%ld %ld"
  input3: .asciz "%ld %ld %ld"
  string: .space 100
  inputStr: .asciz "%ls"
  outputCh: .asciz "%c"
  hexFormatAns: .asciz "0x%s"
  xorredMess: .space 400
  stringBits: .space 400
  matrix: .space 2000
  oldMatrix: .space 2000
  stringNums: .space 400
  matSize: .space 4
  auxR: .space 4
  auxC: .space 4
  dirR: .long -1, -1, -1, 0, 0, 1, 1, 1
  dirC: .long -1, 0, 1, -1, 1, -1, 0, 1
  dirSz: .long 8
  decimalArray: .space 400
  count: .space 4
  counter: .space 4
  len: .space 4
  hexSymbols: .asciz "0123456789ABCDEF"
  stringAns: .space 100
  newline: .asciz "\n"

.text
convertDecimalToBinary:
  pushl %ebp
  movl %esp, %ebp
  lea stringNums, %edi
  lea stringBits, %esi
  xor %edx, %edx
  xor %eax, %eax
  addBits:
    mov len, %ebx
    cmp %edx, %ebx
    je endConvertDecimalToBinary
    mov 8(%ebp), %ecx
    mov (%edi, %edx, 4), %ebx
    mov %edx, counter
    iterateBits:
      dec %ecx
      mov $1, %edx
      shl %ecx, %edx
      and %ebx, %edx
      shr %ecx, %edx
      mov %edx, (%esi, %eax, 4)
      inc %eax
      xor %edx, %edx
      cmp %edx, %ecx
      jne iterateBits
    mov counter, %edx
    inc %edx
    jmp addBits
  endConvertDecimalToBinary:
    mov %eax, len
    popl %ebp
    ret

xor2Arrays:
  pushl %ebp
  mov %esp, %ebp
  mov 8(%ebp), %edi
  mov 12(%ebp), %ebx
  xor %ecx, %ecx
  traverseArr:
    mov 16(%ebp), %esi
    mov 12(%ebp), %ebx
    cmp %ebx, %ecx
    je endXor
    mov 20(%ebp), %ebx
    mov %ecx, %eax
    xor %edx, %edx
    div %ebx
    mov %edx, %eax
    mov (%edi, %ecx, 4), %ebx
    mov (%esi, %eax, 4), %edx
    xor %edx, %ebx
    lea xorredMess, %esi
    mov %ebx, (%esi, %ecx, 4)
    inc %ecx
    jmp traverseArr
  endXor:
    popl %ebp
    ret

convertBinaryToDecimal:
  pushl %ebp
  mov %esp, %ebp
  preparationConversion:
    xor %ecx, %ecx
    xor %esi, %esi
  conversion:
    lea xorredMess, %edi
    mov len, %eax
    cmp %eax, %esi
    je conversionEnding
    mov 8(%ebp), %edx
    xor %ebx, %ebx
    getDecimalNum:
      dec %edx
      mov (%edi, %esi, 4), %eax
      mov %ecx, counter
      mov %edx, %ecx
      shl %ecx, %eax
      mov counter, %ecx
      add %eax, %ebx
      inc %esi
      xor %eax, %eax
      cmp %eax, %edx
      je endDecimalConversion
      jmp getDecimalNum
    endDecimalConversion:
      lea decimalArray, %edi
      mov %ebx, (%edi, %ecx, 4)
      inc %ecx
      jmp conversion
  conversionEnding:
    mov %ecx, len
    popl %ebp
    ret

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
  lea matrix, %edi
  readDimensions:
    pushl $alive
    pushl $cols
    pushl $rows
    pushl $input3
    call scanf
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
    je readRest
    pushl %ecx
    pushl $auxC
    pushl $auxR
    pushl $input2
    call scanf
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
  readRest:
    pushl $type
    pushl $iter
    pushl $input2
    call scanf
    popl %eax
    popl %eax
    popl %eax
    pushl $string
    pushl $inputStr
    call scanf
    popl %eax
    popl %eax
  iterateMatrix:
    xor %esi, %esi
    kLoop:
      mov iter, %eax
      cmp %eax, %esi
      je preparation
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
  preparation:
    mov rows, %eax
    mov cols, %ebx
    mull %ebx
    movl %eax, matSize
    xor %eax, %eax
    mov %eax, len
    xor %eax, %eax
    mov type, %ebx
    cmp %eax, %ebx
    jne solveStatement2

  solveStatement1:
    xor %ecx, %ecx
    lea stringNums, %edi
    lea string, %esi
    convertStringToBinary:
      mov %ecx, len
      mov (%esi, %ecx, 4), %eax
      xor %ebx, %ebx
      cmp %eax, %ebx
      je xorTheArrays
      mov %eax, (%edi, %ecx, 4)
      inc %ecx
      jmp convertStringToBinary
    xorTheArrays:
      pushl $8
      call convertDecimalToBinary
      popl %eax
      pushl matSize
      pushl $matrix
      pushl len
      pushl $stringBits
      call xor2Arrays
      add $16, %esp
      xor %ecx, %ecx
    convertBinaryToHex:
      pushl $4
      call convertBinaryToDecimal
      add $4, %esp
      xor %ecx, %ecx
      lea stringAns, %edi
    convertDecimalToHex:
      mov len, %eax
      cmp %eax, %ecx
      je printMessage
      lea decimalArray, %esi
      mov (%esi, %ecx, 4), %eax
      lea hexSymbols, %esi
      mov (%esi, %eax, 1), %al
      mov %al, (%edi, %ecx, 1)
      inc %ecx
      jmp convertDecimalToHex
    printMessage:
      lea stringAns, %edi
      pushl %edi
      pushl $hexFormatAns
      call printf
      popl %eax
      popl %eax
      jmp exit

  solveStatement2:
    mov $0, %ecx
    lea string, %edi
    convertHexToDecimal:
      mov %ecx, len
      mov 8(%edi, %ecx, 4), %ebx
      xor %eax, %eax
      cmp %eax, %ebx
      je printWord
      mov $60, %eax
      cmp %eax, %ebx
      jg isLetter
      sub $48, %ebx
      jmp appendNumToArray
      isLetter:
        sub $55, %ebx
      appendNumToArray:
        lea stringNums, %esi
        mov %ebx, (%esi, %ecx, 4)
        inc %ecx
        jmp convertHexToDecimal
    printWord:
      pushl $4
      call convertDecimalToBinary
      popl %eax
      pushl matSize
      pushl $matrix
      pushl len
      pushl $stringBits
      call xor2Arrays
      add $16, %esp
      pushl $8
      call convertBinaryToDecimal
      popl %eax
      xor %ecx, %ecx
      lea decimalArray, %edi
      lea stringAns, %esi
      moveDecimalToString:
        mov len, %eax
        cmp %eax, %ecx
        je exit
        mov (%edi, %ecx, 4), %eax
        pushl %ecx
        pushl %eax
        pushl $outputCh
        call printf
        popl %eax
        popl %eax
        popl %ecx
        inc %ecx
        jmp moveDecimalToString
exit:
  pushl $newline
  call printf
  popl %eax
  pushl $0
  call fflush
  popl %eax
  mov $1, %eax
  xor %ebx, %ebx
  int $0x80