//===============================================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project 5: Arduino Input shield: Control RC Servo motor position				
//===============================================================================================

#include <Servo.h>

Servo servo1;

int potpin_x = A0;                    // analog pin used to connect the potentiometer
int potpin_y = A1;                    // analog pin used to connect the potentiometer
const int joy_pushbutton = 5;         // joystick push button
const int pushbuttonB = 3;            // Input shield push button C
const int pushbuttonC = 4;            // Input shield push button B

int val;                             // variable to read the value from the analog pin 
int mode = 1;                        // Define the mode as mode 1 at the start 
int current_joy_mode;                // store the mode value
                                
/***********************************************************************************************
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
**********************************************************************************************/
// The setup() method runs once, when the sketch starts
void setup ()
{
  servo1.attach(6);                            // servo1 signal pin attach on digital pin 2
  pinMode(joy_pushbutton,INPUT);               // joystick push button push button set as input
  pinMode(pushbuttonB,INPUT);                 //  push button B set as input
  pinMode(pushbuttonC,INPUT);                 //  push button C set as input
}


/********************************************************************************************
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
*******************************************************************************************/
void loop()
{
  switch(mode)
    {
    case 1: val = analogRead(potpin_x);            // reads the value of the analog joystick_x (value between 0 and 1023) 
            val = map(val, 0, 1023, 0, 179);       // scale it to use it with the servo1 (value between 0 and 180) 
            servo1.write(val);                     // sets the servo1 position according to the scaled value 
            delay(15);                             // waits for the servo1 to get there 
            break;                                 // break out of current loop
              
              
    case 2: val = analogRead(potpin_y);            // reads the value of the analog joystick_x (value between 0 and 1023) 
            val = map(val, 0, 1023, 0, 179);       // scale it to use it with the servo1 (value between 0 and 180) 
            servo1.write(val);                     // sets the servo1 position according to the scaled value 
            delay(15); 
            break;             
  
  
    case 3: for(val = 0; val < 180; val += 1)      // goes from 0 degrees to 180 degrees 
              {                                    // in steps of 1 degree 
              servo1.write(val);                   // tell servo1 to go to position in variable 'val'
              delay(15);                           // waits 15ms for both servo to reach the position 
              } 
            for(val = 180; val > 1; val -= 1)      // goes from 180 degrees to 0 degrees 
              {                                
              servo1.write(val);                  // tell servo1 to go to position in variable 'val'
              delay(15);                          // waits 15ms for both servo to reach the position 
              }
            mode =  current_joy_mode;             // restore the pervious mode between mode 1/2
            break;
    
    
    case 4: for(;;)
            {
            for(val = 180; val > 0; val -= 1)      // goes from 0 degrees to 180 degrees 
              {                                    // in steps of 1 degree 
              servo1.write(val);                   // tell servo1 to go to position in variable 'val'
              delay(15);                           // waits 15ms for both servo to reach the position 
              } 
            for(val = 0; val < 180; val += 1)      // goes from 180 degrees to 0 degrees 
              {                                
              servo1.write(val);                  // tell servo1 to go to position in variable 'val'
              delay(15);                          // waits 15ms for both servo to reach the position 
              }
              mode =  current_joy_mode;            // restore the pervious mode between mode 1/2
              break;
            }
    }  
      
      
      if ((digitalRead(joy_pushbutton)) == LOW) {          // check if the joystick pushbutton is press
        while((digitalRead(joy_pushbutton)) == LOW);       // wait for debounce
        if (++mode > 2)                                    // increase mode by 1 and check whether is greater than 2.
            mode = 1;                                      // if yes then change back to mode 1
             current_joy_mode = mode;                      // store the current mode in current_joy_mode
      }
      
      if ((digitalRead(pushbuttonB)) == LOW) {              // Check if pushbuttonB is press
        while((digitalRead(pushbuttonB)) == LOW);           // wait for debounce
          mode = 3;                                         // change to mode 3
          }
          
      if ((digitalRead(pushbuttonC)) == LOW) {              // check if pushbuttonC is press
        while((digitalRead(pushbuttonC)) == LOW);           // wait for debounce
          mode = 4;                                         // change to mode 4
          }       
} 
 
 
 
 
    

