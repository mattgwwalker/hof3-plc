
//IV15 Data
REG &IV15status1 = &USER_MEMORY_580
BITREG &IV15status1 = [|IV15out, |IV15motFault, |IV15man]
MEM &IV15status1 = 0
REG &IV15status2 = &USER_MEMORY_581
BITREG &IV15status2 = [|IV15eng, |IV15deeng, |IV15autoOut, |IV15delayedAutoOut, |IV15delayedOut, |IV15fault, |IV15engEnable, |IV15deengEnable, |IV15manEnable, |IV15faultResetEnable, |IV15autoInterlock, |IV15manInterlock, |IV15manOFFInterlock, |IV15manONInterlock]
MEM &IV15status2 = 194
REG &IV15cmd = &USER_MEMORY_582
REG &IV15delayTimerAcc = &USER_MEMORY_583
MEM &IV15delayTimerAcc = 0
REG &IV15faultTimerAcc = &USER_MEMORY_584
MEM &IV15faultTimerAcc = 0
REG &IV15motFaultTimerAcc = &USER_MEMORY_585
MEM &IV15motFaultTimerAcc = 0
REG &IV15delayTimerEngPre = &USER_MEMORY_586
MEM &IV15delayTimerEngPre = 0 
REG &IV15delayTimerDeengPre = &USER_MEMORY_587
MEM &IV15delayTimerDeengPre = 0
REG &IV15faultTimerEngPre = &USER_MEMORY_588
MEM &IV15faultTimerEngPre = 1500 
REG &IV15faultTimerDeengPre = &USER_MEMORY_589
MEM &IV15faultTimerDeengPre = 1500
