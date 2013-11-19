REG &fd101StepNum = &AUX3  
MEM &fd101StepNum = 0
MEM &AUX3_TEXT = "FD101_SN"
MEM &DISPLAY_FORMAT_AUX3 = 0
CONST fd101StepNum_RESET = 0
CONST fd101StepNum_BYPASS = 1
CONST fd101StepNum_RECIRC_TOP = 2
CONST fd101StepNum_RECIRC_TO_BOTTOM = 3
CONST fd101StepNum_RECIRC_BOTTOM = 4
CONST fd101StepNum_RECIRC_TO_TOP = 5
CONST fd101StepNum_RECIRC_BW_TOP = 6
CONST fd101StepNum_RECIRC_BW_BOTTOM = 7
CONST fd101StepNum_DRAIN_TOP = 8
CONST fd101StepNum_DRAIN_BOTTOM = 9

DIM fd101MsgArray[] = \
["Reset",\
"Default Route - Flow Through Bypass",\
"Recirc - Flow From Top",\
"Recirc - Flow To Bottom",\
"Recirc - Flow From Botton",\
"Recirc - Flow To Top",\
"Recirc - BW From Top",\
"Recirc - BW From Bottom",\
 ""\
]

REG &fd101StepTimeAcc = &AUX4
MEM &fd101StepTimeAcc = 0
MEM &AUX4_TEXT = "FD101_ST"
MEM &DISPLAY_FORMAT_AUX4 = 1

