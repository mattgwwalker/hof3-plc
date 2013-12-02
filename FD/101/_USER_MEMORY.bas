//FD101 USER_MEMORY registers
//** &USER_MEMORY_930 to &USER_MEMORY_959 currently allocated ** 
REG &fd101ProgOut01 = &USER_MEMORY_930
MEM &fd101ProgOut01 = 0
BITREG &fd101ProgOut01 = [\
|fd101_BF01,\
|fd101_DV01,\
|fd101_DV02,\
|fd101_DV03,\
|fd101_IV01,\
|fd101_IV02,\
|fd101_IV04,\
|fd101_IV05,\
|fd101_IV06,\
|fd101_DPC01pidHold,\
|fd101_PC01pidHold,\
|fd101_PC03calc,\
|fd101_PC05pidHold,\
|fd101_RC01pidHold]

REG &fd101ProgOut02 = &USER_MEMORY_931
MEM &fd101ProgOut02 = 0

REG &fd101StepTimeAcc_s10 = &USER_MEMORY_932
MEM &fd101StepTimeAcc_s10 = 0
REG &fd101StepTimeAcc_m = &USER_MEMORY_933
MEM &fd101StepTimeAcc_m = 0

// The four second delay on the following two timers was optimised by Peter and
// Matthew 22-11-2013.  These values need to be considered along with the delay
// times for valves IV05, IV06, and DV0{1,2,3}.
REG &fd101StepTimePre_RECIRC_TO_BOTTOM_s10 = &USER_MEMORY_934
MEM &fd101StepTimePre_RECIRC_TO_BOTTOM_s10 = 40 // four seconds 
REG &fd101StepTimePre_RECIRC_TO_BOTTOM_m = &USER_MEMORY_935
MEM &fd101StepTimePre_RECIRC_TO_BOTTOM_m = 0

REG &fd101StepTimePre_RECIRC_TO_TOP_s10 = &USER_MEMORY_936
MEM &fd101StepTimePre_RECIRC_TO_TOP_s10 = 40 // four seconds
REG &fd101StepTimePre_RECIRC_TO_TOP_m = &USER_MEMORY_937
MEM &fd101StepTimePre_RECIRC_TO_TOP_m = 0

REG &fd101StepTimePre_RECIRC_BW_TOP_s10 = &USER_MEMORY_938
MEM &fd101StepTimePre_RECIRC_BW_TOP_s10 = 50
REG &fd101StepTimePre_RECIRC_BW_TOP_m = &USER_MEMORY_939
MEM &fd101StepTimePre_RECIRC_BW_TOP_m = 0

REG &fd101StepTimePre_RECIRC_BW_BOTTOM_s10 = &USER_MEMORY_940
MEM &fd101StepTimePre_RECIRC_BW_BOTTOM_s10 = 50
REG &fd101StepTimePre_RECIRC_BW_BOTTOM_m = &USER_MEMORY_941
MEM &fd101StepTimePre_RECIRC_BW_BOTTOM_m = 0

REG &fd101StepTimePre_RECIRC_BW_RETRACT_s10 = &USER_MEMORY_954
MEM &fd101StepTimePre_RECIRC_BW_RETRACT_s10 = 50
REG &fd101StepTimePre_RECIRC_BW_RETRACT_m = &USER_MEMORY_955
MEM &fd101StepTimePre_RECIRC_BW_RETRACT_m = 0

REG &fd101StepTimePre_DRAIN_s10 = &USER_MEMORY_942
MEM &fd101StepTimePre_DRAIN_s10 = 50
REG &fd101StepTimePre_DRAIN_m = &USER_MEMORY_943
MEM &fd101StepTimePre_DRAIN_m = 0

REG &fd101BWTimeAcc_s10 = &USER_MEMORY_944
MEM &fd101BWTimeAcc_s10 = 0
REG &fd101BWTimeAcc_m = &USER_MEMORY_945
MEM &fd101BWTimeAcc_m = 0

REG &fd101BWTimePre_RECIRC_s10 = &USER_MEMORY_946
MEM &fd101BWTimePre_RECIRC_s10 = 0
REG &fd101BWTimePre_RECIRC_m = &USER_MEMORY_947
MEM &fd101BWTimePre_RECIRC_m = 1

REG &fd101DirTimeAcc_s10 = &USER_MEMORY_948
MEM &fd101DirTimeAcc_s10 = 0
REG &fd101DirTimeAcc_m = &USER_MEMORY_949
MEM &fd101DirTimeAcc_m = 0

REG &fd101DirTimePre_RECIRC_s10 = &USER_MEMORY_950
MEM &fd101DirTimePre_RECIRC_s10 = 0
REG &fd101DirTimePre_RECIRC_m = &USER_MEMORY_951
MEM &fd101DirTimePre_RECIRC_m = 5

REG &fd101_BW_PT03max = &USER_MEMORY_952
MEM &fd101_BW_PT03max = 0
REG &fd101_BW_count = &USER_MEMORY_953
MEM &fd101_BW_count = 0

// User memory 954 and 955 used above

REG &fd101_BW_LoggingEnabled = &USER_MEMORY_956
MEM &fd101_BW_LoggingEnabled = 0