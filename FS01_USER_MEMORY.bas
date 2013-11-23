//FS01 Data
//** &USER_MEMORY_845 to &USER_MEMORY_845 currently allocated ** 

REG &FS01_StateChangeTimeAcc_s10 = &USER_MEMORY_845
MEM &FS01_StateChangeTimeAcc_s10 = 0

CONST FS01_COUNT_BEFORE_OFF_s10 = 5 // 0.5 seconds.  This will eliminate faulting due to flickering of this value
CONST FS01_COUNT_BEFORE_ON_s10 = 2  //  0.2 seconds.  If there's any flow at all, that's probably enough for the pump
