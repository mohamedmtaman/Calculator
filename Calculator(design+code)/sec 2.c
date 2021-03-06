//DOCS
//https://download.mikroe.com/documents/compilers/mikroc/pic/help/mikroc_pro_libraries.htm

//---------------------------KEYPAD-----------------------------------------------
int keypad_key_pressed; //variable for key pressed

char keypadLookUP[] = "741.8520963=/x-+C";//given index 0 i will return '7' //and elegant implementation for keypad

// Keypad module connections
char keypadPort at PORTB;
// End Keypad module connections
//---------------------------KEYPAD-----------------------------------------------


//---------------------------LCD-----------------------------------------------
// LCD Module connections
                 sbit LCD_RS at RC4_bit;
                 sbit LCD_EN at RC5_bit;

                 sbit LCD_D7 at RD7_bit;
                 sbit LCD_D6 at RD6_bit;
                 sbit LCD_D5 at RD5_bit;
                 sbit LCD_D4 at RD4_bit;
// End LCD module connections

// LCD Pin direction
                 sbit LCD_RS_Direction at TRISC4_bit;
                 sbit LCD_EN_Direction at TRISC5_bit;

                 sbit LCD_D7_Direction at TRISD7_bit;
                 sbit LCD_D6_Direction at TRISD6_bit;
                 sbit LCD_D5_Direction at TRISD5_bit;
                 sbit LCD_D4_Direction at TRISD4_bit;
// End of LCD Pin direction

//---------------------------LCD-----------------------------------------------

//---------------------------Base Variables-----------------------------------------------
#define width 17 //LCD SCREEN WIDTH is 16

//calculator variables
//float==double==long double== floating-point types are the same for mikroC.
                 float answer, second;
                 char operation=0,i,j; //loop index
                 bit belongToCal,state,dotSeen;
                 char secondString[width]="0";//append to it (second)
                 char answerString[width]="0";//to print on 16 column screen and to append to the first operand
//end calculator variables
//---------------------------Base Variables-----------------------------------------------

//---------------------------Truncate-----------------------------------------------
//truncateTo5_answerString variables
                 int pointLocation,
                 expLocation,
                 strlength;
//end truncateTo5_answerString variables
                 void truncateTo5_answerString(){       //truncate answerString after 5
    pointLocation = expLocation = width; //out of bound so the string replacement wont do anything
    strlength = strlen(answerString);

    for (j = 0; j < strlength; j++)
        if (answerString[j] == '.')
            pointLocation = j;
        else if (answerString[j] == 'e')
            expLocation = j;

    if (expLocation == width) //no exponential found
    {
        for (j = pointLocation + 6; j < width; j++)   //truncate after 5
        {
            answerString[j] = 0;//this is '\0'*/
        }
    } else {  //we have exponential

        for (j = expLocation + 1; j < strlength; j++)   //move them
        {
            answerString[j + 3] = answerString[j];
        }
        answerString[expLocation] = 'x';
        answerString[expLocation + 1] = '1';
        answerString[expLocation + 2] = '0';
        answerString[expLocation + 3] = '^';

        answerString[strlength + 3] = 0;//this is '\0'*/
    }
}
//---------------------------Truncate-----------------------------------------------

//---------------------------Welcome-----------------------------------------------
char UselessString[] = "               Useless Calculator ";

void welcomeToUseless() {
    Lcd_Out(1, 1, " Welcome To The ");   // Write to the first row
    delay_ms(1000);                     // Delay of 0.5s

    for (i = 0; i < 34 * 2; i++) {
        Lcd_Out(2, 1, UselessString + (i % 34)); //shift the string
        delay_ms(50);
    }
    Lcd_Cmd(_LCD_CLEAR);               // Clear Display
}
//---------------------------Welcome-----------------------------------------------


float compute() { //c computes from left to write
    answer = atof(answerString); //ascii to float
    second = atof(secondString); //ascii to float

    switch (operation) {
        case '+':return answer + second;
        case '-':return answer - second;
        case 'x':return answer * second;
        case '/':return answer / second;
        default :return answer;
    }
}

void main() {
    //Initialization
    //----------------------------------------
    //UART1_Init(9600);
    //----------------------------------------
    TrisD=0b00000001;
    portd.B1=1;


    Lcd_Init();                     // Initialize LCD

/*TrisD=0x00;
    PORTD.B0=1;
    Lcd_Out(1, 1, " Welcome To The ");   // Write to the first row
    while(1);*/

    Keypad_Init();                  // Initialize Keypad
    Lcd_Cmd(_LCD_CURSOR_OFF);       // Cursor Off

    welcomeToUseless(); //welcome LCD
    i=0;
    do {//start a new session

         // Wait for key to be pressed and released
          do
           {
            keypad_key_pressed = Keypad_Key_Click(); // Store key code in keypad_key_pressed variable
            while (PORTD.B0) keypad_key_pressed=17;
           }
          while (!keypad_key_pressed);

          keypad_key_pressed = keypadLookUP[keypad_key_pressed - 1];  //get the character from the look up table

          if(keypad_key_pressed=='C')
            {
              Lcd_Cmd(_LCD_CLEAR),state=i=belongToCal=answer=second=secondString[1]= secondString[1]=dotSeen=0;
              secondString[0]=answerString[0]='0';
            }
          else if(keypad_key_pressed=='=') {
           if(state){//state 1
             belongToCal=1;state=0;
             answer=compute();
           }

           Lcd_Cmd(_LCD_CLEAR);               // Clear Display
           FloatToStr(answer, answerString); //convert to string and put the result in answerString

           truncateTo5_answerString();//answerString truncation
           Lcd_Out(2, 1, answerString); //print answer
           i=0;
          }

          else if(keypad_key_pressed=='+'||keypad_key_pressed=='-'||keypad_key_pressed=='x'||keypad_key_pressed=='/'){//opertion
                     if(state){//state 1

                         Lcd_Cmd(_LCD_CLEAR);               // Clear Display
                         if(i>0)//we have second
                         {
                             answer=compute();
                             FloatToStr(answer, answerString); //compute and convert to string and put the result in answerString
                             truncateTo5_answerString();//answerString truncation
                             Lcd_Out(1, 1, answerString); //print answer
                             belongToCal=1;
                         }
                         Lcd_Chr(2, 1, keypad_key_pressed);
                         operation=keypad_key_pressed;
                         dotSeen=i=0;//for second

                     }
                     else {//state 0
                        if(!belongToCal) answerString[i]=0;

                        operation=keypad_key_pressed;
                        Lcd_Cmd(_LCD_CLEAR);               // Clear Display
                        Lcd_Chr(2, 1, keypad_key_pressed);
                        dotSeen=i=0;
                        state=1;
                     }

                     secondString[0]='0';
                     secondString[1]=0;

                 }
          else { //digit or .

              if((!dotSeen || keypad_key_pressed!='.') && i < width-1)//dot not seen or not dot
              {
               if(keypad_key_pressed=='.') dotSeen=1;

                  if(state)//state 1
                   {
                     if(belongToCal){
                        belongToCal=0;
                        Lcd_Cmd(_LCD_CLEAR);
                        Lcd_Chr(2, 1, operation);
                      }

                     secondString[i++]= keypad_key_pressed;

                   }
              else {//state 0
                      if(belongToCal){
                        belongToCal=0;
                        Lcd_Cmd(_LCD_CLEAR);
                        dotSeen=i=0;//reset
                      }
                      answerString[i++]= keypad_key_pressed;

                      answerString[i]=0;
                      answer = atof(answerString); //ascii to float

                   }

              Lcd_Chr(1, i, keypad_key_pressed);

              }

          }
    } while (1);
}



