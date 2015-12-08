//==========================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_8:IR distance sensor to LCD display					
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

int range;
long Vout;

int range_analogPin = A1;              
                    
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
  lcd.begin(16, 2);                   // set the lcd dimension
  lcd.clear();                        // LCD screen clear
  lcd.print("  CYTRON TECH.");        // display the text
  lcd.setCursor(0,1);                 // set lcd.setCursor (column,row) 
  lcd.print(" IR Dist Sensor");  
  delay(3000);                        // delay for 3000ms
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Range:  cm");            
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
  range = analogRead(range_analogPin);    //get analog value
  Vout = (range*500000)/1024;
  	
  if ((Vout > 43945)&&(Vout < 279785))			// read only from 0.4V = 80cm  to 2.8V = 8cm
    {											
    range = (Vout - 19000)/2099;				//	Vout = 20.99*Distance + 0.19;
    lcd.setCursor(6,0);								
    lcd.print(1000/range,DEC);
    }
  else 
    {
    lcd.setCursor(0,1);	
    lcd.print("OUT OF RANGE");
    }								

  delay(100);               // the purpose of delay is to delay the update value for not too fast
  range_value_clear();        // clear the value
}

/*******************************************************************************
* PRIVATE FUNCTION: range_value_clear
*
* PARAMETERS:
* ~ void
*
* RETURN:
* ~ void
*
* DESCRIPTIONS:
* clear the IR Distance range value 
*
*******************************************************************************/ 
void range_value_clear(void)
{
lcd.setCursor(6,0);	
lcd.print("  ");
lcd.setCursor(0,1);
lcd.print("               ");
}
