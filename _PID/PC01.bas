//****************************************************************
//PC01
//Membrane Inlet Pressure Control Slave Loop

IF (&PT01_1000 < 0 ) THEN 
 &PC01pv = 0
ELSIF (&PT01_1000 > 5000 ) THEN 
 &PC01pv = 5000
ELSE
 &PC01pv = &PT01_1000
ENDIF

//Setpoint Set By Master Loop DPC01 and Max Inlet Pressure SP10
&PC01spRampTarget = &PC01sp10 * (&DPC01cv / 10000.0)

if (|fd100_PC01pidEn1=ON) then
 if ((|fd100Fault_PC01pidHold=OFF) and (|fd101_PC01pidHold=OFF)) then 
  |fd100_PC01pid=ON
 else
  |fd100_PC01so=ON
 endif
endif

|PC01progOutModePID = |fd100_PC01pid

|PC01modeManEnable = ON
|PC01modeRev = OFF
|PC01calc = OFF
|PC01calcMode = OFF

//INPUTS
&PIDstatus = &PC01status
&PIDcmd = &PC01cmd
&PIDstate = &PC01state
&PIDpv = &PC01pv
&PIDcv = &PC01cv
&PIDsp = &PC01sp
&PIDerr = &PC01err
&PIDerrLast = &PC01errLast
&PIDerrLastLast = &PC01errLastLast
&PIDp = &PC01p
&PIDi = &PC01i
&PIDd = &PC01d
&PIDtacc = &PC01tacc
&PIDspRampTarget = &PC01spRampTarget
&PIDspRampRate = &PC01spRampRate
&PIDspRampMaxErr = &PC01spRampMaxErr

GOSUB PID

//OUTPUTS
&PC01status = &PIDstatus
IF (&PC01cmd = &PIDcmd) THEN
  &PC01cmd = 0
ENDIF
&PC01state = &PIDstate
&PC01cv = &PIDcv
&PC01sp = &PIDsp
&PC01spRampTarget = &PIDspRampTarget 
&PC01err = &PIDerr
&PC01errLast = &PIDerrLast
&PC01errLastLast = &PIDerrLastLast
&PC01tacc = &PIDtacc

IF ((|fd100_PC01pid=OFF) AND (|fd100_PC01so=OFF) AND (|PC01modeMan=OFF)) THEN
  |PC01modeSpRamp = OFF
  &PC01cv = 0
ENDIF

