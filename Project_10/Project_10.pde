//==========================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project 10: Serial control servo position					
//==========================================================================

#include <Servo.h>

Servo servo1;               // servo name
Servo servo2;   

int inByte[] = {0};         // incoming serial byte

int value;
unsigned int old_value;
unsigned char i;           

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
  servo1.attach(2);                // servo1 signal pin attach on digital pin 2
  servo2.attach(3);                // servo2 signal pin attach on digital pin 3
  Serial.begin(9600);
  
  servo1.write(90);               // set the servo position to 90 degreee
  servo2.write(90);  
  old_value = 90;
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
  Serial.print("Servo Position(00-18)=");                    // Send a string to serial monitor

   for (i=0 ; i<2 ; i++) {                                   // Read ADSCII value    
     while (!Serial.available());                            // wait until there was signal send from computer
     inByte[i] = Serial.read();
     inByte[i] = inByte[i]-48;   
     }  
     
  Serial.println();                                            // print new line
    value = inByte[0]*100 + inByte[1]*10;                      // convert to decimal value
    if (value > 180) value = 180;                              // make sure the value are within 0 to 180 degree
    else if (value < 0) value = 0;
    
     if (value < old_value)                                    // check the value 
        {   
       for(i = old_value ; i > value ; i -= 1)
          {
          servo1.write(i);                                     // tell servo1 to go to position in variable 'i'
          servo2.write(i);                                     // tell servo2 to go to position in variable 'i'  
          delay(15);                                           // waits 15ms for both servo to reach the position 
          }
          old_value = value;                                  // store the current position value to old_value
        }
        
      if (value > old_value)
        {
        for(i = old_value ; i < value ; i += 1)
          {
          servo1.write(i);                                     // tell servo1 to go to position in variable 'i'
          servo2.write(i);                                     // tell servo2 to go to position in variable 'i'  
          delay(15);                                           // waits 15ms for both servo to reach the position 
          }
          old_value = value;                                  // store the current position value to old_value
       }
}

