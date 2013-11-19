//********************************************************************************
//PP02
//

if ((|fd102_PP02=ON) AND (|fd100Fault_fd102_Pause = OFF)) then
  |PP02autoOut = ON
else
  |PP02autoOut = OFF
endif

|PP02manEnable = ON
|PP02engEnable = ON
|PP02deengEnable = OFF
|PP02faultResetEnable = OFF

//INPUTS
&VVstatus1 = &PP02status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &PP02status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &PP02cmd
&VVdelayTimerAcc = &PP02delayTimerAcc
&VVfaultTimerAcc = &PP02faultTimerAcc
&VVmotFaultTimerAcc = &PP02motFaultTimerAcc
&VVdelayTimerEngPre = &PP02delayTimerEngPre
&VVdelayTimerDeengPre = &PP02delayTimerDeengPre
&VVfaultTimerEngPre = &PP02faultTimerEngPre
&VVfaultTimerDeengPre = &PP02faultTimerDeengPre

GOSUB VV

//OUTPUTS
&PP02status1 = &VVstatus1
&PP02status2 = &VVstatus2
IF (&PP02cmd = &VVcmd) THEN
  &PP02cmd = 0
ENDIF
&PP02delayTimerAcc = &VVdelayTimerAcc
&PP02faultTimerAcc = &VVfaultTimerAcc
&PP02motFaultTimerAcc = &VVmotFaultTimerAcc

|PP02_O = |PP02out
