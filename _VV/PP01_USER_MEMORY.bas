
//PP01 Data
REG &PP01status1 = &USER_MEMORY_600
BITREG &PP01status1 = [|PP01out, |PP01motFault, |PP01man]
MEM &PP01status1 = 0
REG &PP01status2 = &USER_MEMORY_601
BITREG &PP01status2 = [|PP01eng, |PP01deeng, |PP01autoOut, |PP01delayedAutoOut, |PP01delayedOut, |PP01fault, |PP01engEnable, |PP01deengEnable, |PP01manEnable, |PP01faultResetEnable, |PP01autoInterlock, |PP01manInterlock, |PP01manOFFInterlock, |PP01manONInterlock]
MEM &PP01status2 = 194
REG &PP01cmd = &USER_MEMORY_602
REG &PP01delayTimerAcc = &USER_MEMORY_603
MEM &PP01delayTimerAcc = 0
REG &PP01faultTimerAcc = &USER_MEMORY_604
MEM &PP01faultTimerAcc = 0
REG &PP01motFaultTimerAcc = &USER_MEMORY_605
MEM &PP01motFaultTimerAcc = 0
REG &PP01delayTimerEngPre = &USER_MEMORY_606
MEM &PP01delayTimerEngPre = 1000 
REG &PP01delayTimerDeengPre = &USER_MEMORY_607
MEM &PP01delayTimerDeengPre = 0
REG &PP01faultTimerEngPre = &USER_MEMORY_608
MEM &PP01faultTimerEngPre = 1500 
REG &PP01faultTimerDeengPre = &USER_MEMORY_609
MEM &PP01faultTimerDeengPre = 1500

// PP01_RawSpeed is defined in USER_MEMORY_0xx.bas

