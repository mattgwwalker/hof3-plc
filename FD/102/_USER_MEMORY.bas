//FD102 USER_MEMORY registers
//** &USER_MEMORY_990 to &USER_MEMORY_1009 currently allocated ** 
REG &fd102ProgOut01 = &USER_MEMORY_990
MEM &fd102ProgOut01 = 0
BITREG &fd102ProgOut01 = [\
|fd102_DV06,\
|fd102_IV09,\
|fd102_IV10,\
|fd102_PP02,\
|fd102_fd100_dosingChem,\
|fd102_fd100_faultDosingChem]

REG &fd102StepTimeAcc_s10 = &USER_MEMORY_991
MEM &fd102StepTimeAcc_s10 = 0
REG &fd102StepTimeAcc_m = &USER_MEMORY_992
MEM &fd102StepTimeAcc_m = 0

// Length of time to run dosing pump
REG &fd102StepTimePre_DOSE_CHEM_s10 = &USER_MEMORY_993
MEM &fd102StepTimePre_DOSE_CHEM_s10 = 50 // five seconds
REG &fd102StepTimePre_DOSE_CHEM_m = &USER_MEMORY_994
MEM &fd102StepTimePre_DOSE_CHEM_m = 0

// Length of time to purge chemical line with water
REG &fd102StepTimePre_PURGE_s10 = &USER_MEMORY_995
MEM &fd102StepTimePre_PURGE_s10 = 5 // half a second
REG &fd102StepTimePre_PURGE_m = &USER_MEMORY_996
MEM &fd102StepTimePre_PURGE_m = 0

// Length of time to wait before pH check is made
REG &fd102StepTimePre_CHECK_PH_s10 = &USER_MEMORY_997
MEM &fd102StepTimePre_CHECK_PH_s10 = 200 // 20 seconds
REG &fd102StepTimePre_CHECK_PH_m = &USER_MEMORY_998
MEM &fd102StepTimePre_CHECK_PH_m = 0

// Length of time to wash chemical line with water after dosing is complete
REG &fd102StepTimePre_WASH_s10 = &USER_MEMORY_999
MEM &fd102StepTimePre_WASH_s10 = 50 // 5 seconds
REG &fd102StepTimePre_WASH_m = &USER_MEMORY_1000
MEM &fd102StepTimePre_WASH_m = 0


// Desired pH.  Set to -1 to ignore pH measurement and dose just once.
REG &fd102_pHDesired = &USER_MEMORY_1001
MEM &fd102_pHDesired = -1

REG &fd102_DoseCount = &USER_MEMORY_1002
MEM &fd102_DoseCount = 0

REG &fd102_MaxDoseCount = &USER_MEMORY_1003
MEM &fd102_MaxDoseCount = 0 // No dosing is allowed by default

