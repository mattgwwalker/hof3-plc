//********************************************************************************
//DV08
//

IF ((|CP02out = ON) AND (&TT01_100 > (&TT01SP01 + &TT01SP02))) THEN
 |DV08autoOut= ON
ELSIF ((|CP02out = OFF) OR (&TT01_100 < (&TT01SP01 - &TT01SP02))) THEN
 |DV08autoOut = OFF
ENDIF

|DV08manEnable = ON
|DV08engEnable = ON
|DV08deengEnable = ON
|DV08faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV08status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV08status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV08cmd
&VVdelayTimerAcc = &DV08delayTimerAcc
&VVfaultTimerAcc = &DV08faultTimerAcc
&VVmotFaultTimerAcc = &DV08motFaultTimerAcc
&VVdelayTimerEngPre = &DV08delayTimerEngPre
&VVdelayTimerDeengPre = &DV08delayTimerDeengPre
&VVfaultTimerEngPre = &DV08faultTimerEngPre
&VVfaultTimerDeengPre = &DV08faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV08status1 = &VVstatus1
&DV08status2 = &VVstatus2
IF (&DV08cmd = &VVcmd) THEN
  &DV08cmd = 0
ENDIF
&DV08delayTimerAcc = &VVdelayTimerAcc
&DV08faultTimerAcc = &VVfaultTimerAcc
&DV08motFaultTimerAcc = &VVmotFaultTimerAcc

IF (|DV08out = ON) THEN  
 |DV08_O = OFF
ELSE
 |DV08_O = ON
ENDIF
