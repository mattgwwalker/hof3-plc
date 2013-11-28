//BF01 Data
REG &BF01status1 = &USER_MEMORY_370
BITREG &BF01status1 = [|BF01out, |BF01motFault, |BF01man]
MEM &BF01status1 = 0
REG &BF01status2 = &USER_MEMORY_371
BITREG &BF01status2 = [|BF01eng, |BF01deeng, |BF01autoOut, |BF01delayedAutoOut, |BF01delayedOut, |BF01fault, |BF01engEnable, |BF01deengEnable, |BF01manEnable, |BF01faultResetEnable, |BF01autoInterlock, |BF01manInterlock, |BF01manOFFInterlock, |BF01manONInterlock]
MEM &BF01status2 = 194
REG &BF01cmd = &USER_MEMORY_372
REG &BF01delayTimerAcc = &USER_MEMORY_373
MEM &BF01delayTimerAcc = 0
REG &BF01faultTimerAcc = &USER_MEMORY_374
MEM &BF01faultTimerAcc = 0
REG &BF01motFaultTimerAcc = &USER_MEMORY_375
MEM &BF01motFaultTimerAcc = 0
REG &BF01delayTimerEngPre = &USER_MEMORY_376
MEM &BF01delayTimerEngPre = 50 // half second delay 
REG &BF01delayTimerDeengPre = &USER_MEMORY_377
MEM &BF01delayTimerDeengPre = 0
REG &BF01faultTimerEngPre = &USER_MEMORY_378
MEM &BF01faultTimerEngPre = 1500 
REG &BF01faultTimerDeengPre = &USER_MEMORY_379
MEM &BF01faultTimerDeengPre = 1500

