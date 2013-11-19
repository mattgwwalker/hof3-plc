//********************************************************************************
//DV05
//

|DV05eng = |DV05E_I
|DV05deeng = |DV05D_I
|DV05manEnable = ON
|DV05engEnable = ON
|DV05deengEnable = ON
|DV05faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV05status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV05status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV05cmd
&VVdelayTimerAcc = &DV05delayTimerAcc
&VVfaultTimerAcc = &DV05faultTimerAcc
&VVmotFaultTimerAcc = &DV05motFaultTimerAcc
&VVdelayTimerEngPre = &DV05delayTimerEngPre
&VVdelayTimerDeengPre = &DV05delayTimerDeengPre
&VVfaultTimerEngPre = &DV05faultTimerEngPre
&VVfaultTimerDeengPre = &DV05faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV05status1 = &VVstatus1
&DV05status2 = &VVstatus2
IF (&DV05cmd = &VVcmd) THEN
  &DV05cmd = 0
ENDIF
&DV05delayTimerAcc = &VVdelayTimerAcc
&DV05faultTimerAcc = &VVfaultTimerAcc
&DV05motFaultTimerAcc = &VVmotFaultTimerAcc

|DV05_O = |DV05out