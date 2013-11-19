//********************************************************************************
//IV02
//
|IV02autoOut = |fd101_IV02
|IV02deeng = |IV02D_I
|IV02eng = |IV02E_I
|IV02manEnable = ON
|IV02engEnable = ON
|IV02deengEnable = ON
|IV02faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV02status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV02status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV02cmd
&VVdelayTimerAcc = &IV02delayTimerAcc
&VVfaultTimerAcc = &IV02faultTimerAcc
&VVmotFaultTimerAcc = &IV02motFaultTimerAcc
&VVdelayTimerEngPre = &IV02delayTimerEngPre
&VVdelayTimerDeengPre = &IV02delayTimerDeengPre
&VVfaultTimerEngPre = &IV02faultTimerEngPre
&VVfaultTimerDeengPre = &IV02faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV02status1 = &VVstatus1
&IV02status2 = &VVstatus2
IF (&IV02cmd = &VVcmd) THEN
  &IV02cmd = 0
ENDIF
&IV02delayTimerAcc = &VVdelayTimerAcc
&IV02faultTimerAcc = &VVfaultTimerAcc
&IV02motFaultTimerAcc = &VVmotFaultTimerAcc

|IV02_O = |IV02out

