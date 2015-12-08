//======================================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_4: Kight Rider Light Bar	
//                            http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1276737123
//                            http://code.google.com/p/rogue-code/wiki/SoftPWMLibraryDocumentation#Description					
//======================================================================================
#include <SoftPWM.h>

#define DELAY 40

int leds[8] = {2, 3, 4, 5, 6, 7, 8, 9};        // Pin using


/**************************************************************************************
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
***************************************************************************************/
void setup()
{
  SoftPWMBegin();                          //Initializes the library - sets up the timer and other tasks.

  for (int i = 0; i < 8; i++)              // loop from 0 to 7
    SoftPWMSet(leds[i], 0);                // SoftPWMSet(pin, value)   // pin is the output pin   // value is a value between 0 and 255 (inclusive)

  SoftPWMSetFadeTime(ALL, 30, 200);        // SoftPWMSetFadeTime(pin, fadeUpTime, fadeDownTime)
}                                          // pin is the output pin
                                           // fadeuptime is the time in milliseconds that it will take the channel to fade from 0 to 255.
                                           // fadedowntime is the time in milliseconds that it will take the channel to fade from 255 to 0.
                                           
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
  int i;

  for (i = 0; i < 3; i++)                    //loop from 0 to 2
  {
    SoftPWMSet(leds[i+1], 255);              // set LED value to 255
    SoftPWMSet(leds[6-i], 255);
    SoftPWMSet(leds[i], 0);                  
    SoftPWMSet(leds[7-i], 0);
    delay(DELAY);
  }
  
  delay(250);
  
  for (i = 3; i > 0; i--)
  {
    SoftPWMSet(leds[i-1], 255);
    SoftPWMSet(leds[8-i], 255);
    SoftPWMSet(leds[i], 0);
    SoftPWMSet(leds[7-i], 0);
    delay(DELAY);
  }

  delay(250);
} 
