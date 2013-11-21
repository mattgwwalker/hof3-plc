
//DV01 Data
REG &DV01status1 = &USER_MEMORY_400
BITREG &DV01status1 = [|DV01out, |DV01motFault, |DV01man]
MEM &DV01status1 = 0
REG &DV01status2 = &USER_MEMORY_401
BITREG &DV01status2 = [|DV01eng, |DV01deeng, |DV01autoOut, |DV01delayedAutoOut, |DV01delayedOut, |DV01fault, |DV01engEnable, |DV01deengEnable, |DV01manEnable, |DV01faultResetEnable, |DV01autoInterlock, |DV01manInterlock, |DV01manOFFInterlock, |DV01manONInterlock]
MEM &DV01status2 = 194
REG &DV01cmd = &USER_MEMORY_402
REG &DV01delayTimerAcc = &USER_MEMORY_403
MEM &DV01delayTimerAcc = 0
REG &DV01faultTimerAcc = &USER_MEMORY_404
MEM &DV01faultTimerAcc = 0
REG &DV01motFaultTimerAcc = &USER_MEMORY_405
MEM &DV01motFaultTimerAcc = 0
REG &DV01delayTimerEngPre = &USER_MEMORY_406
MEM &DV01delayTimerEngPre = 250 // 2.5 seconds
REG &DV01delayTimerDeengPre = &USER_MEMORY_407
MEM &DV01delayTimerDeengPre = 250 // 2.5 seconds
REG &DV01faultTimerEngPre = &USER_MEMORY_408
MEM &DV01faultTimerEngPre = 1500 
REG &DV01faultTimerDeengPre = &USER_MEMORY_409
MEM &DV01faultTimerDeengPre = 1500
