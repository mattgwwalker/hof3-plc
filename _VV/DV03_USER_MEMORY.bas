
//DV03 Data
REG &DV03status1 = &USER_MEMORY_420
BITREG &DV03status1 = [|DV03out, |DV03motFault, |DV03man]
MEM &DV03status1 = 0
REG &DV03status2 = &USER_MEMORY_421
BITREG &DV03status2 = [|DV03eng, |DV03deeng, |DV03autoOut, |DV03delayedAutoOut, |DV03delayedOut, |DV03fault, |DV03engEnable, |DV03deengEnable, |DV03manEnable, |DV03faultResetEnable, |DV03autoInterlock, |DV03manInterlock, |DV03manOFFInterlock, |DV03manONInterlock]
MEM &DV03status2 = 194
REG &DV03cmd = &USER_MEMORY_422
REG &DV03delayTimerAcc = &USER_MEMORY_423
MEM &DV03delayTimerAcc = 0
REG &DV03faultTimerAcc = &USER_MEMORY_424
MEM &DV03faultTimerAcc = 0
REG &DV03motFaultTimerAcc = &USER_MEMORY_425
MEM &DV03motFaultTimerAcc = 0
REG &DV03delayTimerEngPre = &USER_MEMORY_426
MEM &DV03delayTimerEngPre = 500 
REG &DV03delayTimerDeengPre = &USER_MEMORY_427
MEM &DV03delayTimerDeengPre = 500
REG &DV03faultTimerEngPre = &USER_MEMORY_428
MEM &DV03faultTimerEngPre = 1500 
REG &DV03faultTimerDeengPre = &USER_MEMORY_429
MEM &DV03faultTimerDeengPre = 1500
