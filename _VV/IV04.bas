//********************************************************************************
//IV04
//
|IV04autoOut = |fd101_IV04
|IV04Ddeeng = |IV04D_I
|IV04Deng = |IV04E_I
|IV04manEnable = ON
|IV04engEnable = ON
|IV04deengEnable = ON
|IV04faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV04status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV04status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV04cmd
&VVdelayTimerAcc = &IV04delayTimerAcc
&VVfaultTimerAcc = &IV04faultTimerAcc
&VVmotFaultTimerAcc = &IV04motFaultTimerAcc
&VVdelayTimerEngPre = &IV04delayTimerEngPre
&VVdelayTimerDeengPre = &IV04delayTimerDeengPre
&VVfaultTimerEngPre = &IV04faultTimerEngPre
&VVfaultTimerDeengPre = &IV04faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV04status1 = &VVstatus1
&IV04status2 = &VVstatus2
IF (&IV04cmd = &VVcmd) THEN
  &IV04cmd = 0
ENDIF
&IV04delayTimerAcc = &VVdelayTimerAcc
&IV04faultTimerAcc = &VVfaultTimerAcc
&IV04motFaultTimerAcc = &VVmotFaultTimerAcc

|IV04_O = |IV04out
