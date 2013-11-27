//************************************************************************
//Smart 2 module setup ISQP1
  
mem &DATA_SOURCE_CH9=addr(&SMART2_RESULT1)
mem &DATA_SOURCE_CH10=addr(&SMART2_RESULT2) 


mem &SMART2_SETUP1=0324

// 1st digit = frequency select
// 0 =
// 1 = 60hz
// 2 =
// 3 = 50hz
//
// 2nd digit=signal 1 gain
// always = 2
//
// 3rd digit= output rate
// 0 = 0.5hz averaged
// 1 = 1hz averaged
// 2 = 5hz averaged
// 3 = 10hz averaged
// 4 = 20hz averaged
// 5 = 40hz averaged

mem &SMART2_SETUP2=0222 //

// 1st digit =signal 4 gain
// always = 2
//
// 2nd digit =signal 3 gain
// always = 2
//
// 3rd digit =signal 2 gain
// always = 2
//

mem &SMART2_SETUP3=000 //

//Check following codes are correct (see module sheet for details)
//&CODE1=000
//&CODE2=170
//&CODE3=000
//&CODE4=050
//&CODE5=072
//&CODE6=073

/////////////////////////////////////////////
//Temp Integer_Variables
REG &lastScanTimeFast = &INTEGER_VARIABLE1
REG &lastScanTimeShort = &INTEGER_VARIABLE2

//****************************************
REG &TempInt1 = &INTEGER_VARIABLE3
//OP
REG &OPmsg = &TempInt1
//FD
REG &tempStepNum = &TempInt1
//VV Subroutine
REG &VVstatus1 = &TempInt1
BITREG &VVstatus1 = [|VVout, |VVmotFault, |VVman]
//PID Subroutine
REG &PIDstatus = &TempInt1
BITREG &PIDstatus = [|PIDmodeRev, |PIDmodeMan, |PIDmodePID, |PIDmodeSpRamp, |PIDmodeSpRampLast, |PIDprogOutModePID, |PIDmodeManEnable, |PIDautoInterlock, |PIDmanInterlock, |PIDsetOutputInterlock, |PIDpidInterlock, |PIDspRampOFFInterlock, |PIDspRampONInterlock, |PIDcvP, |PIDcalcMode, |PIDcalc]

//****************************************
REG &TempInt2 = &INTEGER_VARIABLE4
//VV Subroutine
REG &VVstatus2 = &TempInt2
BITREG &VVstatus2 = [|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable, |VVautoInterlock, |VVmanInterlock, |VVmanOFFInterlock, |VVmanONInterlock]

//****************************************
REG &TempInt3 = &INTEGER_VARIABLE5
//VV Subroutine
REG &VVcmd = &TempInt3
//PID Subroutine
REG &PIDcmd = &TempInt3

//**************************************** 
REG &TempInt4 = &INTEGER_VARIABLE6
//VV Subroutine
REG &VVdelayTimerAcc = &TempInt4
//PID Subroutine
REG &PIDstate = &TempInt4


//**************************************** 
REG &TempInt5 = &INTEGER_VARIABLE7
//VV Subroutine
REG &VVfaultTimerAcc = &TempInt5
//PID Subroutine
REG &PIDpv = &TempInt5

//****************************************
REG &TempInt6 = &INTEGER_VARIABLE8
//VV Subroutine
REG &VVmotFaultTimerAcc = &TempInt6
//PID Subroutine
REG &PIDcv = &TempInt6

//**************************************** 
REG &TempInt7 = &INTEGER_VARIABLE9
//VV Subroutine
REG &VVdelayTimerEngPre = &TempInt7
//PID Subroutine
REG &PIDsp = &TempInt7

//**************************************** 
REG &TempInt8 = &INTEGER_VARIABLE10
//VV Subroutine
REG &VVdelayTimerDeengPre = &TempInt8
//PID Subroutine
REG &PIDerr = &TempInt8

//****************************************
REG &TempInt9 = &INTEGER_VARIABLE11
//VV Subroutine
REG &VVfaultTimerEngPre = &TempInt9
//PID Subroutine
REG &PIDerrLast = &TempInt9

//****************************************
REG &TempInt10 = &INTEGER_VARIABLE12
//VV Subroutine
REG &VVfaultTimerDeengPre = &TempInt10
//PID Subroutine
REG &PIDerrLastLast = &TempInt10

//****************************************
REG &TempInt11 = &INTEGER_VARIABLE13
//PID Subroutine
REG &PIDp = &TempInt11

//****************************************
REG &TempInt12 = &INTEGER_VARIABLE14
//PID Subroutine
REG &PIDi = &TempInt12

//****************************************
REG &TempInt13 = &INTEGER_VARIABLE15
//PID Subroutine
REG &PIDd = &TempInt13

//****************************************
REG &TempInt14 = &INTEGER_VARIABLE16
//PID Subroutine
REG &PIDtacc = &TempInt14

//****************************************
REG &TempInt15 = &INTEGER_VARIABLE17
//PID Subroutine
REG &PIDstateNew = &TempInt15

//****************************************
REG &TempInt16 = &INTEGER_VARIABLE18
//PID Subroutine
REG &PIDspRampTarget = &TempInt16

//****************************************
REG &TempInt17 = &INTEGER_VARIABLE19
//PID Subroutine
REG &PIDspRampRate = &TempInt17

//****************************************
REG &TempInt18 = &INTEGER_VARIABLE20
//PID Subroutine
REG &PIDspRampMaxErr = &TempInt18

//****************************************
REG &TempInt19 = &INTEGER_VARIABLE21
//PID Subroutine
REG &PIDcvMax = &TempInt19

//****************************************
REG &TempInt20 = &INTEGER_VARIABLE20
//PID Subroutine
REG &PIDcvMaxDt = &TempInt20
