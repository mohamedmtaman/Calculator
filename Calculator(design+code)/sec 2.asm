
_truncateTo5_answerString:

;sec 2.c,57 :: 		void truncateTo5_answerString(){       //truncate answerString after 5
;sec 2.c,58 :: 		pointLocation = expLocation = width; //out of bound so the string replacement wont do anything
	MOVLW      17
	MOVWF      _expLocation+0
	MOVLW      0
	MOVWF      _expLocation+1
	MOVLW      17
	MOVWF      _pointLocation+0
	MOVLW      0
	MOVWF      _pointLocation+1
;sec 2.c,59 :: 		strlength = strlen(answerString);
	MOVLW      _answerString+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVF       R0+0, 0
	MOVWF      _strlength+0
	MOVF       R0+1, 0
	MOVWF      _strlength+1
;sec 2.c,61 :: 		for (j = 0; j < strlength; j++)
	CLRF       _j+0
L_truncateTo5_answerString0:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _strlength+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__truncateTo5_answerString60
	MOVF       _strlength+0, 0
	SUBWF      _j+0, 0
L__truncateTo5_answerString60:
	BTFSC      STATUS+0, 0
	GOTO       L_truncateTo5_answerString1
;sec 2.c,62 :: 		if (answerString[j] == '.')
	MOVF       _j+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      46
	BTFSS      STATUS+0, 2
	GOTO       L_truncateTo5_answerString3
;sec 2.c,63 :: 		pointLocation = j;
	MOVF       _j+0, 0
	MOVWF      _pointLocation+0
	CLRF       _pointLocation+1
	GOTO       L_truncateTo5_answerString4
L_truncateTo5_answerString3:
;sec 2.c,64 :: 		else if (answerString[j] == 'e')
	MOVF       _j+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      101
	BTFSS      STATUS+0, 2
	GOTO       L_truncateTo5_answerString5
;sec 2.c,65 :: 		expLocation = j;
	MOVF       _j+0, 0
	MOVWF      _expLocation+0
	CLRF       _expLocation+1
L_truncateTo5_answerString5:
L_truncateTo5_answerString4:
;sec 2.c,61 :: 		for (j = 0; j < strlength; j++)
	INCF       _j+0, 1
;sec 2.c,65 :: 		expLocation = j;
	GOTO       L_truncateTo5_answerString0
L_truncateTo5_answerString1:
;sec 2.c,67 :: 		if (expLocation == width) //no exponential found
	MOVLW      0
	XORWF      _expLocation+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__truncateTo5_answerString61
	MOVLW      17
	XORWF      _expLocation+0, 0
L__truncateTo5_answerString61:
	BTFSS      STATUS+0, 2
	GOTO       L_truncateTo5_answerString6
;sec 2.c,69 :: 		for (j = pointLocation + 6; j < width; j++)   //truncate after 5
	MOVLW      6
	ADDWF      _pointLocation+0, 0
	MOVWF      _j+0
L_truncateTo5_answerString7:
	MOVLW      17
	SUBWF      _j+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_truncateTo5_answerString8
;sec 2.c,71 :: 		answerString[j] = 0;//this is '\0'*/
	MOVF       _j+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	CLRF       INDF+0
;sec 2.c,69 :: 		for (j = pointLocation + 6; j < width; j++)   //truncate after 5
	INCF       _j+0, 1
;sec 2.c,72 :: 		}
	GOTO       L_truncateTo5_answerString7
L_truncateTo5_answerString8:
;sec 2.c,73 :: 		} else {  //we have exponential
	GOTO       L_truncateTo5_answerString10
L_truncateTo5_answerString6:
;sec 2.c,75 :: 		for (j = expLocation + 1; j < strlength; j++)   //move them
	INCF       _expLocation+0, 0
	MOVWF      _j+0
L_truncateTo5_answerString11:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _strlength+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__truncateTo5_answerString62
	MOVF       _strlength+0, 0
	SUBWF      _j+0, 0
L__truncateTo5_answerString62:
	BTFSC      STATUS+0, 0
	GOTO       L_truncateTo5_answerString12
;sec 2.c,77 :: 		answerString[j + 3] = answerString[j];
	MOVLW      3
	ADDWF      _j+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _answerString+0
	MOVWF      R1+0
	MOVF       _j+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;sec 2.c,75 :: 		for (j = expLocation + 1; j < strlength; j++)   //move them
	INCF       _j+0, 1
;sec 2.c,78 :: 		}
	GOTO       L_truncateTo5_answerString11
L_truncateTo5_answerString12:
;sec 2.c,79 :: 		answerString[expLocation] = 'x';
	MOVF       _expLocation+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVLW      120
	MOVWF      INDF+0
;sec 2.c,80 :: 		answerString[expLocation + 1] = '1';
	MOVF       _expLocation+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _expLocation+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVLW      49
	MOVWF      INDF+0
;sec 2.c,81 :: 		answerString[expLocation + 2] = '0';
	MOVLW      2
	ADDWF      _expLocation+0, 0
	MOVWF      R0+0
	MOVF       _expLocation+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
;sec 2.c,82 :: 		answerString[expLocation + 3] = '^';
	MOVLW      3
	ADDWF      _expLocation+0, 0
	MOVWF      R0+0
	MOVF       _expLocation+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVLW      94
	MOVWF      INDF+0
;sec 2.c,84 :: 		answerString[strlength + 3] = 0;//this is '\0'*/
	MOVLW      3
	ADDWF      _strlength+0, 0
	MOVWF      R0+0
	MOVF       _strlength+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	CLRF       INDF+0
;sec 2.c,85 :: 		}
L_truncateTo5_answerString10:
;sec 2.c,86 :: 		}
	RETURN
; end of _truncateTo5_answerString

_welcomeToUseless:

;sec 2.c,92 :: 		void welcomeToUseless() {
;sec 2.c,93 :: 		Lcd_Out(1, 1, " Welcome To The ");   // Write to the first row
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_sec_322+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;sec 2.c,94 :: 		delay_ms(1000);                     // Delay of 0.5s
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_welcomeToUseless14:
	DECFSZ     R13+0, 1
	GOTO       L_welcomeToUseless14
	DECFSZ     R12+0, 1
	GOTO       L_welcomeToUseless14
	DECFSZ     R11+0, 1
	GOTO       L_welcomeToUseless14
	NOP
	NOP
;sec 2.c,96 :: 		for (i = 0; i < 34 * 2; i++) {
	CLRF       _i+0
L_welcomeToUseless15:
	MOVLW      68
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_welcomeToUseless16
;sec 2.c,97 :: 		Lcd_Out(2, 1, UselessString + (i % 34)); //shift the string
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      34
	MOVWF      R4+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      _UselessString+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;sec 2.c,98 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_welcomeToUseless18:
	DECFSZ     R13+0, 1
	GOTO       L_welcomeToUseless18
	DECFSZ     R12+0, 1
	GOTO       L_welcomeToUseless18
	NOP
;sec 2.c,96 :: 		for (i = 0; i < 34 * 2; i++) {
	INCF       _i+0, 1
;sec 2.c,99 :: 		}
	GOTO       L_welcomeToUseless15
L_welcomeToUseless16:
;sec 2.c,100 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,101 :: 		}
	RETURN
; end of _welcomeToUseless

_compute:

;sec 2.c,105 :: 		float compute() { //c computes from left to write
;sec 2.c,106 :: 		answer = atof(answerString); //ascii to float
	MOVLW      _answerString+0
	MOVWF      FARG_atof_s+0
	CALL       _atof+0
	MOVF       R0+0, 0
	MOVWF      _answer+0
	MOVF       R0+1, 0
	MOVWF      _answer+1
	MOVF       R0+2, 0
	MOVWF      _answer+2
	MOVF       R0+3, 0
	MOVWF      _answer+3
;sec 2.c,107 :: 		second = atof(secondString); //ascii to float
	MOVLW      _secondString+0
	MOVWF      FARG_atof_s+0
	CALL       _atof+0
	MOVF       R0+0, 0
	MOVWF      _second+0
	MOVF       R0+1, 0
	MOVWF      _second+1
	MOVF       R0+2, 0
	MOVWF      _second+2
	MOVF       R0+3, 0
	MOVWF      _second+3
;sec 2.c,109 :: 		switch (operation) {
	GOTO       L_compute19
;sec 2.c,110 :: 		case '+':return answer + second;
L_compute21:
	MOVF       _answer+0, 0
	MOVWF      R0+0
	MOVF       _answer+1, 0
	MOVWF      R0+1
	MOVF       _answer+2, 0
	MOVWF      R0+2
	MOVF       _answer+3, 0
	MOVWF      R0+3
	MOVF       _second+0, 0
	MOVWF      R4+0
	MOVF       _second+1, 0
	MOVWF      R4+1
	MOVF       _second+2, 0
	MOVWF      R4+2
	MOVF       _second+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	RETURN
;sec 2.c,111 :: 		case '-':return answer - second;
L_compute22:
	MOVF       _second+0, 0
	MOVWF      R4+0
	MOVF       _second+1, 0
	MOVWF      R4+1
	MOVF       _second+2, 0
	MOVWF      R4+2
	MOVF       _second+3, 0
	MOVWF      R4+3
	MOVF       _answer+0, 0
	MOVWF      R0+0
	MOVF       _answer+1, 0
	MOVWF      R0+1
	MOVF       _answer+2, 0
	MOVWF      R0+2
	MOVF       _answer+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	RETURN
;sec 2.c,112 :: 		case 'x':return answer * second;
L_compute23:
	MOVF       _answer+0, 0
	MOVWF      R0+0
	MOVF       _answer+1, 0
	MOVWF      R0+1
	MOVF       _answer+2, 0
	MOVWF      R0+2
	MOVF       _answer+3, 0
	MOVWF      R0+3
	MOVF       _second+0, 0
	MOVWF      R4+0
	MOVF       _second+1, 0
	MOVWF      R4+1
	MOVF       _second+2, 0
	MOVWF      R4+2
	MOVF       _second+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	RETURN
;sec 2.c,113 :: 		case '/':return answer / second;
L_compute24:
	MOVF       _second+0, 0
	MOVWF      R4+0
	MOVF       _second+1, 0
	MOVWF      R4+1
	MOVF       _second+2, 0
	MOVWF      R4+2
	MOVF       _second+3, 0
	MOVWF      R4+3
	MOVF       _answer+0, 0
	MOVWF      R0+0
	MOVF       _answer+1, 0
	MOVWF      R0+1
	MOVF       _answer+2, 0
	MOVWF      R0+2
	MOVF       _answer+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	RETURN
;sec 2.c,114 :: 		default :return answer;
L_compute25:
	MOVF       _answer+0, 0
	MOVWF      R0+0
	MOVF       _answer+1, 0
	MOVWF      R0+1
	MOVF       _answer+2, 0
	MOVWF      R0+2
	MOVF       _answer+3, 0
	MOVWF      R0+3
	RETURN
;sec 2.c,115 :: 		}
L_compute19:
	MOVF       _operation+0, 0
	XORLW      43
	BTFSC      STATUS+0, 2
	GOTO       L_compute21
	MOVF       _operation+0, 0
	XORLW      45
	BTFSC      STATUS+0, 2
	GOTO       L_compute22
	MOVF       _operation+0, 0
	XORLW      120
	BTFSC      STATUS+0, 2
	GOTO       L_compute23
	MOVF       _operation+0, 0
	XORLW      47
	BTFSC      STATUS+0, 2
	GOTO       L_compute24
	GOTO       L_compute25
;sec 2.c,116 :: 		}
	RETURN
; end of _compute

_main:

;sec 2.c,118 :: 		void main() {
;sec 2.c,123 :: 		TrisD=0b00000001;
	MOVLW      1
	MOVWF      TRISD+0
;sec 2.c,124 :: 		portd.B1=1;
	BSF        PORTD+0, 1
;sec 2.c,127 :: 		Lcd_Init();                     // Initialize LCD
	CALL       _Lcd_Init+0
;sec 2.c,134 :: 		Keypad_Init();                  // Initialize Keypad
	CALL       _Keypad_Init+0
;sec 2.c,135 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);       // Cursor Off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,137 :: 		welcomeToUseless(); //welcome LCD
	CALL       _welcomeToUseless+0
;sec 2.c,138 :: 		i=0;
	CLRF       _i+0
;sec 2.c,139 :: 		do {//start a new session
L_main26:
;sec 2.c,142 :: 		do
L_main29:
;sec 2.c,144 :: 		keypad_key_pressed = Keypad_Key_Click(); // Store key code in keypad_key_pressed variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _keypad_key_pressed+0
	CLRF       _keypad_key_pressed+1
;sec 2.c,145 :: 		while (PORTD.B0) keypad_key_pressed=17;
L_main32:
	BTFSS      PORTD+0, 0
	GOTO       L_main33
	MOVLW      17
	MOVWF      _keypad_key_pressed+0
	MOVLW      0
	MOVWF      _keypad_key_pressed+1
	GOTO       L_main32
L_main33:
;sec 2.c,147 :: 		while (!keypad_key_pressed);
	MOVF       _keypad_key_pressed+0, 0
	IORWF      _keypad_key_pressed+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
;sec 2.c,149 :: 		keypad_key_pressed = keypadLookUP[keypad_key_pressed - 1];  //get the character from the look up table
	MOVLW      1
	SUBWF      _keypad_key_pressed+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _keypad_key_pressed+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _keypadLookUP+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _keypad_key_pressed+0
	CLRF       _keypad_key_pressed+1
	MOVLW      0
	MOVWF      _keypad_key_pressed+1
;sec 2.c,151 :: 		if(keypad_key_pressed=='C')
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      67
	XORWF      _keypad_key_pressed+0, 0
L__main63:
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;sec 2.c,153 :: 		Lcd_Cmd(_LCD_CLEAR),state=i=belongToCal=answer=second=secondString[1]= secondString[1]=dotSeen=0;
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	BCF        _dotSeen+0, BitPos(_dotSeen+0)
	MOVLW      0
	BTFSC      _dotSeen+0, BitPos(_dotSeen+0)
	MOVLW      1
	MOVWF      _secondString+1
	MOVF       _secondString+1, 0
	MOVWF      R0+0
	CALL       _Byte2Double+0
	MOVF       R0+0, 0
	MOVWF      _second+0
	MOVF       R0+1, 0
	MOVWF      _second+1
	MOVF       R0+2, 0
	MOVWF      _second+2
	MOVF       R0+3, 0
	MOVWF      _second+3
	MOVF       R0+0, 0
	MOVWF      _answer+0
	MOVF       R0+1, 0
	MOVWF      _answer+1
	MOVF       R0+2, 0
	MOVWF      _answer+2
	MOVF       R0+3, 0
	MOVWF      _answer+3
	BTFSC      R0+0, 0
	GOTO       L__main64
	BCF        _belongToCal+0, BitPos(_belongToCal+0)
	GOTO       L__main65
L__main64:
	BSF        _belongToCal+0, BitPos(_belongToCal+0)
L__main65:
	MOVLW      0
	BTFSC      _belongToCal+0, BitPos(_belongToCal+0)
	MOVLW      1
	MOVWF      _i+0
	BTFSC      _i+0, 0
	GOTO       L__main66
	BCF        _state+0, BitPos(_state+0)
	GOTO       L__main67
L__main66:
	BSF        _state+0, BitPos(_state+0)
L__main67:
;sec 2.c,154 :: 		secondString[0]=answerString[0]='0';
	MOVLW      48
	MOVWF      _answerString+0
	MOVLW      48
	MOVWF      _secondString+0
;sec 2.c,155 :: 		}
	GOTO       L_main35
L_main34:
;sec 2.c,156 :: 		else if(keypad_key_pressed=='=') {
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVLW      61
	XORWF      _keypad_key_pressed+0, 0
L__main68:
	BTFSS      STATUS+0, 2
	GOTO       L_main36
;sec 2.c,157 :: 		if(state){//state 1
	BTFSS      _state+0, BitPos(_state+0)
	GOTO       L_main37
;sec 2.c,158 :: 		belongToCal=1;state=0;
	BSF        _belongToCal+0, BitPos(_belongToCal+0)
	BCF        _state+0, BitPos(_state+0)
;sec 2.c,159 :: 		answer=compute();
	CALL       _compute+0
	MOVF       R0+0, 0
	MOVWF      _answer+0
	MOVF       R0+1, 0
	MOVWF      _answer+1
	MOVF       R0+2, 0
	MOVWF      _answer+2
	MOVF       R0+3, 0
	MOVWF      _answer+3
;sec 2.c,160 :: 		}
L_main37:
;sec 2.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,163 :: 		FloatToStr(answer, answerString); //convert to string and put the result in answerString
	MOVF       _answer+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _answer+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _answer+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _answer+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _answerString+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;sec 2.c,165 :: 		truncateTo5_answerString();//answerString truncation
	CALL       _truncateTo5_answerString+0
;sec 2.c,166 :: 		Lcd_Out(2, 1, answerString); //print answer
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _answerString+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;sec 2.c,167 :: 		i=0;
	CLRF       _i+0
;sec 2.c,168 :: 		}
	GOTO       L_main38
L_main36:
;sec 2.c,170 :: 		else if(keypad_key_pressed=='+'||keypad_key_pressed=='-'||keypad_key_pressed=='x'||keypad_key_pressed=='/'){//opertion
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVLW      43
	XORWF      _keypad_key_pressed+0, 0
L__main69:
	BTFSC      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVLW      45
	XORWF      _keypad_key_pressed+0, 0
L__main70:
	BTFSC      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      120
	XORWF      _keypad_key_pressed+0, 0
L__main71:
	BTFSC      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      47
	XORWF      _keypad_key_pressed+0, 0
L__main72:
	BTFSC      STATUS+0, 2
	GOTO       L__main59
	GOTO       L_main41
L__main59:
;sec 2.c,171 :: 		if(state){//state 1
	BTFSS      _state+0, BitPos(_state+0)
	GOTO       L_main42
;sec 2.c,173 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,174 :: 		if(i>0)//we have second
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main43
;sec 2.c,176 :: 		answer=compute();
	CALL       _compute+0
	MOVF       R0+0, 0
	MOVWF      _answer+0
	MOVF       R0+1, 0
	MOVWF      _answer+1
	MOVF       R0+2, 0
	MOVWF      _answer+2
	MOVF       R0+3, 0
	MOVWF      _answer+3
;sec 2.c,177 :: 		FloatToStr(answer, answerString); //compute and convert to string and put the result in answerString
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _answerString+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;sec 2.c,178 :: 		truncateTo5_answerString();//answerString truncation
	CALL       _truncateTo5_answerString+0
;sec 2.c,179 :: 		Lcd_Out(1, 1, answerString); //print answer
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _answerString+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;sec 2.c,180 :: 		belongToCal=1;
	BSF        _belongToCal+0, BitPos(_belongToCal+0)
;sec 2.c,181 :: 		}
L_main43:
;sec 2.c,182 :: 		Lcd_Chr(2, 1, keypad_key_pressed);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;sec 2.c,183 :: 		operation=keypad_key_pressed;
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      _operation+0
;sec 2.c,184 :: 		dotSeen=i=0;//for second
	CLRF       _i+0
	BCF        _dotSeen+0, BitPos(_dotSeen+0)
;sec 2.c,186 :: 		}
	GOTO       L_main44
L_main42:
;sec 2.c,188 :: 		if(!belongToCal) answerString[i]=0;
	BTFSC      _belongToCal+0, BitPos(_belongToCal+0)
	GOTO       L_main45
	MOVF       _i+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	CLRF       INDF+0
L_main45:
;sec 2.c,190 :: 		operation=keypad_key_pressed;
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      _operation+0
;sec 2.c,191 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,192 :: 		Lcd_Chr(2, 1, keypad_key_pressed);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;sec 2.c,193 :: 		dotSeen=i=0;
	CLRF       _i+0
	BCF        _dotSeen+0, BitPos(_dotSeen+0)
;sec 2.c,194 :: 		state=1;
	BSF        _state+0, BitPos(_state+0)
;sec 2.c,195 :: 		}
L_main44:
;sec 2.c,197 :: 		secondString[0]='0';
	MOVLW      48
	MOVWF      _secondString+0
;sec 2.c,198 :: 		secondString[1]=0;
	CLRF       _secondString+1
;sec 2.c,200 :: 		}
	GOTO       L_main46
L_main41:
;sec 2.c,203 :: 		if((!dotSeen || keypad_key_pressed!='.') && i < width-1)//dot not seen or not dot
	BTFSS      _dotSeen+0, BitPos(_dotSeen+0)
	GOTO       L__main58
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      46
	XORWF      _keypad_key_pressed+0, 0
L__main73:
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	GOTO       L_main51
L__main58:
	MOVLW      16
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main51
L__main57:
;sec 2.c,205 :: 		if(keypad_key_pressed=='.') dotSeen=1;
	MOVLW      0
	XORWF      _keypad_key_pressed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      46
	XORWF      _keypad_key_pressed+0, 0
L__main74:
	BTFSS      STATUS+0, 2
	GOTO       L_main52
	BSF        _dotSeen+0, BitPos(_dotSeen+0)
L_main52:
;sec 2.c,207 :: 		if(state)//state 1
	BTFSS      _state+0, BitPos(_state+0)
	GOTO       L_main53
;sec 2.c,209 :: 		if(belongToCal){
	BTFSS      _belongToCal+0, BitPos(_belongToCal+0)
	GOTO       L_main54
;sec 2.c,210 :: 		belongToCal=0;
	BCF        _belongToCal+0, BitPos(_belongToCal+0)
;sec 2.c,211 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,212 :: 		Lcd_Chr(2, 1, operation);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _operation+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;sec 2.c,213 :: 		}
L_main54:
;sec 2.c,215 :: 		secondString[i++]= keypad_key_pressed;
	MOVF       _i+0, 0
	ADDLW      _secondString+0
	MOVWF      FSR
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      INDF+0
	INCF       _i+0, 1
;sec 2.c,217 :: 		}
	GOTO       L_main55
L_main53:
;sec 2.c,219 :: 		if(belongToCal){
	BTFSS      _belongToCal+0, BitPos(_belongToCal+0)
	GOTO       L_main56
;sec 2.c,220 :: 		belongToCal=0;
	BCF        _belongToCal+0, BitPos(_belongToCal+0)
;sec 2.c,221 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;sec 2.c,222 :: 		dotSeen=i=0;//reset
	CLRF       _i+0
	BCF        _dotSeen+0, BitPos(_dotSeen+0)
;sec 2.c,223 :: 		}
L_main56:
;sec 2.c,224 :: 		answerString[i++]= keypad_key_pressed;
	MOVF       _i+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      INDF+0
	INCF       _i+0, 1
;sec 2.c,226 :: 		answerString[i]=0;
	MOVF       _i+0, 0
	ADDLW      _answerString+0
	MOVWF      FSR
	CLRF       INDF+0
;sec 2.c,227 :: 		answer = atof(answerString); //ascii to float
	MOVLW      _answerString+0
	MOVWF      FARG_atof_s+0
	CALL       _atof+0
	MOVF       R0+0, 0
	MOVWF      _answer+0
	MOVF       R0+1, 0
	MOVWF      _answer+1
	MOVF       R0+2, 0
	MOVWF      _answer+2
	MOVF       R0+3, 0
	MOVWF      _answer+3
;sec 2.c,229 :: 		}
L_main55:
;sec 2.c,231 :: 		Lcd_Chr(1, i, keypad_key_pressed);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _keypad_key_pressed+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;sec 2.c,233 :: 		}
L_main51:
;sec 2.c,235 :: 		}
L_main46:
L_main38:
L_main35:
;sec 2.c,236 :: 		} while (1);
	GOTO       L_main26
;sec 2.c,237 :: 		}
	GOTO       $+0
; end of _main
