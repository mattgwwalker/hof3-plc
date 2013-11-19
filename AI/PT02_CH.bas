//PT02 - Filter Inlet Pressure

CONST PT02_EUMax = 5.00 //Units bar
CONST PT02_EUMin = 0.00 //Units bar
CONST PT02_EUMultiplier = 1000.0

MEM &SCALE_FACTOR_CH6 = CH06_CalScaleFactor * (PT02_EUMax * PT02_EUMultiplier / CH06_CalScaledMax)
MEM &OFFSET_CH6 = CH06_CalOffset * (PT02_EUMax * PT02_EUMultiplier/ CH06_CalScaledMax)

MEM &CHANNEL6_TEXT = "PT02_bar"
MEM &DISPLAY_FORMAT_CH6 = 4

REG &PT02_1000 = &CH6
