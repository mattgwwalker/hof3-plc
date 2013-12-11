//FD100 USER_MEMORY registers
//** &USER_MEMORY_880 to &USER_MEMORY_929 currently allocated ** 

REG &fd100cmd = &USER_MEMORY_890
MEM &fd100cmd = 0
CONST fd100cmd_noAction = 0 //No Action
CONST fd100cmd_ACK = 1 //Acknowledge End State
CONST fd100cmd_PB = 2 //Pushbutton Required
CONST fd100cmd_stop = 3 //Stop
CONST fd100cmd_RECIRC = 4 //Recirc
CONST fd100cmd_PAUSE = 5 //Pause ... i.e. simulate PB01 action
CONST fd100cmd_ABORT = 6 //Abort current sequence
CONST fd100cmd_DRAIN = 7 //Feedtank To Drain
CONST fd100cmd_STORE = 8 //Feedtank To Storage Tank


REG &fd100cmdOns = &USER_MEMORY_891
MEM &fd100cmdOns = 0

REG &fd100cmd_prod_msg = &USER_MEMORY_892
MEM &fd100cmd_prod_msg = 0

REG &fd100cmd_cip_msg = &USER_MEMORY_893
MEM &fd100cmd_cip_msg = 0

REG &fd100cmd_rinse_msg = &USER_MEMORY_894
MEM &fd100cmd_rinse_msg = 0

REG &fd100cmd_DRAIN_msg = &USER_MEMORY_895
MEM &fd100cmd_DRAIN_msg = 0

REG &fd100cmd_STORE_msg = &USER_MEMORY_896
MEM &fd100cmd_STORE_msg = 0

REG &fd100Faultcmd = &USER_MEMORY_902
MEM &fd100Faultcmd = 0
CONST fd100Faultcmd_NO_ACTION = 0      // No Action
CONST fd100Faultcmd_RESET = 1          // Reset/Clear current fault [Not implemented]
CONST fd100Faultcmd_ENABLE_FAULTS = 2  // Enable fault checking
CONST fd100Faultcmd_DISABLE_FAULTS = 3 // Disable fault checking

REG &fd100FaultcmdOns = &USER_MEMORY_903
MEM &fd100FaultcmdOns = 0

REG &fd100Faultcmd_resetMsg = &USER_MEMORY_904
MEM &fd100Faultcmd_resetMsg = 0

DIM fd100Faultcmd_resetMsgArray[] = \
[" ",\
"1.Main Feed Pump Fault",\
"2.Pause Pushbutton Activated",\
"3.Estop Activated",\
"4.No Water Pressure",\
"5.No High Pressure Air",\
"6.No Low Pressure Air",\
"7.No Main Feed Pump Seal Water",\
"8.Feed tank full of Product",\
"9.Feed tank empty of Product",\
"10.Feed tank full of Rinse Water",\
"11.Feed tank empty of Rinse Water",\
"12.Feed tank full of CIP Chem",\
"13.Feed tank empty of CIP Chem",\
"14.Pause Selection Activated",\
"15.Feed tank Fill Max Time Expired",\
"16.Feed tank Temperature Too Low",\
"17.Feed tank Temperature Too High",\
"18.Inlet Pressure High",\
"19.Transmembrane Pressure High",\
"20.Back Pressure High",\
"21.Along Membrane Pressure High",\
"22.Feed tank pH Too Low",\
"23.Feed tank pH Too High",\
""]

REG &fd100ProgOut01 = &USER_MEMORY_905
BITREG &fd100ProgOut01 = [\
|fd100_DV04,\
|fd100_DV05,\
|fd100_DV06en1,\
|fd100_fd100Fault_enable1,\
|fd100_fd100Fault_FILL,\
|fd100_IL01,\
|fd100_IL01waiting,\
|fd100_IV07,\
|fd100_IV08en1,\
|fd100_IV10en1,\
|fd100_IV15,\
|fd100_PP01,\
|fd100_PP03en1,\
|fd100Temperatureen1,\
|fd100_fd102_chemdoseEn1]
MEM &fd100ProgOut01 = 0

REG &fd100ProgOut02 = &USER_MEMORY_906
BITREG &fd100ProgOut02 = [\
|fd100_DPC01so,\
|fd100_DPC01pidEn1,\
|fd100_DPC01pid,\
|fd100_PC01so,\
|fd100_PC01pidEn1,\
|fd100_PC01pid,\
|fd100_PC03so,\
|fd100_PC03pid,\
|fd100_PC05so,\
|fd100_PC05pidEn1,\
|fd100_PC05pid,\
|fd100_RC01so,\
|fd100_RC01pidEn1,\
|fd100_RC01pid,\
|fd100_fd101_drain,\
|fd100_fd101_recirc]
MEM &fd100ProgOut02 = 0

REG &PB01State = &USER_MEMORY_907
BITREG &PB01State = [|PB01_1, |PB01_2]
CONST PB01Pressed = 1

//Step Timer
REG &fd100StepTimeAcc_s10 = &USER_MEMORY_908
MEM &fd100StepTimeAcc_s10 = 0
REG &fd100StepTimeAcc_m = &USER_MEMORY_909
MEM &fd100StepTimeAcc_m = 0

//Max Time For Pushbutton 
REG &fd100StepTimePre_PB_s10 = &USER_MEMORY_910
MEM &fd100StepTimePre_PB_s10 = 100
REG &fd100StepTimePre_PB_m = &USER_MEMORY_911
MEM &fd100StepTimePre_PB_m = 1

//Time for Fill see below...added after

//Time for Step MIX 
REG &fd100StepTimePre_MIX_s10 = &USER_MEMORY_912
MEM &fd100StepTimePre_MIX_s10 = 300
REG &fd100StepTimePre_MIX_m = &USER_MEMORY_913
MEM &fd100StepTimePre_MIX_m = 0

//Time for Step RECIRC 
REG &fd100StepTimePre_RECIRC_s10 = &USER_MEMORY_914
MEM &fd100StepTimePre_RECIRC_s10 = 300
REG &fd100StepTimePre_RECIRC_m = &USER_MEMORY_915
MEM &fd100StepTimePre_RECIRC_m = 0

//Time for Step DRAIN 
REG &fd100StepTimePre_DRAIN_s10 = &USER_MEMORY_916
MEM &fd100StepTimePre_DRAIN_s10 = 150
REG &fd100StepTimePre_DRAIN_m = &USER_MEMORY_917
MEM &fd100StepTimePre_DRAIN_m = 0

//RECIRC Timer
REG &fd100TimeAcc_RECIRC_s10 = &USER_MEMORY_918
MEM &fd100TimeAcc_RECIRC_s10 = 0
REG &fd100TimeAcc_RECIRC_m = &USER_MEMORY_919
MEM &fd100TimeAcc_RECIRC_m = 0

//RECIRC Time
REG &fd100TimePre_RECIRC_s10 = &USER_MEMORY_920
MEM &fd100TimePre_RECIRC_s10 = 0
REG &fd100TimePre_RECIRC_m = &USER_MEMORY_921
MEM &fd100TimePre_RECIRC_m = 60



REG &fd100FaultStepNum = &USER_MEMORY_922  
MEM &fd100FaultStepNum = 0
CONST fd100Fault_reset = 0     // The reset state
CONST fd100Fault_monitor1 = 1  // Faults are being monitored
CONST fd100Fault_action1 =  2  // A fault has occurred
CONST fd100Fault_disabled = 3  // Fault checking is disabled

REG &fd100FaultProgOut01 = &USER_MEMORY_923
MEM &fd100FaultProgOut01 = 0
BITREG &fd100FaultProgOut01 = [\
|fd100Fault_msg1,\
|fd100Fault_IL01fault,\
|fd100Fault_PB01toPause,\
|fd100Fault_PB01toRestart,\
|fd100Fault_PP01pause,\
|fd100Fault_PP03pause,\
|fd100Fault_DPC01pidHold,\
|fd100Fault_PC01pidHold,\
|fd100Fault_PC05pidHold,\
|fd100Fault_RC01pidHold,\
|fd100Fault_temperatureHold,\
|fd100Fault_fd100_Pause,\
|fd100Fault_fd101_Pause,\
|fd100Fault_fd102_Pause]



REG &fd100FillSource = &USER_MEMORY_924
CONST fd100FillSource_NONE = 0 //No fill source... manual fill required to operate
CONST fd100FillSource_SITE = 1 //Fill Feedtank from Site
CONST fd100FillSource_WATER = 2 //Fill Feedtank with water via CIP chemical line
CONST fd100FillSource_CHEM = 3 //Fill Feedtank with water and CIP Chemical line
CONST fd100FillSource_MANCHEM = 4 //Fill Feedtank with water and Manually Dosed CIP Chemical
CONST fd100FillSource_TANK = 5 //Fill Feedtank from Storage Tank 
MEM &fd100FillSource = fd100FillSource_SITE

REG &fd100Status = &USER_MEMORY_925
CONST fd100Status_UNKNOWN = 0 //Unknown Plant State
CONST fd100Status_PROD_FULL = 1 //Feed tank full of Product
CONST fd100Status_PROD_MT = 2 //Feed tank empty of Product
CONST fd100Status_RINSE_FULL = 3 //Feed tank full of Rinse Water
CONST fd100Status_RINSE_MT = 4 //Feed tank empty of Rinse Water
CONST fd100Status_CIP_FULL = 5 //Feed tank full of CIP Chem
CONST fd100Status_CIP_MT = 6 //Feed tank empty of CIP Chem
MEM &fd100Status = fd100Status_UNKNOWN

//Fill Time 
REG &fd100StepTimePre_FILL_s10 = &USER_MEMORY_926
MEM &fd100StepTimePre_FILL_s10 = 200
REG &fd100StepTimePre_FILL_m = &USER_MEMORY_927
MEM &fd100StepTimePre_FILL_m = 0

REG &fd100_LT01max = &USER_MEMORY_928

REG &fd100Temperature = &USER_MEMORY_929
CONST fd100Temperature_NONE = 0 //None
CONST fd100Temperature_HEAT = 1 //Heat to Setpoint
CONST fd100Temperature_COOL = 2 //Cool to Setpoint
MEM &fd100Temperature = fd100Temperature_NONE


// Logging frequency (timer-based)
REG &fd100LogTimePre_s10 = &USER_MEMORY_888
MEM &fd100LogTimePre_s10 = -10
REG &fd100LogTimePre_m = &USER_MEMORY_889
MEM &fd100LogTimePre_m = 0

// Logging timer
REG &fd100LogTimeAcc_s10 = &USER_MEMORY_886
MEM &fd100LogTimeAcc_s10 = 0
REG &fd100LogTimeAcc_m = &USER_MEMORY_887
MEM &fd100LogTimeAcc_m = 0

