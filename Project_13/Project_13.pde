//============================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_12: UART to Computer
//                            				
//============================================================================

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

int serial_in;
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
void setup()
{
  lcd.begin(16,2);                   // set the lcd dimension
  lcd.print("  CYTRON TECH.");        // display the text
  lcd.setCursor(0,1);                 // set lcd.setCursor (column,row) 
  lcd.print("  UART TO COMP");  
  delay(3000);                        // delay for 3000ms
  lcd.clear();
  lcd.setCursor(0,0);
  Serial.begin(9600);              // 9600 baud rate
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
  for (int lcd_cursor=0; lcd_cursor<32; lcd_cursor++)
    {
    if (lcd_cursor == 15) lcd.setCursor(0,1);
    else if (lcd_cursor == 31) lcd.home();
      while (!Serial.available());                            // wait until there was signal send from computer
      serial_in = Serial.read();                            // Receive signal in ASCII
      lcd.write(serial_in);
    }
}
