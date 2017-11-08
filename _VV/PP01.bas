//********************************************************************************
//PP01 - Main Feed Pump
//

// Pump speed ramping
// We take the current pump speed (assumed to be equal to the raw speed variable)
// and, applying a maximum rate of change, we move it in the desired direction.
if &PC01cv > &PP01_RawSpeed then
  // We want to increase the pump's speed
  // The 100.0 is to convert the scan time (in units of 0.01 seconds) to seconds 
  if &PC01cv - &PP01_RawSpeed > &PP01_MaxDeltaSpeed * (&lastScanTimeFast / 100.0) then
    // Difference is too great to make in one change
    &PP01_RawSpeed = &PP01_RawSpeed + (&PP01_MaxDeltaSpeed * (&lastScanTimeFast / 100.0))
  else
    &PP01_RawSpeed = &PC01cv 
  endif
else
  // We want to decrease the pump's speed (or keep it constant)
  // The 100.0 is to convert the scan time (in units of 0.01 seconds) to seconds 
  if &PP01_RawSpeed - &PC01cv > &PP01_MaxDeltaSpeed * (&lastScanTimeFast / 100.0) then
    // Difference is too great to make in one change
    &PP01_RawSpeed = &PP01_RawSpeed - (&PP01_MaxDeltaSpeed * (&lastScanTimeFast / 100.0))
  else
    &PP01_RawSpeed = &PC01cv 
  endif
endif



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




// If the pump is off (either manually or automatically), set the raw speed
// to zero
if |PP01out = OFF then
  &PP01_RawSpeed = 0
endif