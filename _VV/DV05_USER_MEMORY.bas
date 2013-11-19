
//DV05 Data
REG &DV05status1 = &USER_MEMORY_440
BITREG &DV05status1 = [|DV05out, |DV05motFault, |DV05man]
MEM &DV05status1 = 0
REG &DV05status2 = &USER_MEMORY_441
BITREG &DV05status2 = [|DV05eng, |DV05deeng, |DV05autoOut, |DV05delayedAutoOut, |DV05delayedOut, |DV05fault, |DV05engEnable, |DV05deengEnable, |DV05manEnable, |DV05faultResetEnable, |DV05autoInterlock, |DV05manInterlock, |DV05manOFFInterlock, |DV05manONInterlock]
MEM &DV05status2 = 194
REG &DV05cmd = &USER_MEMORY_442
REG &DV05delayTimerAcc = &USER_MEMORY_443
MEM &DV05delayTimerAcc = 0
REG &DV05faultTimerAcc = &USER_MEMORY_444
MEM &DV05faultTimerAcc = 0
REG &DV05motFaultTimerAcc = &USER_MEMORY_445
MEM &DV05motFaultTimerAcc = 0
REG &DV05delayTimerEngPre = &USER_MEMORY_446
MEM &DV05delayTimerEngPre = 0 
REG &DV05delayTimerDeengPre = &USER_MEMORY_447
MEM &DV05delayTimerDeengPre = 0
REG &DV05faultTimerEngPre = &USER_MEMORY_448
MEM &DV05faultTimerEngPre = 1500 
REG &DV05faultTimerDeengPre = &USER_MEMORY_449
MEM &DV05faultTimerDeengPre = 1500
