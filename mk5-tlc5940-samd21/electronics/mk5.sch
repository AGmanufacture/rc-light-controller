EESchema Schematic File Version 2
LIBS:bat54c
LIBS:power
LIBS:device
LIBS:switches
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:texas
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:diode
LIBS:ESD_Protection
LIBS:mk5-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L TLC5940PWP U4
U 1 1 59C45A36
P 9250 3650
F 0 "U4" H 8750 4525 50  0000 L CNN
F 1 "TLC5940PWP" H 9300 4525 50  0000 L CNN
F 2 "Housings_SSOP_modified:HTSSOP-28_4.4x9.7mm_Pitch0.65mm_ThermalPad_paste" H 9275 2675 50  0001 L CNN
F 3 "" H 8850 4350 50  0001 C CNN
	1    9250 3650
	1    0    0    -1  
$EndComp
$Comp
L USB_OTG J2
U 1 1 59C45BE8
P 1850 5150
F 0 "J2" H 1650 5600 50  0000 L CNN
F 1 "USB" H 1650 5500 50  0000 L CNN
F 2 "USB:Mirco_USB_Type_B_eBay_AliExpress" H 2000 5100 50  0001 C CNN
F 3 "" H 2000 5100 50  0001 C CNN
	1    1850 5150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 59C45D35
P 3750 4250
F 0 "#PWR01" H 3750 4000 50  0001 C CNN
F 1 "GND" H 3750 4100 50  0000 C CNN
F 2 "" H 3750 4250 50  0001 C CNN
F 3 "" H 3750 4250 50  0001 C CNN
	1    3750 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 59C45D7F
P 9250 5000
F 0 "#PWR02" H 9250 4750 50  0001 C CNN
F 1 "GND" H 9250 4850 50  0000 C CNN
F 2 "" H 9250 5000 50  0001 C CNN
F 3 "" H 9250 5000 50  0001 C CNN
	1    9250 5000
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR03
U 1 1 59C45E41
P 9250 2350
F 0 "#PWR03" H 9250 2200 50  0001 C CNN
F 1 "+3V3" H 9250 2490 50  0000 C CNN
F 2 "" H 9250 2350 50  0001 C CNN
F 3 "" H 9250 2350 50  0001 C CNN
	1    9250 2350
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR04
U 1 1 59C45E7A
P 3700 1950
F 0 "#PWR04" H 3700 1800 50  0001 C CNN
F 1 "+3V3" H 3700 2090 50  0000 C CNN
F 2 "" H 3700 1950 50  0001 C CNN
F 3 "" H 3700 1950 50  0001 C CNN
	1    3700 1950
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW1
U 1 1 59C45F57
P 1300 3700
F 0 "SW1" H 1350 3800 50  0000 L CNN
F 1 "BTN" H 1300 3640 50  0000 C CNN
F 2 "" H 1300 3900 50  0001 C CNN
F 3 "" H 1300 3900 50  0001 C CNN
	1    1300 3700
	0    1    1    0   
$EndComp
$Comp
L TEST TP1
U 1 1 59C46169
P 5900 5100
F 0 "TP1" V 5900 5300 50  0000 L BNN
F 1 "SWCLK" V 5950 5300 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5900 5100 50  0001 C CNN
F 3 "" H 5900 5100 50  0001 C CNN
	1    5900 5100
	0    1    1    0   
$EndComp
$Comp
L TEST TP2
U 1 1 59C46225
P 5900 5350
F 0 "TP2" V 5900 5550 50  0000 L BNN
F 1 "SWDIO" V 5950 5550 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5900 5350 50  0001 C CNN
F 3 "" H 5900 5350 50  0001 C CNN
	1    5900 5350
	0    1    1    0   
$EndComp
$Comp
L TEST TP3
U 1 1 59C4652D
P 5900 5600
F 0 "TP3" V 5900 5800 50  0000 L BNN
F 1 "RESET" V 5950 5800 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5900 5600 50  0001 C CNN
F 3 "" H 5900 5600 50  0001 C CNN
	1    5900 5600
	0    1    1    0   
$EndComp
Text Label 6800 3750 2    60   ~ 0
DP
Text Label 6800 3650 2    60   ~ 0
DM
$Comp
L GND #PWR05
U 1 1 59C46A64
P 8550 1550
F 0 "#PWR05" H 8550 1300 50  0001 C CNN
F 1 "GND" H 8550 1400 50  0000 C CNN
F 2 "" H 8550 1550 50  0001 C CNN
F 3 "" H 8550 1550 50  0001 C CNN
	1    8550 1550
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 59C46F6E
P 7750 3300
F 0 "R1" V 7830 3300 50  0000 C CNN
F 1 "2K 1%" V 7650 3300 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7680 3300 50  0001 C CNN
F 3 "" H 7750 3300 50  0001 C CNN
	1    7750 3300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 59C4705C
P 7750 3500
F 0 "#PWR06" H 7750 3250 50  0001 C CNN
F 1 "GND" H 7600 3400 50  0000 C CNN
F 2 "" H 7750 3500 50  0001 C CNN
F 3 "" H 7750 3500 50  0001 C CNN
	1    7750 3500
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 59C47154
P 9500 2450
F 0 "C4" H 9525 2550 50  0000 L CNN
F 1 "100n" H 9525 2350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9538 2300 50  0001 C CNN
F 3 "" H 9500 2450 50  0001 C CNN
	1    9500 2450
	0    1    1    0   
$EndComp
$Comp
L C C3
U 1 1 59C471E5
P 3700 2800
F 0 "C3" H 3725 2900 50  0000 L CNN
F 1 "100n" H 3725 2700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3738 2650 50  0001 C CNN
F 3 "" H 3700 2800 50  0001 C CNN
	1    3700 2800
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR07
U 1 1 59C472D9
P 3700 3050
F 0 "#PWR07" H 3700 2800 50  0001 C CNN
F 1 "GND" H 3700 2900 50  0000 C CNN
F 2 "" H 3700 3050 50  0001 C CNN
F 3 "" H 3700 3050 50  0001 C CNN
	1    3700 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 59C47427
P 9700 2500
F 0 "#PWR08" H 9700 2250 50  0001 C CNN
F 1 "GND" H 9700 2350 50  0000 C CNN
F 2 "" H 9700 2500 50  0001 C CNN
F 3 "" H 9700 2500 50  0001 C CNN
	1    9700 2500
	1    0    0    -1  
$EndComp
$Comp
L MCP1703A-3302_SOT23 U2
U 1 1 59C474C3
P 3850 6600
F 0 "U2" H 4000 6350 50  0000 C CNN
F 1 "MCP1702-3302_SOT23" H 3300 6750 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 3850 6800 50  0001 C CNN
F 3 "" H 3850 6550 50  0001 C CNN
	1    3850 6600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 59C476EE
P 3850 7100
F 0 "#PWR09" H 3850 6850 50  0001 C CNN
F 1 "GND" H 3850 6950 50  0000 C CNN
F 2 "" H 3850 7100 50  0001 C CNN
F 3 "" H 3850 7100 50  0001 C CNN
	1    3850 7100
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR010
U 1 1 59C477CD
P 4350 6500
F 0 "#PWR010" H 4350 6350 50  0001 C CNN
F 1 "+3V3" H 4350 6640 50  0000 C CNN
F 2 "" H 4350 6500 50  0001 C CNN
F 3 "" H 4350 6500 50  0001 C CNN
	1    4350 6500
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 59C4792E
P 3300 6850
F 0 "C1" H 3325 6950 50  0000 L CNN
F 1 "1u/16V" H 3325 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 3338 6700 50  0001 C CNN
F 3 "" H 3300 6850 50  0001 C CNN
	1    3300 6850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 59C47A90
P 4350 7100
F 0 "#PWR011" H 4350 6850 50  0001 C CNN
F 1 "GND" H 4350 6950 50  0000 C CNN
F 2 "" H 4350 7100 50  0001 C CNN
F 3 "" H 4350 7100 50  0001 C CNN
	1    4350 7100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 59C47B21
P 3300 7100
F 0 "#PWR012" H 3300 6850 50  0001 C CNN
F 1 "GND" H 3300 6950 50  0000 C CNN
F 2 "" H 3300 7100 50  0001 C CNN
F 3 "" H 3300 7100 50  0001 C CNN
	1    3300 7100
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J3
U 1 1 59C4821D
P 8550 700
F 0 "J3" H 8550 800 50  0000 C CNN
F 1 "15S" H 8550 600 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 8550 700 50  0001 C CNN
F 3 "" H 8550 700 50  0001 C CNN
	1    8550 700 
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR013
U 1 1 59C49331
P 1850 5650
F 0 "#PWR013" H 1850 5400 50  0001 C CNN
F 1 "GND" H 1850 5500 50  0000 C CNN
F 2 "" H 1850 5650 50  0001 C CNN
F 3 "" H 1850 5650 50  0001 C CNN
	1    1850 5650
	1    0    0    -1  
$EndComp
NoConn ~ 2150 5350
Text Label 3950 5150 2    60   ~ 0
DP
Text Label 3950 5250 2    60   ~ 0
DM
$Comp
L PWR_FLAG #FLG014
U 1 1 59C4A3FC
P 2300 4800
F 0 "#FLG014" H 2300 4875 50  0001 C CNN
F 1 "PWR_FLAG" H 2300 4950 50  0000 C CNN
F 2 "" H 2300 4800 50  0001 C CNN
F 3 "" H 2300 4800 50  0001 C CNN
	1    2300 4800
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG015
U 1 1 59C4A5F6
P 1850 2100
F 0 "#FLG015" H 1850 2175 50  0001 C CNN
F 1 "PWR_FLAG" H 1850 2250 50  0000 C CNN
F 2 "" H 1850 2100 50  0001 C CNN
F 3 "" H 1850 2100 50  0001 C CNN
	1    1850 2100
	1    0    0    -1  
$EndComp
NoConn ~ 8550 3850
NoConn ~ 8550 4450
$Comp
L Conn_01x01 J7
U 1 1 59C4AFD0
P 10550 2950
F 0 "J7" H 10700 2950 50  0000 C CNN
F 1 "0" H 10850 2950 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 2950 50  0001 C CNN
F 3 "" H 10550 2950 50  0001 C CNN
	1    10550 2950
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J8
U 1 1 59C4B114
P 10550 3050
F 0 "J8" H 10700 3050 50  0000 C CNN
F 1 "1" H 10850 3050 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3050 50  0001 C CNN
F 3 "" H 10550 3050 50  0001 C CNN
	1    10550 3050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J9
U 1 1 59C4B188
P 10550 3150
F 0 "J9" H 10700 3150 50  0000 C CNN
F 1 "2" H 10850 3150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3150 50  0001 C CNN
F 3 "" H 10550 3150 50  0001 C CNN
	1    10550 3150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J10
U 1 1 59C4B238
P 10550 3250
F 0 "J10" H 10700 3250 50  0000 C CNN
F 1 "3" H 10850 3250 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3250 50  0001 C CNN
F 3 "" H 10550 3250 50  0001 C CNN
	1    10550 3250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J11
U 1 1 59C4B296
P 10550 3350
F 0 "J11" H 10700 3350 50  0000 C CNN
F 1 "4" H 10850 3350 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3350 50  0001 C CNN
F 3 "" H 10550 3350 50  0001 C CNN
	1    10550 3350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J12
U 1 1 59C4B2F7
P 10550 3450
F 0 "J12" H 10700 3450 50  0000 C CNN
F 1 "5" H 10850 3450 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3450 50  0001 C CNN
F 3 "" H 10550 3450 50  0001 C CNN
	1    10550 3450
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J13
U 1 1 59C4B35F
P 10550 3550
F 0 "J13" H 10700 3550 50  0000 C CNN
F 1 "6" H 10850 3550 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3550 50  0001 C CNN
F 3 "" H 10550 3550 50  0001 C CNN
	1    10550 3550
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J14
U 1 1 59C4B3C6
P 10550 3650
F 0 "J14" H 10700 3650 50  0000 C CNN
F 1 "7" H 10850 3650 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3650 50  0001 C CNN
F 3 "" H 10550 3650 50  0001 C CNN
	1    10550 3650
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J15
U 1 1 59C4B44E
P 10550 3750
F 0 "J15" H 10700 3750 50  0000 C CNN
F 1 "8" H 10850 3750 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3750 50  0001 C CNN
F 3 "" H 10550 3750 50  0001 C CNN
	1    10550 3750
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J16
U 1 1 59C4B4BB
P 10550 3850
F 0 "J16" H 10700 3850 50  0000 C CNN
F 1 "9" H 10850 3850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3850 50  0001 C CNN
F 3 "" H 10550 3850 50  0001 C CNN
	1    10550 3850
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J17
U 1 1 59C4B52B
P 10550 3950
F 0 "J17" H 10700 3950 50  0000 C CNN
F 1 "10" H 10850 3950 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3950 50  0001 C CNN
F 3 "" H 10550 3950 50  0001 C CNN
	1    10550 3950
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J18
U 1 1 59C4B5A2
P 10550 4050
F 0 "J18" H 10700 4050 50  0000 C CNN
F 1 "11" H 10850 4050 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4050 50  0001 C CNN
F 3 "" H 10550 4050 50  0001 C CNN
	1    10550 4050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J19
U 1 1 59C4B6C2
P 10550 4150
F 0 "J19" H 10700 4150 50  0000 C CNN
F 1 "12" H 10850 4150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4150 50  0001 C CNN
F 3 "" H 10550 4150 50  0001 C CNN
	1    10550 4150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J20
U 1 1 59C4B73B
P 10550 4250
F 0 "J20" H 10700 4250 50  0000 C CNN
F 1 "13" H 10850 4250 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4250 50  0001 C CNN
F 3 "" H 10550 4250 50  0001 C CNN
	1    10550 4250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J21
U 1 1 59C4B7B7
P 10550 4350
F 0 "J21" H 10700 4350 50  0000 C CNN
F 1 "14" H 10850 4350 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4350 50  0001 C CNN
F 3 "" H 10550 4350 50  0001 C CNN
	1    10550 4350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J22
U 1 1 59C4B836
P 10550 4450
F 0 "J22" H 10700 4450 50  0000 C CNN
F 1 "15" H 10850 4450 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4450 50  0001 C CNN
F 3 "" H 10550 4450 50  0001 C CNN
	1    10550 4450
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG016
U 1 1 59C4CC7B
P 2900 6450
F 0 "#FLG016" H 2900 6525 50  0001 C CNN
F 1 "PWR_FLAG" H 2900 6600 50  0000 C CNN
F 2 "" H 2900 6450 50  0001 C CNN
F 3 "" H 2900 6450 50  0001 C CNN
	1    2900 6450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 59C4DC2B
P 1600 2250
F 0 "#PWR017" H 1600 2000 50  0001 C CNN
F 1 "GND" H 1600 2100 50  0000 C CNN
F 2 "" H 1600 2250 50  0001 C CNN
F 3 "" H 1600 2250 50  0001 C CNN
	1    1600 2250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR018
U 1 1 59C4DE54
P 1850 1100
F 0 "#PWR018" H 1850 950 50  0001 C CNN
F 1 "VCC" H 1850 1250 50  0000 C CNN
F 2 "" H 1850 1100 50  0001 C CNN
F 3 "" H 1850 1100 50  0001 C CNN
	1    1850 1100
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR019
U 1 1 59C4E307
P 1450 6650
F 0 "#PWR019" H 1450 6500 50  0001 C CNN
F 1 "VCC" H 1450 6800 50  0000 C CNN
F 2 "" H 1450 6650 50  0001 C CNN
F 3 "" H 1450 6650 50  0001 C CNN
	1    1450 6650
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 59C50F45
P 2450 1550
F 0 "R2" V 2350 1550 50  0000 C CNN
F 1 "680" V 2450 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2380 1550 50  0001 C CNN
F 3 "" H 2450 1550 50  0001 C CNN
	1    2450 1550
	0    1    1    0   
$EndComp
$Comp
L R R5
U 1 1 59C512D3
P 2450 1650
F 0 "R5" V 2350 1650 50  0000 C CNN
F 1 "680" V 2450 1650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2380 1650 50  0001 C CNN
F 3 "" H 2450 1650 50  0001 C CNN
	1    2450 1650
	0    -1   -1   0   
$EndComp
Text Label 6800 3050 2    60   ~ 0
ST
Text Label 6800 3450 2    60   ~ 0
OUT/Tx
Text Label 2900 1550 2    60   ~ 0
Rx
Text Label 2900 1650 2    60   ~ 0
OUT/Tx
$Comp
L PWR_FLAG #FLG020
U 1 1 59C5625A
P 2250 1100
F 0 "#FLG020" H 2250 1175 50  0001 C CNN
F 1 "PWR_FLAG" H 2250 1250 50  0000 C CNN
F 2 "" H 2250 1100 50  0001 C CNN
F 3 "" H 2250 1100 50  0001 C CNN
	1    2250 1100
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J6
U 1 1 59C4B6A6
P 9450 5850
F 0 "J6" H 9450 5950 50  0000 C CNN
F 1 "+LED" H 9600 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9450 5850 50  0001 C CNN
F 3 "" H 9450 5850 50  0001 C CNN
	1    9450 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J23
U 1 1 59C4B79E
P 9650 5850
F 0 "J23" H 9650 5950 50  0000 C CNN
F 1 "+LED" H 9800 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9650 5850 50  0001 C CNN
F 3 "" H 9650 5850 50  0001 C CNN
	1    9650 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J24
U 1 1 59C4BD3B
P 9850 5850
F 0 "J24" H 9850 5950 50  0000 C CNN
F 1 "+LED" H 10000 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9850 5850 50  0001 C CNN
F 3 "" H 9850 5850 50  0001 C CNN
	1    9850 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J25
U 1 1 59C4BDD3
P 10050 5850
F 0 "J25" H 10050 5950 50  0000 C CNN
F 1 "+LED" H 10200 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10050 5850 50  0001 C CNN
F 3 "" H 10050 5850 50  0001 C CNN
	1    10050 5850
	0    -1   -1   0   
$EndComp
$Comp
L VCC #PWR021
U 1 1 59C4C32D
P 8850 5950
F 0 "#PWR021" H 8850 5800 50  0001 C CNN
F 1 "VCC" H 8850 6100 50  0000 C CNN
F 2 "" H 8850 5950 50  0001 C CNN
F 3 "" H 8850 5950 50  0001 C CNN
	1    8850 5950
	1    0    0    -1  
$EndComp
$Comp
L Q_NMOS_GSD Q1
U 1 1 59C4D834
P 8450 1250
F 0 "Q1" H 8650 1300 50  0000 L CNN
F 1 "MOSFET 20V 3A" H 8650 1200 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 8650 1350 50  0001 C CNN
F 3 "" H 8450 1250 50  0001 C CNN
	1    8450 1250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J26
U 1 1 59DB376D
P 10250 5850
F 0 "J26" H 10250 5950 50  0000 C CNN
F 1 "+LED" H 10400 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10250 5850 50  0001 C CNN
F 3 "" H 10250 5850 50  0001 C CNN
	1    10250 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J27
U 1 1 59DB380B
P 10450 5850
F 0 "J27" H 10450 5950 50  0000 C CNN
F 1 "+LED" H 10600 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10450 5850 50  0001 C CNN
F 3 "" H 10450 5850 50  0001 C CNN
	1    10450 5850
	0    -1   -1   0   
$EndComp
$Comp
L TEST TP4
U 1 1 59DB5CFC
P 5900 5850
F 0 "TP4" V 5900 6050 50  0000 L BNN
F 1 "GND" V 5950 6050 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 5900 5850 50  0001 C CNN
F 3 "" H 5900 5850 50  0001 C CNN
	1    5900 5850
	0    1    1    0   
$EndComp
$Comp
L GND #PWR022
U 1 1 59DB5EB3
P 5900 5950
F 0 "#PWR022" H 5900 5700 50  0001 C CNN
F 1 "GND" H 5900 5800 50  0000 C CNN
F 2 "" H 5900 5950 50  0001 C CNN
F 3 "" H 5900 5950 50  0001 C CNN
	1    5900 5950
	1    0    0    -1  
$EndComp
$Comp
L LED_ALT D3
U 1 1 59DC7006
P 8050 1800
F 0 "D3" H 8050 1900 50  0000 C CNN
F 1 "LED" H 8050 1700 50  0000 C CNN
F 2 "LEDs:LED_0603" H 8050 1800 50  0001 C CNN
F 3 "" H 8050 1800 50  0001 C CNN
	1    8050 1800
	0    -1   -1   0   
$EndComp
$Comp
L R R6
U 1 1 59DC70B5
P 8050 1450
F 0 "R6" V 8130 1450 50  0000 C CNN
F 1 "1k2" V 8050 1450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7980 1450 50  0001 C CNN
F 3 "" H 8050 1450 50  0001 C CNN
	1    8050 1450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR023
U 1 1 59DC74AB
P 8050 2000
F 0 "#PWR023" H 8050 1750 50  0001 C CNN
F 1 "GND" H 8050 1850 50  0000 C CNN
F 2 "" H 8050 2000 50  0001 C CNN
F 3 "" H 8050 2000 50  0001 C CNN
	1    8050 2000
	1    0    0    -1  
$EndComp
Text Label 6800 2250 2    60   ~ 0
XLAT
Text Label 6800 1950 2    60   ~ 0
OUT15
$Comp
L GS2 J4
U 1 1 59DCA798
P 1900 6600
F 0 "J4" H 2000 6750 50  0000 C CNN
F 1 "GS2" H 2000 6451 50  0000 C CNN
F 2 "SMD-pads:SMD_solder_jumper_2pin" V 1974 6600 50  0001 C CNN
F 3 "" H 1900 6600 50  0001 C CNN
	1    1900 6600
	-1   0    0    1   
$EndComp
Text Label 8150 3250 0    60   ~ 0
GSCLK
Text Label 6800 2350 2    60   ~ 0
BLANK
Text Label 6800 3350 2    60   ~ 0
TH
Text Label 6800 2550 2    60   ~ 0
GSCLK
Text Label 6800 4050 2    60   ~ 0
SWCLK
Text Label 6800 4150 2    60   ~ 0
SWDIO
Text Label 5450 5100 0    60   ~ 0
SWCLK
Text Label 5450 5350 0    60   ~ 0
SWDIO
Text Label 5450 5600 0    60   ~ 0
RESET
Text Label 3400 1650 0    60   ~ 0
RESET
Text Label 6800 3150 2    60   ~ 0
CH3
$Comp
L GND #PWR024
U 1 1 5A0ED963
P 1300 4000
F 0 "#PWR024" H 1300 3750 50  0001 C CNN
F 1 "GND" H 1300 3850 50  0000 C CNN
F 2 "" H 1300 4000 50  0001 C CNN
F 3 "" H 1300 4000 50  0001 C CNN
	1    1300 4000
	1    0    0    -1  
$EndComp
Text Label 3100 3200 2    60   ~ 0
Button
Text Label 8150 3450 0    60   ~ 0
BLANK
Text Label 8150 3550 0    60   ~ 0
XLAT
Text Label 8150 4250 0    60   ~ 0
SCLK
Text Label 8150 4350 0    60   ~ 0
SIN
Text Label 7650 1250 0    60   ~ 0
OUT15
$Comp
L Conn_01x06_Male J1
U 1 1 5A0F5BA3
P 1200 1650
F 0 "J1" H 1200 1950 50  0000 C CNN
F 1 "IN/OUT" H 1200 1250 50  0000 C CNN
F 2 "SMD-pads:CONN_6_SMD_FLAT" H 1200 1650 50  0001 C CNN
F 3 "" H 1200 1650 50  0001 C CNN
	1    1200 1650
	1    0    0    1   
$EndComp
Text Label 6800 2150 2    60   ~ 0
SCLK
Text Label 6800 2050 2    60   ~ 0
SIN
Text Label 6800 2750 2    60   ~ 0
BUTTON
Text Label 2300 5800 1    60   ~ 0
VUSB
Text Label 3000 6600 0    60   ~ 0
V_IN
Text Label 7850 3050 0    60   ~ 0
IREF
$Comp
L BAT54C D1
U 1 1 5A105797
P 2300 6600
F 0 "D1" H 2325 6450 50  0000 L CNN
F 1 "BAT54C" H 2050 6725 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 2375 6725 50  0001 L CNN
F 3 "" H 2170 6600 50  0001 C CNN
	1    2300 6600
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR025
U 1 1 5A111798
P 2300 3400
F 0 "#PWR025" H 2300 3150 50  0001 C CNN
F 1 "GND" H 2300 3250 50  0000 C CNN
F 2 "" H 2300 3400 50  0001 C CNN
F 3 "" H 2300 3400 50  0001 C CNN
	1    2300 3400
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR026
U 1 1 5A111DE2
P 2300 3000
F 0 "#PWR026" H 2300 2850 50  0001 C CNN
F 1 "+3V3" H 2300 3140 50  0000 C CNN
F 2 "" H 2300 3000 50  0001 C CNN
F 3 "" H 2300 3000 50  0001 C CNN
	1    2300 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 4050 3750 4250
Wire Wire Line
	9250 2350 9250 2650
Wire Wire Line
	6350 2150 6800 2150
Wire Wire Line
	8150 3250 8550 3250
Wire Wire Line
	1300 3200 1300 3500
Wire Wire Line
	8150 3550 8550 3550
Wire Wire Line
	6800 2250 6350 2250
Wire Wire Line
	8150 3450 8550 3450
Wire Wire Line
	6350 3650 6800 3650
Wire Wire Line
	6350 3750 6800 3750
Wire Wire Line
	8550 1450 8550 1550
Wire Wire Line
	8550 900  8550 1050
Wire Wire Line
	8450 2450 9350 2450
Wire Wire Line
	8450 2450 8450 3150
Wire Wire Line
	8450 2950 8550 2950
Connection ~ 9250 2450
Wire Wire Line
	8450 3150 8550 3150
Connection ~ 8450 2950
Wire Wire Line
	7750 3050 8550 3050
Wire Wire Line
	7750 3450 7750 3500
Wire Wire Line
	9650 2450 9700 2450
Wire Wire Line
	9700 2450 9700 2500
Wire Wire Line
	3850 6900 3850 7100
Wire Wire Line
	3300 6600 3300 6700
Wire Wire Line
	4150 6600 4350 6600
Wire Wire Line
	4350 6500 4350 6700
Connection ~ 4350 6600
Wire Wire Line
	4350 7000 4350 7100
Wire Wire Line
	3300 7000 3300 7100
Connection ~ 3300 6600
Connection ~ 2900 6600
Wire Wire Line
	2300 4800 2300 6300
Wire Wire Line
	2150 5150 3950 5150
Wire Wire Line
	2150 5250 3950 5250
Wire Wire Line
	1850 5550 1850 5650
Wire Wire Line
	1750 5550 1750 5650
Connection ~ 2300 5950
Wire Wire Line
	9950 4450 10350 4450
Wire Wire Line
	9950 4350 10350 4350
Wire Wire Line
	9950 4250 10350 4250
Wire Wire Line
	9950 4150 10350 4150
Wire Wire Line
	9950 4050 10350 4050
Wire Wire Line
	9950 3950 10350 3950
Wire Wire Line
	9950 3850 10350 3850
Wire Wire Line
	9950 3750 10350 3750
Wire Wire Line
	9950 3650 10350 3650
Wire Wire Line
	9950 3550 10350 3550
Wire Wire Line
	9950 3450 10350 3450
Wire Wire Line
	9950 3350 10350 3350
Wire Wire Line
	9950 3250 10350 3250
Wire Wire Line
	9950 3150 10350 3150
Wire Wire Line
	9950 2950 10350 2950
Wire Wire Line
	9950 3050 10350 3050
Wire Wire Line
	1400 1850 1600 1850
Wire Wire Line
	1600 1350 1600 2250
Wire Wire Line
	1450 6650 1450 7000
Wire Wire Line
	1850 1100 1850 1750
Wire Wire Line
	7650 1250 8250 1250
Wire Wire Line
	1400 1650 2300 1650
Wire Wire Line
	1400 1550 2300 1550
Wire Wire Line
	2900 1650 2600 1650
Wire Wire Line
	2600 1550 2900 1550
Wire Wire Line
	2250 1450 2250 1100
Wire Wire Line
	1400 1450 2250 1450
Connection ~ 1850 1450
Wire Wire Line
	8850 5950 8850 6250
Wire Wire Line
	8850 6250 10450 6250
Wire Wire Line
	9450 6250 9450 6050
Wire Wire Line
	9650 6250 9650 6050
Connection ~ 9450 6250
Wire Wire Line
	9850 6250 9850 6050
Connection ~ 9650 6250
Wire Wire Line
	10050 6250 10050 6050
Connection ~ 9850 6250
Wire Wire Line
	10250 6250 10250 6050
Connection ~ 10050 6250
Wire Wire Line
	10450 6250 10450 6050
Connection ~ 10250 6250
Wire Wire Line
	5900 5850 5900 5950
Wire Wire Line
	1400 1350 1600 1350
Connection ~ 1600 1850
Wire Wire Line
	1850 1750 1400 1750
Wire Wire Line
	8050 1600 8050 1650
Wire Wire Line
	8050 1950 8050 2000
Wire Wire Line
	1850 2100 1850 2150
Wire Wire Line
	1850 2150 1600 2150
Connection ~ 1600 2150
Wire Wire Line
	9250 4750 9250 5000
Wire Wire Line
	9150 4750 9150 4900
Wire Wire Line
	9150 4900 9250 4900
Connection ~ 9250 4900
Wire Wire Line
	6800 2050 6350 2050
Wire Wire Line
	6350 4050 6800 4050
Wire Wire Line
	6350 4150 6800 4150
Wire Wire Line
	3850 1650 3400 1650
Wire Wire Line
	6800 2350 6350 2350
Wire Wire Line
	1300 3900 1300 4000
Wire Wire Line
	8550 4250 8150 4250
Wire Wire Line
	8550 4350 8150 4350
Wire Wire Line
	7750 3050 7750 3150
Wire Wire Line
	5900 5100 5450 5100
Wire Wire Line
	5900 5350 5450 5350
Wire Wire Line
	5900 5600 5450 5600
Wire Wire Line
	8050 1300 8050 1250
Connection ~ 8050 1250
Wire Wire Line
	1450 7000 2300 7000
Wire Wire Line
	2300 7000 2300 6900
Wire Wire Line
	2500 6600 3550 6600
Wire Wire Line
	2900 6450 2900 6600
Wire Notes Line
	1000 3050 1000 4300
Wire Notes Line
	1000 4300 1600 4300
Wire Notes Line
	1600 4300 1600 3050
Wire Notes Line
	1600 3050 1000 3050
Wire Wire Line
	2200 3300 2300 3300
Wire Wire Line
	2300 3300 2300 3400
Wire Wire Line
	2200 3100 2300 3100
Wire Wire Line
	2300 3100 2300 3000
Wire Wire Line
	2200 3200 3100 3200
Wire Wire Line
	1300 3200 2000 3200
Text Notes 1050 3150 0    30   ~ 0
External push button
$Comp
L Conn_01x01 J28
U 1 1 5A114975
P 2000 3200
F 0 "J28" H 2000 3000 50  0000 C CNN
F 1 "Button" H 2150 3200 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 2000 3200 50  0001 C CNN
F 3 "" H 2000 3200 50  0001 C CNN
	1    2000 3200
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x01 J5
U 1 1 5A114E6C
P 2000 3100
F 0 "J5" H 1800 3250 50  0000 C CNN
F 1 "+3V3" H 2150 3100 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 2000 3100 50  0001 C CNN
F 3 "" H 2000 3100 50  0001 C CNN
	1    2000 3100
	-1   0    0    1   
$EndComp
$Comp
L Conn_01x01 J29
U 1 1 5A114F10
P 2000 3300
F 0 "J29" H 2000 3400 50  0000 C CNN
F 1 "GND" H 2150 3300 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 2000 3300 50  0001 C CNN
F 3 "" H 2000 3300 50  0001 C CNN
	1    2000 3300
	-1   0    0    1   
$EndComp
$Comp
L CP C2
U 1 1 5A1150A8
P 4350 6850
F 0 "C2" H 4375 6950 50  0000 L CNN
F 1 "67u/6.3V Polymer 0805" H 4375 6750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 4388 6700 50  0001 C CNN
F 3 "" H 4350 6850 50  0001 C CNN
	1    4350 6850
	1    0    0    -1  
$EndComp
Text Notes 8800 800  0    60   ~ 0
High-power switched\nlight output
Wire Wire Line
	1900 6800 1900 7000
Connection ~ 1900 7000
Wire Wire Line
	1900 6400 1900 6200
Wire Wire Line
	1900 6200 2300 6200
Connection ~ 2300 6200
Text Notes 1600 7650 0    60   ~ 0
Solder jumper to\npower LEDs from USB\nWARNING: do not connect\nUSB and another power \nsupply (ESC, Receiver) \nat the same time!
$Comp
L TEST TP6
U 1 1 5A12668E
P 7100 5350
F 0 "TP6" V 7100 5650 50  0000 C BNN
F 1 "SIN" V 7150 5650 50  0000 C CNN
F 2 "SMD-pads:Measurement_Point_Round-SMD-Pad_0_6mm" H 7100 5350 50  0001 C CNN
F 3 "" H 7100 5350 50  0001 C CNN
	1    7100 5350
	0    1    1    0   
$EndComp
$Comp
L TEST TP7
U 1 1 5A1272F3
P 7100 5600
F 0 "TP7" V 7100 5900 50  0000 C BNN
F 1 "XLAT" V 7150 5900 50  0000 C CNN
F 2 "SMD-pads:Measurement_Point_Round-SMD-Pad_0_6mm" H 7100 5600 50  0001 C CNN
F 3 "" H 7100 5600 50  0001 C CNN
	1    7100 5600
	0    1    1    0   
$EndComp
$Comp
L TEST TP8
U 1 1 5A1273A0
P 7100 5850
F 0 "TP8" V 7100 6150 50  0000 C BNN
F 1 "BLANK" V 7150 6150 50  0000 C CNN
F 2 "SMD-pads:Measurement_Point_Round-SMD-Pad_0_6mm" H 7100 5850 50  0001 C CNN
F 3 "" H 7100 5850 50  0001 C CNN
	1    7100 5850
	0    1    1    0   
$EndComp
$Comp
L TEST TP9
U 1 1 5A127450
P 7100 6100
F 0 "TP9" V 7100 6400 50  0000 C BNN
F 1 "GSCLK" V 7150 6400 50  0000 C CNN
F 2 "SMD-pads:Measurement_Point_Round-SMD-Pad_0_6mm" H 7100 6100 50  0001 C CNN
F 3 "" H 7100 6100 50  0001 C CNN
	1    7100 6100
	0    1    1    0   
$EndComp
$Comp
L TEST TP5
U 1 1 5A12767F
P 7100 5100
F 0 "TP5" V 7100 5400 50  0000 C BNN
F 1 "SCK" V 7150 5400 50  0000 C CNN
F 2 "SMD-pads:Measurement_Point_Round-SMD-Pad_0_6mm" H 7100 5100 50  0001 C CNN
F 3 "" H 7100 5100 50  0001 C CNN
	1    7100 5100
	0    1    1    0   
$EndComp
Wire Wire Line
	7100 5100 6750 5100
Wire Wire Line
	7100 5350 6750 5350
Wire Wire Line
	7100 5600 6750 5600
Wire Wire Line
	7100 5850 6750 5850
Wire Wire Line
	7100 6100 6750 6100
Text Label 6750 5100 0    60   ~ 0
SCLK
Text Label 6750 5350 0    60   ~ 0
SIN
Text Label 6750 5600 0    60   ~ 0
XLAT
Text Label 6750 5850 0    60   ~ 0
BLANK
Text Label 6750 6100 0    60   ~ 0
GSCLK
$Comp
L SAMD20E15A-MU U3
U 1 1 5A2E1938
P 5100 2900
F 0 "U3" H 4050 4300 50  0000 C CNN
F 1 "SAMD21E15A-MU" H 5950 1500 50  0000 C CNN
F 2 "Housings_DFN_QFN:QFN-32-1EP_5x5mm_Pitch0.5mm" H 5100 1900 50  0001 C CIN
F 3 "" H 5100 2900 50  0001 C CNN
	1    5100 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 1950 3700 2650
Wire Wire Line
	3700 2050 3850 2050
Wire Wire Line
	3850 2550 3700 2550
Connection ~ 3700 2550
Wire Wire Line
	3850 4150 3750 4150
Wire Wire Line
	3850 4050 3750 4050
Connection ~ 3750 4150
Wire Wire Line
	6350 3550 6800 3550
Text Label 6800 3550 2    60   ~ 0
Rx
Connection ~ 3700 2050
Wire Wire Line
	3700 2950 3700 3050
Wire Wire Line
	6350 3050 6800 3050
Wire Wire Line
	6350 3150 6800 3150
Wire Wire Line
	6350 3350 6800 3350
NoConn ~ 6350 1650
NoConn ~ 6350 1750
NoConn ~ 6350 2850
NoConn ~ 6350 3850
NoConn ~ 6350 3950
NoConn ~ 6800 3150
NoConn ~ 6350 3250
NoConn ~ 6800 3350
$Comp
L PRTR5V0U2X D2
U 1 1 5A2E4F71
P 3050 5650
F 0 "D2" H 3050 5900 50  0000 C CNN
F 1 "PRTR5V0U2X" H 3050 5400 50  0000 C CNN
F 2 "SOT143B:SOT143B" H 3100 5600 50  0001 C CNN
F 3 "" H 3100 5600 50  0001 C CNN
	1    3050 5650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2300 5950 2950 5950
Wire Wire Line
	2150 4950 2300 4950
Connection ~ 2300 4950
NoConn ~ 1750 5650
$Comp
L GND #PWR027
U 1 1 5A2E6905
P 3150 6050
F 0 "#PWR027" H 3150 5800 50  0001 C CNN
F 1 "GND" H 3150 5900 50  0000 C CNN
F 2 "" H 3150 6050 50  0001 C CNN
F 3 "" H 3150 6050 50  0001 C CNN
	1    3150 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 5950 3150 6050
Wire Wire Line
	6350 1950 6800 1950
NoConn ~ 6350 1850
Wire Wire Line
	2950 5350 2950 5150
Connection ~ 2950 5150
Wire Wire Line
	3150 5350 3150 5250
Connection ~ 3150 5250
$Comp
L C C5
U 1 1 5A2F6947
P 3300 2350
F 0 "C5" H 3325 2450 50  0000 L CNN
F 1 "1u" H 3325 2250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3338 2200 50  0001 C CNN
F 3 "" H 3300 2350 50  0001 C CNN
	1    3300 2350
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR028
U 1 1 5A2F6A32
P 3300 2600
F 0 "#PWR028" H 3300 2350 50  0001 C CNN
F 1 "GND" H 3300 2450 50  0000 C CNN
F 2 "" H 3300 2600 50  0001 C CNN
F 3 "" H 3300 2600 50  0001 C CNN
	1    3300 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 2500 3300 2600
Wire Wire Line
	3300 2200 3850 2200
Text Label 3300 2200 0    60   ~ 0
VCORE
Wire Wire Line
	6350 2750 6800 2750
NoConn ~ 6350 2450
NoConn ~ 6350 2950
NoConn ~ 6350 2650
Wire Wire Line
	6350 2550 6800 2550
Wire Wire Line
	6350 3450 6800 3450
NoConn ~ 6800 3050
$EndSCHEMATC