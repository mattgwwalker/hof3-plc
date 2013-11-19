//********************************************************************************
//PP03
//

|PP03manEnable = ON
|PP03engEnable = ON
|PP03deengEnable = OFF
|PP03faultResetEnable = OFF

//INPUTS
&VVstatus1 = &PP03status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &PP03status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &PP03cmd
&VVdelayTimerAcc = &PP03delayTimerAcc
&VVfaultTimerAcc = &PP03faultTimerAcc
&VVmotFaultTimerAcc = &PP03motFaultTimerAcc
&VVdelayTimerEngPre = &PP03delayTimerEngPre
&VVdelayTimerDeengPre = &PP03delayTimerDeengPre
&VVfaultTimerEngPre = &PP03faultTimerEngPre
&VVfaultTimerDeengPre = &PP03faultTimerDeengPre

GOSUB VV

//OUTPUTS
&PP03status1 = &VVstatus1
&PP03status2 = &VVstatus2
IF (&PP03cmd = &VVcmd) THEN
  &PP03cmd = 0
ENDIF
&PP03delayTimerAcc = &VVdelayTimerAcc
&PP03faultTimerAcc = &VVfaultTimerAcc
&PP03motFaultTimerAcc = &VVmotFaultTimerAcc

|PP03_O = |PP03out

