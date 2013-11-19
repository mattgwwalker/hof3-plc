
//IV09 Data
REG &IV09status1 = &USER_MEMORY_560
BITREG &IV09status1 = [|IV09out, |IV09motFault, |IV09man]
MEM &IV09status1 = 0
REG &IV09status2 = &USER_MEMORY_561
BITREG &IV09status2 = [|IV09eng, |IV09deeng, |IV09autoOut, |IV09delayedAutoOut, |IV09delayedOut, |IV09fault, |IV09engEnable, |IV09deengEnable, |IV09manEnable, |IV09faultResetEnable, |IV09autoInterlock, |IV09manInterlock, |IV09manOFFInterlock, |IV09manONInterlock]
MEM &IV09status2 = 194
REG &IV09cmd = &USER_MEMORY_562
REG &IV09delayTimerAcc = &USER_MEMORY_563
MEM &IV09delayTimerAcc = 0
REG &IV09faultTimerAcc = &USER_MEMORY_564
MEM &IV09faultTimerAcc = 0
REG &IV09motFaultTimerAcc = &USER_MEMORY_565
MEM &IV09motFaultTimerAcc = 0
REG &IV09delayTimerEngPre = &USER_MEMORY_566
MEM &IV09delayTimerEngPre = 0 
REG &IV09delayTimerDeengPre = &USER_MEMORY_567
MEM &IV09delayTimerDeengPre = 100
REG &IV09faultTimerEngPre = &USER_MEMORY_568
MEM &IV09faultTimerEngPre = 1500 
REG &IV09faultTimerDeengPre = &USER_MEMORY_569
MEM &IV09faultTimerDeengPre = 1500
