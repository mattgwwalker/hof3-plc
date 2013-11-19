//********************************************************************************
//IV05
//
|IV05autoOut = |fd101_IV05
|IV05eng = |IV05E_I
|IV05deeng = |IV05D_I
|IV05manEnable = ON
|IV05engEnable = ON
|IV05deengEnable = ON
|IV05faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV05status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV05status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV05cmd
&VVdelayTimerAcc = &IV05delayTimerAcc
&VVfaultTimerAcc = &IV05faultTimerAcc
&VVmotFaultTimerAcc = &IV05motFaultTimerAcc
&VVdelayTimerEngPre = &IV05delayTimerEngPre
&VVdelayTimerDeengPre = &IV05delayTimerDeengPre
&VVfaultTimerEngPre = &IV05faultTimerEngPre
&VVfaultTimerDeengPre = &IV05faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV05status1 = &VVstatus1
&IV05status2 = &VVstatus2
IF (&IV05cmd = &VVcmd) THEN
  &IV05cmd = 0
ENDIF
&IV05delayTimerAcc = &VVdelayTimerAcc
&IV05faultTimerAcc = &VVfaultTimerAcc
&IV05motFaultTimerAcc = &VVmotFaultTimerAcc

|IV05_O = |IV05out
