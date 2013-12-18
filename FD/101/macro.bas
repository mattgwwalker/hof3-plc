// ********************
// FD101 Route Sequence
// ********************

// This code is responsible for the timing of direction changes (whether liquid 
// flows from the top or from the bottom of the membrane) during Recirculation 
// and Draining, and for the timing of backwashes.

// The state names are, for example, "Recirc Bottom" which indicates that the
// membrane flow is from the bottom.  The name "Recirc to Top" indicates that
// we are transitioning to the state "Recirc Top", i.e. the flow will become 
// from the top.

// The length of time to freeze the PID controllers after a direction change 
// or backwash
CONST fd101StepTimeAcc_FREEZE_PIDS_m = 0
CONST fd101StepTimeAcc_FREEZE_PIDS_s10 = 100


//Clear Sequence Outputs... these are then set on below
&fd101ProgOut01 = 0


// ******************
// Step Transisitions
// ******************

&tempStepNum = &fd101StepNum

select &tempStepNum
  case  fd101StepNum_RESET:
    // On reset, we go immediately to the Bypass state
    &tempStepNum = fd101StepNum_BYPASS
  
  
  case  fd101StepNum_BYPASS:
    // If the Recirc bit is on, we go immediately to the RecircTop state
    if (|fd100_fd101_recirc=ON) then
      &tempStepNum = fd101StepNum_RECIRC_TOP
    endif
  
    // If the Drain flag is on, we go immediately to the DrainTop state 
    if (|fd100_fd101_drain=ON) then
      &tempStepNum = fd101StepNum_DRAIN_TOP
    endif





  // *** Recirculating ***  
  
  case fd101StepNum_RECIRC_TOP_SPEED_RAMP_UP:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've spent enough time here, we head to recirculating from the top
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_TOP
    endif


  case  fd101StepNum_RECIRC_TOP:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If it's time to do a direction change, we head off to slow the pump
    if  &fd101DirTimeAcc_m >= &fd101DirTimePre_RECIRC_m \
    and &fd101DirTimeAcc_s10 >= &fd101DirTimePre_RECIRC_s10 \
    and &fd101DirTimePre_RECIRC_s10 > -1 then // Putting a negative value into the timer disables direction changes
      &tempStepNum = fd101StepNum_RECIRC_TOP_SPEED_RAMP_DOWN
    endif
    // Or if it's time to do a backwash, we head off to slow the pump
    if  &fd101BWTimeAcc_m >= &fd101BWTimePre_RECIRC_m \
    and &fd101BWTimeAcc_s10 >= &fd101BWTimePre_RECIRC_s10\
    and &fd101BWTimePre_RECIRC_s10 > -1 then // Putting a negative value into the timer disables backwashes
      &tempStepNum = fd101StepNum_RECIRC_TOP_SPEED_RAMP_DOWN
    endif


  case fd101StepNum_RECIRC_TOP_SPEED_RAMP_DOWN:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've finished slowing down, we need to work out where to go next
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_TOP_SLOW
    endif


  case fd101StepNum_RECIRC_TOP_SLOW:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif

    // Check if it's time to do a backwash
    if  &fd101BWTimeAcc_m >= &fd101BWTimePre_RECIRC_m \
    and &fd101BWTimeAcc_s10 >= &fd101BWTimePre_RECIRC_s10\
    and &fd101BWTimePre_RECIRC_s10 > -1 then // Putting a negative value into the timer disables backwashes
      &tempStepNum = fd101StepNum_RECIRC_BW_TOP

    // Check if it's time to do a direction change
    elsif &fd101DirTimeAcc_m >= &fd101DirTimePre_RECIRC_m \
    and &fd101DirTimeAcc_s10 >= &fd101DirTimePre_RECIRC_s10 \
    and &fd101DirTimePre_RECIRC_s10 > -1 then // Putting a negative value into the timer disables direction changes
      &tempStepNum = fd101StepNum_RECIRC_TO_BOTTOM

    // Otherwise we must have done what we came here to do, so speed back up
    else
      &tempStepNum = fd101StepNum_RECIRC_TOP_SPEED_RAMP_UP
    endif
      
  
   
  case fd101StepNum_RECIRC_TO_BOTTOM:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've spent enough time here, and thus made the change to flow from
    // the bottom of the membrane, we then check to see if we should first do a
    // backwash before we bring the pump speed back up
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_TO_BOTTOM_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_TO_BOTTOM_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM_SLOW
    endif


  case fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_UP:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've spent enough time here, we head to recirculating from the bottom
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM
    endif
   

  case  fd101StepNum_RECIRC_BOTTOM:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If it's time to do a direction change, we head off to slow the pump
    if ((&fd101DirTimeAcc_m >= &fd101DirTimePre_RECIRC_m) \
    and (&fd101DirTimeAcc_s10 >= &fd101DirTimePre_RECIRC_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_DOWN
    endif
    // Or if it's time to do a backwash, we head off to slow the pump
    if ((&fd101BWTimeAcc_m >= &fd101BWTimePre_RECIRC_m) \
    and (&fd101BWTimeAcc_s10 >= &fd101BWTimePre_RECIRC_s10)\
    and (&fd101BWTimePre_RECIRC_s10 > -1)) then  // Putting a negative value into the timer disables backwashes
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_DOWN
    endif
   

  case fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_DOWN:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've finished slowing down, we need to work out where to go next
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM_SLOW
    endif


  case fd101StepNum_RECIRC_BOTTOM_SLOW:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif

    // Check if it's time to do a backwash
    if  &fd101BWTimeAcc_m >= &fd101BWTimePre_RECIRC_m \
    and &fd101BWTimeAcc_s10 >= &fd101BWTimePre_RECIRC_s10\
    and &fd101BWTimePre_RECIRC_s10 > -1 then // Putting a negative value into the timer disables backwashes
      &tempStepNum = fd101StepNum_RECIRC_BW_BOTTOM

    // Check if it's time to do a direction change
    elsif &fd101DirTimeAcc_m >= &fd101DirTimePre_RECIRC_m \
    and &fd101DirTimeAcc_s10 >= &fd101DirTimePre_RECIRC_s10 \
    and &fd101DirTimePre_RECIRC_s10 > -1 then // Putting a negative value into the timer disables direction changes
      &tempStepNum = fd101StepNum_RECIRC_TO_TOP

    // Otherwise we must have done what we came here to do, so speed back up
    else
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_UP
    endif


  case  fd101StepNum_RECIRC_TO_TOP:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've spent enough time here, and thus made the change to flow from
    // the top of the membrane, we then check to see if we should first do a
    // backwash before we bring the pump speed back up
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_TO_TOP_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_TO_TOP_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_TOP_SLOW
    endif



   
   
  // *** Backwashing ***

  case  fd101StepNum_RECIRC_BW_TOP:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // Once we've spent enough time here, we head off to retract the 
    // backwash device
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BW_TOP_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BW_TOP_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BW_TOP_RETRACT
    endif


  case  fd101StepNum_RECIRC_BW_TOP_RETRACT:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // Once we've spent enough time here, we increment the backwash count
    // and set a flag to ensure the PID controller PC03 gets updated
    // then we head back to RecircTop
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BW_RETRACT_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BW_RETRACT_s10)) then
      &fd101_BW_count = &fd101_BW_count + 1
      |fd101_PC03calc = ON
      // Log the maximum backwash pressure
      gosub logMaxBackwashPressure
      &tempStepNum = fd101StepNum_RECIRC_TOP_SLOW
    endif

    
  case  fd101StepNum_RECIRC_BW_BOTTOM:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // Once we've spent enough time here, we head off to retract the 
    // backwash device                                       
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BW_BOTTOM_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BW_BOTTOM_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BW_BOTTOM_RETRACT
    endif
  

  case  fd101StepNum_RECIRC_BW_BOTTOM_RETRACT:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_recirc=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // Once we've spent enough time here, we increment the backwash count
    // and set a flag to ensure the PID controller PC03 gets updated
    // then we head back to RecircBottom
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_RECIRC_BW_RETRACT_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_RECIRC_BW_RETRACT_s10)) then
      &tempStepNum = fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_UP
      &fd101_BW_count = &fd101_BW_count + 1
      |fd101_PC03calc = ON
      // Log the maximum backwash pressure
      gosub logMaxBackwashPressure
    endif


  // *** Draining ***
  
  case fd101StepNum_DRAIN_TOP:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_drain=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif 
    // If we've spent enough time here we head to DrainBottom
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_DRAIN_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_DRAIN_s10)) then
      &tempStepNum = fd101StepNum_DRAIN_BOTTOM
    endif 

 
  case fd101StepNum_DRAIN_BOTTOM:
    // If the Recirc flag is off, head back to the Bypass state
    if (|fd100_fd101_drain=OFF) then
      &tempStepNum = fd101StepNum_BYPASS
    endif
    // If we've spent enough time here we head to DrainTop
    if ((&fd101StepTimeAcc_m >= &fd101StepTimePre_DRAIN_m) \
    and (&fd101StepTimeAcc_s10 >= &fd101StepTimePre_DRAIN_s10)) then
      &tempStepNum = fd101StepNum_DRAIN_TOP
    endif   
        
  default:
    // If we're not in any of the above states, head to the reset state.
    &tempStepNum = fd101StepNum_RESET

endsel




// **********************
// One-shot (ONS) Actions
// **********************

// These actions only occur as the state is changing.  They do not
// occur every scan.


if (&tempStepNum != &fd101StepNum) then
  // We're changing steps, make the new step the official one
  &fd101StepNum = &tempStepNum

  // Reset the step timer to zero seeing we're changing steps
  &fd101StepTimeAcc_s10 = 0
  &fd101StepTimeAcc_m = 0

  select &tempStepNum
    case fd101StepNum_RESET:

    case fd101StepNum_BYPASS:

    case fd101StepNum_RECIRC_TOP_SPEED_RAMP_UP:

    case fd101StepNum_RECIRC_TOP:

    case fd101StepNum_RECIRC_TOP_SPEED_RAMP_DOWN:
      // Copy current pump speed
      &fd101_PreviousPumpSpeed = &PC01cv
      gosub calcSlowPumpSpeed
    
    case fd101StepNum_RECIRC_TOP_SLOW:

    case fd101StepNum_RECIRC_TO_BOTTOM:
      gosub logDirectionChangeEvent
      
    case fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_UP:

    case fd101StepNum_RECIRC_BOTTOM:

    case fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_DOWN:
      // Copy current pump speed
      &fd101_PreviousPumpSpeed = &PC01cv
      gosub calcSlowPumpSpeed

    case fd101StepNum_RECIRC_BOTTOM_SLOW:

    case fd101StepNum_RECIRC_TO_TOP:
      gosub logDirectionChangeEvent

    case fd101StepNum_RECIRC_BW_TOP:
      // When we start backwashing, set the initial value for maximum 
      // observed pressure to the current value of PT03
      &fd101_BW_PT03max = &PT03_1000
      gosub logBackwashEvent

    case fd101StepNum_RECIRC_BW_TOP_RETRACT:

    case fd101StepNum_RECIRC_BW_BOTTOM:
      // When we start backwashing, set the initial value for maximum 
      // observed pressure to the current value of PT03
      &fd101_BW_PT03max = &PT03_1000
      gosub logBackwashEvent

    case fd101StepNum_RECIRC_BW_BOTTOM_RETRACT:

    case fd101StepNum_DRAIN_TOP:

    case fd101StepNum_DRAIN_BOTTOM:          

    default:

  endsel

endif



// ************
// Step Actions
// ************

select &tempStepNum
  case  fd101StepNum_RESET: 
    // Do nothing in the Reset state
 

  case  fd101StepNum_BYPASS:
    |fd101_IV06=OFF // OFF = Open the bypass
    |fd101_DV02=ON


  case fd101StepNum_RECIRC_TOP_SPEED_RAMP_UP:  
    // Check that we're not paused, and update the timers
    gosub updateTimers
    // Requires: IV05 delay on < IV06 delay on
    // Requires: time for this state > IV05 delay on + IV06 delay on (DV0{1,2,3} aren't changing)
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_IV06=ON // ON = Close the bypass
    // Freeze PID loops
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    |fd101_RC01pidHold=ON
    gosub logFreezePIDsEvent
    // Ramp up pump speed
    if &fd101StepTimeAcc_m = &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_m \
    and &fd101StepTimeAcc_s10 = &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_s10 then
      &PC01cv = &fd101_PreviousPumpSpeed
    else         
      &PC01cv = (&fd101_PreviousPumpSpeed - &PC01cv) / (1.0 - (&fd101StepTimeAcc_m * 600.0 + &fd101StepTimeAcc_s10) / (&fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_m * 600.0 + &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_s10)) * (&lastScanTimeShort / (&fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_m * 600.0 + &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_UP_s10)) + &PC01cv 
    endif


  case  fd101StepNum_RECIRC_TOP:
    // Check that we're not paused, and update the timers
    gosub updateTimers
    // Requires: IV05 delay on < IV06 delay on
    // Requires: time for this state > IV05 delay on + IV06 delay on (DV0{1,2,3} aren't changing)
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_IV06=ON // ON = Close the bypass
    // Freeze the PID controllers for the first few seconds of this state
    if ((&fd101StepTimeAcc_m <= fd101StepTimeAcc_FREEZE_PIDS_m) \
    and (&fd101StepTimeAcc_s10 < fd101StepTimeAcc_FREEZE_PIDS_s10)) then       
      |fd101_DPC01pidHold=ON
      |fd101_PC01pidHold=ON
      gosub PC05freezePrevious
      |fd101_PC05pidHold=ON  
      |fd101_RC01pidHold=ON
      gosub logFreezePIDsEvent
    else
      gosub PC05unfreeze
    endif   


  case fd101StepNum_RECIRC_TOP_SPEED_RAMP_DOWN:  
    // Check that we're not paused, and update the timers
    gosub updateTimers
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_IV06=ON // ON = Close the bypass
    // Freeze PID loops
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    |fd101_RC01pidHold=ON
    gosub logFreezePIDsEvent
    // Ramp down pump speed 
    if &fd101StepTimeAcc_m = &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_m \
    and &fd101StepTimeAcc_s10 = &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_s10 then
      &PC01cv = &fd101_SlowPumpSpeed
    else         
      &PC01cv = (&fd101_SlowPumpSpeed - &PC01cv) / (1.0 - (&fd101StepTimeAcc_m * 600.0 + &fd101StepTimeAcc_s10) / (&fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_m * 600.0 + &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_s10)) * (&lastScanTimeShort / (&fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_m * 600.0 + &fd101StepTimePre_RECIRC_TOP_SPEED_RAMP_DOWN_s10)) + &PC01cv 
    endif


  case fd101StepNum_RECIRC_TOP_SLOW:  
    // Check that we're not paused, and update the timers
    gosub updateTimers
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_IV06=ON // ON = Close the bypass
    // Freeze PID loops
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    |fd101_RC01pidHold=ON
    gosub logFreezePIDsEvent
    // Ensure speed's at the slow target 
    &PC01cv = &fd101_SlowPumpSpeed



  case  fd101StepNum_RECIRC_TO_BOTTOM:
    // Check that we're not paused, and update the timers
    gosub updateTimers
    // In this state we're changing to a membrane flow that will be from the bottom
    // so reset the direction change timer to zero
    &fd101DirTimeAcc_s10 = 0
    &fd101DirTimeAcc_m = 0
    // Change the direction of the flow in the membrane
    // It's critical that each of the valves' delay timers are correctly set
    // and that the state has enough time to complete
    // Requires: IV06 delay off < IV05 delay off < DV0(1,2,3} delay on
    // Requires: time for this state > IV06 delay off + IV05 delay off + DV0{1,2,3} delay on
    |fd101_IV06=ON // ON = Close the bypass
    |fd101_IV05=ON // ON = Allow flow into membranes
    // ON = flow from the bottom
    |fd101_DV01=ON
    |fd101_DV02=ON
    |fd101_DV03=ON
    // Freeze the PID Controllers for the duration of this state
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    gosub PC05freezePrevious // We tried freezing open but this suddenly drops P2, effectively spiking the along-membrane pressure
    |fd101_RC01pidHold=ON   
 

  case fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_UP:  
    // Check that we're not paused, and update the timers
    gosub updateTimers
    // Requires: IV05 delay on < IV06 delay on
    // Requires: time for this state > IV05 delay on + IV06 delay on (DV0{1,2,3} aren't changing)
    |fd101_IV05=ON // ON = flow to the membranes
    |fd101_IV06=ON // ON = Bypass valve closed
    |fd101_DV01=ON // ON = flow from the bottom
    |fd101_DV02=ON
    |fd101_DV03=ON
    // Freeze the PID controllers     
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    |fd101_RC01pidHold=ON
    gosub logFreezePIDsEvent
    // Ramp
    if &fd101StepTimeAcc_m = &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_m \
    and &fd101StepTimeAcc_s10 = &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_s10 then
      &PC01cv = &fd101_PreviousPumpSpeed
    else         
      &PC01cv = (&fd101_PreviousPumpSpeed - &PC01cv) / (1.0 - (&fd101StepTimeAcc_m * 600.0 + &fd101StepTimeAcc_s10) / (&fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_m * 600.0 + &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_s10)) * (&lastScanTimeShort / (&fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_m * 600.0 + &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_UP_s10)) + &PC01cv 
    endif



  case  fd101StepNum_RECIRC_BOTTOM:
    // Check that we're not paused, and update the timers
    gosub updateTimers
    // Requires: IV05 delay on < IV06 delay on
    // Requires: time for this state > IV05 delay on + IV06 delay on (DV0{1,2,3} aren't changing)
    |fd101_IV05=ON // ON = flow to the membranes
    |fd101_IV06=ON // ON = Bypass valve closed
    |fd101_DV01=ON // ON = flow from the bottom
    |fd101_DV02=ON
    |fd101_DV03=ON
    // Freeze the PID controllers for the first few seconds of this state
    if ((&fd101StepTimeAcc_m <= fd101StepTimeAcc_FREEZE_PIDS_m) \
    and (&fd101StepTimeAcc_s10 < fd101StepTimeAcc_FREEZE_PIDS_s10)) then     
      |fd101_DPC01pidHold=ON
      |fd101_PC01pidHold=ON
      |fd101_PC05pidHold=ON  
      gosub PC05freezePrevious
      |fd101_RC01pidHold=ON
      gosub logFreezePIDsEvent
    else
      gosub PC05unfreeze
    endif


  case fd101StepNum_RECIRC_BOTTOM_SPEED_RAMP_DOWN:  
    // Check that we're not paused, and update the timers
    gosub updateTimers
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_IV06=ON // ON = Close the bypass
    |fd101_DV01=ON // ON = flow from the bottom
    |fd101_DV02=ON
    |fd101_DV03=ON
    // Freeze PID loops
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    |fd101_RC01pidHold=ON
    gosub logFreezePIDsEvent
    // Ramp down pump speed 
    if &fd101StepTimeAcc_m = &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_m \
    and &fd101StepTimeAcc_s10 = &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_s10 then
      &PC01cv = &fd101_SlowPumpSpeed
    else         
      &PC01cv = (&fd101_SlowPumpSpeed - &PC01cv) / (1.0 - (&fd101StepTimeAcc_m * 600.0 + &fd101StepTimeAcc_s10) / (&fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_m * 600.0 + &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_s10)) * (&lastScanTimeShort / (&fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_m * 600.0 + &fd101StepTimePre_RECIRC_BOTTOM_SPEED_RAMP_DOWN_s10)) + &PC01cv 
    endif


  case fd101StepNum_RECIRC_BOTTOM_SLOW:  
    // Check that we're not paused, and update the timers
    gosub updateTimers
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_IV06=ON // ON = Close the bypass
    |fd101_DV01=ON // ON = flow from the bottom
    |fd101_DV02=ON
    |fd101_DV03=ON
    // Freeze PID loops
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    |fd101_RC01pidHold=ON
    gosub logFreezePIDsEvent
    // Ensure speed's at the slow target 
    &PC01cv = &fd101_SlowPumpSpeed


  case  fd101StepNum_RECIRC_TO_TOP:
    // Check that we're not paused, and update the timers
    gosub updateTimers
    // In this state we're changing to a membrane flow that will be from the top
    // so reset the direction change timer to zero
    &fd101DirTimeAcc_s10 = 0
    &fd101DirTimeAcc_m = 0
    // Change the direction of the flow in the membrane
    // It's critical that each of the valves' delay timers are correctly set
    // and that the state has enough time to complete
    // Requires: IV06 delay off < IV05 delay off < DV0(1,2,3} delay off
    // Requires: time for this state > IV06 delay off + IV05 delay off + DV0{1,2,3} delay off
    |fd101_IV06=ON // ON = Close the bypass
    |fd101_IV05=ON // ON = Allow flow into membranes
    // OFF = flow from the top
    |fd101_DV01=OFF
    |fd101_DV02=OFF
    |fd101_DV03=OFF
    // Freeze the PID Controllers for the duration of this state
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON  
    gosub PC05freezePrevious // We tried freezing open but this suddenly drops P2, effectively spiking the along-membrane pressure
    |fd101_RC01pidHold=ON


  // *** Backwashing ***
   

  case  fd101StepNum_RECIRC_BW_TOP:
    // Increment step timer
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
    // Set the backwash timer to zero
    &fd101BWTimeAcc_s10 = 0
    &fd101BWTimeAcc_m = 0
    // Fire the backwash device
    |fd101_BF01=ON
    |fd101_IV06=ON // ON = Close the bypass
    // The flow through the membrane is from the top (because DV01 to DV03 are OFF)
    |fd101_IV05=ON // ON = Allow flow into membranes
    // Freeze the PID Controllers for the duration of this state
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON
    gosub PC05freezePrevious // We tried freezing open but this suddenly drops P2, effectively spiking the along-membrane pressure
    |fd101_RC01pidHold=ON
    // Log the backwash pressures at every scan of the backwash
    gosub logDuringBackwashEvent
    // Get the maximum pressure of the backwash
    if (&fd101_BW_PT03max < &PT03_1000) then
      &fd101_BW_PT03max = &PT03_1000
    endif

  case  fd101StepNum_RECIRC_BW_TOP_RETRACT:
    // Increment step timer
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
    // Set the backwash timer to zero
    &fd101BWTimeAcc_s10 = 0
    &fd101BWTimeAcc_m = 0
    // Retract the backwash device
    |fd101_BF01=OFF
    |fd101_IV06=ON // ON = Close the bypass
    // The flow through the membrane is from the top (because DV01 to DV03 are OFF)
    |fd101_IV05=ON // ON = Allow flow into membranes
    // Freeze the PID Controllers for the duration of this state
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON
    gosub PC05freezePrevious // We tried freezing open but this suddenly drops P2, effectively spiking the along-membrane pressure
    |fd101_RC01pidHold=ON
    // Log the backwash pressures at every scan of the backwash
    gosub logDuringBackwashRetractEvent
    
         
  case  fd101StepNum_RECIRC_BW_BOTTOM:
    // Increment step timer
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
    // Set the backwash timer to zero
    &fd101BWTimeAcc_s10 = 0
    &fd101BWTimeAcc_m = 0
    // Fire the backwash device
    |fd101_BF01=ON
    |fd101_IV06=ON // ON = Close the bypass
    //The flow through the membrane is from the bottom
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_DV01=ON
    |fd101_DV02=ON
    |fd101_DV03=ON  
    // Freeze the PID Controllers for the duration of this state
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON
    gosub PC05freezePrevious // We tried freezing open but this suddenly drops P2, effectively spiking the along-membrane pressure
    |fd101_RC01pidHold=ON
    // Log the backwash pressures at every scan of the backwash
    gosub logDuringBackwashEvent
    // Get the maximum pressure of the backwash
    if (&fd101_BW_PT03max < &PT03_1000) then
      &fd101_BW_PT03max = &PT03_1000
    endif

     
  case  fd101StepNum_RECIRC_BW_BOTTOM_RETRACT:
    // Increment step timer
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
    // Set the backwash timer to zero
    &fd101BWTimeAcc_s10 = 0
    &fd101BWTimeAcc_m = 0
    // Retract the backwash device
    |fd101_BF01=OFF
    |fd101_IV06=ON // ON = Close the bypass
    //The flow through the membrane is from the bottom
    |fd101_IV05=ON // ON = Allow flow into membranes
    |fd101_DV01=ON
    |fd101_DV02=ON
    |fd101_DV03=ON  
    // Freeze the PID Controllers for the duration of this state
    |fd101_DPC01pidHold=ON
    |fd101_PC01pidHold=ON
    |fd101_PC05pidHold=ON
    gosub PC05freezePrevious // We tried freezing open but this suddenly drops P2, effectively spiking the along-membrane pressure
    |fd101_RC01pidHold=ON
    // Log the backwash pressures at every scan of the backwash
    gosub logDuringBackwashRetractEvent

    
  case fd101StepNum_DRAIN_TOP:
    // Increment step timer
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
    // Open drain valves
    |fd101_IV01=ON
    |fd101_IV02=ON
    |fd101_IV04=ON
    |fd101_IV05=ON 
    // Membrane flow (were liquid being pumped) would be from the top as 
    // DV01 to DV03 are OFF
 
  case fd101StepNum_DRAIN_BOTTOM:
    // Increment step timer
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
    // Membrane flow (were liquid being pumped) would be from the bottom
    |fd101_DV01=ON
    |fd101_DV02=ON
    |fd101_DV03=ON 
    // Open drain valves
    |fd101_IV01=ON
    |fd101_IV02=ON
    |fd101_IV04=ON
    |fd101_IV05=ON  
         
  default:
    // By default, if we're in none of the above states, do nothing.

endsel


// Increment minutes counter of step timer
if (&fd101StepTimeAcc_s10 > 599) then
  &fd101StepTimeAcc_s10 = 0
  &fd101StepTimeAcc_m = &fd101StepTimeAcc_m + 1
endif
if (&fd101StepTimeAcc_m > 32000) then
  &fd101StepTimeAcc_m = 32000
endif

// Increment minutes counter of backwash timer
if (&fd101BWTimeAcc_s10 > 599) then
  &fd101BWTimeAcc_s10 = 0
  &fd101BWTimeAcc_m = &fd101StepTimeAcc_m + 1
endif
if (&fd101BWTimeAcc_m > 32000) then
  &fd101BWTimeAcc_m = 32000
endif

// Increment minutes counter of direction change timer
if (&fd101DirTimeAcc_s10 > 599) then
  &fd101DirTimeAcc_s10 = 0
  &fd101DirTimeAcc_m = &fd101DirTimeAcc_m + 1
endif
if (&fd101DirTimeAcc_m > 32000) then
  &fd101DirTimeAcc_m = 32000
endif

