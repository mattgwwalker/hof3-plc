//PT01 - Filter Inlet Pressure

CONST PT01_EUMax = 5.00 //Units bar
CONST PT01_EUMin = 0.00 //Units bar
CONST PT01_EUMultiplier = 1000.0

MEM &SCALE_FACTOR_CH5 = CH05_CalScaleFactor * (PT01_EUMax * PT01_EUMultiplier / CH05_CalScaledMax)
MEM &OFFSET_CH5 = CH05_CalOffset * (PT01_EUMax * PT01_EUMultiplier/ CH05_CalScaledMax)

MEM &CHANNEL5_TEXT = "PT01_bar"
MEM &DISPLAY_FORMAT_CH5 = 4

REG &PT01_1000 = &CH5
