//FT03 - Retentate Flow

CONST FT03_EUMax = 120.00 //Units l/hr
CONST FT03_EUMin = 0.00 //Units l/hr
CONST FT03_EUMultiplier = 100.0

MEM &SCALE_FACTOR_CH3 = CH03_CalScaleFactor * (FT03_EUMax * FT03_EUMultiplier / CH03_CalScaledMax)
MEM &OFFSET_CH3 = CH03_CalOffset * (FT03_EUMax * FT03_EUMultiplier/ CH03_CalScaledMax)

MEM &CHANNEL3_TEXT = "FT03_l/h" 
MEM &DISPLAY_FORMAT_CH3 = 5

REG &FT03_100 = &CH3
