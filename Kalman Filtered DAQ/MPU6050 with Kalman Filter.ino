#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include "I2C.h"

Adafruit_MPU6050 mpu;

struct KalmanFilter {
  float Q;
  float R;
  float x;
  float P;
  float K;

  KalmanFilter(float Q, float R) : Q(Q), R(R), x(0), P(1), K(0) {}

  float update(float measurement) {
    P += Q;
    K = P / (P + R);
    x += K * (measurement - x);
    P *= (1 - K);
    return x;
  }
};

KalmanFilter kfX(0.001, 0.1);
KalmanFilter kfY(0.001, 0.1);
KalmanFilter kfZ(0.001, 0.1);

void setup(void) {
  Serial.begin(115200);

  Wire.begin();
  TWBR = ((F_CPU / 400000L) - 16) / 2;

  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  Serial.println("MPU6050 Found!");

  mpu.setAccelerometerRange(MPU6050_RANGE_8_G);
  mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);

  // Set sample rate to 1 kHz
  i2cWrite(0x19, 0x00, true);  // MPU6050_REG_SMPLRT_DIV register, set to 0 for 1kHz

  delay(100);
}

void loop() {
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);

  float ax = kfX.update(a.acceleration.x);
  float ay = kfY.update(a.acceleration.y);
  float az = kfZ.update(a.acceleration.z);

  Serial.print(ax);
  Serial.print(" ");
  Serial.print(ay);
  Serial.print(" ");
  Serial.println(az);

  delay(1); // Run the loop at approximately 1000Hz
}
