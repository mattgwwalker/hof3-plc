//********************************************************************************
//BF01
//
|BF01autoOut = |fd101_BF01
|BF01manEnable = ON
|BF01engEnable = OFF
|BF01deengEnable = OFF
|BF01faultResetEnable = OFF

//INPUTS
&VVstatus1 = &BF01status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &BF01status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &BF01cmd
&VVdelayTimerAcc = &BF01delayTimerAcc
&VVfaultTimerAcc = &BF01faultTimerAcc
&VVmotFaultTimerAcc = &BF01motFaultTimerAcc
&VVdelayTimerEngPre = &BF01delayTimerEngPre
&VVdelayTimerDeengPre = &BF01delayTimerDeengPre
&VVfaultTimerEngPre = &BF01faultTimerEngPre
&VVfaultTimerDeengPre = &BF01faultTimerDeengPre

GOSUB VV

//OUTPUTS
&BF01status1 = &VVstatus1
&BF01status2 = &VVstatus2
IF (&BF01cmd = &VVcmd) THEN
  &BF01cmd = 0
ENDIF
&BF01delayTimerAcc = &VVdelayTimerAcc
&BF01faultTimerAcc = &VVfaultTimerAcc
&BF01motFaultTimerAcc = &VVmotFaultTimerAcc

|BF01_O = |BF01out
