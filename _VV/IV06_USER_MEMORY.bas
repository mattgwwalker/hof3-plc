
//IV06 Data
REG &IV06status1 = &USER_MEMORY_530
BITREG &IV06status1 = [|IV06out, |IV06motFault, |IV06man]
MEM &IV06status1 = 0
REG &IV06status2 = &USER_MEMORY_531
BITREG &IV06status2 = [|IV06eng, |IV06deeng, |IV06autoOut, |IV06delayedAutoOut, |IV06delayedOut, |IV06fault, |IV06engEnable, |IV06deengEnable, |IV06manEnable, |IV06faultResetEnable, |IV06autoInterlock, |IV06manInterlock, |IV06manOFFInterlock, |IV06manONInterlock]
MEM &IV06status2 = 194
REG &IV06cmd = &USER_MEMORY_532
REG &IV06delayTimerAcc = &USER_MEMORY_533
MEM &IV06delayTimerAcc = 0
REG &IV06faultTimerAcc = &USER_MEMORY_534
MEM &IV06faultTimerAcc = 0
REG &IV06motFaultTimerAcc = &USER_MEMORY_535
MEM &IV06motFaultTimerAcc = 0
REG &IV06delayTimerEngPre = &USER_MEMORY_536
MEM &IV06delayTimerEngPre = 100 // one second delay 
REG &IV06delayTimerDeengPre = &USER_MEMORY_537
MEM &IV06delayTimerDeengPre = 0
REG &IV06faultTimerEngPre = &USER_MEMORY_538
MEM &IV06faultTimerEngPre = 1500 
REG &IV06faultTimerDeengPre = &USER_MEMORY_539
MEM &IV06faultTimerDeengPre = 1500
