// Check if the abort command has been issued
checkForAbort:
  if (&fd100cmdOns=fd100cmd_ABORT) then
    // Log abort event
    &EventID = EventID_ABORTED
    force_log
    &EventID = EventID_NONE
    
    // Return to the waiting-for-instruction state
    &tempStepNum = fd100StepNum_WAITINS  
  endif
  return


// Log a stop event
logStopEvent:
  // Log abort event
  &EventID = EventID_STOPPED
  force_log
  &EventID = EventID_NONE
  return
 

