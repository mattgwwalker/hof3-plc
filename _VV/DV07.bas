//********************************************************************************
//DV07
//

IF ((|CP01out = ON) AND (&TT01_100 > (&TT01SP01 + &TT01SP02))) THEN
 |DV07autoOut= ON
ELSIF ((|CP01out = OFF) OR (&TT01_100 < (&TT01SP01 - &TT01SP02))) THEN
 |DV07autoOut = OFF
ENDIF


|DV07manEnable = ON
|DV07engEnable = ON
|DV07deengEnable = ON
|DV07faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV07status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV07status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV07cmd
&VVdelayTimerAcc = &DV07delayTimerAcc
&VVfaultTimerAcc = &DV07faultTimerAcc
&VVmotFaultTimerAcc = &DV07motFaultTimerAcc
&VVdelayTimerEngPre = &DV07delayTimerEngPre
&VVdelayTimerDeengPre = &DV07delayTimerDeengPre
&VVfaultTimerEngPre = &DV07faultTimerEngPre
&VVfaultTimerDeengPre = &DV07faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV07status1 = &VVstatus1
&DV07status2 = &VVstatus2
IF (&DV07cmd = &VVcmd) THEN
  &DV07cmd = 0
ENDIF
&DV07delayTimerAcc = &VVdelayTimerAcc
&DV07faultTimerAcc = &VVfaultTimerAcc
&DV07motFaultTimerAcc = &VVmotFaultTimerAcc

IF (|DV07out = ON) THEN  
 |DV07_O = OFF
ELSE
 |DV07_O = ON
ENDIF

 