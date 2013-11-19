//TT01 - Feed Tank Temperature

CONST TT01_EUMax = 100.00 //Units degC
CONST TT01_EUMin = 0.00 //Units degC
CONST TT01_EUMultiplier = 100.0

MEM &SCALE_FACTOR_CH4 = CH04_CalScaleFactor * (TT01_EUMax * TT01_EUMultiplier / CH04_CalScaledMax)
MEM &OFFSET_CH4 = CH04_CalOffset * (TT01_EUMax * TT01_EUMultiplier/ CH04_CalScaledMax)

MEM &CHANNEL4_TEXT = "TT01degC"
MEM &DISPLAY_FORMAT_CH4 = 5

REG &TT01_100 = &CH4
