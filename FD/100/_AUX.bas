REG &fd100StepNum = &AUX1  
MEM &fd100StepNum = 0
MEM &AUX1_TEXT = "FD100_SN"
MEM &DISPLAY_FORMAT_AUX1 = 0
CONST fd100StepNum_RESET = 0
CONST fd100StepNum_WAIT_INSTRUCTION = 1
CONST fd100StepNum_WAIT_PUSH_BUTTON = 2
CONST fd100StepNum_END = 3
CONST fd100StepNum_FILL = 4
CONST fd100StepNum_MIX = 5
CONST fd100StepNum_RECIRC = 6
CONST fd100StepNum_BLAST = 7
CONST fd100StepNum_CONC = 8
CONST fd100StepNum_CONC_TILL_EMPTY = 9
CONST fd100StepNum_PUMP_TO_WASTE = 10
CONST fd100StepNum_DRAIN_TO_WASTE = 11
CONST fd100StepNum_PUMP_TO_STORE = 12
CONST fd100StepNum_DRAIN_TO_STORE = 13
CONST fd100StepNum_DRAIN_STORE_TO_WASTE = 14
CONST fd100StepNum_PRE_END = 15

DIM fd100MsgArray[] = \
["     Reset     ",\
"      Ready     ",\
"               Press the green button to start               ",\
"    Waiting     ",\
"Filling feedtank",\
"     Mixing     ",\
"  Recirculating ",\
"  Concentrating ",\
"Emptying to site",\
"Pumping to waste",\
"               Draining to waste               ",\
"               Pumping to storage tank               ",\
"               Draining to storage tank               ",\
"               Draining storage tank to waste               ",\
"               Washing chemical line               "]

REG &fd100StepTimeAcc = &AUX2
MEM &fd100StepTimeAcc = 0
MEM &AUX2_TEXT = "FD100_ST"
MEM &DISPLAY_FORMAT_AUX2 = 1

