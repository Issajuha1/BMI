#line 1 "D:/project/BMI_final_pinpoint_accuracy/BMI.c"

sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D4 at RC2_bit;
sbit LCD_D5 at RC3_bit;
sbit LCD_D6 at RC4_bit;
sbit LCD_D7 at RC5_bit;
sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC4_bit;
sbit LCD_D7_Direction at TRISC5_bit;

const char txt[16];

char keypadPort at PORTD;

unsigned short kp,cur;
float numKey;
char key;
void Check_Key(unsigned short kp);

unsigned int T1overflow=0;
unsigned long T1counts;
unsigned long T1time;
float Distance;

unsigned int Dcntr;
float height = 0.0;
float weight = 0.0;
float bmi = 0.0;

void usDelay(unsigned int);
void msDelay(unsigned int);

void init_sonar(void);
void read_sonar(void);
void checkBMI();

void main()
{

 char heightEntered = 0;
 char weightEntered = 0;

 Lcd_Init();
 Keypad_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Press A to");
 Lcd_Out(2, 1,"measure height.");
 do
 {
 kp = 1;
 do
 kp = Keypad_Key_Click();
 while (!kp);
 Check_Key(kp);
 if (key == 'A')
 {
 heightEntered = 0;
 weightEntered = 0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Measuring Height");
 init_sonar();
 while (!heightEntered)
 {
 read_sonar();
 if (Distance > 0)
 {
 height = 2.1 - Distance / 100;
 heightEntered = 1;
 }
 }
 delay_ms(1000);
 Lcd_Out(1, 1, "Enter Weight(kg)");

 weight = 0;
 while (!weightEntered)
 {
 kp = 1;
 do
 kp = Keypad_Key_Click();
 while (!kp);
 Check_Key(kp);

 if (key >= '0' && key <= '9')
 {
 weight = (weight * 10) + numKey;
 Lcd_Chr(2, 1+cur, key);
 cur++;
 }
 else if (key == '#')
 {
 delay_ms(1000);
 bmi = weight/(height * height);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "BMI: ");

 Lcd_Out(1, 6, bmi);
 weightEntered = 1;
 checkBMI();
 }
 }
 }
 }while (1);
}
#line 116 "D:/project/BMI_final_pinpoint_accuracy/BMI.c"
void Check_Key(unsigned short kp){
 switch (kp)
 {
 case 1: key = '1'; numKey = 1.0; break;
 case 2: key = '2'; numKey = 2.0; break;
 case 3: key = '3'; numKey = 3.0; break;
 case 4: key = 'A'; break;
 case 5: key = '4'; numKey = 4.0; break;
 case 6: key = '5'; numKey = 5.0;break;
 case 7: key = '6'; numKey = 6.0;break;
 case 8: key = 'B'; break;
 case 9: key = '7'; numKey = 7.0; break;
 case 10: key = '8'; numKey = 8.0; break;
 case 11: key = '9'; numKey = 9.0; break;
 case 12: key = 'C'; break;
 case 13: key = '*'; break;
 case 14: key = '0'; numKey = 0.0; break;
 case 15: key = '#'; break;
 case 16: key = 'D'; break;
 }
}
void checkBMI(){
 if(bmi<18.5)
 Lcd_Out(2, 1, "UnderWeight");
 else if(bmi>=18.5&&bmi<=24.9)
 Lcd_Out(2, 1, "Normal Weight");
 else if(bmi>=25.0&&bmi<=29.9)
 Lcd_Out(2, 1, "OverWeight");
 else if(bmi>=30.0&&bmi<=34.9)
 Lcd_Out(2, 1, "Obesity class 1");
 else if(bmi>=35.0&&bmi<=39.9)
 Lcd_Out(2, 1, "Obesity class 2");
 else if(bmi>=40.0)
 Lcd_Out(2, 1, "Obesity class 3");
}
void read_sonar(void)
{
 T1overflow = 0;
 TMR1H = 0;
 TMR1L = 0;

 PORTB = 0x04;
 usDelay(10);
 PORTB = 0x00;

 while (!(PORTB & 0x02));
 T1CON |= 0x01;
 while (PORTB & 0x02);
 T1CON &= 0xFE;
 T1counts = ((TMR1H << 8) | TMR1L) + (T1overflow * 65536);
 T1time = T1counts;
 Distance = (((T1time-128) * 343) / (8000)) / 2;
}

void init_sonar(void)
{
 T1overflow = 0;
 T1counts = 0;
 T1time = 0;
 Distance = 0;
 TMR1H = 0;
 TMR1L = 0;
 TRISB = 0x02;
 PORTB = 0x00;
 INTCON |= 0xC0;
 PIE1 |= 0x01;
 T1CON = 0x10;
}

void usDelay(unsigned int usCnt)
{
 unsigned int us;

 for (us = 0; us < usCnt; us++)
 {
 Delay_us(1);
 }
}

void msDelay(unsigned int msCnt)
{
 unsigned int ms;

 for (ms = 0; ms < msCnt; ms++)
 {
 Delay_ms(1);
 }
}
