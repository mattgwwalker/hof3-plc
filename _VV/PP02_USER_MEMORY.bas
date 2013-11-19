
//PP02 Data
REG &PP02status1 = &USER_MEMORY_610
BITREG &PP02status1 = [|PP02out, |PP02motFault, |PP02man]
MEM &PP02status1 = 0
REG &PP02status2 = &USER_MEMORY_611
BITREG &PP02status2 = [|PP02eng, |PP02deeng, |PP02autoOut, |PP02delayedAutoOut, |PP02delayedOut, |PP02fault, |PP02engEnable, |PP02deengEnable, |PP02manEnable, |PP02faultResetEnable, |PP02autoInterlock, |PP02manInterlock, |PP02manOFFInterlock, |PP02manONInterlock]
MEM &PP02status2 = 194
REG &PP02cmd = &USER_MEMORY_612
REG &PP02delayTimerAcc = &USER_MEMORY_613
MEM &PP02delayTimerAcc = 0
REG &PP02faultTimerAcc = &USER_MEMORY_614
MEM &PP02faultTimerAcc = 0
REG &PP02motFaultTimerAcc = &USER_MEMORY_615
MEM &PP02motFaultTimerAcc = 0
REG &PP02delayTimerEngPre = &USER_MEMORY_616
MEM &PP02delayTimerEngPre = 100 
REG &PP02delayTimerDeengPre = &USER_MEMORY_617
MEM &PP02delayTimerDeengPre = 0
REG &PP02faultTimerEngPre = &USER_MEMORY_618
MEM &PP02faultTimerEngPre = 1500 
REG &PP02faultTimerDeengPre = &USER_MEMORY_619
MEM &PP02faultTimerDeengPre = 1500
