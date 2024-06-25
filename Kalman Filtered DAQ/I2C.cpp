#include "I2C.h"

uint8_t i2cWrite(uint8_t registerAddress, uint8_t data, bool sendStop) {
  Wire.beginTransmission(0x68);
  Wire.write(registerAddress);
  Wire.write(data);
  uint8_t status = Wire.endTransmission(sendStop);
  return status;
}

uint8_t i2cWrite(uint8_t registerAddress, uint8_t *data, uint8_t length, bool sendStop) {
  Wire.beginTransmission(0x68);
  Wire.write(registerAddress);
  for (uint8_t i = 0; i < length; i++) {
    Wire.write(data[i]);
  }
  uint8_t status = Wire.endTransmission(sendStop);
  return status;
}

uint8_t i2cRead(uint8_t registerAddress, uint8_t *data, uint8_t length) {
  Wire.beginTransmission(0x68);
  Wire.write(registerAddress);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, length);
  for (uint8_t i = 0; i < length && Wire.available(); i++) {
    data[i] = Wire.read();
  }
  return Wire.available() == length ? 0 : 1; // Return 0 if all bytes are read, 1 otherwise
}
