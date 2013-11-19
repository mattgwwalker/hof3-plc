
//IV04 Data
REG &IV04status1 = &USER_MEMORY_510
BITREG &IV04status1 = [|IV04out, |IV04motFault, |IV04man]
MEM &IV04status1 = 0
REG &IV04status2 = &USER_MEMORY_511
BITREG &IV04status2 = [|IV04eng, |IV04deeng, |IV04autoOut, |IV04delayedAutoOut, |IV04delayedOut, |IV04fault, |IV04engEnable, |IV04deengEnable, |IV04manEnable, |IV04faultResetEnable, |IV04autoInterlock, |IV04manInterlock, |IV04manOFFInterlock, |IV04manONInterlock]
MEM &IV04status2 = 194
REG &IV04cmd = &USER_MEMORY_512
REG &IV04delayTimerAcc = &USER_MEMORY_513
MEM &IV04delayTimerAcc = 0
REG &IV04faultTimerAcc = &USER_MEMORY_514
MEM &IV04faultTimerAcc = 0
REG &IV04motFaultTimerAcc = &USER_MEMORY_515
MEM &IV04motFaultTimerAcc = 0
REG &IV04delayTimerEngPre = &USER_MEMORY_516
MEM &IV04delayTimerEngPre = 0 
REG &IV04delayTimerDeengPre = &USER_MEMORY_517
MEM &IV04delayTimerDeengPre = 0
REG &IV04faultTimerEngPre = &USER_MEMORY_518
MEM &IV04faultTimerEngPre = 1500 
REG &IV04faultTimerDeengPre = &USER_MEMORY_519
MEM &IV04faultTimerDeengPre = 1500
