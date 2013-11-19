
//DV08 Data
REG &DV08status1 = &USER_MEMORY_470
BITREG &DV08status1 = [|DV08out, |DV08motFault, |DV08man]
MEM &DV08status1 = 0
REG &DV08status2 = &USER_MEMORY_471
BITREG &DV08status2 = [|DV08eng, |DV08deeng, |DV08autoOut, |DV08delayedAutoOut, |DV08delayedOut, |DV08fault, |DV08engEnable, |DV08deengEnable, |DV08manEnable, |DV08faultResetEnable, |DV08autoInterlock, |DV08manInterlock, |DV08manOFFInterlock, |DV08manONInterlock]
MEM &DV08status2 = 194
REG &DV08cmd = &USER_MEMORY_472
REG &DV08delayTimerAcc = &USER_MEMORY_473
MEM &DV08delayTimerAcc = 0
REG &DV08faultTimerAcc = &USER_MEMORY_474
MEM &DV08faultTimerAcc = 0
REG &DV08motFaultTimerAcc = &USER_MEMORY_475
MEM &DV08motFaultTimerAcc = 0
REG &DV08delayTimerEngPre = &USER_MEMORY_476
MEM &DV08delayTimerEngPre = 0 
REG &DV08delayTimerDeengPre = &USER_MEMORY_477
MEM &DV08delayTimerDeengPre = 0
REG &DV08faultTimerEngPre = &USER_MEMORY_478
MEM &DV08faultTimerEngPre = 1500 
REG &DV08faultTimerDeengPre = &USER_MEMORY_479
MEM &DV08faultTimerDeengPre = 1500
