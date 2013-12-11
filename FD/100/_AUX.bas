REG &fd100StepNum = &AUX1  
MEM &fd100StepNum = 0
MEM &AUX1_TEXT = "FD100_SN"
MEM &DISPLAY_FORMAT_AUX1 = 0
CONST fd100StepNum_RESET = 0
CONST fd100StepNum_WAITINS = 1
CONST fd100StepNum_PB = 2
CONST fd100StepNum_END = 3
CONST fd100StepNum_FILL = 4
CONST fd100StepNum_MIX = 5
CONST fd100StepNum_RECIRC = 6
CONST fd100StepNum_CONC = 7
CONST fd100StepNum_MT2SITE = 8
CONST fd100StepNum_MT2WASTE = 9
CONST fd100StepNum_DRAIN2WASTE = 10
CONST fd100StepNum_MT2STORE = 11
CONST fd100StepNum_DRAIN2STORE = 12

DIM fd100MsgArray[] = \
["     Reset     ",\
"      Ready     ",\
"               Press the green button to start               ",\
"    Waiting     ",\
"Filling Feedtank",\
"     Mixing     ",\
"  Recirculating ",\
"  Concentrating ",\
"Emptying to site",\
"Pumping to waste",\
"Draining to waste",\
"Pumping to store",\
"Draining to store"]

REG &fd100StepTimeAcc = &AUX2
MEM &fd100StepTimeAcc = 0
MEM &AUX2_TEXT = "FD100_ST"
MEM &DISPLAY_FORMAT_AUX2 = 1

