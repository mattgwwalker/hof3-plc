
//PP03 Data
REG &PP03status1 = &USER_MEMORY_620
BITREG &PP03status1 = [|PP03out, |PP03motFault, |PP03man]
MEM &PP03status1 = 0
REG &PP03status2 = &USER_MEMORY_621
BITREG &PP03status2 = [|PP03eng, |PP03deeng, |PP03autoOut, |PP03delayedAutoOut, |PP03delayedOut, |PP03fault, |PP03engEnable, |PP03deengEnable, |PP03manEnable, |PP03faultResetEnable, |PP03autoInterlock, |PP03manInterlock, |PP03manOFFInterlock, |PP03manONInterlock]
MEM &PP03status2 = 194
REG &PP03cmd = &USER_MEMORY_622
REG &PP03delayTimerAcc = &USER_MEMORY_623
MEM &PP03delayTimerAcc = 0
REG &PP03faultTimerAcc = &USER_MEMORY_624
MEM &PP03faultTimerAcc = 0
REG &PP03motFaultTimerAcc = &USER_MEMORY_625
MEM &PP03motFaultTimerAcc = 0
REG &PP03delayTimerEngPre = &USER_MEMORY_626
MEM &PP03delayTimerEngPre = 0 
REG &PP03delayTimerDeengPre = &USER_MEMORY_627
MEM &PP03delayTimerDeengPre = 0
REG &PP03faultTimerEngPre = &USER_MEMORY_628
MEM &PP03faultTimerEngPre = 1500 
REG &PP03faultTimerDeengPre = &USER_MEMORY_629
MEM &PP03faultTimerDeengPre = 1500
