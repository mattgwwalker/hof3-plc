//********************************************************************************
//DV04
//
|DV04autoOut = |fd100_DV04
|DV04eng = |DV04E_I
|DV04deeng = |DV04D_I
|DV04manEnable = ON
|DV04engEnable = ON
|DV04deengEnable = ON
|DV04faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV04status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV04status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV04cmd
&VVdelayTimerAcc = &DV04delayTimerAcc
&VVfaultTimerAcc = &DV04faultTimerAcc
&VVmotFaultTimerAcc = &DV04motFaultTimerAcc
&VVdelayTimerEngPre = &DV04delayTimerEngPre
&VVdelayTimerDeengPre = &DV04delayTimerDeengPre
&VVfaultTimerEngPre = &DV04faultTimerEngPre
&VVfaultTimerDeengPre = &DV04faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV04status1 = &VVstatus1
&DV04status2 = &VVstatus2
IF (&DV04cmd = &VVcmd) THEN
  &DV04cmd = 0
ENDIF
&DV04delayTimerAcc = &VVdelayTimerAcc
&DV04faultTimerAcc = &VVfaultTimerAcc
&DV04motFaultTimerAcc = &VVmotFaultTimerAcc

|DV04_O = |DV04out