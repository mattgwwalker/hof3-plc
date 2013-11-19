
//IV08 Data
REG &IV08status1 = &USER_MEMORY_550
BITREG &IV08status1 = [|IV08out, |IV08motFault, |IV08man]
MEM &IV08status1 = 0
REG &IV08status2 = &USER_MEMORY_551
BITREG &IV08status2 = [|IV08eng, |IV08deeng, |IV08autoOut, |IV08delayedAutoOut, |IV08delayedOut, |IV08fault, |IV08engEnable, |IV08deengEnable, |IV08manEnable, |IV08faultResetEnable, |IV08autoInterlock, |IV08manInterlock, |IV08manOFFInterlock, |IV08manONInterlock]
MEM &IV08status2 = 194
REG &IV08cmd = &USER_MEMORY_552
REG &IV08delayTimerAcc = &USER_MEMORY_553
MEM &IV08delayTimerAcc = 0
REG &IV08faultTimerAcc = &USER_MEMORY_554
MEM &IV08faultTimerAcc = 0
REG &IV08motFaultTimerAcc = &USER_MEMORY_555
MEM &IV08motFaultTimerAcc = 0
REG &IV08delayTimerEngPre = &USER_MEMORY_556
MEM &IV08delayTimerEngPre = 0 
REG &IV08delayTimerDeengPre = &USER_MEMORY_557
MEM &IV08delayTimerDeengPre = 0
REG &IV08faultTimerEngPre = &USER_MEMORY_558
MEM &IV08faultTimerEngPre = 1500 
REG &IV08faultTimerDeengPre = &USER_MEMORY_559
MEM &IV08faultTimerDeengPre = 1500
