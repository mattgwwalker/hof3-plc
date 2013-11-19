//********************************************************************************
//CP01
//

|CP01eng = |CP01_I
|CP01manEnable = ON
|CP01engEnable = ON
|CP01deengEnable = ON
|CP01faultResetEnable = OFF

//INPUTS
&VVstatus1 = &CP01status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &CP01status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &CP01cmd
&VVdelayTimerAcc = &CP01delayTimerAcc
&VVfaultTimerAcc = &CP01faultTimerAcc
&VVmotFaultTimerAcc = &CP01motFaultTimerAcc
&VVdelayTimerEngPre = &CP01delayTimerEngPre
&VVdelayTimerDeengPre = &CP01delayTimerDeengPre
&VVfaultTimerEngPre = &CP01faultTimerEngPre
&VVfaultTimerDeengPre = &CP01faultTimerDeengPre

GOSUB VV

//OUTPUTS
&CP01status1 = &VVstatus1
&CP01status2 = &VVstatus2
IF (&CP01cmd = &VVcmd) THEN
  &CP01cmd = 0
ENDIF
&CP01delayTimerAcc = &VVdelayTimerAcc
&CP01faultTimerAcc = &VVfaultTimerAcc
&CP01motFaultTimerAcc = &VVmotFaultTimerAcc

|CP01_O = |CP01out
