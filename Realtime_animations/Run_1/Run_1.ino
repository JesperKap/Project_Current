//Include relevant libraries
#include <math.h>           // For performing calculations
#include <Time.h>           // For time synchronization
#include <TimeLib.h>        // For time synchronization
#include <DS1307RTC.h>      // For communicating with the real-time clock

// Define pin for communication with accelerometer
const int x_out = A0;

void setup() {
  
  // Begin serial communication with baud rate of 9600
  Serial.begin(9600); 
}

void loop() {

  // Read acceleration value
  int x_adc_value = analogRead(x_out);

  // Acceleration value
  double x_g_value_current = ( ( ( (double)(x_adc_value * 5)/1024) - 1.65 ) / 0.330 );  

  // Read real-time clock      
  tmElements_t tm;

  if (RTC.read(tm)) {

    Serial.print(" T "); 
    print2digits(tm.Hour);
    Serial.write(':');
    print2digits(tm.Minute);
    Serial.write(':');
    print2digits(tm.Second);
    Serial.print(" G ");
    Serial.print(x_g_value_current);
    Serial.println();
  }
}

// Helper function to print time correctly
void print2digits(int number) {
  if (number >= 0 && number < 10) {
    Serial.write('0');
  }
  Serial.print(number);
}
