//****************************************
//User Memory

//Fault 1
REG &DPT01fault1Status = &USER_MEMORY_2 //Fault
BITREG &DPT01fault1Status = [|DPT01fault1, |DPT01fault1Mot, |DPT01fault1EnableH, |DPT01fault1Low, |DPT01fault1EnableLatch]
REG &DPT01fault1cmd = &USER_MEMORY_3 //Reset Fault 1 = 1
REG &DPT01fault1Acc = &USER_MEMORY_4 //Time Acc (s x 100)
REG &DPT01fault1Sp = &USER_MEMORY_5 //Value
REG &DPT01fault1Time = &USER_MEMORY_6 //Time (s x 100)


// Inputs indirection: To allow pre-processing on input bits (such as ensuring
// they do not ficker form one state to another)
REG &InputsIndirection = &USER_MEMORY_98
MEM &InputsIndirection = 0
BITREG &InputsIndirection = [ |FS01_I ]


// CheckAuto: Check if all items are in auto
REG &CheckAuto = &USER_MEMORY_99
CONST CheckAuto_ALL_IN_AUTO = 1
CONST CheckAuto_NOT_ALL_IN_AUTO = 0