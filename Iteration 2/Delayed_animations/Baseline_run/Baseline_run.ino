//Include relevant libraries
#include <math.h>           // For performing calculations
#include <Time.h>           // For time synchronization
#include <TimeLib.h>        // For time synchronization
#include <DS1307RTC.h>      // For communicating with the real-time clock

void setup() {
  Serial.begin(9600);                                   // Begin serial communication with baud rate of 9600
}

void loop() {

  // Wait for 15 seconds
  delay(15000);

  // Start driving
  Serial.println("Drive");

  // Read real-time clock      
  tmElements_t tm;

  if (RTC.read(tm)) {

    //Print time at which acceleration starts
    Serial.print(" T "); 
    print2digits(tm.Hour);
    Serial.write(':');
    print2digits(tm.Minute);
    Serial.write(':');
    print2digits(tm.Second);
    Serial.println();
  }

  // Long pause to stop car and animation
  delay(20000);
}

// Helper function to print time correctly
void print2digits(int number) {
  if (number >= 0 && number < 10) {
    Serial.write('0');
  }
  Serial.print(number);
}
