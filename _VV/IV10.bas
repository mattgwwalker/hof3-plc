//********************************************************************************
//IV10 - Water To Feedtank Block Valve
//

if (((|fd102_IV10=ON) AND (|fd100Fault_fd102_Pause = OFF))\
 OR ((|fd100_IV10en1=ON)\
 AND ((&fd100FillSource = fd100FillSource_WATER)\
 OR (&fd100FillSource = fd100FillSource_AUTO_CHEM))\
 AND (&LT01_100 < (&LT01SP01 - &LT01SP02))))  then
  |IV10autoOut = ON
elsif (((|fd102_IV10=OFF) OR (|fd100Fault_fd102_Pause = ON))\
 AND ((|fd100_IV10en1=OFF)\
 OR ((&fd100FillSource != fd100FillSource_WATER)\
 AND (&fd100FillSource != fd100FillSource_AUTO_CHEM))\
 OR (&LT01_100 > (&LT01SP01 + &LT01SP02)))) then
  |IV10autoOut = OFF
endif

|IV10manEnable = ON
|IV10engEnable = OFF
|IV10deengEnable = OFF
|IV10faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV10status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV10status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV10cmd
&VVdelayTimerAcc = &IV10delayTimerAcc
&VVfaultTimerAcc = &IV10faultTimerAcc
&VVmotFaultTimerAcc = &IV10motFaultTimerAcc
&VVdelayTimerEngPre = &IV10delayTimerEngPre
&VVdelayTimerDeengPre = &IV10delayTimerDeengPre
&VVfaultTimerEngPre = &IV10faultTimerEngPre
&VVfaultTimerDeengPre = &IV10faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV10status1 = &VVstatus1
&IV10status2 = &VVstatus2
IF (&IV10cmd = &VVcmd) THEN
  &IV10cmd = 0
ENDIF
&IV10delayTimerAcc = &VVdelayTimerAcc
&IV10faultTimerAcc = &VVfaultTimerAcc
&IV10motFaultTimerAcc = &VVmotFaultTimerAcc

|IV10_O = |IV10out
