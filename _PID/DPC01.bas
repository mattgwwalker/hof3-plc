//****************************************************************
//DPC01
//Membrane Differential Pressure Control Master Loop

&DPT01_1000 = &PT01_1000 - &PT02_1000

// Ensure the differential pressure is between zero and 5 bar
IF (&DPT01_1000 < 0 ) THEN 
  &DPC01pv = 0
ELSIF (&DPT01_1000 > 5000 ) THEN 
  &DPC01pv = 5000
ELSE
  &DPC01pv = &DPT01_1000
ENDIF


if (|fd100_DPC01pidEn1=ON) then
  // We're being asked to engage the PID controller ...
  if ((|fd100Fault_DPC01pidHold=OFF) and (|fd101_DPC01pidHold=OFF)) then 
    // ... and we're not begin asked to freeze it, so we're effectively asking 
    // for PID mode
    |fd100_DPC01pid=ON
  else
    // ... but we're being asked to freeze it, so we're effectively asking for
    // set-output mode
    |fd100_DPC01so=ON
  endif
endif

|DPC01progOutModePID = |fd100_DPC01pid
  
|DPC01modeManEnable = ON
|DPC01modeRev = OFF
|DPC01calc = OFF
|DPC01calcMode = OFF

//INPUTS
&PIDstatus = &DPC01status
&PIDcmd = &DPC01cmd
&PIDstate = &DPC01state
&PIDpv = &DPC01pv
&PIDcv = &DPC01cv
&PIDsp = &DPC01sp
&PIDerr = &DPC01err
&PIDerrLast = &DPC01errLast
&PIDerrLastLast = &DPC01errLastLast
&PIDp = &DPC01p
&PIDi = &DPC01i
&PIDd = &DPC01d
&PIDtacc = &DPC01tacc
&PIDspRampTarget = &DPC01spRampTarget
&PIDspRampRate = &DPC01spRampRate
&PIDspRampMaxErr = &DPC01spRampMaxErr

GOSUB PID

//OUTPUTS
&DPC01status = &PIDstatus
IF (&DPC01cmd = &PIDcmd) THEN
  &DPC01cmd = 0
ENDIF
&DPC01state = &PIDstate
&DPC01cv = &PIDcv
&DPC01sp = &PIDsp
&DPC01spRampTarget = &PIDspRampTarget 
&DPC01err = &PIDerr
&DPC01errLast = &PIDerrLast
&DPC01errLastLast = &PIDerrLastLast
&DPC01tacc = &PIDtacc


// If we're asking to turn off this controller, ensure the output is set to zero
// immediately
IF ((|fd100_DPC01pid=OFF) AND (|fd100_DPC01so=OFF) AND (|DPC01modeMan=OFF)) THEN
  |DPC01modeSpRamp = OFF
  &DPC01spRampTarget = 0
  &DPC01sp = 0
  &DPC01cv = 0
ENDIF

