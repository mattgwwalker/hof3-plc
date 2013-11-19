//********************************************************************************
//EL01
//

|EL01manEnable = ON
|EL01engEnable = ON
|EL01deengEnable = ON
|EL01faultResetEnable = OFF

//INPUTS
&VVstatus1 = &EL01status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &EL01status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &EL01cmd
&VVdelayTimerAcc = &EL01delayTimerAcc
&VVfaultTimerAcc = &EL01faultTimerAcc
&VVmotFaultTimerAcc = &EL01motFaultTimerAcc
&VVdelayTimerEngPre = &EL01delayTimerEngPre
&VVdelayTimerDeengPre = &EL01delayTimerDeengPre
&VVfaultTimerEngPre = &EL01faultTimerEngPre
&VVfaultTimerDeengPre = &EL01faultTimerDeengPre

GOSUB VV

//OUTPUTS
&EL01status1 = &VVstatus1
&EL01status2 = &VVstatus2
IF (&EL01cmd = &VVcmd) THEN
  &EL01cmd = 0
ENDIF
&EL01delayTimerAcc = &VVdelayTimerAcc
&EL01faultTimerAcc = &VVfaultTimerAcc
&EL01motFaultTimerAcc = &VVmotFaultTimerAcc

|EL01_O = |EL01out
|EL01_PWM1 = OFF //............
|EL01_PWM2 = OFF //...............
|EL01_PWM3 = OFF //..............

