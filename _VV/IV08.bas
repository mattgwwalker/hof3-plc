//********************************************************************************
//IV08
//

if ((|fd100_IV08en1=ON)\
 AND (&fd100FillSource = fd100FillSource_SITE)\
 AND (&LT01_100 < (&LT01SP01 - &LT01SP02)))  then
  |IV08autoOut = ON
elsif ((|fd100_IV08en1=OFF)\
 OR (&fd100FillSource != fd100FillSource_SITE)\
 OR (&LT01_100 > (&LT01SP01 + &LT01SP02))) then
  |IV08autoOut = OFF
endif

|IV08eng = |IV08E_I
|IV08deeng = |IV08D_I
|IV08manEnable = ON
|IV08engEnable = ON
|IV08deengEnable = ON
|IV08faultResetEnable = OFF

//INPUTS
&VVstatus1 = &IV08status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &IV08status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &IV08cmd
&VVdelayTimerAcc = &IV08delayTimerAcc
&VVfaultTimerAcc = &IV08faultTimerAcc
&VVmotFaultTimerAcc = &IV08motFaultTimerAcc
&VVdelayTimerEngPre = &IV08delayTimerEngPre
&VVdelayTimerDeengPre = &IV08delayTimerDeengPre
&VVfaultTimerEngPre = &IV08faultTimerEngPre
&VVfaultTimerDeengPre = &IV08faultTimerDeengPre

GOSUB VV

//OUTPUTS
&IV08status1 = &VVstatus1
&IV08status2 = &VVstatus2
IF (&IV08cmd = &VVcmd) THEN
  &IV08cmd = 0
ENDIF
&IV08delayTimerAcc = &VVdelayTimerAcc
&IV08faultTimerAcc = &VVfaultTimerAcc
&IV08motFaultTimerAcc = &VVmotFaultTimerAcc

|IV08_O = |IV08out

