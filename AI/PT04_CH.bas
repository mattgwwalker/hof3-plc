//PT04 - Filter Inlet Pressure

CONST PT04_EUMax = 6.00 //Units bar
CONST PT04_EUMin = 0.00 //Units bar
CONST PT04_EUMultiplier = 1000.0

MEM &SCALE_FACTOR_CH8 = CH08_CalScaleFactor * (PT04_EUMax * PT04_EUMultiplier / CH08_CalScaledMax)
MEM &OFFSET_CH8 = CH08_CalOffset * (PT04_EUMax * PT04_EUMultiplier/ CH08_CalScaledMax)

MEM &CHANNEL8_TEXT = "PT04_bar"
MEM &DISPLAY_FORMAT_CH8 = 4

REG &PT04_1000 = &CH8
