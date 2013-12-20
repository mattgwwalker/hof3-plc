//********************************************************************************
//DV06
//

if (|fd100_DV06en1=ON\
    and (&fd100FillSource = fd100FillSource_WATER\
         or &fd100FillSource = fd100FillSource_AUTO_CHEM))\
or |fd102_DV06=ON then
  // Either FD100 is asking for DV06 to be on and the fill source is one of
  // water or auto-chem,
  // Or FD102 is asking for it to be on
  |DV06autoOut = ON
else
  |DV06autoOut = OFF
endif

|DV06eng = |DV06E_I
|DV06deeng = |DV06D_I
|DV06manEnable = ON
|DV06engEnable = ON
|DV06deengEnable = ON
|DV06faultResetEnable = OFF

//INPUTS
&VVstatus1 = &DV06status1 // ..|VVout, |VVmotFault, |VVman
&VVstatus2 = &DV06status2 // ..|VVeng, |VVdeeng, |VVautoOut, |VVdelayedAutoOut, |VVdelayedOut, |VVfault, |VVengEnable, |VVdeengEnable, |VVmanEnable, |VVfaultResetEnable
&VVcmd = &DV06cmd
&VVdelayTimerAcc = &DV06delayTimerAcc
&VVfaultTimerAcc = &DV06faultTimerAcc
&VVmotFaultTimerAcc = &DV06motFaultTimerAcc
&VVdelayTimerEngPre = &DV06delayTimerEngPre
&VVdelayTimerDeengPre = &DV06delayTimerDeengPre
&VVfaultTimerEngPre = &DV06faultTimerEngPre
&VVfaultTimerDeengPre = &DV06faultTimerDeengPre

GOSUB VV

//OUTPUTS
&DV06status1 = &VVstatus1
&DV06status2 = &VVstatus2
IF (&DV06cmd = &VVcmd) THEN
  &DV06cmd = 0
ENDIF
&DV06delayTimerAcc = &VVdelayTimerAcc
&DV06faultTimerAcc = &VVfaultTimerAcc
&DV06motFaultTimerAcc = &VVmotFaultTimerAcc

|DV06_O = |DV06out