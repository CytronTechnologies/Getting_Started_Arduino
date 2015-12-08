//==========================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_2: Graphic LCD sheild 					
//==========================================================================
#include <LCD4884.h>
#include "cytron.h"

int adc_key_in;
int joy_stick = 0;
int  adc_key_val[5] ={50, 200, 400, 600, 800 };

#define LCD_Backlight 7
#define NUM_KEYS 5


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
lcd.LCD_init();                             // creates instance of LCD
lcd.LCD_clear();                           // blanks the display

pinMode(LCD_Backlight, OUTPUT);            // set the LCD_backlight pin as output
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
  for (int a=0; a<5; a++)                                        // loop for 5 times                  
    {
    digitalWrite(LCD_Backlight, LOW);
    delay(300);
    digitalWrite(LCD_Backlight, HIGH);
    delay(300);
    }
  
  lcd.LCD_draw_bmp_pixel(2,1, cytron,80,24);                    // display the Bitmap
  delay(2000);
  lcd.LCD_clear();                                              // clear GLCD screen
  
  for (int a=0; a<6; a++)
    {
    lcd.LCD_write_string(0,a,"01234567980123", MENU_NORMAL);     // Write a string to GLCD
    delay(200);
    }
    
  delay(200);
  lcd.LCD_clear();                                             // blanks the display
  
  delay(500);
  lcd.LCD_write_string_big(0, 0, "012345", MENU_NORMAL);
  lcd.LCD_write_string_big(0, 3, "-+-+-+", MENU_NORMAL);
  delay(1000);
  lcd.LCD_clear(); 

  do
    {
    adc_key_in = analogRead(joy_stick);                        // check the ADC value
    adc_key_in = get_key(adc_key_in);                          // convert to a decimal number between 0 to 4
    
      if (adc_key_in == 0)
        {
        lcd.LCD_write_string(2,2,"Down", MENU_NORMAL);
        }     else
        
      if (adc_key_in == 1)
        {
        lcd.LCD_write_string(2,2,"OK   ", MENU_NORMAL);
        delay(200);
        }       else
        
        if (adc_key_in == 2) 
        {
        lcd.LCD_write_string(2,2,"Right", MENU_NORMAL);
        delay(200);
        }         else

        if (adc_key_in == 3)
        {
        lcd.LCD_write_string(2,2,"Up   ", MENU_NORMAL);
        delay(200);
        }         else
    
        if (adc_key_in == 4)
        {
        lcd.LCD_write_string(2,2,"Left ", MENU_NORMAL);
        delay(200);
        }           else
    
        {
        lcd.LCD_write_string(2,2,"nil  ", MENU_NORMAL);
        delay(200);
        }
        
    }  while (1);
  }

/*******************************************************************************
* PRIVATE FUNCTION: get_key
*
* PARAMETERS:
* ~ void
*
* RETURN:
* ~ void
*
* DESCRIPTIONS:
* change the ADC value to number between 0 to 4 
*
*******************************************************************************/
// Convert ADC value to key number
char get_key(unsigned int input)
{
	char k;
    
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

