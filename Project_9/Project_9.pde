//===============================================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project 9: Arduno 2-Amp Motor Driver shield: 
//                                        ADC (temperature) to control DC brush motor speed(PWM Mode Only)
//http://droboticsonline.com/ebaydownloads/L298_Motor_Shield_Manual.pdf				
//===============================================================================================

//Arduino PWM Speed Control：
int PWM_E1 = 6;
int PWM_M1 = 7;
int PWM_E2 = 5;
int PWM_M2 = 4;

int analogPin = A0;
                            
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
pinMode(PWM_M1, OUTPUT);
pinMode(PWM_M2, OUTPUT);
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
int value;
value = (analogRead(analogPin))*5;    // In room tempreture, the ADC value are too LOW and cannot move the motor.
digitalWrite(PWM_M1,HIGH);            // So, we make the ADC value 5 times larger to make sure the motor move according to the tempreture change.
digitalWrite(PWM_M2, HIGH);
analogWrite(PWM_E1, value); //PWM Speed Control
analogWrite(PWM_E2, value); //PWM Speed Control
delay(30);  
}
  


