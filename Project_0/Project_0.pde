//==========================================================================
//	Author		    : CYTRON TECHNOLOGIES SDN BHD
//	Project	            : Arduino Duemilanove
//	Project description : Project_0: LED Dice						
//==========================================================================

//LEDs 
const int pinLeds1 = 2;  // assign group of leds1 to digital pin 2
const int pinLeds2 = 3;  // assign group of leds2 to digital pin 3
const int pinLeds3 = 4;  // assign group of leds3 to digital pin 4
const int pinLeds4 = 5;  // assign group of leds4 to digital pin 5
const int pinLeds5 = 6;  // assign group of leds5 to digital pin 6
const int pinLeds6 = 7;  // assign group of leds6 to digital pin 7
const int pinLeds7 = 8;  // assign group of leds7 to digital pin 8
const int buttonPin = 11; // assign push-button digital pin 11

// ramdom number will store in ran
unsigned char ran = 0;

// Push Button
int buttonState;         // define pushbutton state


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
  pinMode (pinLeds1, OUTPUT); // declare pinLeds1 as output
  pinMode (pinLeds2, OUTPUT); // declare pinLeds2 as output
  pinMode (pinLeds3, OUTPUT); // declare pinLeds3 as output
  pinMode (pinLeds4, OUTPUT);  // declare pinLed4 as output
  pinMode (buttonPin, INPUT); // declare buttonPin as input
  pinMode (pinLeds5, OUTPUT); // declare pinLeds5 as output
  pinMode (pinLeds6, OUTPUT); // declare pinLeds6 as output
  pinMode (pinLeds7, OUTPUT); // declare pinLeds7 as output
  randomSeed(analogRead(0));  // to avoid arduino to follow any pattern
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
  buttonState = digitalRead(buttonPin);
  while (buttonState == LOW){                   // checks state of pushbutton to start loop
    ran = random(1, 7);                         // a number between 1 to 6 is randomized for die 1
  
  // now arduino will toss the die
   if (ran == 1){
      digitalWrite (pinLeds4, HIGH);           // turns on led4 if ran equals to 1
      delay(50);                               // delay for 50ms
      while (digitalRead(buttonPin) == HIGH);  // If Detected HIGH(1) on push button, stay at here
      led_clear();                             // call led_clear subroutine
   }
   
   if (ran == 2){
      digitalWrite (pinLeds1, HIGH);           // turns on leds1 & leds7 if ran equals to 2
      digitalWrite (pinLeds7, HIGH);
      delay(50);                               // delay for 50ms
      while (digitalRead(buttonPin) == HIGH);  // If Detected HIGH(1) on push button, stay at here
      led_clear();                             // call led_clear subroutine
   }
   
   if (ran == 3){
      digitalWrite (pinLeds1, HIGH);
      digitalWrite (pinLeds4, HIGH);
      digitalWrite (pinLeds7, HIGH);           // turns on leds1, leds4 and led7 if ran equals to 3
      delay(50);                               // delay for 50ms
      while (digitalRead(buttonPin) == HIGH);  // If Detected HIGH(1) on push button, stay at here
      led_clear();                             // call led_clear subroutine
   }
   
    if (ran == 4){
      digitalWrite (pinLeds1, HIGH);
      digitalWrite (pinLeds3, HIGH);
      digitalWrite (pinLeds5, HIGH);
      digitalWrite (pinLeds7, HIGH);           // turns on leds1, leds3, leds5 and leds7 if ran equals to 4
      delay(50);                               // delay for 50ms
      while (digitalRead(buttonPin) == HIGH);  // If Detected HIGH(1) on push button, stay at here
      led_clear();                             // call led_clear subroutine
  }
  
    if (ran == 5){
      digitalWrite (pinLeds1, HIGH);
      digitalWrite (pinLeds3, HIGH);
      digitalWrite (pinLeds4, HIGH);           // turns on leds1, leds3, led4, leds5 and leds7 if ran equals to 5
      digitalWrite (pinLeds5, HIGH);
      digitalWrite (pinLeds7, HIGH);   
      delay(50);                               // delay for 50ms
      while (digitalRead(buttonPin) == HIGH);  // If Detected HIGH(1) on push button, stay at here
      led_clear();                             // call led_clear subroutine
  }
  
   if (ran == 6){
      digitalWrite (pinLeds1, HIGH);
      digitalWrite (pinLeds2, HIGH);
      digitalWrite (pinLeds3, HIGH);           // turns on leds1,leds2, leds3, leds5, leds6 and leds7 if ran equals to 6
      digitalWrite (pinLeds5, HIGH); 
      digitalWrite (pinLeds6, HIGH);
      digitalWrite (pinLeds7, HIGH); 
      delay(50);                               // delay for 50ms
      while (digitalRead(buttonPin) == HIGH);  // If Detected HIGH(1) on push button, stay at here
      led_clear();                             // call led_clear subroutine
   }   
  }
}


/*******************************************************************************
* PRIVATE FUNCTION: led_clear
*
* PARAMETERS:
* ~ void
*
* RETURN:
* ~ void
*
* DESCRIPTIONS:
* OFF all LED 
*
*******************************************************************************/
void led_clear (void)
{
  digitalWrite (pinLeds1, LOW);
  digitalWrite (pinLeds2, LOW);
  digitalWrite (pinLeds3, LOW);
  digitalWrite (pinLeds4, LOW);
  digitalWrite (pinLeds5, LOW);
  digitalWrite (pinLeds6, LOW);
  digitalWrite (pinLeds7, LOW);  
}
