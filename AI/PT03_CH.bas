//PT03 - Filter Inlet Pressure

CONST PT03_EUMax = 5.00 //Units bar
CONST PT03_EUMin = 0.00 //Units bar
CONST PT03_EUMultiplier = 1000.0

MEM &SCALE_FACTOR_CH10 = CH10_CalScaleFactor * (PT03_EUMax * PT03_EUMultiplier / CH10_CalScaledMax)
MEM &OFFSET_CH10 = CH10_CalOffset * (PT03_EUMax * PT03_EUMultiplier/ CH10_CalScaledMax)

MEM &CHANNEL10_TEXT = "PT03_bar"
MEM &DISPLAY_FORMAT_CH10 = 4

REG &PT03_1000 = &CH10
