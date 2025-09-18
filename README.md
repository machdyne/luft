# Luft Air Sensor Controller

Luft is an experimental open-source air sensor controller with sockets for up to four MQ gas sensor modules. In addition to MQ modules, you can also connect a SEN55 module (particulate matter, Volatile Organic Compounds, Nitrogen Oxides, humidity, and temperature) and a I2C oxygen sensor, CO₂ sensor, or other I2C sensors.

![Luft](https://github.com/machdyne/luft/blob/2c4f1d8e13273574a24588450f4d979c41fc7301/luft.png)

Luft enables remote monitoring of gasses, air quality and other environmental factors.

The alarm can be triggered by either the MCU or the MQ modules based on their potentiometer setting. The alarm is only activated when JP1 is shunted with a jumper or key switch.

This repo contains schematics, PCB layouts, a DIN-mountable 3D-printable case, and documentation.

Find more information on the [Luft product page](https://machdyne.com/product/luft-air-sensor-controller/).

## Configuration (Tasmota)

### Template

```
{"NAME":"LUFT-ESP32C3","GPIO":[8546,8547,1,8545,8544,1,3872,416,1,1,480,0,0,0,0,0,0,0,1,1,608,640],"FLAG":0,"BASE":1}
```

### Pinout

| GPIO | Function | Description |
| ---- | -------- | ----------- |
| GPIO0 | ADC MQ 3 | MQ3 analog |
| GPIO1 | ADC MQ 4 | MQ4 analog |
| GPIO3 | ADC MQ 2 | MQ2 analog |
| GPIO4 | ADC MQ 1 | MQ1 analog |
| GPIO6 | OUTPUT LOW | MQ power enable |
| GPIO7 | PWM 1 | Fan power control |
| GPIO10 | BUZZER | Buzzer power control |
| GPIO20 | I2C SCL | I2C clock |
| GPIO21 | I2C SDA | I2C data |

### Example Rules

```
# Send MQTT data every 60 seconds
TelePeriod 60

# Socket 1: MQ-135 (GPIO4)
AdcGpio4 135.00, 605.18, -3.937, 15.0

# Socket 2: MQ-2 (GPIO3)
AdcGpio3 2.00, 574.25, -2.22, 15.0

# Socket 3: MQ-6 (GPIO0)
AdcGpio0 6.00, 574.25, -2.22, 15.0

# Socket 4: MQ-9 (GPIO1)
AdcGpio1 9.00, 574.25, -2.22, 15.0
```

### Notes

If you have issues detecting the SEN55 module: https://github.com/arendst/Tasmota/discussions/19027

## Safety

This is an experimental design, use at your own risk. The heating elements in MQ modules can potentially ignite gasses. Luft is intended to be used with the 3D-printable case and an exhaust fan.

## License

The contents of this repo are released under the [Lone Dynamics Open License](LICENSE.md).

Note: You can use these designs for commercial purposes but we ask that instead of producing exact clones, that you either replace our trademarks and logos with your own or add your own next to ours.
