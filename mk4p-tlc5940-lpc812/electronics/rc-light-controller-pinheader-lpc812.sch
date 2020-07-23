EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "DIY RC Light Controller Mk4 S"
Date "2020-06-14"
Rev "1"
Comp "LANE Boys RC"
Comment1 "laneboysrc@gmail.com"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	6000 2400 6000 2200
Wire Wire Line
	6000 2400 5800 2400
Wire Wire Line
	4000 3200 4000 3000
Wire Wire Line
	4400 2600 4400 3200
Wire Wire Line
	1450 5000 1450 4900
Wire Wire Line
	1450 4900 1050 4900
Wire Wire Line
	3150 4200 2650 4200
Text Label 3150 4200 2    50   ~ 0
TH-TX
Wire Wire Line
	4400 2400 4000 2400
Wire Wire Line
	4000 2700 4000 2400
Connection ~ 4000 2400
Text Label 2400 2400 0    70   ~ 0
VIN
Wire Wire Line
	3150 4100 2650 4100
Text Label 3150 4100 2    50   ~ 0
ST-RX
Wire Wire Line
	3150 4400 2650 4400
Text Label 3150 4300 2    50   ~ 0
OUT-ISP
Wire Wire Line
	1450 4400 2250 4400
Wire Wire Line
	2650 4300 3150 4300
Text Label 3150 4400 2    50   ~ 0
CH3
$Comp
L rc-light-controller-pinheader-lpc812-rescue:+3V3-rc-light-controller-tlc5940-lpc812-eagle-import #+3V01
U 1 1 910CF6D9
P 9750 1150
F 0 "#+3V01" H 9750 1150 50  0001 C CNN
F 1 "+3V3" V 9650 950 59  0000 L BNN
F 2 "" H 9750 1150 50  0001 C CNN
F 3 "" H 9750 1150 50  0001 C CNN
	1    9750 1150
	1    0    0    -1
$EndComp
$Comp
L rc-light-controller-pinheader-lpc812-rescue:+3V3-rc-light-controller-tlc5940-lpc812-eagle-import #+3V03
U 1 1 8A0CCF2D
P 6000 2100
F 0 "#+3V03" H 6000 2100 50  0001 C CNN
F 1 "+3V3" V 5900 1900 59  0000 L BNN
F 2 "" H 6000 2100 50  0001 C CNN
F 3 "" H 6000 2100 50  0001 C CNN
	1    6000 2100
	1    0    0    -1
$EndComp
$Comp
L rc-light-controller-pinheader-lpc812-rescue:MCP1703T-3302E_CB-rc-light-controller-tlc5940-lpc812-eagle-import U$1
U 1 1 09B5DC2D
P 5100 2400
F 0 "U$1" H 4946 2699 69  0000 L BNN
F 1 "3V3" H 4994 1812 69  0000 L BNN
F 2 "rc-light-controller-tlc5940-lpc812:SOT95P300X145-3N" H 5100 2400 50  0001 C CNN
F 3 "" H 5100 2400 50  0001 C CNN
	1    5100 2400
	1    0    0    -1
$EndComp
$Comp
L rc-light-controller-pinheader-lpc812-rescue:C-EUC0805-rc-light-controller-tlc5940-lpc812-eagle-import C1
U 1 1 30D010B6
P 4000 2800
F 0 "C1" H 4060 2815 59  0000 L BNN
F 1 "1u/16V" H 4060 2615 59  0000 L BNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4000 2800 50  0001 C CNN
F 3 "" H 4000 2800 50  0001 C CNN
	1    4000 2800
	1    0    0    -1
$EndComp
Text Notes 7750 4500 0    56   ~ 0
Special pins:\nPIO0_0  (19)   ISP UART RX\nPIO0_4  ( 5)   ISP UART TX\nPIO0_5  ( 4)   RESET\nPIO0_10 ( 9)   Open drain\nPIO0_11 ( 8)   Open drain\nPIO0_2  ( 7)   SWDIO\nPIO0_3  ( 6)   SWCLK
Text Notes 1750 3650 0    85   ~ 0
Servo in/out
Text Notes 4600 1750 0    85   ~ 0
Voltage regulator
Text Notes 9350 900  0    85   ~ 0
Microcontroller
Text Notes 3650 3000 0    59   ~ 0
X7R
Text Notes 2650 2650 0    59   ~ 0
Input voltage range:\n4 ... 10V
Text Notes 6300 2600 0    59   ~ 0
LDO: Microchip \nMCP1702 or MCP1703
Text Notes 10450 3900 0    59   ~ 0
NXP LPC812\nARM Cortex-M0\n16K Flash, 4K RAM\nTSSOP-20
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5C85CE29
P 1150 10450
F 0 "#FLG0101" H 1150 10525 50  0001 C CNN
F 1 "PWR_FLAG" H 1150 10624 50  0000 C CNN
F 2 "" H 1150 10450 50  0001 C CNN
F 3 "~" H 1150 10450 50  0001 C CNN
	1    1150 10450
	1    0    0    -1
$EndComp
Wire Wire Line
	1150 10450 1150 10550
Wire Wire Line
	6000 2400 6000 2800
Connection ~ 6000 2400
Wire Wire Line
	6000 3100 6000 3200
$Comp
L Device:CP C2
U 1 1 5C870864
P 6000 2950
F 0 "C2" H 6118 2996 50  0000 L CNN
F 1 "47u/6V3" H 6118 2905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 6038 2800 50  0001 C CNN
F 3 "~" H 6000 2950 50  0001 C CNN
	1    6000 2950
	1    0    0    -1
$EndComp
Text Notes 6100 3200 0    50   ~ 0
Polymer
$Comp
L power:GND #PWR0101
U 1 1 5CCABD51
P 1450 5000
F 0 "#PWR0101" H 1450 4750 50  0001 C CNN
F 1 "GND" H 1455 4827 50  0000 C CNN
F 2 "" H 1450 5000 50  0001 C CNN
F 3 "" H 1450 5000 50  0001 C CNN
	1    1450 5000
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5CCAC0F7
P 9750 3550
F 0 "#PWR0103" H 9750 3300 50  0001 C CNN
F 1 "GND" H 9755 3377 50  0000 C CNN
F 2 "" H 9750 3550 50  0001 C CNN
F 3 "" H 9750 3550 50  0001 C CNN
	1    9750 3550
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5CCAC156
P 4000 3200
F 0 "#PWR0104" H 4000 2950 50  0001 C CNN
F 1 "GND" H 4005 3027 50  0000 C CNN
F 2 "" H 4000 3200 50  0001 C CNN
F 3 "" H 4000 3200 50  0001 C CNN
	1    4000 3200
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5CCAC492
P 4400 3200
F 0 "#PWR0105" H 4400 2950 50  0001 C CNN
F 1 "GND" H 4405 3027 50  0000 C CNN
F 2 "" H 4400 3200 50  0001 C CNN
F 3 "" H 4400 3200 50  0001 C CNN
	1    4400 3200
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5CCAC4F1
P 6000 3200
F 0 "#PWR0106" H 6000 2950 50  0001 C CNN
F 1 "GND" H 6005 3027 50  0000 C CNN
F 2 "" H 6000 3200 50  0001 C CNN
F 3 "" H 6000 3200 50  0001 C CNN
	1    6000 3200
	1    0    0    -1
$EndComp
Wire Wire Line
	9750 3450 9750 3550
$Comp
L power:GND #PWR0111
U 1 1 5CD1123C
P 1150 10550
F 0 "#PWR0111" H 1150 10300 50  0001 C CNN
F 1 "GND" H 1155 10377 50  0000 C CNN
F 2 "" H 1150 10550 50  0001 C CNN
F 3 "" H 1150 10550 50  0001 C CNN
	1    1150 10550
	1    0    0    -1
$EndComp
Text Notes 12200 1450 0    85   ~ 0
LED driver and outputs
Wire Wire Line
	9050 2350 8450 2350
Text Label 8450 2350 0    50   ~ 0
ST-RX
Wire Wire Line
	9050 2750 8450 2750
Text Label 8450 2750 0    50   ~ 0
TH-TX
Wire Wire Line
	11100 2650 10450 2650
Text Label 11100 2650 2    50   ~ 0
OUT-ISP
Wire Wire Line
	11100 2750 10450 2750
$Comp
L MCU_NXP_LPC:LPC812M101JDH20 U1
U 1 1 5EE5F15A
P 9750 2750
F 0 "U1" H 9250 3400 50  0000 C CNN
F 1 "LPC812M101JDH20" H 10150 3400 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 10750 3450 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/LPC81XM.pdf" H 9750 2250 50  0001 C CNN
	1    9750 2750
	1    0    0    -1
$EndComp
Wire Wire Line
	9750 1250 9750 1450
Wire Wire Line
	10450 2350 11100 2350
Wire Wire Line
	8450 2450 9050 2450
Text Label 11100 2350 2    50   ~ 0
OUT15S
NoConn ~ 10450 2450
NoConn ~ 10450 2550
Text Label 8450 2650 0    50   ~ 0
XLAT
Text Label 8450 2550 0    50   ~ 0
SCLK
Text Label 8450 3050 0    50   ~ 0
SIN
$Comp
L power:GND #PWR02
U 1 1 5EFD836E
P 2000 6600
F 0 "#PWR02" H 2000 6350 50  0001 C CNN
F 1 "GND" H 2005 6427 50  0000 C CNN
F 2 "" H 2000 6600 50  0001 C CNN
F 3 "" H 2000 6600 50  0001 C CNN
	1    2000 6600
	1    0    0    -1
$EndComp
Wire Wire Line
	1050 6450 1550 6450
Wire Wire Line
	2000 6450 2000 6600
Wire Wire Line
	1950 4300 1950 6250
Wire Wire Line
	1950 6250 1050 6250
Wire Wire Line
	1950 4300 2250 4300
Text Label 8450 2450 0    50   ~ 0
GSCLK
NoConn ~ 9050 2850
Text Label 1700 6050 2    50   ~ 0
VIN
Text Label 1700 5950 2    50   ~ 0
LED+
Text Notes 1300 7950 0    59   ~ 0
VIN1 is physically close to LED+.\nThis allows two modes of operation:\n1) when VIN1 is conntected to LED+\nvia a solder bridge, then the LEDs are \npowered from the receiver.\n2) A separate power supply can be \nconnected to LED+ (and the nearby GND),\ne.g. for higher voltages
Text Notes 1300 5550 0    85   ~ 0
Slave out
Wire Wire Line
	2400 2400 4000 2400
Text Label 1700 4100 0    50   ~ 0
ST-Rx-in
Text Label 1700 4200 0    50   ~ 0
TH-Tx-in
Text Label 1700 4400 0    50   ~ 0
CH3-in
Text Label 1700 4300 0    50   ~ 0
OUT-ISP-out
$Comp
L Connector_Generic:Conn_01x06 J2
U 1 1 5F1D0E80
P 850 4700
F 0 "J2" H 768 4175 50  0000 C CNN
F 1 "Conn_01x06" H 768 4266 50  0000 C CNN
F 2 "rc-light-controller-tlc5940-lpc812:PinHeader_1x06_P2.54mm_Flat" H 850 4700 50  0001 C CNN
F 3 "~" H 850 4700 50  0001 C CNN
	1    850  4700
	-1   0    0    1
$EndComp
Wire Wire Line
	1450 4400 1450 4500
Wire Wire Line
	1450 4500 1050 4500
Wire Wire Line
	1300 4200 1300 4600
Wire Wire Line
	1300 4600 1050 4600
Wire Wire Line
	1300 4200 2250 4200
Wire Wire Line
	1200 4100 1200 4700
Wire Wire Line
	1200 4700 1050 4700
Wire Wire Line
	1200 4100 2250 4100
Wire Wire Line
	1050 4800 1600 4800
Text Label 1600 4800 2    50   ~ 0
VIN
Wire Wire Line
	15600 2550 15600 1750
Text Label 15600 1750 0    50   ~ 0
LED+
Connection ~ 15600 2550
Connection ~ 15600 2650
Wire Wire Line
	15600 2650 15600 2550
Connection ~ 15600 2750
Wire Wire Line
	15600 2750 15600 2650
Connection ~ 15600 2850
Wire Wire Line
	15600 2850 15600 2750
Connection ~ 15600 2950
Wire Wire Line
	15600 2950 15600 2850
Connection ~ 15600 3050
Wire Wire Line
	15600 3050 15600 2950
Connection ~ 15600 3150
Wire Wire Line
	15600 3150 15600 3050
Wire Wire Line
	15600 3150 15600 3250
Connection ~ 15600 3250
Wire Wire Line
	15600 3250 15600 3350
Connection ~ 15600 3350
Wire Wire Line
	15600 3350 15600 3450
Connection ~ 15600 3450
Wire Wire Line
	15600 3450 15600 3550
Connection ~ 15600 3550
Wire Wire Line
	15600 3550 15600 3650
Connection ~ 15600 3650
Wire Wire Line
	15600 3650 15600 3750
Connection ~ 15600 3750
Wire Wire Line
	15600 3750 15600 3850
Connection ~ 15600 3850
Wire Wire Line
	15600 3850 15600 3950
Connection ~ 15600 3950
Wire Wire Line
	15600 3950 15600 4050
Connection ~ 15600 4050
Wire Wire Line
	15600 4050 15600 4150
Wire Wire Line
	14850 4150 14850 6500
$Comp
L Connector_Generic:Conn_01x06 J3
U 1 1 5F244636
P 850 6250
F 0 "J3" H 768 5725 50  0000 C CNN
F 1 "Conn_01x06" H 768 5816 50  0000 C CNN
F 2 "rc-light-controller-tlc5940-lpc812:PinHeader_1x06_P2.54mm_Flat" H 850 6250 50  0001 C CNN
F 3 "~" H 850 6250 50  0001 C CNN
	1    850  6250
	-1   0    0    1
$EndComp
Wire Wire Line
	1050 6050 1250 6050
Wire Wire Line
	1050 6350 1250 6350
Wire Wire Line
	1250 6350 1250 6050
Connection ~ 1250 6050
Wire Wire Line
	1250 6050 1700 6050
Wire Wire Line
	1050 6150 1550 6150
Wire Wire Line
	1550 6150 1550 6450
Connection ~ 1550 6450
Wire Wire Line
	1550 6450 2000 6450
Wire Wire Line
	1050 5950 1700 5950
Wire Wire Line
	15600 2850 15350 2850
Wire Wire Line
	15350 2750 15600 2750
Wire Wire Line
	15350 2650 15600 2650
Wire Wire Line
	15350 4150 15600 4150
Wire Wire Line
	15350 4050 15600 4050
Wire Wire Line
	15350 3950 15600 3950
Wire Wire Line
	15350 3850 15600 3850
Wire Wire Line
	15350 3750 15600 3750
Wire Wire Line
	15350 3650 15600 3650
Wire Wire Line
	15350 3550 15600 3550
Wire Wire Line
	15350 3450 15600 3450
Wire Wire Line
	15350 2550 15600 2550
Wire Wire Line
	15350 3350 15600 3350
Wire Wire Line
	15350 3250 15600 3250
Wire Wire Line
	15350 3150 15600 3150
Wire Wire Line
	15350 3050 15600 3050
Wire Wire Line
	15350 2950 15600 2950
$Comp
L Connector_Generic:Conn_02x17_Odd_Even J1
U 1 1 5F1ABEB8
P 15150 3350
F 0 "J1" H 15200 4367 50  0000 C CNN
F 1 "Conn_02x17_Odd_Even" H 15200 4276 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x17_P2.54mm_Horizontal" H 15150 3350 50  0001 C CNN
F 3 "~" H 15150 3350 50  0001 C CNN
	1    15150 3350
	-1   0    0    1
$EndComp
$Comp
L Device:R_Pack04 RN1
U 1 1 5F192F7F
P 2450 4300
F 0 "RN1" V 2033 4300 50  0000 C CNN
F 1 "R_Pack04" V 2124 4300 50  0000 C CNN
F 2 "Resistor_SMD:R_Array_Concave_4x0603" V 2725 4300 50  0001 C CNN
F 3 "~" H 2450 4300 50  0001 C CNN
	1    2450 4300
	0    1    1    0
$EndComp
Text Label 11100 2750 2    50   ~ 0
CH3
Wire Wire Line
	8450 2550 9050 2550
Wire Wire Line
	8450 3050 9050 3050
Wire Wire Line
	1950 4300 1100 4300
Wire Wire Line
	1100 4300 1100 4400
Wire Wire Line
	1100 4400 1050 4400
Connection ~ 1950 4300
$Comp
L Mechanical:MountingHole H1
U 1 1 5F2D18E2
P 7600 8150
F 0 "H1" H 7700 8196 50  0000 L CNN
F 1 "MountingHole" H 7700 8105 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_ISO14580" H 7600 8150 50  0001 C CNN
F 3 "~" H 7600 8150 50  0001 C CNN
	1    7600 8150
	1    0    0    -1
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5F2D2122
P 7600 8400
F 0 "H2" H 7700 8446 50  0000 L CNN
F 1 "MountingHole" H 7700 8355 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_ISO14580" H 7600 8400 50  0001 C CNN
F 3 "~" H 7600 8400 50  0001 C CNN
	1    7600 8400
	1    0    0    -1
$EndComp
Wire Wire Line
	8450 2650 9050 2650
NoConn ~ 10450 2850
$Comp
L Device:C C3
U 1 1 5F2418F7
P 10050 1600
F 0 "C3" H 10165 1646 50  0000 L CNN
F 1 "100n" H 10165 1555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 10088 1450 50  0001 C CNN
F 3 "~" H 10050 1600 50  0001 C CNN
	1    10050 1600
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5F2421F0
P 10050 1800
F 0 "#PWR03" H 10050 1550 50  0001 C CNN
F 1 "GND" H 10055 1627 50  0000 C CNN
F 2 "" H 10050 1800 50  0001 C CNN
F 3 "" H 10050 1800 50  0001 C CNN
	1    10050 1800
	1    0    0    -1
$EndComp
Wire Wire Line
	10050 1750 10050 1800
Wire Wire Line
	10050 1450 9750 1450
Connection ~ 9750 1450
Wire Wire Line
	9750 1450 9750 2050
Wire Wire Line
	8450 2950 9050 2950
Text Label 8450 2950 0    50   ~ 0
BLANK
NoConn ~ 9050 3150
NoConn ~ 10450 3150
NoConn ~ 10450 3050
NoConn ~ 10450 2950
$Comp
L power:GND #PWR01
U 1 1 5EEF5842
P 13300 7650
F 0 "#PWR01" H 13300 7400 50  0001 C CNN
F 1 "GND" H 13305 7477 50  0000 C CNN
F 2 "" H 13300 7650 50  0001 C CNN
F 3 "" H 13300 7650 50  0001 C CNN
	1    13300 7650
	1    0    0    -1
$EndComp
Text Notes 12250 7350 0    56   ~ 0
N-Channel MOSFET\nSOT23 package\ne.g. NXP PMV16UN
Wire Wire Line
	13000 6500 14850 6500
Text Label 12100 6700 0    50   ~ 0
OUT15S
Wire Wire Line
	12100 6700 12700 6700
Wire Wire Line
	13300 6900 13300 7650
Wire Wire Line
	13000 6900 13300 6900
$Comp
L Device:Q_NMOS_GSD T9
U 1 1 5EEE69E5
P 12900 6700
F 0 "T9" H 13000 6800 59  0000 L BNN
F 1 "NMOSSOT23" H 13000 6700 59  0001 L BNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 12900 6700 50  0001 C CNN
F 3 "" H 12900 6700 50  0001 C CNN
	1    12900 6700
	1    0    0    -1
$EndComp
NoConn ~ 14550 7300
$Comp
L rc-light-controller-pinheader-lpc812-rescue:TLC5940PWP-rc-light-controller-tlc5940-lpc812-eagle-import 1
U 1 1 5F1F6430
P 8800 7050
F 0 "1" H 8000 8836 59  0000 C CNN
F 1 "TLC5940PWP-rc-light-controller-tlc5940-lpc812-eagle-import" H 8000 8731 59  0000 C CNN
F 2 "rc-light-controller-tlc5940-lpc812:SOP65P640X120-29N" H 8800 7050 50  0001 C CNN
F 3 "" H 8800 7050 50  0001 C CNN
	1    8800 7050
	1    0    0    -1
$EndComp
Wire Wire Line
	8900 5550 9650 5550
Wire Wire Line
	8900 5650 9650 5650
Wire Wire Line
	8900 5750 9650 5750
Wire Wire Line
	8900 5850 9650 5850
Wire Wire Line
	8900 5950 9650 5950
Wire Wire Line
	8900 6050 9650 6050
Wire Wire Line
	8900 6150 9650 6150
Wire Wire Line
	8900 6250 9650 6250
Wire Wire Line
	8900 6350 9650 6350
Wire Wire Line
	8900 6450 9650 6450
Wire Wire Line
	8900 6550 9650 6550
Wire Wire Line
	8900 6650 9650 6650
Wire Wire Line
	8900 6750 9650 6750
Wire Wire Line
	8900 6850 9650 6850
Wire Wire Line
	8900 6950 9650 6950
Wire Wire Line
	8900 7050 9650 7050
Text Label 9650 5550 2    50   ~ 0
OUT0
Text Label 9650 5650 2    50   ~ 0
OUT1
Text Label 9650 5750 2    50   ~ 0
OUT2
Text Label 9650 5850 2    50   ~ 0
OUT3
Text Label 9650 5950 2    50   ~ 0
OUT4
Text Label 9650 6050 2    50   ~ 0
OUT5
Text Label 9650 6150 2    50   ~ 0
OUT6
Text Label 9650 6250 2    50   ~ 0
OUT7
Text Label 9650 6350 2    50   ~ 0
OUT8
Text Label 9650 6450 2    50   ~ 0
OUT9
Text Label 9650 6550 2    50   ~ 0
OUT10
Text Label 9650 6650 2    50   ~ 0
OUT11
Text Label 9650 6750 2    50   ~ 0
OUT12
Text Label 9650 6850 2    50   ~ 0
OUT13
Text Label 9650 6950 2    50   ~ 0
OUT14
Text Label 9650 7050 2    50   ~ 0
OUT15
$Comp
L power:GND #PWR06
U 1 1 5F231909
P 8200 7450
F 0 "#PWR06" H 8200 7200 50  0001 C CNN
F 1 "GND" H 8205 7277 50  0000 C CNN
F 2 "" H 8200 7450 50  0001 C CNN
F 3 "" H 8200 7450 50  0001 C CNN
	1    8200 7450
	1    0    0    -1
$EndComp
Wire Wire Line
	8200 7350 8200 7450
$Comp
L Device:R R1
U 1 1 5F23623F
P 6350 7250
F 0 "R1" H 6420 7296 50  0000 L CNN
F 1 "R" H 6420 7205 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6280 7250 50  0001 C CNN
F 3 "~" H 6350 7250 50  0001 C CNN
	1    6350 7250
	1    0    0    -1
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5F23655D
P 6350 7500
F 0 "#PWR04" H 6350 7250 50  0001 C CNN
F 1 "GND" H 6355 7327 50  0000 C CNN
F 2 "" H 6350 7500 50  0001 C CNN
F 3 "" H 6350 7500 50  0001 C CNN
	1    6350 7500
	1    0    0    -1
$EndComp
Wire Wire Line
	6350 7400 6350 7500
Wire Wire Line
	7100 5650 6350 5650
Wire Wire Line
	6350 5650 6350 7100
$Comp
L power:GND #PWR05
U 1 1 5F23E35F
P 6750 5750
F 0 "#PWR05" H 6750 5500 50  0001 C CNN
F 1 "GND" H 6755 5577 50  0000 C CNN
F 2 "" H 6750 5750 50  0001 C CNN
F 3 "" H 6750 5750 50  0001 C CNN
	1    6750 5750
	1    0    0    -1
$EndComp
Wire Wire Line
	6750 5750 7100 5750
$Comp
L rc-light-controller-pinheader-lpc812-rescue:+3V3-rc-light-controller-tlc5940-lpc812-eagle-import #+3V02
U 1 1 5F24451C
P 6850 4750
F 0 "#+3V02" H 6850 4750 50  0001 C CNN
F 1 "+3V3" V 6750 4550 59  0000 L BNN
F 2 "" H 6850 4750 50  0001 C CNN
F 3 "" H 6850 4750 50  0001 C CNN
	1    6850 4750
	1    0    0    -1
$EndComp
Wire Wire Line
	6850 4850 6850 5550
Wire Wire Line
	6850 5550 7100 5550
Wire Wire Line
	7100 6050 6850 6050
Wire Wire Line
	6850 6050 6850 5550
Connection ~ 6850 5550
Wire Wire Line
	6850 6150 6850 6050
Connection ~ 6850 6050
Wire Wire Line
	6850 6150 7100 6150
Wire Wire Line
	7100 6250 5300 6250
Text Label 5300 6250 0    50   ~ 0
BLANK
Wire Wire Line
	5300 5950 7100 5950
Text Label 5300 5950 0    50   ~ 0
GSCLK
Wire Wire Line
	5300 6550 7100 6550
Text Label 5300 6550 0    50   ~ 0
SCLK
Wire Wire Line
	5300 6650 7100 6650
Text Label 5300 6650 0    50   ~ 0
SIN
Wire Wire Line
	5300 6850 7100 6850
Text Label 5300 6850 0    50   ~ 0
XLAT
NoConn ~ 7100 6750
NoConn ~ 7100 6950
Wire Wire Line
	14850 4050 14150 4050
Wire Wire Line
	14150 3950 14850 3950
Wire Wire Line
	14150 3850 14850 3850
Wire Wire Line
	14150 3750 14850 3750
Wire Wire Line
	14150 3650 14850 3650
Wire Wire Line
	14150 3550 14850 3550
Wire Wire Line
	14150 3450 14850 3450
Wire Wire Line
	14150 3350 14850 3350
Wire Wire Line
	14150 3250 14850 3250
Wire Wire Line
	14150 3150 14850 3150
Wire Wire Line
	14150 3050 14850 3050
Wire Wire Line
	14150 2950 14850 2950
Wire Wire Line
	14150 2850 14850 2850
Wire Wire Line
	14150 2750 14850 2750
Wire Wire Line
	14150 2650 14850 2650
Wire Wire Line
	14150 2550 14850 2550
Text Label 14150 2550 0    50   ~ 0
OUT0
Text Label 14150 2650 0    50   ~ 0
OUT1
Text Label 14150 2750 0    50   ~ 0
OUT2
Text Label 14150 2850 0    50   ~ 0
OUT3
Text Label 14150 2950 0    50   ~ 0
OUT4
Text Label 14150 3050 0    50   ~ 0
OUT5
Text Label 14150 3150 0    50   ~ 0
OUT6
Text Label 14150 3250 0    50   ~ 0
OUT7
Text Label 14150 3350 0    50   ~ 0
OUT8
Text Label 14150 3450 0    50   ~ 0
OUT9
Text Label 14150 3550 0    50   ~ 0
OUT10
Text Label 14150 3650 0    50   ~ 0
OUT11
Text Label 14150 3750 0    50   ~ 0
OUT12
Text Label 14150 3850 0    50   ~ 0
OUT13
Text Label 14150 3950 0    50   ~ 0
OUT14
Text Label 14150 4050 0    50   ~ 0
OUT15
$EndSCHEMATC
