// Check if the abort command has been issued
abortOnRequest:
  if (&fd100cmdOns=fd100cmd_ABORT) then
    // Log abort event
    &EventID = EventID_ABORTED
    force_log
    &EventID = EventID_NONE
    
    // Return to the waiting-for-instruction state
    &tempStepNum = fd100StepNum_WAIT_INSTRUCTION  
  endif
  return


// Log a stop event
logStopEvent:
  // Log abort event
  &EventID = EventID_STOPPED
  force_log
  &EventID = EventID_NONE
  return
 

// Log a timer-based event
logTimerEvent:
  &EventID = EventID_ON_TIMER
  force_log
  &EventID = EventID_NONE
  return


// Log a fault-based event
logFaultEvent:
  &EventID = EventID_FAULT + &fd100Faultcmd_resetMsg
  force_log
  &EventID = EventID_NONE
  return
