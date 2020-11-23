STACK	SEGMENT PARA STACK 'STACK'
	DB 100 DUP(?)
STACK	ENDS
DATA	SEGMENT
ASCSTG  DB  '5', 'A', '6', '1';16A5
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
A2H1:   LODSB;    ASCSTG;
        AND AL, 7FH;AL与01111111B，ASCII码一共能表示128个字符
        CMP AL, '0';AL小于'0'的ASCII码值说明不能转换，跳出
        JL  ERROR;
        CMP AL, '9';AL大于'9'的ASCII值需要进一步判断AL是否为A-F对应的ASCII码
        JG  A2H2
        SUB AL, 30H; num = ascii-30H
        JMP SHORT   A2H3
A2H2:   CMP AL, 'A'
        JL  ERROR
        CMP AL, 'F'
        JG  ERROR
        SUB AL, 37H; AH = ascii - 37H = 10D
A2H3:   OR  DL, AL;AL只有低4位有值，其余为0，把AL的低4位给DL的低４位，不改变DX的其他位
        ROR DX, CL;DX右移4次,把低四位移至最高位
        DEC CH
        JNZ A2H1
        MOV WORD PTR BIN, DX
ERROR:  MOV AH, 4CH
        INT 21H
CODE	ENDS
	END A2H