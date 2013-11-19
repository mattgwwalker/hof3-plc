//FD102 USER_MEMORY registers
//** &USER_MEMORY_990 to &USER_MEMORY_999 currently allocated ** 
REG &fd102ProgOut01 = &USER_MEMORY_990
MEM &fd102ProgOut01 = 0
BITREG &fd102ProgOut01 = [\
|fd102_DV06,\
|fd102_IV09,\
|fd102_IV10,\
|fd102_PP02]

REG &fd102StepTimeAcc_s10 = &USER_MEMORY_991
MEM &fd102StepTimeAcc_s10 = 0
REG &fd102StepTimeAcc_m = &USER_MEMORY_992
MEM &fd102StepTimeAcc_m = 0

REG &fd102StepTimePre_DOSECHEM_s10 = &USER_MEMORY_993
MEM &fd102StepTimePre_DOSECHEM_s10 = 100
REG &fd102StepTimePre_DOSECHEM_m = &USER_MEMORY_994
MEM &fd102StepTimePre_DOSECHEM_m = 0

REG &fd102StepTimePre_PURGE_s10 = &USER_MEMORY_995
MEM &fd102StepTimePre_PURGE_s10 = 50
REG &fd102StepTimePre_PURGE_m = &USER_MEMORY_996
MEM &fd102StepTimePre_PURGE_m = 0
