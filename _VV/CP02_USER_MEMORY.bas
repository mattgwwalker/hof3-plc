//CP02 Data
REG &CP02status1 = &USER_MEMORY_390
BITREG &CP02status1 = [|CP02out, |CP02motFault, |CP02man]
MEM &CP02status1 = 0
REG &CP02status2 = &USER_MEMORY_391
BITREG &CP02status2 = [|CP02eng, |CP02deeng, |CP02autoOut, |CP02delayedAutoOut, |CP02delayedOut, |CP02fault, |CP02engEnable, |CP02deengEnable, |CP02manEnable, |CP02faultResetEnable, |CP02autoInterlock, |CP02manInterlock, |CP02manOFFInterlock, |CP02manONInterlock]
MEM &CP02status2 = 194
REG &CP02cmd = &USER_MEMORY_392
REG &CP02delayTimerAcc = &USER_MEMORY_393
MEM &CP02delayTimerAcc = 0
REG &CP02faultTimerAcc = &USER_MEMORY_394
MEM &CP02faultTimerAcc = 0
REG &CP02motFaultTimerAcc = &USER_MEMORY_395
MEM &CP02motFaultTimerAcc = 0
REG &CP02delayTimerEngPre = &USER_MEMORY_396
MEM &CP02delayTimerEngPre = 0 
REG &CP02delayTimerDeengPre = &USER_MEMORY_397
MEM &CP02delayTimerDeengPre = 0
REG &CP02faultTimerEngPre = &USER_MEMORY_398
MEM &CP02faultTimerEngPre = 1500 
REG &CP02faultTimerDeengPre = &USER_MEMORY_399
MEM &CP02faultTimerDeengPre = 1500

