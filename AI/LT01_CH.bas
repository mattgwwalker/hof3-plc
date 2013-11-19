//LT01 - Feed Tank Level

CONST LT01_EUMax = 684.93 //Units %
CONST LT01_EUMin = 0.00 //Units %
CONST LT01_EUMultiplier = 100.0

MEM &SCALE_FACTOR_CH7 = CH07_CalScaleFactor * (LT01_EUMax * LT01_EUMultiplier / CH07_CalScaledMax)
MEM &OFFSET_CH7 = CH07_CalOffset * (LT01_EUMax * LT01_EUMultiplier/ CH07_CalScaledMax)

MEM &CHANNEL7_TEXT = "LT01_%"
MEM &DISPLAY_FORMAT_CH7 = 5

REG &LT01_100 = &CH7
//Volume = (% * 0.645l/%) + 5l
