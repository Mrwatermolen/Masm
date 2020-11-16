 DATA    SEGMENT
      STRING  DB   'Hello World!', '$'
  DATA    ENDS

  STACK1  SEGMENT PARA    STACK
      DW  20H DUP  (0)
  STACK1  ENDS
  CODE   SEGMENT
  ASSUME  CS:CODE, DS:DATA, SS:STACK1
  BEGIN:  MOV     AX, DATA
      MOV DS, AX
      LEA     DX, STRING
      MOV     AH, 9
      INT     21H
      MOV     AH, 4CH
      INT 21H
  CODE   ENDS

      END BEGIN
