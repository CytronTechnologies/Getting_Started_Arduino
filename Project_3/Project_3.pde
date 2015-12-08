//======================================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_3: LED Chaser (delay control using potentialmeter)							
//======================================================================================

//LEDs 
byte pinLeds[] = {2,3,4,5,6,7};

//delay period initialise
unsigned int delay_period = 0;

//Analog Pin
int analogPin = A0;

unsigned int currentLED = 0;
int direction = 1;

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
// The setup() method runs once, when the sketch starts
void setup ()
{
unsigned char x;
  for (x=0 ; x<6 ; x++)
    {
      pinMode(pinLeds[x],OUTPUT);        // Define pinLeds[0] to pinLeds[5] are output
    }
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
     delay_period = analogRead(analogPin);                     

      // turn on the current LED 
      digitalWrite(pinLeds[currentLED], HIGH);
      delay(delay_period);                               // delay_period refer to ADC value
      digitalWrite (pinLeds[currentLED], LOW);     
      
      // increment by the direction value 
      currentLED += direction; 
      // change direction if we reach the end 
      if (currentLED == 5) {direction = -1;} 
      if (currentLED == 0) {direction = 1;} 
}

