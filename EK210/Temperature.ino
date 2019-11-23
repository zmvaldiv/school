#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

#define RT0 10000   // Ω
#define B 3950      // K
#define VCC 5    //Supply voltage
#define R 10000  //R=10KΩ
int therm0 = A0;
int therm1 = A1;
int therm2 = A2;
int therm3 = A3;
float temp0 = 0;
float temp1 = 0;
float temp2 = 0;
float temp3 = 0;
float tempAvg=0;
int seriesResistor = 10000;
float thermNominal = 25;
int relaypin = 11;
float RT, VR, ln, TX, T0, VRT;

int tim = 500; //the value of delay time
LiquidCrystal_I2C lcd(0x27,20,4);
unsigned long StartTime = millis();
void setup() {
  
  lcd.init();
  lcd.backlight();
  lcd.print("Initializing...");
  pinMode(therm0, INPUT);
  pinMode(therm1, INPUT);
  pinMode(therm2, INPUT);
  pinMode(therm3, INPUT);
  pinMode(relaypin, OUTPUT);
  Serial.begin(9600);
  
}

void loop() {
  temp0=pullTemp(therm0);
  temp1=pullTemp(therm1);
  temp2=pullTemp(therm2);
  temp3=pullTemp(therm3);

  temp0=temp0-2.6673;
  temp1=temp1-2.7067;
  temp2=temp2-2.6632;
  temp3=temp3-2.6617;

  
  tempAvg = (temp0+temp1+temp2+temp3)/4;
  
  if (tempAvg < 37)
    {digitalWrite(relaypin, LOW);}
  else
    {digitalWrite(relaypin, HIGH);}

  printLCD(temp0,temp1,temp2,temp3,tempAvg);
  
  long CurrentTime = millis();
  long ElapsedTime = CurrentTime - StartTime;
  long Time = ElapsedTime/1000.00;
  
  lcd.setCursor(0,3);
  lcd.print("Time Elapsed: ");
  lcd.setCursor(14,3);
  lcd.print(ElapsedTime/1000.00);
  lcd.setCursor(19,3);
  lcd.print("S");
  //Serial.print("Avg Temp: ");
  //Serial.print(tempAvg);
  //Serial.print("Time Elapsed: \t");
  //Serial.print(" ");
  Serial.print(ElapsedTime/1000.00);
  Serial.print(" ");
  Serial.print(temp0);
  Serial.print(" ");
  Serial.print(temp1);
  Serial.print(" ");
  Serial.print(temp2);
  Serial.print(" ");
  Serial.print(temp3);
  Serial.println("\t");
  delay(125);
  
}

float pullTemp(int pin){
  float RT, VR, ln, TX, T0, VRT;
  T0 = 25 + 273.15; 
  VRT = analogRead(pin);              //Acquisition analog value of VRT
  VRT = (5.00 / 1023.00) * VRT;      //Conversion to voltage
  VR = VCC - VRT;
  RT = VRT / (VR / R);
  ln = log(RT / RT0);
  TX = (1 / ((ln / B) + (1 / T0))); //Temperature from thermistor
  TX = TX - 273.15;                 //Conversion to Celsius
  return TX;
}
void printLCD(float temp0, float temp1, float temp2, float temp3, float tempAvg){
  lcd.clear();  //Clears the LCD screen and positions the cursor in the upper-left corner.
  //Row1
  lcd.setCursor(0,0);
  lcd.print("T1:");
  lcd.setCursor(3,0);
  lcd.print(temp0);
  lcd.setCursor(8,0);
  lcd.print("C");
  lcd.setCursor(10,0);
  lcd.print("T2:");
  lcd.setCursor(13,0);
  lcd.print(temp1);
  lcd.setCursor(18,0);
  lcd.print("C");
  //Row2
  lcd.setCursor(0,1);
  lcd.print("T3:");
  lcd.setCursor(3,1);
  lcd.print(temp2);
  lcd.setCursor(8,1);
  lcd.print("C");
  lcd.setCursor(10,1);
  lcd.print("T4:");
  lcd.setCursor(13,1);
  lcd.print(temp3);
  lcd.setCursor(18,1);
  lcd.print("C");
  //Row3
  lcd.setCursor(0,2);
  lcd.print("Avg Temp:");
  lcd.setCursor(9,2);
  lcd.print(tempAvg);
  lcd.setCursor(14,2);
  lcd.print("C");
}
