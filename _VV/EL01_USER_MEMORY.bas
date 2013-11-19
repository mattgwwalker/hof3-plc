
//EL01 Data
//** &USER_MEMORY_830 to &USER_MEMORY_839 currently allocated ** 

REG &EL01status1 = &USER_MEMORY_830
BITREG &EL01status1 = [|EL01out, |EL01motFault, |EL01man]
MEM &EL01status1 = 0
REG &EL01status2 = &USER_MEMORY_831
BITREG &EL01status2 = [|EL01eng, |EL01deeng, |EL01autoOut, |EL01delayedAutoOut, |EL01delayedOut, |EL01fault, |EL01engEnable, |EL01deengEnable, |EL01manEnable, |EL01faultResetEnable, |EL01autoInterlock, |EL01manInterlock, |EL01manOFFInterlock, |EL01manONInterlock]
MEM &EL01status2 = 194
REG &EL01cmd = &USER_MEMORY_832
REG &EL01delayTimerAcc = &USER_MEMORY_833
MEM &EL01delayTimerAcc = 0
REG &EL01faultTimerAcc = &USER_MEMORY_834
MEM &EL01faultTimerAcc = 0
REG &EL01motFaultTimerAcc = &USER_MEMORY_835
MEM &EL01motFaultTimerAcc = 0
REG &EL01delayTimerEngPre = &USER_MEMORY_836
MEM &EL01delayTimerEngPre = 0 
REG &EL01delayTimerDeengPre = &USER_MEMORY_837
MEM &EL01delayTimerDeengPre = 0
REG &EL01faultTimerEngPre = &USER_MEMORY_838
MEM &EL01faultTimerEngPre = 1500 
REG &EL01faultTimerDeengPre = &USER_MEMORY_839
MEM &EL01faultTimerDeengPre = 1500
