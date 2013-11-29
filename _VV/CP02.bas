//********************************************************************************
//CP02
//

IF (|fd100Temperatureen1 = ON) AND (|fd100Fault_temperatureHold = OFF) AND (&fd100Temperature = fd100Temperature_COOL) THEN
 |CP02autoOut = ON
ELSE
 |CP02autoOut = OFF
ENDIF

|CP02eng = |CP02_I
|CP02manEnable = ON
|CP02engEnable = ON
|CP02deengEnable = ON
|CP02faultResetEnable = OFF

//INPUTS
&VVstatus1 = &CP02status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &CP02status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &CP02cmd
&VVdelayTimerAcc = &CP02delayTimerAcc
&VVfaultTimerAcc = &CP02faultTimerAcc
&VVmotFaultTimerAcc = &CP02motFaultTimerAcc
&VVdelayTimerEngPre = &CP02delayTimerEngPre
&VVdelayTimerDeengPre = &CP02delayTimerDeengPre
&VVfaultTimerEngPre = &CP02faultTimerEngPre
&VVfaultTimerDeengPre = &CP02faultTimerDeengPre

GOSUB VV

//OUTPUTS
&CP02status1 = &VVstatus1
&CP02status2 = &VVstatus2
IF (&CP02cmd = &VVcmd) THEN
  &CP02cmd = 0
ENDIF
&CP02delayTimerAcc = &VVdelayTimerAcc
&CP02faultTimerAcc = &VVfaultTimerAcc
&CP02motFaultTimerAcc = &VVmotFaultTimerAcc

|CP02_O = |CP02out
