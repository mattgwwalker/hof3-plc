//PC03 PID loop data - Backwash Pressure Control Loop
//** &USER_MEMORY_710 to &USER_MEMORY_749 currently allocated **

REG &PC03status = &USER_MEMORY_710
BITREG &PC03status = [|PC03modeRev, |PC03modeMan, |PC03modePID, |PC03modeSpRamp, |PC03modeSpRampLast, |PC03progOutModePID, |PC03modeManEnable, |PC03autoInterlock, |PC03manInterlock, |PC03setOutputInterlock, |PC03pidInterlock, |PC03spRampOFFInterlock, |PC03spRampONInterlock, |PC03cvP, |PC03calcMode, |PC03calc]
MEM &PC03status = 0
REG &PC03cmd = &USER_MEMORY_711
MEM &PC03cmd = 0
REG &PC03state = &USER_MEMORY_712
MEM &PC03state = 0
REG &PC03pv = &USER_MEMORY_713
MEM &PC03pv = 0
REG &PC03cv = &USER_MEMORY_714
MEM &PC03cv = 0
REG &PC03sp = &USER_MEMORY_715
MEM &PC03sp = 0
REG &PC03err = &USER_MEMORY_716
MEM &PC03err = 0
REG &PC03errLast = &USER_MEMORY_717
MEM &PC03errLast = 0
REG &PC03errLastLast = &USER_MEMORY_718
MEM &PC03errLastLast = 0
REG &PC03p = &USER_MEMORY_719
MEM &PC03p = 1
REG &PC03i = &USER_MEMORY_720
MEM &PC03i = 1
REG &PC03d = &USER_MEMORY_721
MEM &PC03d = 0
REG &PC03tacc = &USER_MEMORY_722
MEM &PC03tacc = 0
REG &PC03spRampTarget = &USER_MEMORY_723
MEM &PC03spRampTarget = 0
REG &PC03spRampRate = &USER_MEMORY_724
MEM &PC03spRampRate = 0
REG &PC03spRampMaxErr = &USER_MEMORY_725
MEM &PC03spRampMaxErr = 0
REG &PC03cvMax = &USER_MEMORY_726
MEM &PC03cvMax = 10000
REG &PC03cvMaxDt = &USER_MEMORY_727
MEM &PC03cvMaxDt = 10000
REG &PC03sp01 = &USER_MEMORY_730 //Backwash Pressure
MEM &PC03sp01 = 400
REG &PC03sp02 = &USER_MEMORY_731
MEM &PC03sp02 = 0
REG &PC03sp03 = &USER_MEMORY_732
MEM &PC03sp03 = 0
REG &PC03sp04 = &USER_MEMORY_733
MEM &PC03sp04 = 0
REG &PC03sp05 = &USER_MEMORY_734
MEM &PC03sp05 = 0
REG &PC03sp06 = &USER_MEMORY_735
MEM &PC03sp06 = 0
REG &PC03sp07 = &USER_MEMORY_736
MEM &PC03sp07 = 0
REG &PC03sp08 = &USER_MEMORY_737
MEM &PC03sp08 = 0
REG &PC03sp09 = &USER_MEMORY_738
MEM &PC03sp09 = 0
REG &PC03sp10 = &USER_MEMORY_739
MEM &PC03sp10 = 0
REG &PC03cv01 = &USER_MEMORY_740 //Inital Start Value
MEM &PC03cv01 = 0
REG &PC03cv02 = &USER_MEMORY_741
MEM &PC03cv02 = 0
REG &PC03cv03 = &USER_MEMORY_742
MEM &PC03cv03 = 0
REG &PC03cv04 = &USER_MEMORY_743
MEM &PC03cv04 = 0
REG &PC03cv05 = &USER_MEMORY_744
MEM &PC03cv05 = 0
REG &PC03cv06 = &USER_MEMORY_745
MEM &PC03cv06 = 0
REG &PC03cv07 = &USER_MEMORY_746
MEM &PC03cv07 = 0
REG &PC03cv08 = &USER_MEMORY_747
MEM &PC03cv08 = 0
REG &PC03cv09 = &USER_MEMORY_748
MEM &PC03cv09 = 0
REG &PC03cv10 = &USER_MEMORY_749
MEM &PC03cv10 = 0