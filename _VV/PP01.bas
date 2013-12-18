//********************************************************************************
//PP01 - Main Feed Pump
//

if ((|fd100_PP01=ON)\
 and (|fd100Fault_PP01pause = OFF))  then
  |PP01autoOut = ON
else
  |PP01autoOut = OFF
endif

|PP01eng = |PP01E_I

|PP01manEnable = ON
|PP01engEnable = ON
|PP01deengEnable = OFF
|PP01faultResetEnable = OFF

//INPUTS
&VVstatus1 = &PP01status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &PP01status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &PP01cmd
&VVdelayTimerAcc = &PP01delayTimerAcc
&VVfaultTimerAcc = &PP01faultTimerAcc
&VVmotFaultTimerAcc = &PP01motFaultTimerAcc
&VVdelayTimerEngPre = &PP01delayTimerEngPre
&VVdelayTimerDeengPre = &PP01delayTimerDeengPre
&VVfaultTimerEngPre = &PP01faultTimerEngPre
&VVfaultTimerDeengPre = &PP01faultTimerDeengPre

GOSUB VV

//OUTPUTS
&PP01status1 = &VVstatus1
&PP01status2 = &VVstatus2
IF (&PP01cmd = &VVcmd) THEN
  &PP01cmd = 0
ENDIF
&PP01delayTimerAcc = &VVdelayTimerAcc
&PP01faultTimerAcc = &VVfaultTimerAcc
&PP01motFaultTimerAcc = &VVmotFaultTimerAcc

|PP01_O1 = |PP01out
|PP01_O2 = ON //............... Power removed to motor??

