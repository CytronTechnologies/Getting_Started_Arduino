//==========================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_7:Ultrasonic range finder to LCD display			
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

//variables needed to store values
long pulse, anVolt, inches;
int sum=0;                          //Create sum variable so it can be averaged
int avgrange=10;                    //Quantity of values to average (sample size)

const int analogPin = A0;
const int range_analog_analogPin = A1;  
const int range_pwm_Pin = 2; 
int range_uart_RxPin = 0; 
int range_uart_TxPin = 1; 

int adc_key_in;
int NUM_KEYS = 5;
int key=-1;
int adc_key_val[5] ={30, 150, 360, 535, 760 };        
                    
unsigned char mode = 1;
                    
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
  lcd.print(" Ultrasonic-EZ1");  
  delay(3000);                        // delay for 3000ms
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Range:    inch");  
  
  pinMode(range_analog_analogPin, INPUT);
  pinMode(range_pwm_Pin,INPUT);
   
  adc_key_in = analogRead(analogPin); 
  adc_key_in = get_key(adc_key_in);   
  
Serial.begin(9600);  
digitalWrite(range_uart_TxPin,HIGH) ;
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
  switch(mode)
    {
      case 1:	 lcd.setCursor(0,1);
                 lcd.print("ANALOG MODE");
                 while(adc_key_in == -1)                                    // loop forever if the adc_key_in value are -1
                   {
                   for(int i = 0; i < avgrange ; i++)
                      {
                        anVolt = analogRead(range_analog_analogPin);        //Used to read in the analog voltage output that is being sent by the MaxSonar device.
                        sum += anVolt;                                      //Add all the value together
                        delay(10);                                          
                      }  
                        
                   inches = sum/avgrange;                                  // divide to take the average result
                   inches = inches/2;                                      // 1024/522 = ~2
                   lcd.setCursor(6,0);								
                   lcd.print(inches,DEC);  
                         
                   sum = 0;                                                //reset sample total
                    
                   adc_key_in = analogRead(analogPin);                     // Read the Keypad key value
                   adc_key_in = get_key(adc_key_in);                       // Make the Keypad ADC value to a number. 
                   delay(100);                                             // the purpose of delay is to delay the value for not update too fast
                   range_value_clear();                                    // clear the range value           
                   }
		 break;
		 
                 
      case 2:	 lcd.setCursor(0,1);
		 lcd.print("PWM MODE   ");
		 unsigned int range_pwm;
		 while(adc_key_in == -1)                               // loop forever if the adc_key_in value are -1
		  {
		  pulse = pulseIn(range_pwm_Pin , HIGH);		 	// 147us/51.2us = 2.87	
                  inches = pulse/147;										  					
                  lcd.setCursor(6,0);								
                  lcd.print(inches,DEC);  
              
                  adc_key_in = analogRead(analogPin);                          // Read the Keypad key value
                  adc_key_in = get_key(adc_key_in);                            // Make the Keypad ADC value to a number. 
                  delay(100);
                  range_value_clear();
		  }
		 break;

      case 3:	 lcd.setCursor(0,1);
		 lcd.print("UART MODE   ");
		 unsigned int data[] = {0};
                 unsigned int k,l;
		 while(adc_key_in == -1)
		   {              
                   for (l=0 ; l<6 ; l++)
                     {
                    while (!Serial.available());                                        
   		       inches = Serial.read();                                   // read the incoming byte
                         if(inches == 'R') data[k=0] = inches;			 // check if start byte 'R' is met  
			  if(data[0] == 'R') data[k++] = inches;		 // save the data in data array	    
                           if (k>4) k = 4;
                     }
                                                
                  lcd.setCursor(6,0);    
                  lcd.write(data[1]);                                            // Display the serial data.
                  lcd.write(data[2]);
                  lcd.write(data[3]);
                  
                  adc_key_in = analogRead(analogPin);                            // Read the Keypad key value
                  adc_key_in = get_key(adc_key_in);                              // Make the Keypad ADC value to a number. 
                  delay(100);
                  range_value_clear();		              
		  }
                break;       
     }
    
    
		if (adc_key_in == 1) 				// if UP is press
                    {
                      adc_key_in = -1;                          // make it -1 for continue looping in new case above
                      delay(400);
                      if (--mode < 1)                           // minus 1 each loop and compare with 1
                        {
                          mode = 3;                             // if yes then make it 3.
                        }                     
                    }
                    			
                if (adc_key_in == 2)				// if DOWN is press	
                    {
                      adc_key_in = -1;
                      delay(400);
                      if (++mode > 3)                           // increase 1 each loop and compare with 3
                        {
                          mode = 1;                             // if yes then make it 1.
                        }                     
                    }					
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
lcd.print("   ");
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


