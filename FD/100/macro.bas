// FD100 Main Sequence

// This sequence is responsible for the main state of the plant.  For
// example: mixing, recirculating, concentrating.

// When the plant is in the Recirc state, both the retentate and
// permeate lines are returned to the main tank.  This state fills the
// membrane and associated piping with liquid.

// This file is broken up into four main parts: initialisation, the
// step transitions, the one-shot actions, and the step actions that
// happen every scan.

// Fault checking for a given selection can be found at the top of this 
// file.  The code for fault checking while running can be found at the 
// very bottom.



// Clear Sequence Outputs.  These registers are used to hold bit-wise
// values such as whether pump PP01 should be turned on.  By setting
// these registers to zero, all those bits are cleared in each scan,
// meaning that the code below need only set each bit on if required.
// The declaration for each bit can be found in _USER_MEMORY.bas.
&fd100ProgOut01 = 0 
&fd100ProgOut02 = 0


// *******************
// Timer-based logging
// *******************

// If we're in any state other than "awaiting command", then check to
// see if we want to do a timer-based log
if &fd100StepNum != fd100StepNum_WAIT_INSTRUCTION then
  // If the logging timer is enabled (i.e. has a positive value) then 
  // increment it and check if we're ready to log  
  if &fd100LogTimePre_s10 >= 0 then
    // Timer is enabled, increment it
    &fd100LogTimeAcc_s10 = &fd100LogTimeAcc_s10 + &lastScanTimeShort
    // Check if it's time to log
    if &fd100LogTimeAcc_m >= &fd100LogTimePre_m\
    and &fd100LogTimeAcc_s10 >= &fd100LogTimePre_s10 then
      // Log timer-based event
      gosub logTimerEvent
      // Reset timer
      &fd100LogTimeAcc_m = 0
      &fd100LogTimeAcc_s10 = 0
    endif
  endif
endif


// Check if the push button PB01 has been pressed for two sequential scans
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


// *****************************
// Fault checking for selections
// *****************************

// If fault checking is disabled, then set the selection messages to 0, meaning
// there is no fault detected.
if &fd100FaultStepNum = fd100Fault_disabled then
  // Faults are disabled
  &fd100cmd_run_none_msg = 0
  &fd100cmd_run_site_msg = 0
  &fd100cmd_run_auto_chem_msg = 0
  &fd100cmd_run_water_msg = 0
  &fd100cmd_run_store_msg = 0
  
  &fd100cmd_waste_msg = 0
  &fd100cmd_store_msg = 0

else
  // Faults are enabled

  // Check for faults that would inhibit the selection of running with 
  // 'fill source: none'
  &OPmsg = 0
  IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
    // Emergency stop is pressed
    &OPmsg = 3
  ELSIF (|PS01_I = OFF) THEN
    // No water pressure
    &OPmsg = 4
  ELSIF (|PS02_I = OFF) THEN
    // No high-pressure air
    &OPmsg = 5
  ELSIF (|PS03_I = OFF) THEN
    // No low-pressure air
    &OPmsg = 6
  elsif &fd100FeedTankState != fd100TankState_NOT_EMPTY then
    // Feed tank may be empty and we're not filling from any source
    &OPmsg = 30
  ENDIF
  &fd100cmd_run_none_msg = &OPmsg


  // Check for faults that would inhibit the selection of running with 
  // 'fill from site'
  &OPmsg = 0
  IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
    &OPmsg = 3
  ELSIF (|PS01_I = OFF) THEN
    &OPmsg = 4
  ELSIF (|PS02_I = OFF) THEN
    &OPmsg = 5
  ELSIF (|PS03_I = OFF) THEN
    &OPmsg = 6
  elsif &fd100FeedTankContents != fd100TankContents_PROD\
  and &fd100FeedTankContents != fd100TankContents_CLEAN then
    // The contents of the feed tank are neither product nor clean 
    if &fd100FeedTankContents = fd100TankContents_WATER\
    and &fd100FeedTankState = fd100TankState_EMPTY then
      // The feed tank's contents are empty water, good enough for clean so
      // don't worry
    else
      // Whatever's in the tank isn't ok for the addition of product 
      &OPmsg = 26
    endif
  ENDIF
  &fd100cmd_run_site_msg = &OPmsg


  // Check for faults that would inhibit running with the selection of 
  // automatically-dosed chemcial
  &OPmsg = 0
  IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
    &OPmsg = 3
  ELSIF (|PS01_I = OFF) THEN
    &OPmsg = 4
  ELSIF (|PS02_I = OFF) THEN
    &OPmsg = 5
  ELSIF (|PS03_I = OFF) THEN
    &OPmsg = 6
  elsif &fd100FeedTankContents != fd100TankContents_AUTO_CHEM\
  and &fd100FeedTankContents != fd100TankContents_CLEAN then
    // The contents of the feed tank are not auto-chem and not clean 
    if &fd100FeedTankContents = fd100TankContents_WATER\
    and &fd100FeedTankState = fd100TankState_EMPTY then
      // The feed tank's contents are empty water, good enough for clean so
      // don't worry
    else
      // Whatever's in the tank isn't ok for the addition of auto-chemical 
      &OPmsg = 27
    endif
  ENDIF
  &fd100cmd_run_auto_chem_msg = &OPmsg


  // Check for faults that would inhibit running with the selection of water
  &OPmsg = 0
  IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN  //ESTOP
    &OPmsg = 3
  ELSIF (|PS01_I = OFF) THEN  //Water Pressure
    &OPmsg = 4
  ELSIF (|PS02_I = OFF) THEN  //High Pressure Air
    &OPmsg = 5
  ELSIF (|PS03_I = OFF) THEN  //High Low Air
    &OPmsg = 6
  elsif &fd100FeedTankContents != fd100TankContents_RINSE\
  and &fd100FeedTankContents != fd100TankContents_WATER\
  and &fd100FeedTankContents != fd100TankContents_CLEAN then
    // The contents of the feed tank are not rinse water, nor water nor clean
    if &fd100FeedTankState = fd100TankState_EMPTY then
      // The feed tank's contents are empty so don't worry

    elsif &fd100FeedTankContents = fd100TankContents_MAN_CHEM then
      // It's ok to add water to manual chemicals 

    else
      // Whatever's in the tank isn't ok for the addition of water 
      &OPmsg = 28
    endif
  ENDIF
  &fd100cmd_run_water_msg = &OPmsg


  // Check for faults that would inhibit the selection of running with 
  // 'fill source: storage tank'
  &OPmsg = 0
  IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
    // Emergency stop is pressed
    &OPmsg = 3
  ELSIF (|PS01_I = OFF) THEN
    // No water pressure
    &OPmsg = 4
  ELSIF (|PS02_I = OFF) THEN
    // No high-pressure air
    &OPmsg = 5
  ELSIF (|PS03_I = OFF) THEN
    // No low-pressure air
    &OPmsg = 6
  elsif &fd100StorageTankState != fd100TankState_NOT_EMPTY then
    // Storage tank may be empty while trying to fill from storage tank
    &OPmsg = 25
  elsif &fd100StorageTankContents != &fd100FeedTankContents then
    // The storage tank and feed tank's contents are not the same
    if &fd100FeedTankContents = fd100TankContents_CLEAN then
      // The feed tank's clean, all good

    elsif &fd100FeedTankContents = fd100TankContents_WATER\
    and &fd100FeedTankState = fd100TankState_EMPTY then
      // The feed tank's empty of clean water, which is good enough for clean,
      // all good
      
    elsif &fd100FeedTankState = fd100TankState_EMPTY\
    and (&fd100StorageTankContents = fd100TankContents_WATER\
         or &fd100StorageTankContents = fd100TankContents_RINSE) then  
      // We're going to rinse out the feed tnk with the storage tank
      // all good
      
    else
      // Whatever we're trying to do, it's not ok  
      &OPmsg = 29
    endif
  ENDIF
  &fd100cmd_run_store_msg = &OPmsg


  // Check for faults that would inhibit the selection of 'send to waste'
  &OPmsg = 0
  IF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN //ESTOP
    &OPmsg = 3
  ENDIF
  &fd100cmd_waste_msg = &OPmsg


  // Check for faults that would inhibit the selection of 'send to store'
  &OPmsg = 0
  if ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) then
    // Emergency stop is pressed  
    &OPmsg = 3
  elsif &fd100StorageTankContents != &fd100FeedTankContents then
    // The storage tank and feed tank's contents are not the same
    if &fd100StorageTankContents = fd100TankContents_CLEAN then
      // The storage tank's clean, all good

    elsif &fd100StorageTankContents = fd100TankContents_WATER\
    and &fd100StorageTankState = fd100TankState_EMPTY then
      // The storage tank's empty of clean water, which is good enough for clean,
      // all good
      
    elsif &fd100StorageTankState = fd100TankState_EMPTY\
    and (&fd100FeedTankContents = fd100TankContents_WATER\
         or &fd100FeedTankContents = fd100TankContents_RINSE) then  
      // We're going to rinse out the storage tank with the feed tank
      // all good
      
    else
      // Whatever we're trying to do, it's not ok  
      &OPmsg = 29
    endif
  endif
  &fd100cmd_store_msg = &OPmsg


  // Check for faults that would inhibit the selection of 'store to waste'
  &OPmsg = 0
  if ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) then
    // Emergency stop is pressued
    &OPmsg = 3
  elsif (|PS02_I = OFF) then
    // No high-pressure air
    &OPmsg = 5
  endif
  &fd100cmd_store_to_waste_msg = &OPmsg


endif



// Process the instruction.  For the given instruction, check that there are no
// faults detected.  If we're all good to go, copy the instruction into the one-shot
// variable.
select &fd100cmd 

  case  fd100cmd_RUN:
    if &fd100FillSource = fd100FillSource_SITE and &fd100cmd_run_site_msg = 0 then
      // We want to run filling from site and there aren't any problems with this
      &fd100cmdOns = &fd100cmd
    elsif &fd100FillSource = fd100FillSource_NONE and &fd100cmd_run_none_msg = 0 then
      // We want to run but not fill the tank, and there aren't any problem with this
      &fd100cmdOns = &fd100cmd
    elsif &fd100FillSource = fd100FillSource_AUTO_CHEM and &fd100cmd_run_auto_chem_msg = 0 then
      // We want to run filling with automatically-dosed chemical, and there aren't any problem with this
      &fd100cmdOns = &fd100cmd
    elsif &fd100FillSource = fd100FillSource_WATER and &fd100cmd_run_water_msg = 0 then
      // We want to run filling with water, and there aren't any problem with this
      &fd100cmdOns = &fd100cmd
    elsif &fd100FillSource = fd100FillSource_STORAGE_TANK and &fd100cmd_run_store_msg = 0 then
      // We want to run filling from the storage tank and there aren't any problems with this
      &fd100cmdOns = &fd100cmd 
    endif
  

  case  fd100cmd_WASTE:
    if (&fd100cmd_waste_msg = 0) then
      &fd100cmdOns = &fd100cmd
    endif
  

  case  fd100cmd_STORE:
    if (&fd100cmd_store_msg = 0) then
      &fd100cmdOns = &fd100cmd
    endif


  case  fd100cmd_STORE_TO_WASTE:
    if (&fd100cmd_store_to_waste_msg = 0) then
      &fd100cmdOns = &fd100cmd
    endif
  

  default:
    &fd100cmdOns = &fd100cmd

endsel
 
&fd100cmd = fd100cmd_NONE



// ******************
// Step Transisitions
// ******************


&tempStepNum = &fd100StepNum
select &tempStepNum

  case  fd100StepNum_RESET: //*** Powerup and Reset State
    &tempStepNum = fd100StepNum_WAIT_INSTRUCTION


  case fd100StepNum_WAIT_INSTRUCTION: //*** Awaiting Instruction From RPi
    if (&fd100cmdOns=fd100cmd_AWAIT_PUSH_BUTTON) then
      &tempStepNum = fd100StepNum_WAIT_PUSH_BUTTON 

    elsif (&fd100cmdOns=fd100cmd_RUN) then
      &tempStepNum = fd100StepNum_FILL 
    
    elsif &fd100cmdOns=fd100cmd_WASTE then
      &tempStepNum = fd100StepNum_PUMP_TO_WASTE 
    
    elsif &fd100cmdOns=fd100cmd_STORE then
      &tempStepNum = fd100StepNum_PUMP_TO_STORE 

    elsif &fd100cmdOns=fd100cmd_STORE_TO_WASTE then
      &tempStepNum = fd100StepNum_DRAIN_STORE_TO_WASTE 
    endif

    // If we're changing states, start the logging timer
    if &tempStepNum != fd100StepNum_WAIT_INSTRUCTION then
      &fd100LogTimeAcc_s10 = 0
      &fd100LogTimeAcc_m = 0
    endif
   
 
 case fd100StepNum_WAIT_PUSH_BUTTON: //*** Awaiting Start From Pushbutton
   IF (&PB01State=PB01Pressed) THEN
     // Log the start event
     &EventID = EventID_STARTED
     force_log
     &EventID = EventID_NONE

     // Move to END state to signal that the pushbutton has been pressed, 
     // and we're ready to go to the next step
     &tempStepNum = fd100StepNum_END 
   ENDIF
   //If Stop Command from RPi then go back to waiting for new instruction  
   IF (&fd100cmdOns=fd100cmd_STOP) THEN
     gosub logStopEvent
     &tempStepNum = fd100StepNum_WAIT_INSTRUCTION 
   ENDIF
   //If PB01 not push within a time period go back to waiting for new instruction
   IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_PB_m) AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_PB_s10)) THEN
     &tempStepNum = fd100StepNum_WAIT_INSTRUCTION  
   ENDIF
   gosub abortOnRequest
 
  
  case fd100StepNum_END: //Wait for ACK from RPi
    //If Ack Command from RPi then go back to waiting for new instruction  
    IF (&fd100cmdOns=fd100cmd_ACK) THEN
      &tempStepNum = fd100StepNum_WAIT_INSTRUCTION 
    ENDIF
    //If Stop Command from RPi then go back to waiting for new instruction  
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_WAIT_INSTRUCTION 
    ENDIF
    //If Abort Command from RPi then go back to waiting for new instruction  
    gosub abortOnRequest


  case fd100StepNum_FILL: //Fill Feedtank
    if &fd100FillSource = fd100FillSource_STORAGE_TANK then
      // We're filling from the storage tank    
      if &LT01_100 >= 10000 then // 10000 = 100% full
        // The tank is 100% full, so go to Mixing
        &tempStepNum = fd100StepNum_MIX 
      elsif &LT01_100 > (&LT01SP03 + &LT01SP04)\
      and &fd100StorageTankState = fd100TankState_EMPTY then
        // We've put enough in the feed tank and the storage tank is empty
        // so head to Mixing
        &tempStepNum = fd100StepNum_MIX 
      endif
    else
      // We're filling from something other than the storage tank
      if &LT01_100 > (&LT01SP03 + &LT01SP04) then
        // Feedtank is at the desired fill level, so go to Mixing
        &tempStepNum = fd100StepNum_MIX 
      endif
    endif

    // If we've been asked to stop, go to End
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_END 
    ENDIF

    // Abort if we've been asked to do so
    gosub abortOnRequest


  case fd100StepNum_MIX: //Mix Via Bypass Line
    // Stop Recirculation if level drops too low. 
    IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
      &tempStepNum = fd100StepNum_FILL 
    ENDIF
    // Mix Time Before Recirculating through HOF
    IF &fd100StepTimeAcc_m >= &fd100StepTimePre_MIX_m\
    AND &fd100StepTimeAcc_s10 >= &fd100StepTimePre_MIX_s10\
    AND &fd100StepTimePre_MIX_s10 >= 0\
    AND |fd102_fd100_dosingChem=OFF\
    AND (    (&fd100Temperature = fd100Temperature_HEAT AND &TT01_100 > &TT01SP01)\
          OR (&fd100Temperature = fd100Temperature_COOL AND &TT01_100 < &TT01SP01)\
          OR (&fd100Temperature = fd100Temperature_NONE)\
        ) THEN
      &tempStepNum = fd100StepNum_RECIRC  
    ENDIF
    // Stop Production or CIP Chemical Wash  
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_END 
    ENDIF
    gosub abortOnRequest


  // Recirculate the product.  Thus, the retentate and permeate are returned
  // to the feed tank.  A useful state to fill the membrane pipework (note a 
  // direction change is required to fill the pipes completely).  Used for
  // experiments and for cleaning.
  case fd100StepNum_RECIRC:
    // Stop Recirculation if level drops too low. 
    IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
      &tempStepNum = fd100StepNum_FILL 
    ENDIF

    // Stop Recirculation and return to Mix if dosing Chemical. 
    IF (|fd102_fd100_dosingChem=ON) THEN
      &tempStepNum = fd100StepNum_MIX 
    ENDIF

    // Recirculation time before concentrating through membrane
    // Set _s10 to a negative value to stay in this state.
    IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_RECIRC_m)\
    AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_RECIRC_s10)\
    AND (&fd100StepTimePre_RECIRC_s10 >= 0)) THEN
      // We've spent our time recirculating, go to concentrating
      &tempStepNum = fd100StepNum_CONC  
    ENDIF

    // Total membrane-use time before stopping
    // Set _s10 to a negative value to ignore
    IF ((&fd100TimeAcc_MembraneUse_m >= &fd100TimePre_MembraneUse_m)\
    AND (&fd100TimeAcc_MembraneUse_s10 >= &fd100TimePre_MembraneUse_s10)\
    AND (&fd100TimePre_MembraneUse_s10 >= 0)) THEN
      &tempStepNum = fd100StepNum_END  
    ENDIF  

    // Check if we've been asked to stop  
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      &tempStepNum = fd100StepNum_END 
    ENDIF
    
    // Check if we've been asked to abort
    gosub abortOnRequest


//  // Optionally used in cleaning to clear out the retentate and permeate lines 
//  // (blasting them clean by opening the isolation valves and the control valves)
//  case fd100StepNum_BLAST:  
//    // Stop if level drops too low. 
//    IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
//      &tempStepNum = fd100StepNum_FILL 
//    ENDIF
//
//    // Blast duration, set to zero to skip this state entirely.  Set to a 
//    // negative value to stay in this step until the membrane-use timer expires
//    IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_BLAST_m)\
//    AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_BLAST_s10)\
//    AND (&fd100StepTimePre_BLAST_s10 >= 0)) THEN
//      &tempStepNum = fd100StepNum_CONC  
//    ENDIF
//
//    // Total membrane-use time before stopping
//    // Set _s10 to a negative value to ignore
//    IF ((&fd100TimeAcc_MembraneUse_m >= &fd100TimePre_MembraneUse_m)\
//    AND (&fd100TimeAcc_MembraneUse_s10 >= &fd100TimePre_MembraneUse_s10)\
//    AND (&fd100TimePre_MembraneUse_s10 >= 0)) THEN
//      &tempStepNum = fd100StepNum_END  
//    ENDIF  
//
//    // Check if we've been asked to stop  
//    IF (&fd100cmdOns=fd100cmd_STOP) THEN
//      &tempStepNum = fd100StepNum_END 
//    ENDIF
//
//    // Check if we've been asked to abort
//    gosub abortOnRequest


  
  // Concentrate state.  The permeate and retentate lines no longer return to
  // the feed tank.
  case  fd100StepNum_CONC:
    // Stop Concentration if level drops too low. 
    IF (&LT01_100 < (&LT01SP03 - &LT01SP04)) THEN
      &tempStepNum = fd100StepNum_FILL 
    ENDIF

    // Total membrane-use time before stopping
    // Set _s10 to a negative value to ignore
    IF ((&fd100TimeAcc_MembraneUse_m >= &fd100TimePre_MembraneUse_m)\
    AND (&fd100TimeAcc_MembraneUse_s10 >= &fd100TimePre_MembraneUse_s10)\
    AND (&fd100TimePre_MembraneUse_s10 >= 0)) THEN
      &tempStepNum = fd100StepNum_CONC_TILL_EMPTY  
    ENDIF  

    // Check if we've been asked to stop  
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_CONC_TILL_EMPTY 
    ENDIF

    // Check if we've been asked to abort
    gosub abortOnRequest

   

  case fd100StepNum_CONC_TILL_EMPTY: //Production - Empty Feedtank To Site
    //Feed Tank Reached Min Level. 
    IF (&LT01_100 < &LT01SP05) THEN
      &tempStepNum = fd100StepNum_END
    ENDIF
    gosub abortOnRequest
    

  case fd100StepNum_PUMP_TO_WASTE: //Production or CIP Chemical Wash - Pump Feedtank To Drain
    // If we don't have water pressure then we head straight to draining
    if (|PS01_I = OFF) then
      // No water pressure
      &tempStepNum = fd100StepNum_DRAIN_TO_WASTE      
    endif

    //Feed Tank Reached Empty Level. 
    IF (&LT01_100 < &LT01SP06) THEN
      &tempStepNum = fd100StepNum_DRAIN_TO_WASTE
    ENDIF
    gosub abortOnRequest
  

  case fd100StepNum_DRAIN_TO_WASTE: //Production or CIP Chemical Wash - Drain Plant
    // If we've spent enough time here, we head off to the End
    IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_DRAIN_m)\
    AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_DRAIN_s10)) THEN
      &tempStepNum = fd100StepNum_END  
    ENDIF

    // Check if we've been asked to stop    
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_END 
    ENDIF

    gosub abortOnRequest
  

  case fd100StepNum_PUMP_TO_STORE: //Production or CIP Chemical Wash - Pump Feedtank To Drain
    // If we don't have water pressure then we head straight to draining
    if (|PS01_I = OFF) then
      // No water pressure
      &tempStepNum = fd100StepNum_DRAIN_TO_STORE      
    endif

    //Feed Tank Reached Empty Level. 
    IF (&LT01_100 < &LT01SP06) THEN
      &tempStepNum = fd100StepNum_DRAIN_TO_STORE
    ENDIF
    gosub abortOnRequest
  

  case fd100StepNum_DRAIN_TO_STORE: //Production or CIP Chemical Wash - Drain Plant
    //Drain Plant Time
    IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_DRAIN_m)\
    AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_DRAIN_s10)) THEN
      &tempStepNum = fd100StepNum_END  
    ENDIF

    // Check if we've been asked to stop    
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_END 
    ENDIF

    gosub abortOnRequest
   

  case fd100StepNum_DRAIN_STORE_TO_WASTE:
    // If we've spent enough time here, we head off to the End
    IF ((&fd100StepTimeAcc_m >= &fd100StepTimePre_DRAIN_m)\
    AND (&fd100StepTimeAcc_s10 >= &fd100StepTimePre_DRAIN_s10)) THEN
      &tempStepNum = fd100StepNum_END  
    ENDIF

    // Check if we've been asked to stop    
    IF (&fd100cmdOns=fd100cmd_STOP) THEN
      gosub logStopEvent
      &tempStepNum = fd100StepNum_END 
    ENDIF

    gosub abortOnRequest


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
      // Reset FT02's over-max-flow timer
      &FT02_OverMaxFlowTimeAcc_s10 = 0
      &FT02_OverMaxFlowTimeAcc_m = 0

      // Reset FT03's over-max-flow timer
      &FT03_OverMaxFlowTimeAcc_s10 = 0
      &FT03_OverMaxFlowTimeAcc_m = 0
  

    case fd100StepNum_WAIT_INSTRUCTION: //Awaiting Instruction
      &fd100TimeAcc_MembraneUse_s10 = 0
      &fd100TimeAcc_MembraneUse_m = 0
  
      // Disable timer-based logging while awaiting instruction
      &fd100LogTimeAcc_s10 = -10


    case fd100StepNum_WAIT_PUSH_BUTTON: //Awaiting Pushbutton
  

    case fd100StepNum_END: //End wait for Acknowledgement from RPi  
      // Log the fact that we've finished whatever we were doing
      &EventID = EventID_FINISHED
      force_log
      &EventID = EventID_NONE   
  

    case fd100StepNum_FILL: //Production or CIP Chemical Wash - Fill Feedtank
      // Log the fact that filling's started
      &EventID = EventID_FILLING_STARTED
      force_log
      &EventID = EventID_NONE
   
      &PC05cv=&PC05cv01 //Open CV01 to enable recirc
      &fd100_LT01max = 0 
      
      // Set plant status based on fill source
      if (&fd100FillSource = fd100FillSource_NONE) then
        // We're not filling so don't change the current state

      elsif (&fd100FillSource = fd100FillSource_SITE) then
        // Filling with product
        &fd100FeedTankState = fd100TankState_NOT_EMPTY
        &fd100FeedTankContents = fd100TankContents_PROD

      elsif (&fd100FillSource = fd100FillSource_WATER) then
        // Filling with water
        &fd100FeedTankState = fd100TankState_NOT_EMPTY

        if &fd100FeedTankContents = fd100TankContents_CLEAN then
          // We're adding water to a clean tank
          &fd100FeedTankContents = fd100TankContents_WATER
        elsif &fd100FeedTankContents = fd100TankContents_WATER then
          // We're adding water to water, no change required
        elsif &fd100FeedTankContents = fd100TankContents_RINSE then
          // We're adding water to rinse water, all ok
        else
          // We're adding water to something else
          if &fd100FeedTankState = fd100TankState_EMPTY then
            // Feed tank's empty, thus the result of the combination is rinse water
            &fd100FeedTankContents = fd100TankContents_RINSE
          else
            // Feed tank's not empty, thus the resulting combination is unknown
            &fd100FeedTankContents = fd100TankContents_UNKNOWN
          endif
        endif          

      elsif (&fd100FillSource = fd100FillSource_AUTO_CHEM) then
        // Filling with automatically-dosed chemical
        &fd100FeedTankState = fd100TankState_NOT_EMPTY
        &fd100FeedTankContents = fd100TankContents_AUTO_CHEM

      elsif (&fd100FillSource = fd100FillSource_STORAGE_TANK) then
        // We've moving the contents of the storage tank to the feed tank,
        // so just copy the feed tank's status
        &fd100FeedTankState = fd100TankState_NOT_EMPTY
        &fd100FeedTankContents = &fd100StorageTankContents
      endif   


    case fd100StepNum_MIX: //Production or CIP Chemical Wash - Mix Via Bypass Line
      // Log the fact that mixing's started
      &EventID = EventID_MIXING_STARTED
      force_log
      &EventID = EventID_NONE

      &DPC01cv=&DPC01cv01 // Set PC01sp to control the speed of the Main Feed Pump
      &PC01cv=&PC01cv01   // Set Initial the speed of the Main Feed Pump      


    case fd100StepNum_RECIRC: //Production or CIP Chemical Wash - Recirc through filter
      // Log the fact that recirc's started
      &EventID = EventID_RECIRC_STARTED
      force_log
      &EventID = EventID_NONE

      // Set up the PID controllers for Recirc 
      &DPC01spRampTarget = &DPC01sp01
      &PC05spRampTarget  = &PC05sp01
      &PC03spRampTarget  = &PC03sp01 // Backwash target pressure 
      &PC03cv            = &PC03cv01 // Backwash's starting position
    

//    case fd100StepNum_BLAST:
//      // Log the fact that Blast's started
//      &EventID = EventID_BLAST_STARTED
//      force_log
//      &EventID = EventID_NONE
      



    case fd100StepNum_CONC: //Production - Concentrate
      // Log the fact that recirc's started
      &EventID = EventID_CONC_STARTED
      force_log
      &EventID = EventID_NONE

      &RC01cv           = &RC01cv01 //Concentration Ratio Starting Value
      &RC01spRampTarget = &RC01sp01 //Concentration Ratio
   

    case fd100StepNum_CONC_TILL_EMPTY: //Production - Empty Feedtank To Site
      // Log the fact that we've started emptying to site
      &EventID = EventID_MT2SITE_STARTED
      force_log
      &EventID = EventID_NONE
  

    case fd100StepNum_PUMP_TO_WASTE: //Production or CIP Chemical Wash - Pump Feedtank To Drain 
      // Log the fact that we've started pumping to drain
      &EventID = EventID_MT2WASTE_STARTED
      force_log
      &EventID = EventID_NONE

      &PC01cv=&PC01cv02
   

    case fd100StepNum_DRAIN_TO_WASTE: //Production or CIP Chemical Wash - Empty Feedtank To Drain
      // Log the fact that we've started passive draining
      &EventID = EventID_DRAIN2WASTE_STARTED
      force_log
      &EventID = EventID_NONE

      // Change feed tank status to empty
      &fd100FeedTankState = fd100TankState_EMPTY



    case fd100StepNum_PUMP_TO_STORE: //Production or CIP Chemical Wash - Pump Feedtank To Drain 
      // Log the fact that we've started passive draining
      &EventID = EventID_MT2STORE_STARTED
      force_log
      &EventID = EventID_NONE

      &PC01cv=&PC01cv02
   
      // Update storage tank's contents based on current contents and feed
      // tank's contents
      if &fd100StorageTankContents = fd100TankContents_CLEAN then
        // The storage tank's clean, so we copy whatever's in the feed tank
        &fd100StorageTankContents = &fd100FeedTankContents

      elsif &fd100StorageTankContents = &fd100FeedTankContents then
        // The contents of the storage tank and the feed tank are the same,
        // do nothing
      
      elsif &fd100StorageTankContents = fd100TankContents_MAN_CHEM\
      and &fd100FeedTankContents = fd100TankContents_WATER then
        // The contents of the storage tank are manual chemical to which we are
        // adding water, so the storage tank's contents have not changed

      elsif &fd100StorageTankState = fd100TankState_EMPTY\
      and &fd100FeedTankContents = fd100TankContents_WATER then
        // The storage tank's empty and we're adding water, so the result is
        // rinse water
        &fd100StorageTankContents = fd100TankContents_RINSE
      
      elsif &fd100StorageTankState = fd100TankState_EMPTY\
      and &fd100FeedTankContents = fd100TankContents_RINSE then
        // The storage tank's empty and we're adding rinse-water, so the result 
        // is rinse water
        &fd100StorageTankContents = fd100TankContents_RINSE
             
      else
        // None of the previous tests have passed, so we're probably not 
        // supposed to be here     
        &fd100StorageTankContents = fd100TankContents_UNKNOWN
      endif 



      // Update storage tank's state based on current state and feed tank's state
      if &fd100StorageTankState = fd100TankState_EMPTY then
        // The storage tank was empty
        if &fd100FeedTankState = fd100TankState_NOT_EMPTY then
          // But the feed tank was not empty, so the storage tank is no longer
          // empty 
          &fd100StorageTankState = fd100TankState_NOT_EMPTY
        endif
      endif
      if &fd100FeedTankState = fd100TankState_UNKNOWN then
        // The feed tank's state is unknown, thus the storage tank's state also
        // becomes unknown 
        &fd100StorageTankState = fd100TankState_UNKNOWN 
      endif
      // Note in all other cases the storage tank's state remains the same



    case fd100StepNum_DRAIN_TO_STORE: //Production or CIP Chemical Wash - Empty Feedtank To Drain
      // Log the fact that we've started passive draining
      &EventID = EventID_DRAIN2STORE_STARTED
      force_log
      &EventID = EventID_NONE

      // Change feed tank status to empty
      &fd100FeedTankState = fd100TankState_EMPTY


    case fd100StepNum_DRAIN_STORE_TO_WASTE:
      // Log the fact that we've started passive draining of the storage tank
      &EventID = EventID_DRAIN_STORE_TO_WASTE_STARTED
      force_log
      &EventID = EventID_NONE

      // Change feed tank status to empty
      &fd100StorageTankState = fd100TankState_EMPTY
    

         
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
  

  case fd100StepNum_WAIT_INSTRUCTION: //Awaiting Instruction
    &V1x_last = 0.0
    &R01_last = 1.0
    &R01 = 1.0 
  

  case fd100StepNum_WAIT_PUSH_BUTTON: //Awaiting Pushbutton
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
    // Increment step timer while we haven't added more than one percentage 
    // point to the feed tank level  
    if ((&LT01_100 <= &fd100_LT01max + 100) AND (|fd100Fault_fd100_Pause=OFF)) then // 100 = 1%
      &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort

      if &fd100StepTimeAcc_m >= &fd100StepTimePre_FILL_m\
      and &fd100StepTimeAcc_s10 >= &fd100StepTimePre_FILL_s10 then
        // We've spent too much time and haven't incremented the feed tank more 
        // than one percentage point, so the storage tank must be empty
        &fd100StorageTankState = fd100TankState_EMPTY
      endif

    else
      &fd100_LT01max = &LT01_100
      &fd100StepTimeAcc_s10 = 0
      &fd100StepTimeAcc_m = 0
    endif 

    |fd100_fd100Fault_enable1 = ON
    |fd100_fd100Fault_FILL = ON // Enable during-fill faults
    |fd100_DV06en1 = ON // Energise if fill source is WATER  
    |fd100_IL01 =    ON // PB01 LED Light
    |fd100_IV08en1 = ON // Energise if fill source is SITE and level low 
    |fd100_IV10en1 = ON // Energise if fill source is WATER and level low 
    |fd100_IV15 =    ON // Seal Water
    |fd100_PP03en1 = ON // Fill from Storage Tank 
    |fd100_PC05so =  ON // Open CV01 to enable recirc
 

  case fd100StepNum_MIX: //Production or CIP Chemical Wash - Mix Via Bypass Line
    if (|fd100Fault_fd100_Pause=OFF) then
      if (&fd100StepTimePre_MIX_s10 >= 0) then // Set to a negative value to disable 
        &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
      else
        &fd100StepTimeAcc_s10 = 0
        &fd100StepTimeAcc_m = 0
      endif 
    endif 
    |fd100_fd100Fault_enable1 = ON
    |fd100_DV06en1 = ON        // Energise if Fill Source is WATER  
    |fd100_IL01 = ON           // PB01 LED Light
    |fd100_IV08en1 = ON        // Energise if Fill Source is SITE and Level Low 
    |fd100_IV10en1 = ON        // Energise if Fill Source is WATER and Level Low 
    |fd100_IV15 = ON           // Seal Water
    |fd100_PP01 = ON           // Run Pump
    |fd100_DPC01so = ON        // Set SP of HOF Filter Inlet Pressure Control Loop
    |fd100_PC01pidEn1 = ON     // HOF Filter Inlet Pressure Control Loop
    |fd100_PC05so = ON         // Open CV01 to enable recirc
    |fd100Temperatureen1 = ON  // Cool or Heat As Selected
    |fd100_fd102_chemdoseEn1 = ON // Dose Chemical if CIP


  case fd100StepNum_RECIRC: //Production or CIP Chemical Wash - Recirc through filter
    if (|fd100Fault_fd100_Pause=OFF) then
      if (&fd100StepTimePre_RECIRC_s10 >= 0) then
        &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
      else
        &fd100StepTimeAcc_s10 = 0
        &fd100StepTimeAcc_m = 0
      endif
      if (&fd100TimePre_MembraneUse_s10  >= 0) then
        &fd100TimeAcc_MembraneUse_s10 = &fd100TimeAcc_MembraneUse_s10 + &lastScanTimeShort
      else
        &fd100TimeAcc_MembraneUse_s10 = 0
        &fd100TimeAcc_MembraneUse_m = 0
      endif
    endif 
    |fd100_fd100Fault_enable1 = ON
    |fd100_DV06en1 = ON           // Energise If Fill Source is WATER  
    |fd100_IL01 = ON              // PB01 LED Light
    |fd100_IV08en1 = ON           // Energise If Fill Source is SITE and Level Low 
    |fd100_IV10en1 = ON           // Energise If Fill Source is WATER and Level Low 
    |fd100_IV15 = ON              // Seal Water
    |fd100_PP01 = ON              // Run Pump
    |fd100_DPC01pidEn1 = ON       // Along-membrane pressure drop control loop
    |fd100_PC01pidEn1 = ON        // Membrane Inlet Pressure Control Loop
    |fd100_PC03pid = ON           // Backwash Pressure Control Loop
    |fd100_PC05pidEn1 = ON        // Trans Membrane Pressure Control Loop
    |fd100Temperatureen1 = ON     // Cool or Heat As Selected 
    |fd100_fd101_recirc = ON      // Start Route Sequence
    |fd100_fd102_chemdoseEn1 = ON // Dose Chemical If CIP

    // Check if it's time to blast the retentate line
    if &fd100StepTimeAcc_m >= &fd100StepTimePre_Recirc_BlastRetentate_m\
    and &fd100StepTimeAcc_s10 >= &fd100StepTimePre_Recirc_BlastRetentate_s10\
    and &fd100StepTimePre_Recirc_BlastRetentate_s10 >= 0 then
      // It's time to blast the retentate-bleed line
      //|fd100_IV07 = ON   // Open the retentate-bleed isolation valve
      //|fd100_RC01so = ON // Set the concentration-ratio controller to set-output
      //&RC01cv = 10000    // and set the output to 100% fully-open        
    endif

    // Check if it's time to blast the permeate line
    if &fd100StepTimeAcc_m >= &fd100StepTimePre_Recirc_BlastPermeate_m\
    and &fd100StepTimeAcc_s10 >= &fd100StepTimePre_Recirc_BlastPermeate_s10\
    and &fd100StepTimePre_Recirc_BlastPermeate_s10 >= 0 then
      // It's time to blast the permeate line
      //|fd100_DV04 = ON   // Open the retentate-bleed isolation valve
    endif



//  case fd100StepNum_BLAST:
//    if (|fd100Fault_fd100_Pause=OFF) then
//      // We're not paused
//      if (&fd100StepTimePre_RECIRC_s10 >= 0) then
//        // Step timer is enabled, so increment timer
//        &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
//      else
//        // Step timer is disabled, so clear timer to zero
//        &fd100StepTimeAcc_s10 = 0
//        &fd100StepTimeAcc_m = 0
//      endif
//      if (&fd100TimePre_MembraneUse_s10  >= 0) then
//        // Membrane-use timer is enabled, so increment timer
//        &fd100TimeAcc_MembraneUse_s10 = &fd100TimeAcc_MembraneUse_s10 + &lastScanTimeShort
//      else
//        // Membrane-use timer is disabled, so clear timer to zero
//        &fd100TimeAcc_MembraneUse_s10 = 0
//        &fd100TimeAcc_MembraneUse_m = 0
//      endif
//    endif 
//    
//    |fd100_fd100Fault_enable1 = ON
//    |fd100_DV06en1 = ON           // Energise If Fill Source is WATER  
//    |fd100_IL01 = ON              // PB01 LED Light
//    |fd100_IV08en1 = ON           // Energise If Fill Source is SITE and Level Low 
//    |fd100_IV10en1 = ON           // Energise If Fill Source is WATER and Level Low 
//    |fd100_IV15 = ON              // Seal Water
//    |fd100_PP01 = ON              // Run Pump
//    |fd100_DPC01pidEn1 = ON       // Along-membrane pressure drop control loop
//    |fd100_PC01pidEn1 = ON        // Inlet Pressure Control Loop
//    |fd100_PC03pid = ON           // Backwash Pressure Control Loop
//    |fd100_PC05pidEn1 = ON        // Trans Membrane Pressure Control Loop
//    |fd100Temperatureen1 = ON     // Cool or Heat As Selected 
//    |fd100_fd101_recirc = ON      // Start Route Sequence
//    |fd100_fd102_chemdoseEn1 = ON // Dose Chemical If CIP

  
    
  case fd100StepNum_CONC: //Production - Concentrate
    if (|fd100Fault_fd100_Pause=OFF) then
      if (&fd100TimePre_MembraneUse_s10  >= 0) then
        &fd100TimeAcc_MembraneUse_s10 = &fd100TimeAcc_MembraneUse_s10 + &lastScanTimeShort
      else
        &fd100TimeAcc_MembraneUse_s10 = 0
        &fd100TimeAcc_MembraneUse_m = 0
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
    |fd100Temperatureen1 = ON //Cool or Heat As Selected 
    |fd100_fd101_recirc = ON //Start Route Sequence

    // Check if we're over FT02's max flow rate
    if (&FT02_100 > FT02_EUMax * FT02_EUMultiplier) then
      // Increment timer
      &FT02_OverMaxFlowTimeAcc_s10 = &FT02_OverMaxFlowTimeAcc_s10 + &lastScanTimeShort
    endif

    // Check if we're over FT03's max flow rate
    if (&FT03_100 > FT03_EUMax * FT03_EUMultiplier) then
      // Increment timer
      &FT03_OverMaxFlowTimeAcc_s10 = &FT03_OverMaxFlowTimeAcc_s10 + &lastScanTimeShort
    endif
    

  case fd100StepNum_CONC_TILL_EMPTY: //Production - Empty Feedtank To Site
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
    |fd100Temperatureen1 = ON //Cool or Heat As Selected 
    |fd100_fd101_recirc = ON //Start Route Sequence 
   

  case fd100StepNum_PUMP_TO_WASTE: //Production or CIP Chemical Wash - Pump Feedtank To Drain
    |fd100_fd100Fault_enable1 = ON  
    |fd100_IL01 = ON //PB01 LED Light 
    |fd100_IV15 = ON //Seal Water
    |fd100_PP01 = ON //Run Pump 
    |fd100_PC01so = ON
    |fd100_fd101_drain = ON //Cycle Filter Valves to Drain
    &V1x_last = 0.0
    &R01_last = 1.0
    &R01 = 1.0  
  

  case fd100StepNum_DRAIN_TO_WASTE: //Production or CIP Chemical Wash - Empty Feedtank To Drain
    IF (&LT01_100 < &LT01SP06) THEN
      &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
    ELSE
      &fd100StepTimeAcc_s10 = 0
      &fd100StepTimeAcc_m = 0 
    ENDIF
    |fd100_fd101_drain = ON // Cycle Filter Valves to Drain   
    |fd100_IL01 = ON        // PB01 LED Light
    &V1x_last = 0.0
    &R01_last = 1.0
    &R01 = 1.0
  

  case fd100StepNum_PUMP_TO_STORE: // Production or CIP Chemical Wash - Pump Feedtank To Store
    |fd100_DV05 = ON
    |fd100_fd100Fault_enable1 = ON  
    |fd100_IL01 = ON // PB01 LED Light 
    |fd100_IV15 = ON // Seal Water
    |fd100_PP01 = ON // Run Pump 
    |fd100_PC01so = ON
    |fd100_fd101_drain = ON // Cycle Filter Valves to Drain
    &V1x_last = 0.0
    &R01_last = 1.0
    &R01 = 1.0  
  

  case fd100StepNum_DRAIN_TO_STORE: // Production or CIP Chemical Wash - Empty Feedtank To Store
    IF (&LT01_100 < &LT01SP06) THEN
      &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
    ELSE
      &fd100StepTimeAcc_s10 = 0
      &fd100StepTimeAcc_m = 0 
    ENDIF
    |fd100_DV05 = ON
    |fd100_fd101_drain = ON // Cycle Filter Valves to Drain   
    |fd100_IL01 = ON        // PB01 LED Light
    &V1x_last = 0.0
    &R01_last = 1.0
    &R01 = 1.0


  case fd100StepNum_DRAIN_STORE_TO_WASTE:
    &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 + &lastScanTimeShort
    |fd100_IL01 = ON        // PB01 LED Light
    |fd100_IV16 = ON        // Allow storage tank to drain

     
  default:

endsel



// *************
// Timer Updates
// *************

//Step Timer Update Minutes when seconds greater than 59.9s
if (&fd100StepTimeAcc_s10 > 599) then
  &fd100StepTimeAcc_s10 = &fd100StepTimeAcc_s10 - 600
  &fd100StepTimeAcc_m = &fd100StepTimeAcc_m + 1
endif
if (&fd100StepTimeAcc_m > 32000) then
  &fd100StepTimeAcc_m = 32000
endif

//Production Timer Update Minutes when seconds greater than 59.9s
if (&fd100TimeAcc_MembraneUse_s10 > 599) then
  &fd100TimeAcc_MembraneUse_s10 = &fd100TimeAcc_MembraneUse_s10 - 600
  &fd100TimeAcc_MembraneUse_m = &fd100TimeAcc_MembraneUse_m + 1
endif
if (&fd100TimeAcc_MembraneUse_m > 32000) then
  &fd100TimeAcc_MembraneUse_m = 32000
endif

// FT02's over-max-flow timer, update minutes when seconds greater than 59.9s
if (&FT02_OverMaxFlowTimeAcc_s10 > 599) then
  &FT02_OverMaxFlowTimeAcc_s10 = &FT02_OverMaxFlowTimeAcc_s10 - 600
  &FT02_OverMaxFlowTimeAcc_m = &FT02_OverMaxFlowTimeAcc_m + 1
endif
if (&FT02_OverMaxFlowTimeAcc_m > 32000) then
  &FT02_OverMaxFlowTimeAcc_m = 32000
endif

// FT03's over-max-flow timer, update minutes when seconds greater than 59.9s
if (&FT03_OverMaxFlowTimeAcc_s10 > 599) then
  &FT03_OverMaxFlowTimeAcc_s10 = &FT03_OverMaxFlowTimeAcc_s10 - 600
  &FT03_OverMaxFlowTimeAcc_m = &FT03_OverMaxFlowTimeAcc_m + 1
endif
if (&FT03_OverMaxFlowTimeAcc_m > 32000) then
  &FT03_OverMaxFlowTimeAcc_m = 32000
endif

// Logging timer, update minutes when seconds greater than 59.9s
if (&fd100LogTimeAcc_s10 > 599) then
  &fd100LogTimeAcc_s10 = &fd100LogTimeAcc_s10 - 600
  &fd100LogTimeAcc_m = &fd100LogTimeAcc_m + 1
endif
if (&fd100LogTimeAcc_m > 32000) then
  &fd100LogTimeAcc_m = 32000
endif



// *******************
// Fault Monitor Logic
// *******************

// Clear the fault message if the push button has been pressed to restart
// the plant, or if the fault message should be off.
&OPmsg = &fd100Faultcmd_resetMsg
if (|fd100Fault_PB01toRestart = ON and &PB01State=PB01Pressed)\
or |fd100Fault_msg1 = OFF then
  &OPmsg = 0
endif


// Check for possible fault conditions
if (|fd100Fault_msg1 = ON) then
  IF (|PP01motFault = ON) THEN
    // Fault on the main pump
    &OPmsg = 1
  ELSIF ((|fd100Fault_PB01toPause = ON) AND (&PB01State=PB01Pressed)) THEN
    // The push button has been pressed to pause the plant
    &OPmsg = 2
  ELSIF ((|ES01_I1 = OFF) OR (|ES01_I2 = ON)) THEN
    // The emergency stop has been pressed
    &OPmsg = 3
  ELSIF (|PS01_I = OFF) THEN
    // Insufficient water pressure
    &OPmsg = 4
  ELSIF (|PS02_I = OFF) THEN
    // Insufficient high-pressure compressed air
    &OPmsg = 5
  ELSIF (|PS03_I = OFF) THEN
    // Insufficient low-pressure compressed air
    &OPmsg = 6
  ELSIF ((|FS01_I = OFF) AND (|PP01out = ON)) THEN
    // No seal water on the main pump and the main pump is running
    &OPmsg = 7
  ELSIF ((|fd100Fault_PB01toPause = ON) AND (&fd100cmdOns=fd100cmd_PAUSE)) THEN
    // Pause instruction received
    &OPmsg = 14
  ELSIF ((|fd100_fd100Fault_FILL = ON)\
  AND (&fd100StepTimeAcc_m >= &fd100StepTimePre_FILL_m)\
  AND (&fd100StepTimeAcc_s10 > &fd100StepTimePre_FILL_s10)\
  AND (&LT01_100 < (&LT01SP03 + &LT01SP04))) THEN
    // While attempting to fill the tank, the level is still too low and
    // we've exhausted the allowed time.
    &OPmsg = 15
  ELSIF (&TT01_100 < &TT01SP03) THEN
    // The feed tank's temperature is too low
    &OPmsg = 16
  ELSIF (&TT01_100 > &TT01SP04) THEN
    // The feed tank's temperature is too high 
    &OPmsg = 17
  ELSIF (&PT01_1000 > &PT01SP01) THEN
    // The inlet pressure to the membrane is too high
    &OPmsg = 18
  ELSIF (&PT05_1000 > &PT05SP01) THEN
    // The transmembrane pressure is too high
    &OPmsg = 19
  ELSIF (&PT03_1000 > &PT03SP01) THEN
    // The backwash pressure is too high
    &OPmsg = 20
  ELSIF (&DPT01_1000 > &DPT01SP01) THEN
    // Along membrane pressure too high
    &OPmsg = 21
  ELSIF (&PH01_100 < &PH01SP01) THEN
    // pH is too low
    &OPmsg = 22
  ELSIF (&PH01_100 > &PH01SP02) THEN
    // pH is too high
    &OPmsg = 23                  
  ELSIF (&DPT02_1000 > &DPT02SP01) THEN
    // The across bag-filter pressure drop is too high
    &OPmsg = 24                  
  elsif |fd100_fd100Fault_FILL = ON\
  and &fd100FillSource = fd100FillSource_STORAGE_TANK then
    // We're trying to fill from the storage tank
    if &fd100StorageTankState = fd100TankState_EMPTY\
    and &LT01_100 <= (&LT01SP03 + &LT01SP04) then
      // The storage tank is empty
      &OPmsg = 25
      
    elsif &fd100FeedTankState != fd100TankState_EMPTY\
    and &fd100FeedTankContents != &fd100StorageTankContents then
      // The feed tank's not empty and the contents of the storage tank don't
      // match
      &OPmsg = 29

    elsif &fd100FeedTankState = fd100TankState_EMPTY\
    and &fd100FeedTankContents != fd100TankContents_CLEAN\
    and (&fd100FeedTankContents != fd100TankContents_WATER\
         and &fd100FeedTankContents != fd100TankContents_RINSE) then 
      // The feed tank's empty and not clean but we're trying to put in 
      // something other than water or rinse water
      &OPmsg = 29
        
    endif                  

  elsif &fd100StepNum = fd100StepNum_PUMP_TO_STORE then
    // We're moving contents of feed tank to storage tank
    // Check that the contents of the feed tank and the storage tank are
    // compatible
    if &fd100FeedTankContents != &fd100StorageTankContents then
      // The contents aren't the same
      if (&fd100FeedTankContents = fd100TankContents_WATER\
      or &fd100FeedTankContents = fd100TankContents_RINSE)\
      and &fd100StorageTankState = fd100TankState_EMPTY then 
        // We're rinsing out the storage tank, that's ok
  
      elsif &fd100FeedTankContents = fd100TankContents_WATER\
      and &fd100StorageTankContents = fd100TankContents_MAN_CHEM then
        // We're diluting manually-dosed chemicals, that's ok
        
      elsif &fd100StorageTankContents = fd100TankContents_CLEAN then
        // Whatever we're putting in it's ok because the storage tank is clean
      
      else
        // Whatever we're doing at this point, it's not ok 
        &OPmsg = 29
      endif
    endif
    
  elsif |fd102_fd100_faultDosingChem = ON then
    // There's been a fault while dosing chemical
    &OPmsg = 31
                    
  endif

endif



// Check if the fault has changed since last time, logging if changed,
// and set the new fault message (the reason why a fault occurred).
if &fd100Faultcmd_resetMsg != &OPmsg then
  gosub logFaultEvent   
  &fd100Faultcmd_resetMsg = &OPmsg
else
  &fd100Faultcmd_resetMsg = &OPmsg
endif



// Selection From RPi
&fd100FaultcmdOns = &fd100Faultcmd 
&fd100Faultcmd = fd100Faultcmd_NO_ACTION


// Process instruction
&tempStepNum = &fd100FaultStepNum
select &fd100FaultcmdOns

  case fd100Faultcmd_ENABLE_FAULTS:
    // Enable fault checking
    if &fd100FaultStepNum = fd100Fault_disabled then
      &tempStepNum = fd100Fault_reset
    endif  
     
    
  case fd100Faultcmd_DISABLE_FAULTS:
    // Disable fault checking 
    &tempStepNum = fd100Fault_disabled 
    

  default:
    // Do nothing

endsel

// Clear Sequence Outputs... these are then set on below
&fd100FaultProgOut01 = 0

// Step Transistions
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


  case fd100Fault_disabled:
    // Do nothing 


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
      // Do nothing (fault logging occurs above)
      
    case fd100Fault_disabled:
      // Do nothing

    default:
      // Do nothing

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
    |fd100Fault_PP03pause = ON
    |fd100Fault_DPC01pidHold = ON
    |fd100Fault_PC01pidHold = ON
    |fd100Fault_PC05pidHold = ON
    |fd100Fault_RC01pidHold = ON
    |fd100Fault_temperatureHold = ON
    |fd100Fault_fd100_Pause = ON
    |fd100Fault_fd101_Pause = ON
    |fd100Fault_fd102_Pause = ON


  case fd100Fault_disabled:
    // Do nothing 

           
 default:
 
endsel

