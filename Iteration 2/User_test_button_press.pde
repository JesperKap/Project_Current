//Import relevant libraries
import processing.serial.*;
import controlP5.*;
import cc.arduino.*;

//Create Arduino and ControlP5 objects
Arduino arduino;
ControlP5 cp5;

int buttonData;

int myColor = color(0,0,0);
int trianPos; 

Table register;
int freq = 10;  // Frequency of recording = 100 Hz (once every 10 ms)

String pctimestamp; 
String timestamp ; 
boolean timeflag = false; 
int timer;

void setup() {
  size(800,800);
  noStroke();
 
  cp5 = new ControlP5(this);
  
  // create a toggle
  cp5.addButton("Record")
     .setPosition(100, 600)
     .setSize(80,20)
     ;  
  
  // create a toggle
  cp5.addButton("Save")
     .setPosition(200, 600)
     .setSize(80,20)
     ;  

  pctimestamp= str(year())+ '-' + str(month()) + '-' + str(day()) + '-' + str(hour()) + '-' + str(minute());
  
  register = new Table();
  
  register.addColumn("timestamp");
  register.addColumn("raw");
  
  // Prints out the available serial ports.
  println(Arduino.list());
  
  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(0, Arduino.OUTPUT);

}

void draw() {
  background(0);
  
  textSize(14);
  fill(255);
  text("BUTTON POSITION RECORDING", 100, 100); 
  
  fill(0,45,90);
  rect(100,200,500,25);
  
   buttonData = arduino.digitalRead(2);
 println(buttonData);
  trianPos = int(map(buttonData, 0, 1, 100, 600));
 
  fill(0,170,255);
  triangle(trianPos-5,225, trianPos+5, 225, trianPos, 200);

  if(timeflag == true){
    if (millis() - timer >= freq && buttonData == 0) {
        TableRow newRow = register.addRow();
        timestamp= str(year())+'-'+str(month())+'-'+str(day())+'-'+ str(hour())+'-'+str(minute())+'-'+str(second())+'-'+str(millis()); 
        newRow.setString("timestamp", timestamp);
        newRow.setFloat("raw", buttonData);
        timer = millis();
        textSize(10);
        fill(255);
        text("RECORDING DATA", 100, 700);      
    }
  }
}

public void Record() {
  println("Recording Started");
  timeflag = true; 
  timer = millis();
}

public void Save( ) {
  println("Save File");
  timeflag=false; 
  timestamp= str(year())+'-'+str(month())+'-'+str(day())+'-'+ str(hour())+'-'+str(minute())+'-'+str(second()); 
  saveTable(register, "data/" + timestamp + ".csv");
  textSize(10);
  fill(255);
  text("FILE SAVED", 100, 700); 
  register.clearRows();
  delay(4000);
}


void Frecuency(int test) {
  freq = test;
  println("a slider event. setting background to "+ freq);
}
