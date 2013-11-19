//CP01 Data
REG &CP01status1 = &USER_MEMORY_380
BITREG &CP01status1 = [|CP01out, |CP01motFault, |CP01man]
MEM &CP01status1 = 0
REG &CP01status2 = &USER_MEMORY_381
BITREG &CP01status2 = [|CP01eng, |CP01deeng, |CP01autoOut, |CP01delayedAutoOut, |CP01delayedOut, |CP01fault, |CP01engEnable, |CP01deengEnable, |CP01manEnable, |CP01faultResetEnable, |CP01autoInterlock, |CP01manInterlock, |CP01manOFFInterlock, |CP01manONInterlock]
MEM &CP01status2 = 194
REG &CP01cmd = &USER_MEMORY_382
REG &CP01delayTimerAcc = &USER_MEMORY_383
MEM &CP01delayTimerAcc = 0
REG &CP01faultTimerAcc = &USER_MEMORY_384
MEM &CP01faultTimerAcc = 0
REG &CP01motFaultTimerAcc = &USER_MEMORY_385
MEM &CP01motFaultTimerAcc = 0
REG &CP01delayTimerEngPre = &USER_MEMORY_386
MEM &CP01delayTimerEngPre = 0 
REG &CP01delayTimerDeengPre = &USER_MEMORY_387
MEM &CP01delayTimerDeengPre = 0
REG &CP01faultTimerEngPre = &USER_MEMORY_388
MEM &CP01faultTimerEngPre = 1500 
REG &CP01faultTimerDeengPre = &USER_MEMORY_389
MEM &CP01faultTimerDeengPre = 1500

