
//IV05 Data
REG &IV05status1 = &USER_MEMORY_520
BITREG &IV05status1 = [|IV05out, |IV05motFault, |IV05man]
MEM &IV05status1 = 0
REG &IV05status2 = &USER_MEMORY_521
BITREG &IV05status2 = [|IV05eng, |IV05deeng, |IV05autoOut, |IV05delayedAutoOut, |IV05delayedOut, |IV05fault, |IV05engEnable, |IV05deengEnable, |IV05manEnable, |IV05faultResetEnable, |IV05autoInterlock, |IV05manInterlock, |IV05manOFFInterlock, |IV05manONInterlock]
MEM &IV05status2 = 194
REG &IV05cmd = &USER_MEMORY_522
REG &IV05delayTimerAcc = &USER_MEMORY_523
MEM &IV05delayTimerAcc = 0
REG &IV05faultTimerAcc = &USER_MEMORY_524
MEM &IV05faultTimerAcc = 0
REG &IV05motFaultTimerAcc = &USER_MEMORY_525
MEM &IV05motFaultTimerAcc = 0
REG &IV05delayTimerEngPre = &USER_MEMORY_526
MEM &IV05delayTimerEngPre = 0 
REG &IV05delayTimerDeengPre = &USER_MEMORY_527
MEM &IV05delayTimerDeengPre = 100 // one second delay
REG &IV05faultTimerEngPre = &USER_MEMORY_528
MEM &IV05faultTimerEngPre = 1500 
REG &IV05faultTimerDeengPre = &USER_MEMORY_529
MEM &IV05faultTimerDeengPre = 1500
