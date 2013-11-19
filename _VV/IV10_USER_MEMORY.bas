
//IV10 Data
REG &IV10status1 = &USER_MEMORY_570
BITREG &IV10status1 = [|IV10out, |IV10motFault, |IV10man]
MEM &IV10status1 = 0
REG &IV10status2 = &USER_MEMORY_571
BITREG &IV10status2 = [|IV10eng, |IV10deeng, |IV10autoOut, |IV10delayedAutoOut, |IV10delayedOut, |IV10fault, |IV10engEnable, |IV10deengEnable, |IV10manEnable, |IV10faultResetEnable, |IV10autoInterlock, |IV10manInterlock, |IV10manOFFInterlock, |IV10manONInterlock]
MEM &IV10status2 = 194
REG &IV10cmd = &USER_MEMORY_572
REG &IV10delayTimerAcc = &USER_MEMORY_573
MEM &IV10delayTimerAcc = 0
REG &IV10faultTimerAcc = &USER_MEMORY_574
MEM &IV10faultTimerAcc = 0
REG &IV10motFaultTimerAcc = &USER_MEMORY_575
MEM &IV10motFaultTimerAcc = 0
REG &IV10delayTimerEngPre = &USER_MEMORY_576
MEM &IV10delayTimerEngPre = 0 
REG &IV10delayTimerDeengPre = &USER_MEMORY_577
MEM &IV10delayTimerDeengPre = 0
REG &IV10faultTimerEngPre = &USER_MEMORY_578
MEM &IV10faultTimerEngPre = 1500 
REG &IV10faultTimerDeengPre = &USER_MEMORY_579
MEM &IV10faultTimerDeengPre = 1500
