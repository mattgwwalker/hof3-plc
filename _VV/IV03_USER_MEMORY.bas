
//IV03 Data
REG &IV03status1 = &USER_MEMORY_500
BITREG &IV03status1 = [|IV03out, |IV03motFault, |IV03man]
MEM &IV03status1 = 0
REG &IV03status2 = &USER_MEMORY_501
BITREG &IV03status2 = [|IV03eng, |IV03deeng, |IV03autoOut, |IV03delayedAutoOut, |IV03delayedOut, |IV03fault, |IV03engEnable, |IV03deengEnable, |IV03manEnable, |IV03faultResetEnable, |IV03autoInterlock, |IV03manInterlock, |IV03manOFFInterlock, |IV03manONInterlock]
MEM &IV03status2 = 194
REG &IV03cmd = &USER_MEMORY_502
REG &IV03delayTimerAcc = &USER_MEMORY_503
MEM &IV03delayTimerAcc = 0
REG &IV03faultTimerAcc = &USER_MEMORY_504
MEM &IV03faultTimerAcc = 0
REG &IV03motFaultTimerAcc = &USER_MEMORY_505
MEM &IV03motFaultTimerAcc = 0
REG &IV03delayTimerEngPre = &USER_MEMORY_506
MEM &IV03delayTimerEngPre = 0 
REG &IV03delayTimerDeengPre = &USER_MEMORY_507
MEM &IV03delayTimerDeengPre = 0
REG &IV03faultTimerEngPre = &USER_MEMORY_508
MEM &IV03faultTimerEngPre = 1500 
REG &IV03faultTimerDeengPre = &USER_MEMORY_509
MEM &IV03faultTimerDeengPre = 1500
