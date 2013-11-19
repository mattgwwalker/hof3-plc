
//IV07 Data
REG &IV07status1 = &USER_MEMORY_540
BITREG &IV07status1 = [|IV07out, |IV07motFault, |IV07man]
MEM &IV07status1 = 0
REG &IV07status2 = &USER_MEMORY_541
BITREG &IV07status2 = [|IV07eng, |IV07deeng, |IV07autoOut, |IV07delayedAutoOut, |IV07delayedOut, |IV07fault, |IV07engEnable, |IV07deengEnable, |IV07manEnable, |IV07faultResetEnable, |IV07autoInterlock, |IV07manInterlock, |IV07manOFFInterlock, |IV07manONInterlock]
MEM &IV07status2 = 194
REG &IV07cmd = &USER_MEMORY_542
REG &IV07delayTimerAcc = &USER_MEMORY_543
MEM &IV07delayTimerAcc = 0
REG &IV07faultTimerAcc = &USER_MEMORY_544
MEM &IV07faultTimerAcc = 0
REG &IV07motFaultTimerAcc = &USER_MEMORY_545
MEM &IV07motFaultTimerAcc = 0
REG &IV07delayTimerEngPre = &USER_MEMORY_546
MEM &IV07delayTimerEngPre = 0 
REG &IV07delayTimerDeengPre = &USER_MEMORY_547
MEM &IV07delayTimerDeengPre = 0
REG &IV07faultTimerEngPre = &USER_MEMORY_548
MEM &IV07faultTimerEngPre = 1500 
REG &IV07faultTimerDeengPre = &USER_MEMORY_549
MEM &IV07faultTimerDeengPre = 1500
