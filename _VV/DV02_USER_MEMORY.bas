
//DV02 Data
REG &DV02status1 = &USER_MEMORY_410
BITREG &DV02status1 = [|DV02out, |DV02motFault, |DV02man]
MEM &DV02status1 = 0
REG &DV02status2 = &USER_MEMORY_411
BITREG &DV02status2 = [|DV02eng, |DV02deeng, |DV02autoOut, |DV02delayedAutoOut, |DV02delayedOut, |DV02fault, |DV02engEnable, |DV02deengEnable, |DV02manEnable, |DV02faultResetEnable, |DV02autoInterlock, |DV02manInterlock, |DV02manOFFInterlock, |DV02manONInterlock]
MEM &DV02status2 = 194
REG &DV02cmd = &USER_MEMORY_412
REG &DV02delayTimerAcc = &USER_MEMORY_413
MEM &DV02delayTimerAcc = 0
REG &DV02faultTimerAcc = &USER_MEMORY_414
MEM &DV02faultTimerAcc = 0
REG &DV02motFaultTimerAcc = &USER_MEMORY_415
MEM &DV02motFaultTimerAcc = 0
REG &DV02delayTimerEngPre = &USER_MEMORY_416
MEM &DV02delayTimerEngPre = 500 
REG &DV02delayTimerDeengPre = &USER_MEMORY_417
MEM &DV02delayTimerDeengPre = 500
REG &DV02faultTimerEngPre = &USER_MEMORY_418
MEM &DV02faultTimerEngPre = 1500 
REG &DV02faultTimerDeengPre = &USER_MEMORY_419
MEM &DV02faultTimerDeengPre = 1500
