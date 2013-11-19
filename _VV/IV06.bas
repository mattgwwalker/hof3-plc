//********************************************************************************
//IV06
//
|IV06autoOut = |fd101_IV06
|IV06eng = |IV06E_I
|IV06deeng = |IV06D_I
|IV06manEnable = ON
|IV06engEnable = ON
|IV06deengEnable = ON
|IV06faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV06status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV06status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV06cmd
&VVdelayTimerAcc = &IV06delayTimerAcc
&VVfaultTimerAcc = &IV06faultTimerAcc
&VVmotFaultTimerAcc = &IV06motFaultTimerAcc
&VVdelayTimerEngPre = &IV06delayTimerEngPre
&VVdelayTimerDeengPre = &IV06delayTimerDeengPre
&VVfaultTimerEngPre = &IV06faultTimerEngPre
&VVfaultTimerDeengPre = &IV06faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV06status1 = &VVstatus1
&IV06status2 = &VVstatus2
IF (&IV06cmd = &VVcmd) THEN
  &IV06cmd = 0
ENDIF
&IV06delayTimerAcc = &VVdelayTimerAcc
&IV06faultTimerAcc = &VVfaultTimerAcc
&IV06motFaultTimerAcc = &VVmotFaultTimerAcc

|IV06_O = |IV06out
