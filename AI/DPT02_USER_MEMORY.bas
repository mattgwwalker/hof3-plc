
//&DPT02_1000 Data
//** &USER_MEMORY_275 to &USER_MEMORY_279 currently allocated ** 

REG &DPT02SP01 = &USER_MEMORY_275 //High bag filter pressure drop fault
MEM &DPT02SP01 = 5000 //5.00 bar

REG &DPT02_FaultTimeAcc_s10 = &USER_MEMORY_276
MEM &DPT02_FaultTimeAcc_s10 = 0
REG &DPT02_FaultTimeAcc_m = &USER_MEMORY_277
MEM &DPT02_FaultTimeAcc_m = 0

// The length of time required for the bag filter to be continuously
// above the fault pressure before a fault is registered
REG &DPT02_FaultTimePre_s10 = &USER_MEMORY_278
MEM &DPT02_FaultTimePre_s10 = 5
REG &DPT02_FaultTimePre_m = &USER_MEMORY_279
MEM &DPT02_FaultTimePre_m = 0


