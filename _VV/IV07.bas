//********************************************************************************
//IV07
//
|IV07autoOut = |fd100_IV07
|IV07deeng = |IV07D_I
|IV07eng = |IV07E_I
|IV07manEnable = ON
|IV07engEnable = ON
|IV07deengEnable = ON
|IV07faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV07status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV07status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV07cmd
&VVdelayTimerAcc = &IV07delayTimerAcc
&VVfaultTimerAcc = &IV07faultTimerAcc
&VVmotFaultTimerAcc = &IV07motFaultTimerAcc
&VVdelayTimerEngPre = &IV07delayTimerEngPre
&VVdelayTimerDeengPre = &IV07delayTimerDeengPre
&VVfaultTimerEngPre = &IV07faultTimerEngPre
&VVfaultTimerDeengPre = &IV07faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV07status1 = &VVstatus1
&IV07status2 = &VVstatus2
IF (&IV07cmd = &VVcmd) THEN
  &IV07cmd = 0
ENDIF
&IV07delayTimerAcc = &VVdelayTimerAcc
&IV07faultTimerAcc = &VVfaultTimerAcc
&IV07motFaultTimerAcc = &VVmotFaultTimerAcc

|IV07_O = |IV07out

