
//DV07 Data
REG &DV07status1 = &USER_MEMORY_460
BITREG &DV07status1 = [|DV07out, |DV07motFault, |DV07man]
MEM &DV07status1 = 0
REG &DV07status2 = &USER_MEMORY_461
BITREG &DV07status2 = [|DV07eng, |DV07deeng, |DV07autoOut, |DV07delayedAutoOut, |DV07delayedOut, |DV07fault, |DV07engEnable, |DV07deengEnable, |DV07manEnable, |DV07faultResetEnable, |DV07autoInterlock, |DV07manInterlock, |DV07manOFFInterlock, |DV07manONInterlock]
MEM &DV07status2 = 194
REG &DV07cmd = &USER_MEMORY_462
REG &DV07delayTimerAcc = &USER_MEMORY_463
MEM &DV07delayTimerAcc = 0
REG &DV07faultTimerAcc = &USER_MEMORY_464
MEM &DV07faultTimerAcc = 0
REG &DV07motFaultTimerAcc = &USER_MEMORY_465
MEM &DV07motFaultTimerAcc = 0
REG &DV07delayTimerEngPre = &USER_MEMORY_466
MEM &DV07delayTimerEngPre = 0 
REG &DV07delayTimerDeengPre = &USER_MEMORY_467
MEM &DV07delayTimerDeengPre = 0
REG &DV07faultTimerEngPre = &USER_MEMORY_468
MEM &DV07faultTimerEngPre = 1500 
REG &DV07faultTimerDeengPre = &USER_MEMORY_469
MEM &DV07faultTimerDeengPre = 1500
