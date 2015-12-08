//============================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_14: Arduino Xbee shield, for wireless temperature logging. 2 ways communication.
//                            http://www.arduino.cc/en/Guide/ArduinoXbeeShield					
//============================================================================

int temp_analogPin = A0;      // LM35 connected to Analog port-1
int LED = 2;                  //LED connected to Digital port-2

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
  int temp_value,LED_trigger;
  
  temp_value = analogRead(temp_analogPin);                // Read Analog value from analog port-1
  temp_value = temp_value/2;                              // Divide by 2 to get temperature in celsius
  
  Serial.print("Current Temperature:");                   // send out a string
  Serial.println(temp_value);                             // send out temperature value
  
  Serial.print("LED(ON = 1)(OFF = 0):");                  
  while (!Serial.available());                            // wait until there was signal send from computer
  Serial.println(); 
  LED_trigger = Serial.read();                            // Receive signal in ASCII
  LED_trigger = LED_trigger - 48;                         // Minus 48(30 hex) to get the decimal value
    if (LED_trigger == 1)digitalWrite(LED,HIGH);          // HIGH LED if value is 1
    if (LED_trigger == 0) digitalWrite(LED,LOW);          // LOW LED if value is 0
}
