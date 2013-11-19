
//DV04 Data
REG &DV04status1 = &USER_MEMORY_430
BITREG &DV04status1 = [|DV04out, |DV04motFault, |DV04man]
MEM &DV04status1 = 0
REG &DV04status2 = &USER_MEMORY_431
BITREG &DV04status2 = [|DV04eng, |DV04deeng, |DV04autoOut, |DV04delayedAutoOut, |DV04delayedOut, |DV04fault, |DV04engEnable, |DV04deengEnable, |DV04manEnable, |DV04faultResetEnable, |DV04autoInterlock, |DV04manInterlock, |DV04manOFFInterlock, |DV04manONInterlock]
MEM &DV04status2 = 194
REG &DV04cmd = &USER_MEMORY_432
REG &DV04delayTimerAcc = &USER_MEMORY_433
MEM &DV04delayTimerAcc = 0
REG &DV04faultTimerAcc = &USER_MEMORY_434
MEM &DV04faultTimerAcc = 0
REG &DV04motFaultTimerAcc = &USER_MEMORY_435
MEM &DV04motFaultTimerAcc = 0
REG &DV04delayTimerEngPre = &USER_MEMORY_436
MEM &DV04delayTimerEngPre = 0 
REG &DV04delayTimerDeengPre = &USER_MEMORY_437
MEM &DV04delayTimerDeengPre = 0
REG &DV04faultTimerEngPre = &USER_MEMORY_438
MEM &DV04faultTimerEngPre = 1500 
REG &DV04faultTimerDeengPre = &USER_MEMORY_439
MEM &DV04faultTimerDeengPre = 1500
