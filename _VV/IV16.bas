//********************************************************************************
//IV16
//

if |fd100_IV16 = ON then
  |IV16autoOut = ON
else
  |IV16autoOut = OFF
endif

|IV16eng = |IV16E_I
|IV16deeng = |IV16D_I
|IV16manEnable = ON
|IV16engEnable = ON
|IV16deengEnable = ON
|IV16faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV16status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV16status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV16cmd
&VVdelayTimerAcc = &IV16delayTimerAcc
&VVfaultTimerAcc = &IV16faultTimerAcc
&VVmotFaultTimerAcc = &IV16motFaultTimerAcc
&VVdelayTimerEngPre = &IV16delayTimerEngPre
&VVdelayTimerDeengPre = &IV16delayTimerDeengPre
&VVfaultTimerEngPre = &IV16faultTimerEngPre
&VVfaultTimerDeengPre = &IV16faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV16status1 = &VVstatus1
&IV16status2 = &VVstatus2
IF (&IV16cmd = &VVcmd) THEN
  &IV16cmd = 0
ENDIF
&IV16delayTimerAcc = &VVdelayTimerAcc
&IV16faultTimerAcc = &VVfaultTimerAcc
&IV16motFaultTimerAcc = &VVmotFaultTimerAcc

|IV16_O = |IV16out
