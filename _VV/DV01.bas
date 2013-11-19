//********************************************************************************
//DV01
//
|DV01autoOut = |fd101_DV01
|DV01eng = |DV01E_I
|DV01deeng = |DV01D_I
|DV01manEnable = ON
|DV01engEnable = ON
|DV01deengEnable = ON
|DV01faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV01status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV01status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV01cmd
&VVdelayTimerAcc = &DV01delayTimerAcc
&VVfaultTimerAcc = &DV01faultTimerAcc
&VVmotFaultTimerAcc = &DV01motFaultTimerAcc
&VVdelayTimerEngPre = &DV01delayTimerEngPre
&VVdelayTimerDeengPre = &DV01delayTimerDeengPre
&VVfaultTimerEngPre = &DV01faultTimerEngPre
&VVfaultTimerDeengPre = &DV01faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV01status1 = &VVstatus1
&DV01status2 = &VVstatus2
IF (&DV01cmd = &VVcmd) THEN
  &DV01cmd = 0
ENDIF
&DV01delayTimerAcc = &VVdelayTimerAcc
&DV01faultTimerAcc = &VVfaultTimerAcc
&DV01motFaultTimerAcc = &VVmotFaultTimerAcc

|DV01_O = |DV01out