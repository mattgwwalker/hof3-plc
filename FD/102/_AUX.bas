REG &fd102StepNum = &AUX7  
CONST fd102StepNum_RESET     = 0
CONST fd102StepNum_CHECK_PH  = 1
CONST fd102StepNum_DOSE_CHEM = 2
CONST fd102StepNum_PURGE     = 3
CONST fd102StepNum_WASH      = 4
CONST fd102StepNum_END       = 5
MEM &fd102StepNum = fd102StepNum_RESET

MEM &AUX7_TEXT = "FD102_SN"
MEM &DISPLAY_FORMAT_AUX7 = 0


//DIM fd102MsgArray[] = \
//["Reset",\
//"Add Chemical",\
//"Purge Line",\
//"End",\
// ""\
//]
