//********************************************************************************
//IV15
//
|IV15autoOut = |fd100_IV15
|IV15manEnable = ON
|IV15engEnable = OFF
|IV15deengEnable = OFF
|IV15faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV15status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV15status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV15cmd
&VVdelayTimerAcc = &IV15delayTimerAcc
&VVfaultTimerAcc = &IV15faultTimerAcc
&VVmotFaultTimerAcc = &IV15motFaultTimerAcc
&VVdelayTimerEngPre = &IV15delayTimerEngPre
&VVdelayTimerDeengPre = &IV15delayTimerDeengPre
&VVfaultTimerEngPre = &IV15faultTimerEngPre
&VVfaultTimerDeengPre = &IV15faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV15status1 = &VVstatus1
&IV15status2 = &VVstatus2
IF (&IV15cmd = &VVcmd) THEN
  &IV15cmd = 0
ENDIF
&IV15delayTimerAcc = &VVdelayTimerAcc
&IV15faultTimerAcc = &VVfaultTimerAcc
&IV15motFaultTimerAcc = &VVmotFaultTimerAcc

|IV15_O = |IV15out
