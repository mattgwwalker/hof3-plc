//********************************************************************************
//IV09
//


|IV09autoOut = |fd102_IV09

|IV09manEnable = ON
|IV09engEnable = ON
|IV09deengEnable = ON
|IV09faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV09status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV09status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV09cmd
&VVdelayTimerAcc = &IV09delayTimerAcc
&VVfaultTimerAcc = &IV09faultTimerAcc
&VVmotFaultTimerAcc = &IV09motFaultTimerAcc
&VVdelayTimerEngPre = &IV09delayTimerEngPre
&VVdelayTimerDeengPre = &IV09delayTimerDeengPre
&VVfaultTimerEngPre = &IV09faultTimerEngPre
&VVfaultTimerDeengPre = &IV09faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV09status1 = &VVstatus1
&IV09status2 = &VVstatus2
IF (&IV09cmd = &VVcmd) THEN
  &IV09cmd = 0
ENDIF
&IV09delayTimerAcc = &VVdelayTimerAcc
&IV09faultTimerAcc = &VVfaultTimerAcc
&IV09motFaultTimerAcc = &VVmotFaultTimerAcc

|IV09_O = |IV09out
