//FT02 - Permeate Flow

CONST FT02_EUMax = 2000.00 //Units l/hr
CONST FT02_EUMin = 0.00 //Units l/hr
CONST FT02_EUMultiplier = 100.0

MEM &SCALE_FACTOR_CH2 = CH02_CalScaleFactor * (FT02_EUMax * FT02_EUMultiplier / CH02_CalScaledMax)
MEM &OFFSET_CH2 = CH02_CalOffset * (FT02_EUMax * FT02_EUMultiplier/ CH02_CalScaledMax)

MEM &CHANNEL2_TEXT = "FT02_l/h" 
MEM &DISPLAY_FORMAT_CH2 = 5

REG &FT02_100 = &CH2
