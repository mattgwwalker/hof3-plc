//****************************************************************
//PC05
//Trans Membrane Pressure Control Loop

&PT05_1000 = ((&PT01_1000 + &PT02_1000) / 2.0) - &PT03_1000

IF (&PT05_1000 < 0 ) THEN 
 &PC05pv = 0
ELSIF (&PT05_1000 > 5000 ) THEN 
 &PC05pv = 5000
ELSE
 &PC05pv = &PT05_1000
ENDIF  

if (|fd100_PC05pidEn1=ON) then
 if ((|fd100Fault_PC05pidHold=OFF) and (|fd101_PC05pidHold=OFF)) then 
  |fd100_PC05pid=ON
 else
  |fd100_PC05so=ON
 endif
endif

|PC05progOutModePID = |fd100_PC05pid

|PC05modeManEnable = ON
|PC05modeRev = ON
|PC05calc = OFF
|PC05calcMode = OFF

//INPUTS
&PIDstatus = &PC05status
&PIDcmd = &PC05cmd
&PIDstate = &PC05state
&PIDpv = &PC05pv
&PIDcv = &PC05cv
&PIDsp = &PC05sp
&PIDerr = &PC05err
&PIDerrLast = &PC05errLast
&PIDerrLastLast = &PC05errLastLast
&PIDp = &PC05p
&PIDi = &PC05i
&PIDd = &PC05d
&PIDtacc = &PC05tacc
&PIDspRampTarget = &PC05spRampTarget
&PIDspRampRate = &PC05spRampRate
&PIDspRampMaxErr = &PC05spRampMaxErr

GOSUB PID

//OUTPUTS
&PC05status = &PIDstatus
IF (&PC05cmd = &PIDcmd) THEN
  &PC05cmd = 0
ENDIF
&PC05state = &PIDstate
&PC05cv = &PIDcv
&PC05sp = &PIDsp
&PC05spRampTarget = &PIDspRampTarget 
&PC05err = &PIDerr
&PC05errLast = &PIDerrLast
&PC05errLastLast = &PIDerrLastLast
&PC05tacc = &PIDtacc

IF ((|fd100_PC05pid=OFF) AND (|fd100_PC05so=OFF) AND (|PC05modeMan=OFF)) THEN
  |PC05modeSpRamp = OFF
  &PC05cv = 0
ENDIF

//Output to CV01
