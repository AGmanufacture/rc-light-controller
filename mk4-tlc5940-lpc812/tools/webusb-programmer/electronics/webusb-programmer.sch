EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "WebUSB Programmer for Light Controller Mk4"
Date "2020-03-16"
Rev "1"
Comp "LANE Boys RC"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:USB_B_Micro J1
U 1 1 5E6F135C
P 1200 3100
F 0 "J1" H 1257 3567 50  0000 C CNN
F 1 "USB_B_Micro" H 1257 3476 50  0000 C CNN
F 2 "USB:Mirco_USB_Type_B_eBay_AliExpress" H 1350 3050 50  0001 C CNN
F 3 "~" H 1350 3050 50  0001 C CNN
	1    1200 3100
	1    0    0    -1  
$EndComp
$Comp
L wla-atsamd21:SAMD21E15A-MU U2
U 1 1 5E6F4A3D
P 5300 2550
F 0 "U2" H 5300 4067 50  0000 C CNN
F 1 "SAMD21E15A-MU" H 5300 3976 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-32-1EP_5x5mm_P0.5mm_EP3.1x3.1mm" H 5300 1550 50  0001 C CIN
F 3 "" H 5300 2550 50  0001 C CNN
	1    5300 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5E6F6F74
P 5000 5700
F 0 "D2" V 5039 5583 50  0000 R CNN
F 1 "OK" V 4948 5583 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Castellated" H 5000 5700 50  0001 C CNN
F 3 "~" H 5000 5700 50  0001 C CNN
	1    5000 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D3
U 1 1 5E6F790B
P 5600 5700
F 0 "D3" V 5639 5582 50  0000 R CNN
F 1 "BUSY" V 5548 5582 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Castellated" H 5600 5700 50  0001 C CNN
F 3 "~" H 5600 5700 50  0001 C CNN
	1    5600 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D4
U 1 1 5E6F7DEF
P 6200 5700
F 0 "D4" V 6239 5583 50  0000 R CNN
F 1 "ERROR" V 6148 5583 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Castellated" H 6200 5700 50  0001 C CNN
F 3 "~" H 6200 5700 50  0001 C CNN
	1    6200 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D1
U 1 1 5E6F89A9
P 3150 6350
F 0 "D1" V 3189 6233 50  0000 R CNN
F 1 "MCU POWER" V 3098 6233 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Castellated" H 3150 6350 50  0001 C CNN
F 3 "~" H 3150 6350 50  0001 C CNN
	1    3150 6350
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D5
U 1 1 5E6F8DF4
P 9200 3400
F 0 "D5" V 9239 3282 50  0000 R CNN
F 1 "LC POWER" V 9148 3282 50  0000 R CNN
F 2 "LED_SMD:LED_0805_2012Metric_Castellated" H 9200 3400 50  0001 C CNN
F 3 "~" H 9200 3400 50  0001 C CNN
	1    9200 3400
	0    -1   -1   0   
$EndComp
$Comp
L Regulator_Linear:MCP1703A-3302_SOT23 U1
U 1 1 5E6F9513
P 2150 5700
F 0 "U1" H 2150 5942 50  0000 C CNN
F 1 "MCP1703A-3302_SOT23" H 2150 5851 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23W_Handsoldering" H 2150 5900 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/20005122B.pdf" H 2150 5650 50  0001 C CNN
	1    2150 5700
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C2
U 1 1 5E6F9D7B
P 2650 5950
F 0 "C2" H 2768 5996 50  0000 L CNN
F 1 "CP" H 2768 5905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 2688 5800 50  0001 C CNN
F 3 "~" H 2650 5950 50  0001 C CNN
	1    2650 5950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5E6FA34F
P 1650 5950
F 0 "C1" H 1765 5996 50  0000 L CNN
F 1 "C" H 1765 5905 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1688 5800 50  0001 C CNN
F 3 "~" H 1650 5950 50  0001 C CNN
	1    1650 5950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5E6FABAC
P 5000 5300
F 0 "R2" H 5070 5346 50  0000 L CNN
F 1 "R" H 5070 5255 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 4930 5300 50  0001 C CNN
F 3 "~" H 5000 5300 50  0001 C CNN
	1    5000 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5E6FBCF2
P 5600 5300
F 0 "R3" H 5670 5346 50  0000 L CNN
F 1 "R" H 5670 5255 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 5530 5300 50  0001 C CNN
F 3 "~" H 5600 5300 50  0001 C CNN
	1    5600 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5E6FC0B8
P 6200 5300
F 0 "R4" H 6270 5346 50  0000 L CNN
F 1 "R" H 6270 5255 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 6130 5300 50  0001 C CNN
F 3 "~" H 6200 5300 50  0001 C CNN
	1    6200 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5E6FD03E
P 9200 3000
F 0 "R5" H 9270 3046 50  0000 L CNN
F 1 "R" H 9270 2955 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9130 3000 50  0001 C CNN
F 3 "~" H 9200 3000 50  0001 C CNN
	1    9200 3000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5E6FD675
P 3150 5950
F 0 "R1" H 3220 5996 50  0000 L CNN
F 1 "R" H 3220 5905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 3080 5950 50  0001 C CNN
F 3 "~" H 3150 5950 50  0001 C CNN
	1    3150 5950
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Male J2
U 1 1 5E6FE83D
P 10300 2650
F 0 "J2" H 10272 2532 50  0000 R CNN
F 1 "Light Controller" H 10272 2623 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 10300 2650 50  0001 C CNN
F 3 "~" H 10300 2650 50  0001 C CNN
	1    10300 2650
	-1   0    0    1   
$EndComp
$Comp
L wla-atsamd21:STMPS2141STR U3
U 1 1 5E709E73
P 8450 2750
F 0 "U3" H 8450 3117 50  0000 C CNN
F 1 "STMPS2141STR" H 8450 3026 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5_HandSoldering" H 8450 3250 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tps22917.pdf" H 8500 2050 50  0001 C CNN
	1    8450 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR019
U 1 1 5E710261
P 9200 3650
F 0 "#PWR019" H 9200 3400 50  0001 C CNN
F 1 "GND" H 9205 3477 50  0000 C CNN
F 2 "" H 9200 3650 50  0001 C CNN
F 3 "" H 9200 3650 50  0001 C CNN
	1    9200 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5E71085D
P 8450 3150
F 0 "#PWR018" H 8450 2900 50  0001 C CNN
F 1 "GND" H 8455 2977 50  0000 C CNN
F 2 "" H 8450 3150 50  0001 C CNN
F 3 "" H 8450 3150 50  0001 C CNN
	1    8450 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 3050 8450 3150
Wire Wire Line
	9200 3150 9200 3250
Wire Wire Line
	9200 3550 9200 3650
$Comp
L power:GND #PWR020
U 1 1 5E713E19
P 10000 2950
F 0 "#PWR020" H 10000 2700 50  0001 C CNN
F 1 "GND" H 10005 2777 50  0000 C CNN
F 2 "" H 10000 2950 50  0001 C CNN
F 3 "" H 10000 2950 50  0001 C CNN
	1    10000 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 2950 10000 2850
Wire Wire Line
	10000 2850 10100 2850
$Comp
L power:+5V #PWR01
U 1 1 5E718ABF
P 1650 5350
F 0 "#PWR01" H 1650 5200 50  0001 C CNN
F 1 "+5V" H 1665 5523 50  0000 C CNN
F 2 "" H 1650 5350 50  0001 C CNN
F 3 "" H 1650 5350 50  0001 C CNN
	1    1650 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 5450 5000 5550
Wire Wire Line
	5600 5450 5600 5550
Wire Wire Line
	6200 5450 6200 5550
$Comp
L power:GND #PWR013
U 1 1 5E730E75
P 5000 5950
F 0 "#PWR013" H 5000 5700 50  0001 C CNN
F 1 "GND" H 5005 5777 50  0000 C CNN
F 2 "" H 5000 5950 50  0001 C CNN
F 3 "" H 5000 5950 50  0001 C CNN
	1    5000 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 5E73101A
P 5600 5950
F 0 "#PWR015" H 5600 5700 50  0001 C CNN
F 1 "GND" H 5605 5777 50  0000 C CNN
F 2 "" H 5600 5950 50  0001 C CNN
F 3 "" H 5600 5950 50  0001 C CNN
	1    5600 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5E73121D
P 6200 5950
F 0 "#PWR016" H 6200 5700 50  0001 C CNN
F 1 "GND" H 6205 5777 50  0000 C CNN
F 2 "" H 6200 5950 50  0001 C CNN
F 3 "" H 6200 5950 50  0001 C CNN
	1    6200 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 5850 6200 5950
Wire Wire Line
	5600 5850 5600 5950
Wire Wire Line
	5000 5850 5000 5950
$Comp
L power:GND #PWR06
U 1 1 5E73DD0C
P 2650 6200
F 0 "#PWR06" H 2650 5950 50  0001 C CNN
F 1 "GND" H 2655 6027 50  0000 C CNN
F 2 "" H 2650 6200 50  0001 C CNN
F 3 "" H 2650 6200 50  0001 C CNN
	1    2650 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5E73F918
P 3150 6600
F 0 "#PWR08" H 3150 6350 50  0001 C CNN
F 1 "GND" H 3155 6427 50  0000 C CNN
F 2 "" H 3150 6600 50  0001 C CNN
F 3 "" H 3150 6600 50  0001 C CNN
	1    3150 6600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5E741307
P 2150 6100
F 0 "#PWR04" H 2150 5850 50  0001 C CNN
F 1 "GND" H 2155 5927 50  0000 C CNN
F 2 "" H 2150 6100 50  0001 C CNN
F 3 "" H 2150 6100 50  0001 C CNN
	1    2150 6100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5E7415B1
P 1650 6200
F 0 "#PWR02" H 1650 5950 50  0001 C CNN
F 1 "GND" H 1655 6027 50  0000 C CNN
F 2 "" H 1650 6200 50  0001 C CNN
F 3 "" H 1650 6200 50  0001 C CNN
	1    1650 6200
	1    0    0    -1  
$EndComp
NoConn ~ 1500 3300
$Comp
L power:GND #PWR03
U 1 1 5E74A406
P 1200 3600
F 0 "#PWR03" H 1200 3350 50  0001 C CNN
F 1 "GND" H 1205 3427 50  0000 C CNN
F 2 "" H 1200 3600 50  0001 C CNN
F 3 "" H 1200 3600 50  0001 C CNN
	1    1200 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 3500 1200 3600
NoConn ~ 1100 3500
Wire Wire Line
	1650 5350 1650 5700
Wire Wire Line
	1650 6100 1650 6200
Wire Wire Line
	1850 5700 1650 5700
Wire Wire Line
	2650 6100 2650 6200
Wire Wire Line
	3150 6100 3150 6200
Wire Wire Line
	3150 6500 3150 6600
Wire Wire Line
	2150 6000 2150 6100
$Comp
L power:+5V #PWR05
U 1 1 5E75A54A
P 1850 2750
F 0 "#PWR05" H 1850 2600 50  0001 C CNN
F 1 "+5V" H 1865 2923 50  0000 C CNN
F 2 "" H 1850 2750 50  0001 C CNN
F 3 "" H 1850 2750 50  0001 C CNN
	1    1850 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 2750 1850 2900
Wire Wire Line
	1850 2900 1500 2900
$Comp
L power:+5V #PWR017
U 1 1 5E75CDA0
P 7850 2450
F 0 "#PWR017" H 7850 2300 50  0001 C CNN
F 1 "+5V" H 7865 2623 50  0000 C CNN
F 2 "" H 7850 2450 50  0001 C CNN
F 3 "" H 7850 2450 50  0001 C CNN
	1    7850 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 2450 7850 2650
Wire Wire Line
	7850 2650 8050 2650
NoConn ~ 10100 2450
$Comp
L Device:R R6
U 1 1 5E7657EA
P 9750 2350
F 0 "R6" V 9700 2150 50  0000 C CNN
F 1 "1k" V 9700 2550 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9680 2350 50  0001 C CNN
F 3 "~" H 9750 2350 50  0001 C CNN
	1    9750 2350
	0    1    1    0   
$EndComp
$Comp
L Device:R R7
U 1 1 5E76649B
P 9750 2550
F 0 "R7" V 9700 2350 50  0000 C CNN
F 1 "1k" V 9700 2750 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9680 2550 50  0001 C CNN
F 3 "~" H 9750 2550 50  0001 C CNN
	1    9750 2550
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 5E76676C
P 9750 2650
F 0 "R8" V 9700 2450 50  0000 C CNN
F 1 "1k" V 9700 2850 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.15x1.40mm_HandSolder" V 9680 2650 50  0001 C CNN
F 3 "~" H 9750 2650 50  0001 C CNN
	1    9750 2650
	0    1    1    0   
$EndComp
Wire Wire Line
	9900 2650 10100 2650
Wire Wire Line
	9900 2550 10100 2550
Wire Wire Line
	9900 2350 10100 2350
Wire Wire Line
	5000 5150 5000 4750
Wire Wire Line
	5600 4750 5600 5150
Wire Wire Line
	6200 4750 6200 5150
$Comp
L power:GND #PWR014
U 1 1 5E770B6C
P 4050 3900
F 0 "#PWR014" H 4050 3650 50  0001 C CNN
F 1 "GND" H 4055 3727 50  0000 C CNN
F 2 "" H 4050 3900 50  0001 C CNN
F 3 "" H 4050 3900 50  0001 C CNN
	1    4050 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 3700 4050 3800
Connection ~ 4050 3800
Wire Wire Line
	4050 3800 4050 3900
Wire Wire Line
	9600 2550 9300 2550
Wire Wire Line
	9300 2650 9600 2650
Text Label 9300 2650 0    50   ~ 0
TX
Text Label 9300 2550 0    50   ~ 0
RX
Wire Wire Line
	9300 2350 9600 2350
Text Label 9300 2350 0    50   ~ 0
ISP
Text Label 8900 2750 0    50   ~ 0
VLIGHT
Wire Wire Line
	6550 3100 7150 3100
Wire Wire Line
	7150 3200 6550 3200
Text Label 7150 3100 2    50   ~ 0
TX
Text Label 7150 3200 2    50   ~ 0
RX
Wire Wire Line
	7150 3300 6550 3300
Wire Wire Line
	7150 3400 6550 3400
Text Label 7150 3300 2    50   ~ 0
USB-DM
Text Label 7150 3400 2    50   ~ 0
USB-DP
Wire Wire Line
	1500 3100 2300 3100
Wire Wire Line
	2300 3200 1500 3200
Text Label 2300 3100 2    50   ~ 0
USB-DP
Text Label 2300 3200 2    50   ~ 0
USB-DM
$Comp
L power:+3V3 #PWR07
U 1 1 5E788A3B
P 3150 5350
F 0 "#PWR07" H 3150 5200 50  0001 C CNN
F 1 "+3V3" H 3165 5523 50  0000 C CNN
F 2 "" H 3150 5350 50  0001 C CNN
F 3 "" H 3150 5350 50  0001 C CNN
	1    3150 5350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR011
U 1 1 5E78CDCD
P 3850 1600
F 0 "#PWR011" H 3850 1450 50  0001 C CNN
F 1 "+3V3" H 3865 1773 50  0000 C CNN
F 2 "" H 3850 1600 50  0001 C CNN
F 3 "" H 3850 1600 50  0001 C CNN
	1    3850 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 1700 3850 1700
Wire Wire Line
	3850 1700 3850 1600
Wire Wire Line
	3850 1700 3850 2200
Wire Wire Line
	3850 2200 4050 2200
Connection ~ 3850 1700
$Comp
L Device:C C5
U 1 1 5E78EC25
P 3850 2350
F 0 "C5" H 3965 2396 50  0000 L CNN
F 1 "100n" H 3965 2305 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3888 2200 50  0001 C CNN
F 3 "~" H 3850 2350 50  0001 C CNN
	1    3850 2350
	1    0    0    -1  
$EndComp
Connection ~ 3850 2200
$Comp
L power:GND #PWR012
U 1 1 5E78FA6F
P 3850 2600
F 0 "#PWR012" H 3850 2350 50  0001 C CNN
F 1 "GND" H 3855 2427 50  0000 C CNN
F 2 "" H 3850 2600 50  0001 C CNN
F 3 "" H 3850 2600 50  0001 C CNN
	1    3850 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 2500 3850 2600
$Comp
L Device:C C4
U 1 1 5E7914FA
P 3500 2000
F 0 "C4" H 3615 2046 50  0000 L CNN
F 1 "1u" H 3615 1955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3538 1850 50  0001 C CNN
F 3 "~" H 3500 2000 50  0001 C CNN
	1    3500 2000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5E79198F
P 3500 2600
F 0 "#PWR010" H 3500 2350 50  0001 C CNN
F 1 "GND" H 3505 2427 50  0000 C CNN
F 2 "" H 3500 2600 50  0001 C CNN
F 3 "" H 3500 2600 50  0001 C CNN
	1    3500 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 2150 3500 2600
Wire Wire Line
	3500 1850 4050 1850
$Comp
L power:GND #PWR09
U 1 1 5E7940E5
P 3150 2600
F 0 "#PWR09" H 3150 2350 50  0001 C CNN
F 1 "GND" H 3155 2427 50  0000 C CNN
F 2 "" H 3150 2600 50  0001 C CNN
F 3 "" H 3150 2600 50  0001 C CNN
	1    3150 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5E799517
P 3150 1450
F 0 "C3" H 3265 1496 50  0000 L CNN
F 1 "100n" H 3265 1405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 3188 1300 50  0001 C CNN
F 3 "~" H 3150 1450 50  0001 C CNN
	1    3150 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 1300 4050 1300
Wire Wire Line
	3150 1600 3150 2600
Text Label 5000 4750 3    50   ~ 0
OK
Text Label 5600 4750 3    50   ~ 0
BUSY
Text Label 6200 4750 3    50   ~ 0
ERROR
Wire Wire Line
	8850 2750 9200 2750
Wire Wire Line
	9200 2850 9200 2750
Connection ~ 9200 2750
Wire Wire Line
	9200 2750 10100 2750
Wire Wire Line
	1650 5700 1650 5800
Connection ~ 1650 5700
Wire Wire Line
	3150 5700 3150 5800
Wire Wire Line
	2450 5700 2650 5700
Wire Wire Line
	3100 5350 3150 5350
Wire Wire Line
	3150 5350 3150 5700
Connection ~ 3150 5350
Connection ~ 3150 5700
Wire Wire Line
	2650 5800 2650 5700
Connection ~ 2650 5700
Wire Wire Line
	2650 5700 3150 5700
Wire Wire Line
	6550 1700 7150 1700
Wire Wire Line
	7150 1800 6550 1800
Wire Wire Line
	7150 1900 6550 1900
Text Label 7150 1700 2    50   ~ 0
OK
Text Label 7150 1800 2    50   ~ 0
BUSY
Text Label 7150 1900 2    50   ~ 0
ERROR
Text Label 7150 3500 2    50   ~ 0
ISP
NoConn ~ 8050 2850
Text Label 7150 2000 2    50   ~ 0
EN
Wire Wire Line
	8050 2750 7350 2750
NoConn ~ 6550 1300
NoConn ~ 6550 1400
NoConn ~ 6550 1500
NoConn ~ 6550 1600
NoConn ~ 6550 2100
NoConn ~ 6550 2200
NoConn ~ 6550 2300
NoConn ~ 6550 2400
NoConn ~ 6550 2500
NoConn ~ 6550 2600
NoConn ~ 6550 2700
NoConn ~ 6550 2800
NoConn ~ 6550 3600
NoConn ~ 6550 3700
NoConn ~ 6550 3800
Text Label 3550 1300 0    50   ~ 0
RESET
Text Label 3550 1850 0    50   ~ 0
VDDCORE
Wire Wire Line
	7150 3500 6550 3500
NoConn ~ 6550 3000
Wire Wire Line
	7350 2750 7350 2000
Wire Wire Line
	7350 2000 6550 2000
NoConn ~ 6550 2900
$EndSCHEMATC
