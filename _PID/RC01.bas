//****************************************************************
//RC01
//Retentate Concentration Ratio Control Loop

//Corrected Permeate Mass Volume
//FT02_100 max = 48000 //Units l*100/hr
if (|DV04out=ON) then
 &V2x = ((&FT02_100 * (&lastScanTimeFast / 36000.0)) * (1.0 - (&R01_last * 0.0))) //Volume in mL ... to do 0.0 to be replaced 
else
 &V2x = 0
endif

//Corrected Retentate Mass Volume
//FT03_100 max = 12000 //Units l*100/hr
if (|IV07out=ON) then
 &V3x = ((&FT03_100 * (&lastScanTimeFast / 36000.0)) * (1.0 - &R01_last)) //Volume in mL
else
 &V3x = 0
endif

//Current Volume in Plant
//Volume = (% * 0.645l/%) + 5l
&V1 = ((&LT01_100 * 6.45) + 5000) //Volume in mL

  
//Calculate Current Concentration Ratio
&R01 = 1.0 + ((&V1x_last + &V2x + &V3x) / &V1)

&R01_last = &R01
&V1x_last = (&V1 * (&R01_last - 1.0))

IF (&R01 < 0.0) THEN
 &R01_1000 = 0 
ELSIF (&R01 > 10.0) THEN
 &R01_1000 = 10000 
ELSE
 &R01_1000 = &R01 * 1000
ENDIF

&RC01pv = &R01_1000

if (|fd100_RC01pidEn1=ON) then
 if ((|fd100Fault_RC01pidHold=OFF) and (|fd101_RC01pidHold=OFF)) then 
  |fd100_RC01pid=ON
 else
  |fd100_RC01so=ON
 endif
endif

|RC01progOutModePID = |fd100_RC01pid 

|RC01modeManEnable = ON
|RC01modeRev = ON
|RC01calc = OFF
|RC01calcMode = OFF

//INPUTS
&PIDstatus = &RC01status
&PIDcmd = &RC01cmd
&PIDstate = &RC01state
&PIDpv = &RC01pv
&PIDcv = &RC01cv
&PIDsp = &RC01sp
&PIDerr = &RC01err
&PIDerrLast = &RC01errLast
&PIDerrLastLast = &RC01errLastLast
&PIDp = &RC01p
&PIDi = &RC01i
&PIDd = &RC01d
&PIDtacc = &RC01tacc
&PIDspRampTarget = &RC01spRampTarget
&PIDspRampRate = &RC01spRampRate
&PIDspRampMaxErr = &RC01spRampMaxErr

GOSUB PID

//OUTPUTS
&RC01status = &PIDstatus
IF (&RC01cmd = &PIDcmd) THEN
  &RC01cmd = 0
ENDIF
&RC01state = &PIDstate
&RC01cv = &PIDcv
&RC01sp = &PIDsp
&RC01spRampTarget = &PIDspRampTarget 
&RC01err = &PIDerr
&RC01errLast = &PIDerrLast
&RC01errLastLast = &PIDerrLastLast
&RC01tacc = &PIDtacc

IF ((|fd100_RC01pid=OFF) AND (|fd100_RC01so=OFF) AND (|RC01modeMan=OFF)) THEN
  |RC01modeSpRamp = OFF
  &RC01cv = 0
ENDIF
