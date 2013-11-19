
//IV16 Data
REG &IV16status1 = &USER_MEMORY_590
BITREG &IV16status1 = [|IV16out, |IV16motFault, |IV16man]
MEM &IV16status1 = 0
REG &IV16status2 = &USER_MEMORY_591
BITREG &IV16status2 = [|IV16eng, |IV16deeng, |IV16autoOut, |IV16delayedAutoOut, |IV16delayedOut, |IV16fault, |IV16engEnable, |IV16deengEnable, |IV16manEnable, |IV16faultResetEnable, |IV16autoInterlock, |IV16manInterlock, |IV16manOFFInterlock, |IV16manONInterlock]
MEM &IV16status2 = 194
REG &IV16cmd = &USER_MEMORY_592
REG &IV16delayTimerAcc = &USER_MEMORY_593
MEM &IV16delayTimerAcc = 0
REG &IV16faultTimerAcc = &USER_MEMORY_594
MEM &IV16faultTimerAcc = 0
REG &IV16motFaultTimerAcc = &USER_MEMORY_595
MEM &IV16motFaultTimerAcc = 0
REG &IV16delayTimerEngPre = &USER_MEMORY_596
MEM &IV16delayTimerEngPre = 0 
REG &IV16delayTimerDeengPre = &USER_MEMORY_597
MEM &IV16delayTimerDeengPre = 0
REG &IV16faultTimerEngPre = &USER_MEMORY_598
MEM &IV16faultTimerEngPre = 1500 
REG &IV16faultTimerDeengPre = &USER_MEMORY_599
MEM &IV16faultTimerDeengPre = 1500
