//********************************************************************************
//DV03
//
|DV03autoOut = |fd101_DV03
|DV03eng = |DV03E_I       
|DV03deeng = |DV03D_I
|DV03manEnable = ON
|DV03engEnable = ON
|DV03deengEnable = ON
|DV03faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV03status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV03status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV03cmd
&VVdelayTimerAcc = &DV03delayTimerAcc
&VVfaultTimerAcc = &DV03faultTimerAcc
&VVmotFaultTimerAcc = &DV03motFaultTimerAcc
&VVdelayTimerEngPre = &DV03delayTimerEngPre
&VVdelayTimerDeengPre = &DV03delayTimerDeengPre
&VVfaultTimerEngPre = &DV03faultTimerEngPre
&VVfaultTimerDeengPre = &DV03faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV03status1 = &VVstatus1
&DV03status2 = &VVstatus2
IF (&DV03cmd = &VVcmd) THEN
  &DV03cmd = 0
ENDIF
&DV03delayTimerAcc = &VVdelayTimerAcc
&DV03faultTimerAcc = &VVfaultTimerAcc
&DV03motFaultTimerAcc = &VVmotFaultTimerAcc

|DV03_O = |DV03out