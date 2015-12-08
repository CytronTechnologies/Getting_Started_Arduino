//===============================================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : 1.Project 12: Send temperature reading to Arduino Serial Monitor, 
//                              control DC motor using keyboard.			
//===============================================================================================

int Temp_Sensor = 0;    // first analog sensor
int inByte[] = {0};         // incoming serial byte

//Arduino 2A Motor Driver Shield
int PWM_E1 = 6;
int PWM_M1 = 7;
int PWM_E2 = 5;
int PWM_M2 = 4;
                            
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
  //Motor control pin
  pinMode(PWM_M1, OUTPUT);          //motor output I/O
  pinMode(PWM_M2, OUTPUT); 
  
  // start serial port at 9600 bps:
  Serial.begin(9600);
  establishContact();              // send a byte to establish contact and wait for responds 
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
unsigned char i;
int value;

  Temp_Sensor = analogRead(A0);                              // Read ADC value
  delay(10);                                                 // delay 10ms to let the ADC recover:
  Serial.print("Current Tempreture Reading(celcius):");      // Send text to HyperTerminal
  Serial.println(Temp_Sensor/2, DEC);                        // send sensor values:
  Serial.print("Motor Speed Require(00 - 25):");

   for (i=0 ; i<2 ; i++) {                                   // Read ADSCII value    
     while (!Serial.available());                            // wait until there was signal send from computer
     inByte[i] = Serial.read();
     inByte[i] = inByte[i]-48;   
     } 
    
       value = inByte[0]*100 + inByte[1]*10 + inByte[2];                      // convert to decimal value
     
  Serial.print("\n");
  Serial.print(value, DEC);                                  // print the decimal value on HyperTerminal
  Serial.println("PWM");  
  digitalWrite(PWM_M1,HIGH);                                    
  digitalWrite(PWM_M2, HIGH);                                    
  analogWrite(PWM_E1, value);                               //PWM Speed Control                     
  analogWrite(PWM_E2, value);                               //PWM Speed Control                 
  delay(30);   
}

/********************************************************************************************
* PRIVATE FUNCTION: establishContact()
*
* PARAMETERS:
* ~ void
*
* RETURN:
* ~ void
*
* DESCRIPTIONS:
* Send data to hyperTerminal to tell that is ready. 
*
*******************************************************************************************/  
void establishContact() 
{
    Serial.println("Arduino Connected");   // send an initial string
    delay(300);
}
	
