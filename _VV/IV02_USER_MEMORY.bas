
//IV02 Data
REG &IV02status1 = &USER_MEMORY_490
BITREG &IV02status1 = [|IV02out, |IV02motFault, |IV02man]
MEM &IV02status1 = 0
REG &IV02status2 = &USER_MEMORY_491
BITREG &IV02status2 = [|IV02eng, |IV02deeng, |IV02autoOut, |IV02delayedAutoOut, |IV02delayedOut, |IV02fault, |IV02engEnable, |IV02deengEnable, |IV02manEnable, |IV02faultResetEnable, |IV02autoInterlock, |IV02manInterlock, |IV02manOFFInterlock, |IV02manONInterlock]
MEM &IV02status2 = 194
REG &IV02cmd = &USER_MEMORY_492
REG &IV02delayTimerAcc = &USER_MEMORY_493
MEM &IV02delayTimerAcc = 0
REG &IV02faultTimerAcc = &USER_MEMORY_494
MEM &IV02faultTimerAcc = 0
REG &IV02motFaultTimerAcc = &USER_MEMORY_495
MEM &IV02motFaultTimerAcc = 0
REG &IV02delayTimerEngPre = &USER_MEMORY_496
MEM &IV02delayTimerEngPre = 0 
REG &IV02delayTimerDeengPre = &USER_MEMORY_497
MEM &IV02delayTimerDeengPre = 0
REG &IV02faultTimerEngPre = &USER_MEMORY_498
MEM &IV02faultTimerEngPre = 1500 
REG &IV02faultTimerDeengPre = &USER_MEMORY_499
MEM &IV02faultTimerDeengPre = 1500
