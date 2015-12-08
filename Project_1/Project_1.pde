//==========================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_1: "Hello World" and utilize switch						
//==========================================================================

#include <LiquidCrystal.h>

/*
  The circuit:
 * LCD RS pin to digital pin 8
 * LCD Enable pin to digital pin 9
 * LCD D4 pin to digital pin 4
 * LCD D5 pin to digital pin 5
 * LCD D6 pin to digital pin 6
 * LCD D7 pin to digital pin 7
 * LCD R/W pin to ground
*/

LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

int analogPin = A0;
int adc_key_old;
int adc_key_in;
int NUM_KEYS = 5;
int key=-1;
int adc_key_val[5] ={30, 150, 360, 535, 760 };        
               
char msgs[5][15] = {"Right Key OK ", 
                    "Up Key OK    ", 
                    "Down Key OK  ", 
                    "Left Key OK  ", 
                    "Select Key OK"};
                    
                    
/*******************************************************************************
* PRIVATE FUNCTION: setup()
*
* PARAMETERS:
* ~ void
*
* RETURN:
* ~ void
*
* DESCRIPTIONS:
* Define of I/O pin as Input or Output 
*
*******************************************************************************/
// The setup() method runs once, when the sketch starts
void setup ()
{
  lcd.begin(16, 2);                         // set the lcd dimension
  lcd.clear();                              // LCD screen clear
  lcd.print("  CYTRON TECH.");              // display the text
  lcd.setCursor(0,1);                       // set lcd.setCursor (column,row) 
  lcd.print(" Eg. LCD Shield");    
  delay(3000);                              // delay for 3000ms
  lcd.clear();
  lcd.setCursor(0,0);              
  lcd.print("Hello World");
  lcd.setCursor(0,1);
  lcd.print("Pls press any"); 
  adc_key_old = analogRead(analogPin);      // store the unpress key value 
}


/*******************************************************************************
* PRIVATE FUNCTION: loop()
*
* PARAMETERS:
* ~ void
*
* RETURN:
* ~ void
*
* DESCRIPTIONS:
* Non-Stop looping 
*
*******************************************************************************/
void loop()
{
  adc_key_in = analogRead(analogPin);     // read ADC value
  adc_key_in = get_key(adc_key_in);
  lcd.setCursor(0, 1);                 
  lcd.print(msgs[adc_key_in]);            //display message key
}
  

/*******************************************************************************
* PRIVATE FUNCTION: get_key
*
* PARAMETERS:
* ~ integer
*
* RETURN:
* ~ unsigned int input
*
* DESCRIPTIONS:
* convert the ADC value to number between 0 to 4
*
*******************************************************************************/
int get_key(unsigned int input)
{
	int k;
    
	for (k = 0; k < NUM_KEYS; k++)
	{
		if (input < adc_key_val[k])
		{
           
    return k;
        }
	}
    
    if (k >= NUM_KEYS)
        k = -1;     // No valid key pressed
    
    return k;
}


