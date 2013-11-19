//FT01 - Circulating Flow

CONST FT01_EUMax = 6000.00 //Units l/hr
CONST FT01_EUMin = 0.00 //Units l/hr
CONST FT01_EUMultiplier = 100.0

MEM &SCALE_FACTOR_CH1 = CH01_CalScaleFactor * (FT01_EUMax * FT01_EUMultiplier / CH01_CalScaledMax)
MEM &OFFSET_CH1 = CH01_CalOffset * (FT01_EUMax * FT01_EUMultiplier/ CH01_CalScaledMax)

MEM &CHANNEL1_TEXT = "FT01_l/h" 
MEM &DISPLAY_FORMAT_CH1 = 5

REG &FT01_100 = &CH1
