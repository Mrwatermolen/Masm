STACK	SEGMENT PARA STACK 'STACK'
		DB 100 DUP(?)
STACK	ENDS
DATA	SEGMENT
BINNUM  DW  4FFFH;20479D
ASCDCD  DB  5 DUP(0)
DATA	ENDS
CODE	SEGMENT
	ASSUME CS:CODE, SS:STACK, DS:DATA, ES:DATA
B2A:	MOV AX, DATA
	MOV DS, AX
	MOV ES, AX
	MOV CX, 5;4FFFH=20479D　一共有5个数
        XOR DX, DX;清零DX
        MOV BX, 10
        MOV AX, BINNUM
        MOV DI, OFFSET  ASCDCD
B2A1:   DIV BX;AX/BX 商放在AX,余数放在DX　取AX的最后一位 并且把AX/10的结果给AX
        ADD DL, 30H;DL+48 ASCII与数字的转化　'0' = 48D = 30H
        MOV [DI],   DL
        INC DI
        AND AX, AX;CF清零
        CMP CX, 5
        JC  STOP;如果AX全0，说明转换结束，跳出
        MOV DL, 0
        LOOP    B2A1
STOP:   MOV AH, 4CH
        INT 21H
CODE	ENDS
		END B2A