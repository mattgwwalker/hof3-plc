//****************************************
//User Memory

//Fault 1
REG &DPT01fault1Status = &USER_MEMORY_2 //Fault
BITREG &DPT01fault1Status = [|DPT01fault1, |DPT01fault1Mot, |DPT01fault1EnableH, |DPT01fault1Low, |DPT01fault1EnableLatch]
REG &DPT01fault1cmd = &USER_MEMORY_3 //Reset Fault 1 = 1
REG &DPT01fault1Acc = &USER_MEMORY_4 //Time Acc (s x 100)
REG &DPT01fault1Sp = &USER_MEMORY_5 //Value
REG &DPT01fault1Time = &USER_MEMORY_6 //Time (s x 100)


// Debug register
REG &Debug = &USER_MEMORY_96


// Register for logging of events
REG &EventID = &USER_MEMORY_97
CONST EventID_ON_TIMER = -1
CONST EventID_NONE = 0
CONST EventID_STARTED = 1
CONST EventID_FINISHED = 2
CONST EventID_STOPPED = 3
CONST EventID_ABORTED = 4
CONST EventID_FILLING_STARTED = 10
CONST EventID_MIXING_STARTED  = 11
CONST EventID_RECIRC_STARTED  = 12
CONST EventID_BLAST_STARTED   = 13
CONST EventID_CONC_STARTED    = 14
CONST EventID_MT2SITE_STARTED = 15
CONST EventID_MT2WASTE_STARTED= 16
CONST EventID_DRAIN2WASTE_STARTED = 17
CONST EventID_MT2STORE_STARTED= 18
CONST EventID_DRAIN2STORE_STARTED = 19
CONST EventID_BACKWASH_STARTED = 20
CONST EventID_DIRECTION_CHANGE_STARTED = 21
CONST EventID_MAX_BACKWASH_PRESSURE = 22
CONST EventID_DRAIN_STORE_TO_WASTE_STARTED = 23
CONST EventID_DURING_BACKWASH = 100
CONST EventID_DURING_BACKWASH_RETRACT = 101
CONST EventID_DURING_FREEZE_PIDS = 102
CONST EventID_FAULT = 10000

MEM &EventID = EventID_NONE


// Inputs indirection: To allow pre-processing on input bits (such as ensuring
// they do not ficker form one state to another)
REG &InputsIndirection = &USER_MEMORY_98
MEM &InputsIndirection = 0
BITREG &InputsIndirection = [ |FS01_I ]


// CheckAuto: Check if all items are in auto
REG &CheckAuto = &USER_MEMORY_99
CONST CheckAuto_ALL_IN_AUTO = 1
CONST CheckAuto_NOT_ALL_IN_AUTO = 0