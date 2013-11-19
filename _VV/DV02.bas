//********************************************************************************
//DV02
//
|DV02autoOut = |fd101_DV02
|DV02eng = |DV02E_I
|DV02deeng = |DV02D_I
|DV02manEnable = ON
|DV02engEnable = ON
|DV02deengEnable = ON
|DV02faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV02status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV02status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV02cmd
&VVdelayTimerAcc = &DV02delayTimerAcc
&VVfaultTimerAcc = &DV02faultTimerAcc
&VVmotFaultTimerAcc = &DV02motFaultTimerAcc
&VVdelayTimerEngPre = &DV02delayTimerEngPre
&VVdelayTimerDeengPre = &DV02delayTimerDeengPre
&VVfaultTimerEngPre = &DV02faultTimerEngPre
&VVfaultTimerDeengPre = &DV02faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV02status1 = &VVstatus1
&DV02status2 = &VVstatus2
IF (&DV02cmd = &VVcmd) THEN
  &DV02cmd = 0
ENDIF
&DV02delayTimerAcc = &VVdelayTimerAcc
&DV02faultTimerAcc = &VVfaultTimerAcc
&DV02motFaultTimerAcc = &VVmotFaultTimerAcc

|DV02_O = |DV02out