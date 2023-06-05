
_main:

;BMI.c,41 :: 		void main()
;BMI.c,44 :: 		char heightEntered = 0;
	CLRF       main_heightEntered_L0+0
	CLRF       main_weightEntered_L0+0
;BMI.c,47 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;BMI.c,48 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;BMI.c,50 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;BMI.c,51 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;BMI.c,52 :: 		Lcd_Out(1, 1, "Press A to");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;BMI.c,53 :: 		Lcd_Out(2, 1,"measure height.");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;BMI.c,54 :: 		do
L_main0:
;BMI.c,56 :: 		kp = 1; // Reset key code variable
	MOVLW      1
	MOVWF      _kp+0
;BMI.c,57 :: 		do
L_main3:
;BMI.c,58 :: 		kp = Keypad_Key_Click(); // Store key
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;BMI.c,59 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;BMI.c,60 :: 		Check_Key(kp);
	MOVF       _kp+0, 0
	MOVWF      FARG_Check_Key_kp+0
	CALL       _Check_Key+0
;BMI.c,61 :: 		if (key == 'A')
	MOVF       _key+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;BMI.c,63 :: 		heightEntered = 0;
	CLRF       main_heightEntered_L0+0
;BMI.c,64 :: 		weightEntered = 0;
	CLRF       main_weightEntered_L0+0
;BMI.c,65 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;BMI.c,66 :: 		Lcd_Out(1, 1, "Measuring Height");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;BMI.c,67 :: 		init_sonar();
	CALL       _init_sonar+0
;BMI.c,68 :: 		while (!heightEntered)
L_main7:
	MOVF       main_heightEntered_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;BMI.c,70 :: 		read_sonar();
	CALL       _read_sonar+0
;BMI.c,71 :: 		if (Distance > 0)
	MOVF       _Distance+0, 0
	MOVWF      R4+0
	MOVF       _Distance+1, 0
	MOVWF      R4+1
	MOVF       _Distance+2, 0
	MOVWF      R4+2
	MOVF       _Distance+3, 0
	MOVWF      R4+3
	CLRF       R0+0
	CLRF       R0+1
	CLRF       R0+2
	CLRF       R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;BMI.c,73 :: 		height = 2.1 - Distance / 100; // Convert cm to meters
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       _Distance+0, 0
	MOVWF      R0+0
	MOVF       _Distance+1, 0
	MOVWF      R0+1
	MOVF       _Distance+2, 0
	MOVWF      R0+2
	MOVF       _Distance+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      102
	MOVWF      R0+0
	MOVLW      102
	MOVWF      R0+1
	MOVLW      6
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _height+0
	MOVF       R0+1, 0
	MOVWF      _height+1
	MOVF       R0+2, 0
	MOVWF      _height+2
	MOVF       R0+3, 0
	MOVWF      _height+3
;BMI.c,74 :: 		heightEntered = 1;
	MOVLW      1
	MOVWF      main_heightEntered_L0+0
;BMI.c,75 :: 		}
L_main9:
;BMI.c,76 :: 		}
	GOTO       L_main7
L_main8:
;BMI.c,77 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;BMI.c,78 :: 		Lcd_Out(1, 1, "Enter Weight(kg)");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;BMI.c,80 :: 		weight = 0;
	CLRF       _weight+0
	CLRF       _weight+1
	CLRF       _weight+2
	CLRF       _weight+3
;BMI.c,81 :: 		while (!weightEntered)
L_main11:
	MOVF       main_weightEntered_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;BMI.c,83 :: 		kp = 1;
	MOVLW      1
	MOVWF      _kp+0
;BMI.c,84 :: 		do
L_main13:
;BMI.c,85 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;BMI.c,86 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main13
;BMI.c,87 :: 		Check_Key(kp);
	MOVF       _kp+0, 0
	MOVWF      FARG_Check_Key_kp+0
	CALL       _Check_Key+0
;BMI.c,89 :: 		if (key >= '0' && key <= '9')
	MOVLW      48
	SUBWF      _key+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main18
	MOVF       _key+0, 0
	SUBLW      57
	BTFSS      STATUS+0, 0
	GOTO       L_main18
L__main70:
;BMI.c,91 :: 		weight = (weight * 10) + numKey;
	MOVF       _weight+0, 0
	MOVWF      R0+0
	MOVF       _weight+1, 0
	MOVWF      R0+1
	MOVF       _weight+2, 0
	MOVWF      R0+2
	MOVF       _weight+3, 0
	MOVWF      R0+3
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       _numKey+0, 0
	MOVWF      R4+0
	MOVF       _numKey+1, 0
	MOVWF      R4+1
	MOVF       _numKey+2, 0
	MOVWF      R4+2
	MOVF       _numKey+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _weight+0
	MOVF       R0+1, 0
	MOVWF      _weight+1
	MOVF       R0+2, 0
	MOVWF      _weight+2
	MOVF       R0+3, 0
	MOVWF      _weight+3
;BMI.c,92 :: 		Lcd_Chr(2, 1+cur, key);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _cur+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _key+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;BMI.c,93 :: 		cur++;
	INCF       _cur+0, 1
;BMI.c,94 :: 		}
	GOTO       L_main19
L_main18:
;BMI.c,95 :: 		else if (key == '#')
	MOVF       _key+0, 0
	XORLW      35
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;BMI.c,97 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
	NOP
	NOP
;BMI.c,98 :: 		bmi = weight/(height * height);
	MOVF       _height+0, 0
	MOVWF      R0+0
	MOVF       _height+1, 0
	MOVWF      R0+1
	MOVF       _height+2, 0
	MOVWF      R0+2
	MOVF       _height+3, 0
	MOVWF      R0+3
	MOVF       _height+0, 0
	MOVWF      R4+0
	MOVF       _height+1, 0
	MOVWF      R4+1
	MOVF       _height+2, 0
	MOVWF      R4+2
	MOVF       _height+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       _weight+0, 0
	MOVWF      R0+0
	MOVF       _weight+1, 0
	MOVWF      R0+1
	MOVF       _weight+2, 0
	MOVWF      R0+2
	MOVF       _weight+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _bmi+0
	MOVF       R0+1, 0
	MOVWF      _bmi+1
	MOVF       R0+2, 0
	MOVWF      _bmi+2
	MOVF       R0+3, 0
	MOVWF      _bmi+3
;BMI.c,99 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;BMI.c,100 :: 		Lcd_Out(1, 1, "BMI: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;BMI.c,101 :: 		FloatToStr_FixLen(bmi,txt,4);
	MOVF       _bmi+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       _bmi+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       _bmi+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       _bmi+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _txt+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVLW      4
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;BMI.c,102 :: 		Lcd_Out(1, 6, txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;BMI.c,103 :: 		weightEntered = 1;
	MOVLW      1
	MOVWF      main_weightEntered_L0+0
;BMI.c,104 :: 		checkBMI();
	CALL       _checkBMI+0
;BMI.c,105 :: 		}
L_main20:
L_main19:
;BMI.c,106 :: 		}
	GOTO       L_main11
L_main12:
;BMI.c,107 :: 		}
L_main6:
;BMI.c,108 :: 		}while (1);
	GOTO       L_main0
;BMI.c,109 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_Check_Key:

;BMI.c,116 :: 		void Check_Key(unsigned short kp){
;BMI.c,117 :: 		switch (kp)
	GOTO       L_Check_Key22
;BMI.c,119 :: 		case 1: key = '1'; numKey = 1.0; break; // 1
L_Check_Key24:
	MOVLW      49
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      0
	MOVWF      _numKey+2
	MOVLW      127
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,120 :: 		case 2: key = '2'; numKey = 2.0; break; // 2
L_Check_Key25:
	MOVLW      50
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      0
	MOVWF      _numKey+2
	MOVLW      128
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,121 :: 		case 3: key = '3'; numKey = 3.0; break; // 3
L_Check_Key26:
	MOVLW      51
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      64
	MOVWF      _numKey+2
	MOVLW      128
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,122 :: 		case 4: key = 'A'; break; // A
L_Check_Key27:
	MOVLW      65
	MOVWF      _key+0
	GOTO       L_Check_Key23
;BMI.c,123 :: 		case 5: key = '4'; numKey = 4.0; break; // 4
L_Check_Key28:
	MOVLW      52
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      0
	MOVWF      _numKey+2
	MOVLW      129
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,124 :: 		case 6: key = '5'; numKey = 5.0;break; // 5
L_Check_Key29:
	MOVLW      53
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      32
	MOVWF      _numKey+2
	MOVLW      129
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,125 :: 		case 7: key = '6'; numKey = 6.0;break; // 6
L_Check_Key30:
	MOVLW      54
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      64
	MOVWF      _numKey+2
	MOVLW      129
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,126 :: 		case 8: key = 'B'; break; // B
L_Check_Key31:
	MOVLW      66
	MOVWF      _key+0
	GOTO       L_Check_Key23
;BMI.c,127 :: 		case 9: key = '7'; numKey = 7.0; break; // 7
L_Check_Key32:
	MOVLW      55
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      96
	MOVWF      _numKey+2
	MOVLW      129
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,128 :: 		case 10: key = '8'; numKey = 8.0; break; // 8
L_Check_Key33:
	MOVLW      56
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      0
	MOVWF      _numKey+2
	MOVLW      130
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,129 :: 		case 11: key = '9'; numKey = 9.0; break; // 9
L_Check_Key34:
	MOVLW      57
	MOVWF      _key+0
	MOVLW      0
	MOVWF      _numKey+0
	MOVLW      0
	MOVWF      _numKey+1
	MOVLW      16
	MOVWF      _numKey+2
	MOVLW      130
	MOVWF      _numKey+3
	GOTO       L_Check_Key23
;BMI.c,130 :: 		case 12: key = 'C'; break; // C
L_Check_Key35:
	MOVLW      67
	MOVWF      _key+0
	GOTO       L_Check_Key23
;BMI.c,131 :: 		case 13: key = '*'; break; // *
L_Check_Key36:
	MOVLW      42
	MOVWF      _key+0
	GOTO       L_Check_Key23
;BMI.c,132 :: 		case 14: key = '0'; numKey = 0.0; break; // 0
L_Check_Key37:
	MOVLW      48
	MOVWF      _key+0
	CLRF       _numKey+0
	CLRF       _numKey+1
	CLRF       _numKey+2
	CLRF       _numKey+3
	GOTO       L_Check_Key23
;BMI.c,133 :: 		case 15: key = '#'; break; // #
L_Check_Key38:
	MOVLW      35
	MOVWF      _key+0
	GOTO       L_Check_Key23
;BMI.c,134 :: 		case 16: key = 'D'; break; // D
L_Check_Key39:
	MOVLW      68
	MOVWF      _key+0
	GOTO       L_Check_Key23
;BMI.c,135 :: 		}
L_Check_Key22:
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key24
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key25
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key26
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key27
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key28
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key29
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key30
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key31
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key32
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key33
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key34
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key35
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key36
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key37
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key38
	MOVF       FARG_Check_Key_kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_Check_Key39
L_Check_Key23:
;BMI.c,136 :: 		}
L_end_Check_Key:
	RETURN
; end of _Check_Key

_checkBMI:

;BMI.c,137 :: 		void checkBMI(){
;BMI.c,138 :: 		if(bmi<18.5)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      20
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _bmi+0, 0
	MOVWF      R0+0
	MOVF       _bmi+1, 0
	MOVWF      R0+1
	MOVF       _bmi+2, 0
	MOVWF      R0+2
	MOVF       _bmi+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI40
;BMI.c,139 :: 		Lcd_Out(2, 1, "UnderWeight");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_checkBMI41
L_checkBMI40:
;BMI.c,140 :: 		else if(bmi>=18.5&&bmi<=24.9)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      20
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _bmi+0, 0
	MOVWF      R0+0
	MOVF       _bmi+1, 0
	MOVWF      R0+1
	MOVF       _bmi+2, 0
	MOVWF      R0+2
	MOVF       _bmi+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI44
	MOVF       _bmi+0, 0
	MOVWF      R4+0
	MOVF       _bmi+1, 0
	MOVWF      R4+1
	MOVF       _bmi+2, 0
	MOVWF      R4+2
	MOVF       _bmi+3, 0
	MOVWF      R4+3
	MOVLW      51
	MOVWF      R0+0
	MOVLW      51
	MOVWF      R0+1
	MOVLW      71
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI44
L__checkBMI74:
;BMI.c,141 :: 		Lcd_Out(2, 1, "Normal Weight");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_checkBMI45
L_checkBMI44:
;BMI.c,142 :: 		else if(bmi>=25.0&&bmi<=29.9)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _bmi+0, 0
	MOVWF      R0+0
	MOVF       _bmi+1, 0
	MOVWF      R0+1
	MOVF       _bmi+2, 0
	MOVWF      R0+2
	MOVF       _bmi+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI48
	MOVF       _bmi+0, 0
	MOVWF      R4+0
	MOVF       _bmi+1, 0
	MOVWF      R4+1
	MOVF       _bmi+2, 0
	MOVWF      R4+2
	MOVF       _bmi+3, 0
	MOVWF      R4+3
	MOVLW      51
	MOVWF      R0+0
	MOVLW      51
	MOVWF      R0+1
	MOVLW      111
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI48
L__checkBMI73:
;BMI.c,143 :: 		Lcd_Out(2, 1, "OverWeight");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_checkBMI49
L_checkBMI48:
;BMI.c,144 :: 		else if(bmi>=30.0&&bmi<=34.9)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      112
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _bmi+0, 0
	MOVWF      R0+0
	MOVF       _bmi+1, 0
	MOVWF      R0+1
	MOVF       _bmi+2, 0
	MOVWF      R0+2
	MOVF       _bmi+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI52
	MOVF       _bmi+0, 0
	MOVWF      R4+0
	MOVF       _bmi+1, 0
	MOVWF      R4+1
	MOVF       _bmi+2, 0
	MOVWF      R4+2
	MOVF       _bmi+3, 0
	MOVWF      R4+3
	MOVLW      154
	MOVWF      R0+0
	MOVLW      153
	MOVWF      R0+1
	MOVLW      11
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI52
L__checkBMI72:
;BMI.c,145 :: 		Lcd_Out(2, 1, "Obesity class 1");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_checkBMI53
L_checkBMI52:
;BMI.c,146 :: 		else if(bmi>=35.0&&bmi<=39.9)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _bmi+0, 0
	MOVWF      R0+0
	MOVF       _bmi+1, 0
	MOVWF      R0+1
	MOVF       _bmi+2, 0
	MOVWF      R0+2
	MOVF       _bmi+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI56
	MOVF       _bmi+0, 0
	MOVWF      R4+0
	MOVF       _bmi+1, 0
	MOVWF      R4+1
	MOVF       _bmi+2, 0
	MOVWF      R4+2
	MOVF       _bmi+3, 0
	MOVWF      R4+3
	MOVLW      154
	MOVWF      R0+0
	MOVLW      153
	MOVWF      R0+1
	MOVLW      31
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI56
L__checkBMI71:
;BMI.c,147 :: 		Lcd_Out(2, 1, "Obesity class 2");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_checkBMI57
L_checkBMI56:
;BMI.c,148 :: 		else if(bmi>=40.0)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _bmi+0, 0
	MOVWF      R0+0
	MOVF       _bmi+1, 0
	MOVWF      R0+1
	MOVF       _bmi+2, 0
	MOVWF      R0+2
	MOVF       _bmi+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkBMI58
;BMI.c,149 :: 		Lcd_Out(2, 1, "Obesity class 3");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_BMI+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_checkBMI58:
L_checkBMI57:
L_checkBMI53:
L_checkBMI49:
L_checkBMI45:
L_checkBMI41:
;BMI.c,150 :: 		}
L_end_checkBMI:
	RETURN
; end of _checkBMI

_read_sonar:

;BMI.c,151 :: 		void read_sonar(void)
;BMI.c,153 :: 		T1overflow = 0;
	CLRF       _T1overflow+0
	CLRF       _T1overflow+1
;BMI.c,154 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;BMI.c,155 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;BMI.c,157 :: 		PORTB = 0x04;
	MOVLW      4
	MOVWF      PORTB+0
;BMI.c,158 :: 		usDelay(10);
	MOVLW      10
	MOVWF      FARG_usDelay+0
	MOVLW      0
	MOVWF      FARG_usDelay+1
	CALL       _usDelay+0
;BMI.c,159 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;BMI.c,161 :: 		while (!(PORTB & 0x02));
L_read_sonar59:
	BTFSC      PORTB+0, 1
	GOTO       L_read_sonar60
	GOTO       L_read_sonar59
L_read_sonar60:
;BMI.c,162 :: 		T1CON |= 0x01;
	BSF        T1CON+0, 0
;BMI.c,163 :: 		while (PORTB & 0x02);
L_read_sonar61:
	BTFSS      PORTB+0, 1
	GOTO       L_read_sonar62
	GOTO       L_read_sonar61
L_read_sonar62:
;BMI.c,164 :: 		T1CON &= 0xFE;
	MOVLW      254
	ANDWF      T1CON+0, 1
;BMI.c,165 :: 		T1counts = ((TMR1H << 8) | TMR1L) + (T1overflow * 65536);
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 0
	MOVWF      R5+0
	MOVF       R0+1, 0
	MOVWF      R5+1
	MOVLW      0
	IORWF      R5+1, 1
	MOVF       _T1overflow+1, 0
	MOVWF      R0+3
	MOVF       _T1overflow+0, 0
	MOVWF      R0+2
	CLRF       R0+0
	CLRF       R0+1
	MOVF       R5+0, 0
	MOVWF      R8+0
	MOVF       R5+1, 0
	MOVWF      R8+1
	CLRF       R8+2
	CLRF       R8+3
	MOVF       R0+0, 0
	ADDWF      R8+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      R8+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      R8+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      R8+3, 1
	MOVF       R8+0, 0
	MOVWF      _T1counts+0
	MOVF       R8+1, 0
	MOVWF      _T1counts+1
	MOVF       R8+2, 0
	MOVWF      _T1counts+2
	MOVF       R8+3, 0
	MOVWF      _T1counts+3
;BMI.c,166 :: 		T1time = T1counts; // in microseconds
	MOVF       R8+0, 0
	MOVWF      _T1time+0
	MOVF       R8+1, 0
	MOVWF      _T1time+1
	MOVF       R8+2, 0
	MOVWF      _T1time+2
	MOVF       R8+3, 0
	MOVWF      _T1time+3
;BMI.c,167 :: 		Distance = (((T1time-128) * 343) / (8000)) / 2; // in cm
	MOVLW      128
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R4+0, 0
	SUBWF      R0+0, 1
	MOVF       R4+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R4+1, 0
	SUBWF      R0+1, 1
	MOVF       R4+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R4+2, 0
	SUBWF      R0+2, 1
	MOVF       R4+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R4+3, 0
	SUBWF      R0+3, 1
	MOVLW      87
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      64
	MOVWF      R4+0
	MOVLW      31
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	RRF        R4+3, 1
	RRF        R4+2, 1
	RRF        R4+1, 1
	RRF        R4+0, 1
	BCF        R4+3, 7
	MOVF       R4+0, 0
	MOVWF      R0+0
	MOVF       R4+1, 0
	MOVWF      R0+1
	MOVF       R4+2, 0
	MOVWF      R0+2
	MOVF       R4+3, 0
	MOVWF      R0+3
	CALL       _longword2double+0
	MOVF       R0+0, 0
	MOVWF      _Distance+0
	MOVF       R0+1, 0
	MOVWF      _Distance+1
	MOVF       R0+2, 0
	MOVWF      _Distance+2
	MOVF       R0+3, 0
	MOVWF      _Distance+3
;BMI.c,168 :: 		}
L_end_read_sonar:
	RETURN
; end of _read_sonar

_init_sonar:

;BMI.c,170 :: 		void init_sonar(void)
;BMI.c,172 :: 		T1overflow = 0;
	CLRF       _T1overflow+0
	CLRF       _T1overflow+1
;BMI.c,173 :: 		T1counts = 0;
	CLRF       _T1counts+0
	CLRF       _T1counts+1
	CLRF       _T1counts+2
	CLRF       _T1counts+3
;BMI.c,174 :: 		T1time = 0;
	CLRF       _T1time+0
	CLRF       _T1time+1
	CLRF       _T1time+2
	CLRF       _T1time+3
;BMI.c,175 :: 		Distance = 0;
	CLRF       _Distance+0
	CLRF       _Distance+1
	CLRF       _Distance+2
	CLRF       _Distance+3
;BMI.c,176 :: 		TMR1H = 0;
	CLRF       TMR1H+0
;BMI.c,177 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;BMI.c,178 :: 		TRISB = 0x02;
	MOVLW      2
	MOVWF      TRISB+0
;BMI.c,179 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;BMI.c,180 :: 		INTCON |= 0xC0;
	MOVLW      192
	IORWF      INTCON+0, 1
;BMI.c,181 :: 		PIE1 |= 0x01;
	BSF        PIE1+0, 0
;BMI.c,182 :: 		T1CON = 0x10;
	MOVLW      16
	MOVWF      T1CON+0
;BMI.c,183 :: 		}
L_end_init_sonar:
	RETURN
; end of _init_sonar

_usDelay:

;BMI.c,185 :: 		void usDelay(unsigned int usCnt)
;BMI.c,189 :: 		for (us = 0; us < usCnt; us++)
	CLRF       R1+0
	CLRF       R1+1
L_usDelay63:
	MOVF       FARG_usDelay_usCnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__usDelay81
	MOVF       FARG_usDelay_usCnt+0, 0
	SUBWF      R1+0, 0
L__usDelay81:
	BTFSC      STATUS+0, 0
	GOTO       L_usDelay64
;BMI.c,191 :: 		Delay_us(1);
	NOP
	NOP
;BMI.c,189 :: 		for (us = 0; us < usCnt; us++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;BMI.c,192 :: 		}
	GOTO       L_usDelay63
L_usDelay64:
;BMI.c,193 :: 		}
L_end_usDelay:
	RETURN
; end of _usDelay

_msDelay:

;BMI.c,195 :: 		void msDelay(unsigned int msCnt)
;BMI.c,199 :: 		for (ms = 0; ms < msCnt; ms++)
	CLRF       R1+0
	CLRF       R1+1
L_msDelay66:
	MOVF       FARG_msDelay_msCnt+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay83
	MOVF       FARG_msDelay_msCnt+0, 0
	SUBWF      R1+0, 0
L__msDelay83:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay67
;BMI.c,201 :: 		Delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_msDelay69:
	DECFSZ     R13+0, 1
	GOTO       L_msDelay69
	DECFSZ     R12+0, 1
	GOTO       L_msDelay69
	NOP
	NOP
;BMI.c,199 :: 		for (ms = 0; ms < msCnt; ms++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;BMI.c,202 :: 		}
	GOTO       L_msDelay66
L_msDelay67:
;BMI.c,203 :: 		}
L_end_msDelay:
	RETURN
; end of _msDelay
