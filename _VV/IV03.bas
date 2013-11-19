//********************************************************************************
//IV03
//
|IV03autoOut = |fd101_IV02
|IV03deeng = |IV03D_I
|IV03eng = |IV03E_I
|IV03manEnable = ON
|IV03engEnable = ON
|IV03deengEnable = ON
|IV03faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV03status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV03status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV03cmd
&VVdelayTimerAcc = &IV03delayTimerAcc
&VVfaultTimerAcc = &IV03faultTimerAcc
&VVmotFaultTimerAcc = &IV03motFaultTimerAcc
&VVdelayTimerEngPre = &IV03delayTimerEngPre
&VVdelayTimerDeengPre = &IV03delayTimerDeengPre
&VVfaultTimerEngPre = &IV03faultTimerEngPre
&VVfaultTimerDeengPre = &IV03faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV03status1 = &VVstatus1
&IV03status2 = &VVstatus2
IF (&IV03cmd = &VVcmd) THEN
  &IV03cmd = 0
ENDIF
&IV03delayTimerAcc = &VVdelayTimerAcc
&IV03faultTimerAcc = &VVfaultTimerAcc
&IV03motFaultTimerAcc = &VVmotFaultTimerAcc

