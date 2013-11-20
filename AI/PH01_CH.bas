// PH01 - pH Meter

CONST PH01_EUMax = 14.00 // pH
CONST PH01_EUMin = 0.00  // pH
CONST PH01_EUMultiplier = 100.0

MEM &SCALE_FACTOR_CH9 = CH09_CalScaleFactor / CH09_CalScaledMax * (PH01_EUMax - PH01_EUMin) * PH01_EUMultiplier

MEM &OFFSET_CH9 = CH09_CalOffset / CH09_CalScaledMax * (PH01_EUMax - PH01_EUMin) * PH01_EUMultiplier + PH01_EUMin * PH01_EUMultiplier

MEM &CHANNEL9_TEXT = "PH01"
MEM &DISPLAY_FORMAT_CH9 = 5

REG &PH01_100 = &CH9
