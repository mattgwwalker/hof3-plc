
//DV06 Data
REG &DV06status1 = &USER_MEMORY_450
BITREG &DV06status1 = [|DV06out, |DV06motFault, |DV06man]
MEM &DV06status1 = 0
REG &DV06status2 = &USER_MEMORY_451
BITREG &DV06status2 = [|DV06eng, |DV06deeng, |DV06autoOut, |DV06delayedAutoOut, |DV06delayedOut, |DV06fault, |DV06engEnable, |DV06deengEnable, |DV06manEnable, |DV06faultResetEnable, |DV06autoInterlock, |DV06manInterlock, |DV06manOFFInterlock, |DV06manONInterlock]
MEM &DV06status2 = 194
REG &DV06cmd = &USER_MEMORY_452
REG &DV06delayTimerAcc = &USER_MEMORY_453
MEM &DV06delayTimerAcc = 0
REG &DV06faultTimerAcc = &USER_MEMORY_454
MEM &DV06faultTimerAcc = 0
REG &DV06motFaultTimerAcc = &USER_MEMORY_455
MEM &DV06motFaultTimerAcc = 0
REG &DV06delayTimerEngPre = &USER_MEMORY_456
MEM &DV06delayTimerEngPre = 0 
REG &DV06delayTimerDeengPre = &USER_MEMORY_457
MEM &DV06delayTimerDeengPre = 0
REG &DV06faultTimerEngPre = &USER_MEMORY_458
MEM &DV06faultTimerEngPre = 1500 
REG &DV06faultTimerDeengPre = &USER_MEMORY_459
MEM &DV06faultTimerDeengPre = 1500
