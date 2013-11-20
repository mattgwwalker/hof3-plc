// FD100 Main Sequence

// This sequence is responsible for the main state of the plant.  For
// example: mixing, recirculating, concentrating.

// When the plant is in the Recirc state, both the retentate and
// permeate lines are returned to the main tank.  This state fills the
// membrane and associated piping with liquid.

// This file is broken up into four main parts: initialisation, the
// step transitions, the one-shot actions, and the step actions that
// happen every scan.

// Clear Sequence Outputs.  These registers are used to hold bit-wise
// values such as whether pump PP01 should be turned on.  By setting
// these registers to zero, all those bits are cleared in each scan,
// meaning that the code below need only set each bit on if required.
// The declaration for each bit can be found in _USER_MEMORY.bas.
&fd100ProgOut01 = 0 &fd100ProgOut02 = 0

//Create ONESHOT function for PB01... which is used to start sequence
IF (|PB01_I = ON) THEN
 IF (|PB01_1 = OFF) THEN
  |PB01_1 = ON
  |PB01_2 = OFF
 ELSE
  |PB01_1 = ON
  |PB01_2 = ON
 ENDIF
ELSE
  |PB01_1 = OFF
  |PB01_2 = OFF
ENDIF

//Selection From RPi
&OPmsg = 0
 IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
  &OPmsg = 3
 ELSIF (|PS01_I = OFF) THEN
  &OPmsg = 4
 ELSIF (|PS02_I = OFF) THEN
  &OPmsg = 5
 ELSIF (|PS03_I = OFF) THEN
  &OPmsg = 6
 ELSIF (&fd100Status = fd100Status_RINSE_FULL) THEN
  &OPmsg = 10
 ELSIF (&fd100Status = fd100Status_CIP_FULL) THEN
  &OPmsg = 12
 ELSIF (&fd100Status = fd100Status_CIP_MT) THEN
  &OPmsg = 13            
 ENDIF
&fd100cmd_prod_msg = &OPmsg

&OPmsg = 0
 IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
  &OPmsg = 3
 ELSIF (|PS01_I = OFF) THEN
  &OPmsg = 4
 ELSIF (|PS02_I = OFF) THEN
  &OPmsg = 5
 ELSIF (|PS03_I = OFF) THEN
  &OPmsg = 6
 ELSIF (&fd100Status = fd100Status_RINSE_FULL) THEN
  &OPmsg = 10
 ELSIF (&fd100Status = fd100Status_PROD_FULL) THEN
  &OPmsg = 8
 ELSIF (&fd100Status = fd100Status_PROD_MT) THEN
  &OPmsg = 9            
 ENDIF
&fd100cmd_cip_msg = &OPmsg

&OPmsg = 0
 IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
  &OPmsg = 3
 ELSIF (|PS01_I = OFF) THEN
  &OPmsg = 4
 ELSIF (|PS02_I = OFF) THEN
  &OPmsg = 5
 ELSIF (|PS03_I = OFF) THEN
  &OPmsg = 6
 ELSIF (&fd100Status = fd100Status_CIP_FULL) THEN
  &OPmsg = 12
 ELSIF (&fd100Status = fd100Status_PROD_FULL) THEN
  &OPmsg = 8           
 ENDIF
&fd100cmd_rinse_msg = &OPmsg


select &fd100cmd 
 //Check If No Precondition Faults
 case  fd100cmd_RECIRC:
  if ((&fd100cmd_prod_msg = 0) AND (&fd100FillSource = fd100FillSource_SITE)) then
   &fd100cmdOns = &fd100cmd
  elsif ((&fd100cmd_prod_msg = 0) AND (&fd100FillSource = fd100FillSource_NONE)) then
   &fd100cmdOns = &fd100cmd
  elsif ((&fd100cmd_rinse_msg = 0) AND (&fd100FillSource = fd100FillSource_WATER)) then
   &fd100cmdOns = &fd100cmd
  elsif ((&fd100cmd_cip_msg = 0) AND (&fd100FillSource = fd100FillSource_CHEM)) then
   &fd100cmdOns = &fd100cmd
  elsif ((&fd100cmd_cip_msg = 0) AND (&fd100FillSource = fd100FillSource_MANCHEM)) then
   &fd100cmdOns = &fd100cmd 
  endif
  
 default:
  &fd100cmdOns = &fd100cmd
endsel
 
&fd100cmd = fd100cmd_noAction


// ******************
// Step Transisitions
// ******************

&tempStepNum = &fd100StepNum
select &tempStepNum
 case  fd100StepNum_RESET: //***Powerup and Reset State
  &tempStepNum = fd100StepNum_WAITINS

 case fd100StepNum_WAITINS: //***Awaiting Instruction From RPi
  IF (&fd100cmdOns=fd100cmd_PB) THEN
   &tempStepNum = fd100StepNum_PB 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_RECIRC) THEN
   &tempStepNum = fd100StepNum_FILL 
  ENDIF 
 
 case fd100StepNum_PB: //***Awaiting Start From Pushbutton
  IF (&PB01State=PB01Pressed) THEN
   &tempStepNum = fd100StepNum_END 
  ENDIF
  //If Stop Command from RPi then go back to waiting for new instruction  
  IF (&fd100cmdOns=fd100cmd_stop) THEN
   &tempStepNum = fd100StepNum_WAITINS 
  ENDIF
  //If PB01 not push within a time period go back to waiting for new instruction
  IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_PB_m) AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_PB_s10)) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF
  
 case fd100StepNum_END: //Wait for ACK from RPi
  //If Ack Command from RPi then go back to waiting for new instruction  
  IF (&fd100cmdOns=fd100cmd_ACK) THEN
   &tempStepNum = fd100StepNum_WAITINS 
  ENDIF
  //If Stop Command from RPi then go back to waiting for new instruction  
  IF (&fd100cmdOns=fd100cmd_stop) THEN
   &tempStepNum = fd100StepNum_WAITINS 
  ENDIF
  //If Abort Command from RPi then go back to waiting for new instruction  
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF    

 case fd100StepNum_FILL: //Fill Feedtank
  //Start Recirc After Feedtank reaches min level. 
  IF (&LT01_100 > (&LT01SP03 + &LT01SP04)) THEN
   &tempStepNum = fd100StepNum_MIX 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_stop) THEN
   &tempStepNum = fd100StepNum_DRAIN 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF 

 case fd100StepNum_MIX: //Mix Via Bypass Line
  //Stop Recirculation if level drops too low. 
  IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
   &tempStepNum = fd100StepNum_FILL 
  ENDIF
  //Mix Time Before Recirculating through HOF
  IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_MIX_m)\
   AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_MIX_s10)\
   AND (&fd100StepTimePre_MIX_s10 >= 0)) THEN
   &tempStepNum = fd100StepNum_RECIRC  
  ENDIF
  //Stop Production or CIP Chemical Wash  
  IF (&fd100cmdOns=fd100cmd_stop) THEN
   &tempStepNum = fd100StepNum_MT2DRAIN 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF

 case fd100StepNum_RECIRC: //Production or CIP Chemical Wash - Recirc To Mix
  //Stop Recirculation if level drops too low. 
  IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
   &tempStepNum = fd100StepNum_FILL 
  ENDIF
  //Recirculation Time Before Concentrating through HOF ... If _s10 < 0  then don't go to CONC
  IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_RECIRC_m)\
   AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_RECIRC_s10)\
   AND (&fd100StepTimePre_RECIRC_s10 >= 0)) THEN
    &tempStepNum = fd100StepNum_CONC  
  ENDIF
  //Total Production or CIP Chemical Wash Time Before Stopping ... If _s10 < 0  then ignore
  IF ((&fd100TimeAcc_RECIRC_m >= &fd100TimePre_RECIRC_m)\
   AND (&fd100TimeAcc_RECIRC_s10 >= &fd100TimePre_RECIRC_s10)\
   AND (&fd100TimePre_RECIRC_s10 >= 0)) THEN
    &tempStepNum = fd100StepNum_MT2DRAIN  
  ENDIF  
  //Stop Production or CIP Chemical Wash  
  IF (&fd100cmdOns=fd100cmd_stop) THEN
   &tempStepNum = fd100StepNum_MT2DRAIN 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF
  
 case  fd100StepNum_CONC: //Production - Circulate through filter
  //Stop Concentration if level drops too low. 
  IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
   &tempStepNum = fd100StepNum_FILL 
  ENDIF
  //Total Production Time Before Stopping ... If _s10 < 0  then ignore
  IF ((&fd100TimeAcc_RECIRC_m >= &fd100TimePre_RECIRC_m)\
   AND (&fd100TimeAcc_RECIRC_s10 >= &fd100TimePre_RECIRC_s10)\
   AND (&fd100TimePre_RECIRC_s10 >= 0)) THEN
    &tempStepNum = fd100StepNum_MT2SITE  
  ENDIF  
  IF (&fd100cmdOns=fd100cmd_stop) THEN
   &tempStepNum = fd100StepNum_MT2SITE 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF
   
 case fd100StepNum_MT2SITE: //Production - Empty Feedtank To Site
  //Feed Tank Reached Min Level. 
  IF (&LT01_100 < &LT01SP05) THEN
   &tempStepNum = fd100StepNum_MT2DRAIN 
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF 
  
 case fd100StepNum_MT2DRAIN: //Production or CIP Chemical Wash - Pump Feedtank To Drain
  //Feed Tank Reached Empty Level. 
  IF (&LT01_100 < &LT01SP06) THEN
   &tempStepNum = fd100StepNum_DRAIN
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF  
  
 case fd100StepNum_DRAIN: //Production or CIP Chemical Wash - Drain Plant
  //Drain Plant Time
  IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_DRAIN_m)\
   AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_DRAIN_s10)) THEN
    &tempStepNum = fd100StepNum_END  
  ENDIF
  IF (&fd100cmdOns=fd100cmd_ABORT) THEN
   &tempStepNum = fd100StepNum_WAITINS  
  ENDIF 
   
 default:
  &tempStepNum = fd100StepNum_RESET
endsel



// **********************
// One-shot (ONS) Actions
// **********************

// These actions only occur as the state is changing.  They do not
// occur every scan.

IF (&tempStepNum != &fd100StepNum) THEN
 &fd100StepNum = &tempStepNum
 &fd100StepTimeAcc_s10 = 0
 &fd100StepTimeAcc_m = 0 
 select &tempStepNum
  case fd100StepNum_RESET: //Powerup and Reset State
  
  case fd100StepNum_WAITINS: //Awaiting Instruction
   &fd100TimeAcc_RECIRC_s10 = 0
   &fd100TimeAcc_RECIRC_m = 0
  
  case fd100StepNum_PB: //Awaiting Pushbutton
  
  case fd100StepNum_END: //End wait for Acknowledgement from RPi  
  
  case fd100StepNum_FILL: //Production or CIP Chemical Wash - Fill Feedtank
   &PC05cv=&PC05cv01 //Open CV01 to enable recirc
   
  case fd100StepNum_MIX: //Production or CIP Chemical Wash - Mix Via Bypass Line
   &DPC01cv=&DPC01cv01 //Set PC01sp to control the speed of the Main Feed Pump
   &PC01cv=&PC01cv01 //Set Initial the speed of the Main Feed Pump
   if (&fd100FillSource = fd100FillSource_NONE) then
    &fd100Status = fd100Status_PROD_FULL //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_SITE) then
    &fd100Status = fd100Status_PROD_FULL //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_WATER) then
    &fd100Status = fd100Status_RINSE_FULL //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_CHEM) then
    &fd100Status = fd100Status_CIP_FULL //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_MANCHEM) then
    &fd100Status = fd100Status_CIP_FULL //Set Plant Status
   endif   

  case fd100StepNum_RECIRC: //Production or CIP Chemical Wash - Recirc through filter
   // Set up the PID controllers for Recirc 
   &DPC01sp=&DPC01sp01
   &PC05sp=&PC05sp01
   &PC03sp=&PC03sp01
   &PC03cv=&PC03cv01
    
  case fd100StepNum_CONC: //Production - Concentrate
   &RC01cv=&RC01cv01 //Concentration Ratio Starting Value
   &RC01sp=&RC01sp01 //Concentration Ratio
   
  case fd100StepNum_MT2SITE: //Production - Empty Feedtank To Site
  
  case fd100StepNum_MT2DRAIN: //Production or CIP Chemical Wash - Pump Feedtank To Drain 
   &PC01cv=&PC01cv02
   
  case fd100StepNum_DRAIN: //Production or CIP Chemical Wash - Empty Feedtank To Drain
   if (&fd100FillSource = fd100FillSource_NONE) then
    &fd100Status = fd100Status_PROD_MT //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_SITE) then
    &fd100Status = fd100Status_PROD_MT //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_WATER) then
    &fd100Status = fd100Status_RINSE_MT //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_CHEM) then
    &fd100Status = fd100Status_CIP_MT //Set Plant Status
   endif
   if (&fd100FillSource = fd100FillSource_MANCHEM) then
    &fd100Status = fd100Status_CIP_MT //Set Plant Status
   endif   
         
  default:
 endsel
ENDIF

// ************
// Step Actions
// ************
select &tempStepNum
 case fd100StepNum_RESET: //Powerup and Reset State
  &V1x_last = 0.0
  &R01_last = 1.0
  &R01 = 1.0
  
 case fd100StepNum_WAITINS: //Awaiting Instruction
  &V1x_last = 0.0
  &R01_last = 1.0
  &R01 = 1.0 
 
 case fd100StepNum_PB: //Awaiting Pushbutton
  &V1x_last = 0.0
  &R01_last = 1.0
  &R01 = 1.0 
  &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
  |fd100_IL01waiting = ON //PB01 LED Light To flash to incidate wait condition
  
 case fd100StepNum_END: //End wait for Acknowledgement from RPi
  &V1x_last = 0.0
  &R01_last = 1.0
  &R01 = 1.0   
  
 case fd100StepNum_FILL: //Production or CIP Chemical Wash - Fill Feedtank
  |fd100_fd100Fault_enable1 = ON
  |fd100_DV06en1 = ON //Energise If Fill Source is WATER  
  |fd100_IL01 = ON //PB01 LED Light
  |fd100_IV08en1 = ON //Energise If Fill Source is SITE and Level Low 
  |fd100_IV10en1 = ON //Energise If Fill Source is WATER and Level Low 
  |fd100_IV15 = ON //Seal Water
  |fd100_PC05so = ON //Open CV01 to enable recirc
 
 case fd100StepNum_MIX: //Production or CIP Chemical Wash - Mix Via Bypass Line
  if (|fd100Fault_fd100_Pause=OFF) then
   if (&fd100StepTimePre_MIX_s10 >= 0) then
    &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
   else
    &fd100StepTimeAcc_s10 = 0
    &fd100StepTimeAcc_m = 0
   endif 
  endif 
  |fd100_fd100Fault_enable1 = ON
  |fd100_DV06en1 = ON //Energise If Fill Source is WATER  
  |fd100_IL01 = ON //PB01 LED Light
  |fd100_IV08en1 = ON //Energise If Fill Source is SITE and Level Low 
  |fd100_IV10en1 = ON //Energise If Fill Source is WATER and Level Low 
  |fd100_IV15 = ON //Seal Water
  |fd100_PP01 = ON //Run Pump
  |fd100_DPC01so = ON //Set SP of HOF Filter Inlet Pressure Control Loop
  |fd100_PC01pidEn1 = ON //HOF Filter Inlet Pressure Control Loop
  |fd100_PC05so = ON //Open CV01 to enable recirc
  |fd100_fd102_chemdoseEn1 = ON //Dose Chemical If CIP


 case fd100StepNum_RECIRC: //Production or CIP Chemical Wash - Recirc through filter
  if (|fd100Fault_fd100_Pause=OFF) then
   if (&fd100StepTimePre_RECIRC_s10 >= 0) then
    &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
   else
    &fd100StepTimeAcc_s10 = 0
    &fd100StepTimeAcc_m = 0
   endif
   if (&fd100TimePre_RECIRC_s10  >= 0) then
    &fd100TimeAcc_RECIRC_s10 = &fd100TimeAcc_RECIRC_s10 + &lastScanTimeShort
   else
    &fd100TimeAcc_RECIRC_s10 = 0
    &fd100TimeAcc_RECIRC_m = 0
   endif
  endif 
  |fd100_fd100Fault_enable1 = ON
  |fd100_DV06en1 = ON //Energise If Fill Source is WATER  
  |fd100_IL01 = ON //PB01 LED Light
  |fd100_IV08en1 = ON //Energise If Fill Source is SITE and Level Low 
  |fd100_IV10en1 = ON //Energise If Fill Source is WATER and Level Low 
  |fd100_IV15 = ON //Seal Water
  |fd100_PP01 = ON //Run Pump
  |fd100_DPC01pidEn1 = ON //HOF Differential Pressure Control Loop
  |fd100_PC01pidEn1 = ON //HOF Inlet Pressure Control Loop
  |fd100_PC03pid = ON //Backwash Pressure Control Loop
  |fd100_PC05pidEn1 = ON //Trans Membrane Pressure Control Loop 
  |fd100_fd101_recirc = ON //Start Route Sequence
  |fd100_fd102_chemdoseEn1 = ON //Dose Chemical If CIP
  
    
 case fd100StepNum_CONC: //Production - Concentrate
  if (|fd100Fault_fd100_Pause=OFF) then
   if (&fd100TimePre_RECIRC_s10  >= 0) then
    &fd100TimeAcc_RECIRC_s10 = &fd100TimeAcc_RECIRC_s10 + &lastScanTimeShort
   else
    &fd100TimeAcc_RECIRC_s10 = 0
    &fd100TimeAcc_RECIRC_m = 0
   endif
  endif  
  |fd100_fd100Fault_enable1 = ON
  |fd100_DV04 = ON //Permeate To Site
  |fd100_DV06en1 = ON //Energise If Fill Source is WATER via CIP  
  |fd100_IL01 = ON //PB01 LED Light
  |fd100_IV07 = ON //Retentate To Site
  |fd100_IV08en1 = ON //Energise If Fill Source is SITE and Level Low   
  |fd100_IV10en1 = ON //Energise If Fill Source is WATER via CIP and Level Low  
  |fd100_IV15 = ON //Seal Water
  |fd100_PP01 = ON //Run Pump
  |fd100_DPC01pidEn1 = ON //HOF Differential Pressure Control Loop
  |fd100_PC01pidEn1 = ON //HOF Inlet Pressure Control Loop
  |fd100_PC03pid = ON //Backwash Pressure Control Loop
  |fd100_PC05pidEn1 = ON //Trans Membrane Pressure Control Loop
  |fd100_RC01pidEn1 = ON //Concetration Ratio Control Loop 
  |fd100_fd101_recirc = ON //Start Route Sequence

 case fd100StepNum_MT2SITE: //Production - Empty Feedtank To Site
  |fd100_fd100Fault_enable1 = ON
  |fd100_DV04 = ON //Permeate To Site  
  |fd100_IL01 = ON //PB01 LED Light
  |fd100_IV07 = ON //Retentate To Site 
  |fd100_IV15 = ON //Seal Water
  |fd100_PP01 = ON //Run Pump
  |fd100_DPC01pidEn1 = ON //HOF Differential Pressure Control Loop
  |fd100_PC01pidEn1 = ON //HOF Inlet Pressure Control Loop
  |fd100_PC03pid = ON //Backwash Pressure Control Loop
  |fd100_PC05pidEn1 = ON //Trans Membrane Pressure Control Loop
  |fd100_RC01pidEn1 = ON //Concetration Ratio Control Loop 
  |fd100_fd101_recirc = ON //Start Route Sequence 
   
 case fd100StepNum_MT2DRAIN: //Production or CIP Chemical Wash - Pump Feedtank To Drain
  |fd100_fd100Fault_enable1 = ON  
  |fd100_IL01 = ON //PB01 LED Light 
  |fd100_IV15 = ON //Seal Water
  |fd100_PP01 = ON //Run Pump 
  |fd100_PC01so = ON
  |fd100_fd101_drain = ON //Cycle Filter Valves to Drain
  &V1x_last = 0.0
  &R01_last = 1.0
  &R01 = 1.0  
  
 case fd100StepNum_DRAIN: //Production or CIP Chemical Wash - Empty Feedtank To Drain
  &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
  |fd100_fd101_drain = ON //Cycle Filter Valves to Drain   
  &V1x_last = 0.0
  &R01_last = 1.0
  &R01 = 1.0
     
 default:
endsel

//Step Timer Update Minutes when seconds greater than 59.9s
if (&fd100StepTimeAcc_s10 > 599) then
  &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 - 600
  &fd100StepTimeAcc_m = &fd100StepTimeAcc_m + 1
endif
if (&fd100StepTimeAcc_m > 32000) then
  &fd100StepTimeAcc_m = 32000
endif

//Productio Timer Update Minutes when seconds greater than 59.9s
if (&fd100TimeAcc_RECIRC_s10 > 599) then
  &fd100TimeAcc_RECIRC_s10 = &fd100TimeAcc_RECIRC_s10 - 600
  &fd100TimeAcc_RECIRC_m = &fd100TimeAcc_RECIRC_m + 1
endif
if (&fd100TimeAcc_RECIRC_m > 32000) then
  &fd100TimeAcc_RECIRC_m = 32000
endif


// *******************
// Fault Monitor Logic
// *******************

//Fault Checks
&OPmsg = &fd100Faultcmd_resetMsg
if (((|fd100Fault_PB01toRestart = ON)\
 and (&PB01State=PB01Pressed))\
 or (|fd100Fault_msg1 = OFF)) then
 &OPmsg = 0
endif

if (|fd100Fault_msg1 = ON) then
 IF (|PP01motFault = ON) THEN
  &OPmsg = 1
 ELSIF ((|fd100Fault_PB01toPause = ON) AND (&PB01State=PB01Pressed)) THEN
  &OPmsg = 2
 ELSIF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
  &OPmsg = 3
 ELSIF (|PS01_I = OFF) THEN
  &OPmsg = 4
 ELSIF (|PS02_I = OFF) THEN
  &OPmsg = 5
 ELSIF (|PS03_I = OFF) THEN
  &OPmsg = 6
 ELSIF ((|FS01_I = OFF) AND (|PP01out = ON)) THEN
  &OPmsg = 7
 ELSIF ((|fd100Fault_PB01toPause = ON) AND (&fd100cmdOns=fd100cmd_PAUSE)) THEN
  &OPmsg = 14       
 ENDIF
endif
&fd100Faultcmd_resetMsg = &OPmsg

//Selection From RPi
&fd100FaultcmdOns = &fd100Faultcmd 
&fd100Faultcmd = fd100Faultcmd_noAction

//Clear Sequence Outputs... these are then set on below
&fd100FaultProgOut01 = 0
//Step Transistions
&tempStepNum = &fd100FaultStepNum
select &tempStepNum 

 case fd100Fault_reset:
  IF (|fd100_fd100Fault_enable1 = ON) THEN
   &tempStepNum = fd100Fault_monitor1 
  ENDIF  

 case fd100Fault_monitor1:
  IF (|fd100_fd100Fault_enable1 = OFF) THEN
   &tempStepNum = fd100Fault_reset 
  ENDIF
  IF (&fd100Faultcmd_resetMsg > 0) THEN
   &tempStepNum = fd100Fault_action1 
  ENDIF  

 case fd100Fault_action1:
  IF (|fd100_fd100Fault_enable1 = OFF) THEN
   &tempStepNum = fd100Fault_reset 
  ENDIF
  IF ((&fd100Faultcmd_resetMsg = 0) AND (&PB01State=PB01Pressed)) THEN
   &tempStepNum = fd100Fault_monitor1 
  ENDIF 

 default:
  &tempStepNum = fd100Fault_reset

endsel

//Step Ons Actions
IF (&tempStepNum != &fd100FaultStepNum) THEN
 &fd100FaultStepNum = &tempStepNum 
 select &tempStepNum
  case fd100Fault_reset:
  case fd100Fault_monitor1:
  case fd100Fault_action1:         
  default:
 endsel
ENDIF

//Step Actions
select &tempStepNum
 case fd100Fault_reset:
 
 case fd100Fault_monitor1:
  |fd100Fault_msg1 = ON
  |fd100Fault_PB01toPause = ON

 case fd100Fault_action1:
  |fd100Fault_IL01fault = ON //PB01 LED Light To flash to incidate fault 
  |fd100Fault_msg1 = ON
  |fd100Fault_PB01toRestart = ON  
  |fd100Fault_PP01pause = ON
  |fd100Fault_DPC01pidHold = ON
  |fd100Fault_PC01pidHold = ON
  |fd100Fault_PC05pidHold = ON
  |fd100Fault_RC01pidHold = ON
  |fd100Fault_fd100_Pause = ON
  |fd100Fault_fd101_Pause = ON
  |fd100Fault_fd102_Pause = ON
           
 default:
 
endsel

 



