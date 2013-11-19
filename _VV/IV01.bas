//********************************************************************************
//IV01
//
|IV01autoOut = |fd101_IV01

|IV01eng = |IV01E_I
|IV01deeng = |IV01D_I
|IV01manEnable = ON
|IV01engEnable = ON
|IV01deengEnable = ON
|IV01faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV01status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV01status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV01cmd
&VVdelayTimerAcc = &IV01delayTimerAcc
&VVfaultTimerAcc = &IV01faultTimerAcc
&VVmotFaultTimerAcc = &IV01motFaultTimerAcc
&VVdelayTimerEngPre = &IV01delayTimerEngPre
&VVdelayTimerDeengPre = &IV01delayTimerDeengPre
&VVfaultTimerEngPre = &IV01faultTimerEngPre
&VVfaultTimerDeengPre = &IV01faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV01status1 = &VVstatus1
&IV01status2 = &VVstatus2
IF (&IV01cmd = &VVcmd) THEN
  &IV01cmd = 0
ENDIF
&IV01delayTimerAcc = &VVdelayTimerAcc
&IV01faultTimerAcc = &VVfaultTimerAcc
&IV01motFaultTimerAcc = &VVmotFaultTimerAcc

|IV01_O = |IV01out