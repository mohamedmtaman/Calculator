#line 1 "D:/preferences/mikroC/Project (calculator)/sec 2.c"




int keypad_key_pressed;

char keypadLookUP[] = "741.8520963=/x-+C";


char keypadPort at PORTB;






 sbit LCD_RS at RC4_bit;
 sbit LCD_EN at RC5_bit;

 sbit LCD_D7 at RD7_bit;
 sbit LCD_D6 at RD6_bit;
 sbit LCD_D5 at RD5_bit;
 sbit LCD_D4 at RD4_bit;



 sbit LCD_RS_Direction at TRISC4_bit;
 sbit LCD_EN_Direction at TRISC5_bit;

 sbit LCD_D7_Direction at TRISD7_bit;
 sbit LCD_D6_Direction at TRISD6_bit;
 sbit LCD_D5_Direction at TRISD5_bit;
 sbit LCD_D4_Direction at TRISD4_bit;









 float answer, second;
 char operation=0,i,j;
 bit belongToCal,state,dotSeen;
 char secondString[ 17 ]="0";
 char answerString[ 17 ]="0";





 int pointLocation,
 expLocation,
 strlength;

 void truncateTo5_answerString(){
 pointLocation = expLocation =  17 ;
 strlength = strlen(answerString);

 for (j = 0; j < strlength; j++)
 if (answerString[j] == '.')
 pointLocation = j;
 else if (answerString[j] == 'e')
 expLocation = j;

 if (expLocation ==  17 )
 {
 for (j = pointLocation + 6; j <  17 ; j++)
 {
 answerString[j] = 0;
 }
 } else {

 for (j = expLocation + 1; j < strlength; j++)
 {
 answerString[j + 3] = answerString[j];
 }
 answerString[expLocation] = 'x';
 answerString[expLocation + 1] = '1';
 answerString[expLocation + 2] = '0';
 answerString[expLocation + 3] = '^';

 answerString[strlength + 3] = 0;
 }
}



char UselessString[] = "               Useless Calculator ";

void welcomeToUseless() {
 Lcd_Out(1, 1, " Welcome To The ");
 delay_ms(1000);

 for (i = 0; i < 34 * 2; i++) {
 Lcd_Out(2, 1, UselessString + (i % 34));
 delay_ms(50);
 }
 Lcd_Cmd(_LCD_CLEAR);
}



float compute() {
 answer = atof(answerString);
 second = atof(secondString);

 switch (operation) {
 case '+':return answer + second;
 case '-':return answer - second;
 case 'x':return answer * second;
 case '/':return answer / second;
 default :return answer;
 }
}

void main() {




 TrisD=0b00000001;
 portd.B1=1;


 Lcd_Init();
#line 134 "D:/preferences/mikroC/Project (calculator)/sec 2.c"
 Keypad_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);

 welcomeToUseless();
 i=0;
 do {


 do
 {
 keypad_key_pressed = Keypad_Key_Click();
 while (PORTD.B0) keypad_key_pressed=17;
 }
 while (!keypad_key_pressed);

 keypad_key_pressed = keypadLookUP[keypad_key_pressed - 1];

 if(keypad_key_pressed=='C')
 {
 Lcd_Cmd(_LCD_CLEAR),state=i=belongToCal=answer=second=secondString[1]= secondString[1]=dotSeen=0;
 secondString[0]=answerString[0]='0';
 }
 else if(keypad_key_pressed=='=') {
 if(state){
 belongToCal=1;state=0;
 answer=compute();
 }

 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(answer, answerString);

 truncateTo5_answerString();
 Lcd_Out(2, 1, answerString);
 i=0;
 }

 else if(keypad_key_pressed=='+'||keypad_key_pressed=='-'||keypad_key_pressed=='x'||keypad_key_pressed=='/'){
 if(state){

 Lcd_Cmd(_LCD_CLEAR);
 if(i>0)
 {
 answer=compute();
 FloatToStr(answer, answerString);
 truncateTo5_answerString();
 Lcd_Out(1, 1, answerString);
 belongToCal=1;
 }
 Lcd_Chr(2, 1, keypad_key_pressed);
 operation=keypad_key_pressed;
 dotSeen=i=0;

 }
 else {
 if(!belongToCal) answerString[i]=0;

 operation=keypad_key_pressed;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Chr(2, 1, keypad_key_pressed);
 dotSeen=i=0;
 state=1;
 }

 secondString[0]='0';
 secondString[1]=0;

 }
 else {

 if((!dotSeen || keypad_key_pressed!='.') && i <  17 -1)
 {
 if(keypad_key_pressed=='.') dotSeen=1;

 if(state)
 {
 if(belongToCal){
 belongToCal=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Chr(2, 1, operation);
 }

 secondString[i++]= keypad_key_pressed;

 }
 else {
 if(belongToCal){
 belongToCal=0;
 Lcd_Cmd(_LCD_CLEAR);
 dotSeen=i=0;
 }
 answerString[i++]= keypad_key_pressed;

 answerString[i]=0;
 answer = atof(answerString);

 }

 Lcd_Chr(1, i, keypad_key_pressed);

 }

 }
 } while (1);
}
