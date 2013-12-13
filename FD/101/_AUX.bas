REG &fd101StepNum = &AUX3  
MEM &AUX3_TEXT = "FD101_SN"
MEM &DISPLAY_FORMAT_AUX3 = 0

CONST fd101StepNum_RESET = 0
CONST fd101StepNum_BYPASS = 1
CONST fd101StepNum_RECIRC_TOP_SPEED_RAMP = 2
CONST fd101StepNum_RECIRC_TOP = 3
CONST fd101StepNum_RECIRC_TO_BOTTOM = 4
CONST fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP = 5 
CONST fd101StepNum_RECIRC_BOTTOM = 6
CONST fd101StepNum_RECIRC_TO_TOP = 7

CONST fd101StepNum_RECIRC_BW_TOP = 10
CONST fd101StepNum_RECIRC_BW_TOP_RETRACT = 11
CONST fd101StepNum_RECIRC_BW_BOTTOM = 12
CONST fd101StepNum_RECIRC_BW_BOTTOM_RETRACT = 13

CONST fd101StepNum_DRAIN_TOP = 20
CONST fd101StepNum_DRAIN_BOTTOM = 21

MEM &fd101StepNum = fd101StepNum_RESET


DIM fd101MsgArray[] = \
["Reset",\
"Default Route - Flowing through bypass only",\
"Recirc - Flow from top of membrane",\
"Recirc - Flow changing to be from bottom of membrane",\
"Recirc - Flow from botton of membrane",\
"Recirc - Flow changing to be from top of membrane",\
"Recirc - Backwashing with flow from the top of the membrane",\
"Recirc - Retracting backwash piston with flow from the top of the membrane",\
"Recirc - Backwashing with flow from the bottom of the membrane",\
"Recirc - Retracting backwash piston with flow from the bottom of the membrane",\
"Drain - Draining with flow from the top of the membrane",\
"Drain - Draining with flow from the bottom of the membrane"\
]

REG &fd101StepTimeAcc = &AUX4
MEM &fd101StepTimeAcc = 0
MEM &AUX4_TEXT = "FD101_ST"
MEM &DISPLAY_FORMAT_AUX4 = 1

