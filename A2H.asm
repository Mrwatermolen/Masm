STACK	SEGMENT PARA STACK 'STACK'
		DB 100 DUP(?)
STACK	ENDS
DATA	SEGMENT
ASCSTG  DB  '5', 'A', '6', '1'
BIN     DB  2 DUP(0)
DATA	ENDS
CODE	SEGMENT
		ASSUME CS:CODE, SS:STACK, DS:DATA, ES:DATA
A2H:	MOV AX, DATA
		MOV DS, AX
		MOV ES, AX
		MOV CL, 4;
        MOV CH, CL
        MOV SI, OFFSET  ASCSTG
        CLD;DF=0
        XOR AX, AX;AX=0
        XOR DX, DX;DX=0
A2H1:   LODS    ASCSTG;
        AND AL, 7FH;
        CMP AL, '0';
        ;JL  ERROR;
        CMP AL, '9';
        JG  A2H2
        SUB AL, 30H;
        JMP SHORT   A2H3
A2H2:   CMP AL, 'A'
        ;JL  ERROR;
        CMP AL, 'F'
        ;JG  ERROR;
        SUB AL, 37H
A2H3:   OR  DL, AL;
        ROR DX, CL;
        DEC CH
        JNZ A2H1
        MOV WORD PTR BIN, DX
        MOV AH, 4CH
        INT 21H
CODE	ENDS
		END A2H