//****************************************************************
//PC03
//Backwash Pressure Control Loop

IF (&fd101_BW_PT03max < 0 ) THEN 
 &PC03pv = 0
ELSIF (&fd101_BW_PT03max > 5000) THEN 
 &PC03pv = 5000
ELSE
 &PC03pv = &fd101_BW_PT03max
ENDIF  

|PC03progOutModePID = |fd100_PC03pid
|PC03calc =|fd101_PC03calc
|PC03modeManEnable = ON
|PC03modeRev = OFF
|PC03calcMode = ON

//INPUTS
&PIDstatus = &PC03status
&PIDcmd = &PC03cmd
&PIDstate = &PC03state
&PIDpv = &PC03pv
&PIDcv = &PC03cv
&PIDsp = &PC03sp
&PIDerr = &PC03err
&PIDerrLast = &PC03errLast
&PIDerrLastLast = &PC03errLastLast
&PIDp = &PC03p
&PIDi = &PC03i
&PIDd = &PC03d
&PIDtacc = &PC03tacc
&PIDspRampTarget = &PC03spRampTarget
&PIDspRampRate = &PC03spRampRate
&PIDspRampMaxErr = &PC03spRampMaxErr

GOSUB PID

//OUTPUTS
&PC03status = &PIDstatus
IF (&PC03cmd = &PIDcmd) THEN
  &PC03cmd = 0
ENDIF
&PC03state = &PIDstate
&PC03cv = &PIDcv
&PC03sp = &PIDsp
&PC03spRampTarget = &PIDspRampTarget 
&PC03err = &PIDerr
&PC03errLast = &PIDerrLast
&PC03errLastLast = &PIDerrLastLast
&PC03tacc = &PIDtacc

IF ((|fd100_PC03pid=OFF) AND (|fd100_PC03so=OFF) AND (|PC03modeMan=OFF)) THEN
  |PC03modeSpRamp = OFF
  &PC03cv = 0
ENDIF


