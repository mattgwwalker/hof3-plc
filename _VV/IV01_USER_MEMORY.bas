
//IV01 Data
REG &IV01status1 = &USER_MEMORY_480
BITREG &IV01status1 = [|IV01out, |IV01motFault, |IV01man]
MEM &IV01status1 = 0
REG &IV01status2 = &USER_MEMORY_481
BITREG &IV01status2 = [|IV01eng, |IV01deeng, |IV01autoOut, |IV01delayedAutoOut, |IV01delayedOut, |IV01fault, |IV01engEnable, |IV01deengEnable, |IV01manEnable, |IV01faultResetEnable, |IV01autoInterlock, |IV01manInterlock, |IV01manOFFInterlock, |IV01manONInterlock]
MEM &IV01status2 = 194
REG &IV01cmd = &USER_MEMORY_482
REG &IV01delayTimerAcc = &USER_MEMORY_483
MEM &IV01delayTimerAcc = 0
REG &IV01faultTimerAcc = &USER_MEMORY_484
MEM &IV01faultTimerAcc = 0
REG &IV01motFaultTimerAcc = &USER_MEMORY_485
MEM &IV01motFaultTimerAcc = 0
REG &IV01delayTimerEngPre = &USER_MEMORY_486
MEM &IV01delayTimerEngPre = 0 
REG &IV01delayTimerDeengPre = &USER_MEMORY_487
MEM &IV01delayTimerDeengPre = 0
REG &IV01faultTimerEngPre = &USER_MEMORY_488
MEM &IV01faultTimerEngPre = 1500 
REG &IV01faultTimerDeengPre = &USER_MEMORY_489
MEM &IV01faultTimerDeengPre = 1500
