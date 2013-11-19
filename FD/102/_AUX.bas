REG &fd102StepNum = &AUX7  
MEM &fd102StepNum = 0
MEM &AUX7_TEXT = "FD102_SN"
MEM &DISPLAY_FORMAT_AUX7 = 0
CONST fd102StepNum_RESET = 0
CONST fd102StepNum_DOSECHEM = 1
CONST fd102StepNum_PURGE = 2
CONST fd102StepNum_END = 3


DIM fd102MsgArray[] = \
["Reset",\
"Add Chemical",\
"Purge Line",\
"End",\
 ""\
]
