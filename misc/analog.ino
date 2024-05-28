void setup()
{
    Serial.begin(9600); // Serial monitor at 9600 baudrate
}
void loop()
{
    int c0 = analogRead(0); // Channel 0 (A0) is selected
    int c1 = analogRead(1); // Channel 0 (A0) is selected
    Serial.print((float)millis()/1000);
    Serial.print(",");
    Serial.print(c0);
    Serial.print(",");
    Serial.println(c1);
    delay(500);
}
