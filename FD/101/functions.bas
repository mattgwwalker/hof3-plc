
// Log backwash event
logBackwashEvent:
  &EventID = EventID_BACKWASH_STARTED
//  force_log
  &EventID = EventID_NONE
  return


// Log direction change event
logDirectionChangeEvent:
  &EventID = EventID_DIRECTION_CHANGE_STARTED
//  force_log
  &EventID = EventID_NONE
  return


// Log maximum backwash pressure
logMaxBackwashPressure:
    &EventID = EventID_MAX_BACKWASH_PRESSURE
//    force_log
    &EventID = EventID_NONE
  return


// Log during-backwash events (every scan of backwash if enabled)
logDuringBackwashEvent:
  if &fd101_BW_LoggingEnabled != 0 then
    &EventID = EventID_DURING_BACKWASH
//    force_log
    &EventID = EventID_NONE
  endif
  return


// Log during-backwash-retract events (every scan of backwash retract if enabled)
logDuringBackwashRetractEvent:
  if &fd101_BW_LoggingEnabled != 0 then
    &EventID = EventID_DURING_BACKWASH_RETRACT
//    force_log
    &EventID = EventID_NONE
  endif
  return


// Log PID-freezing events (every scan for a few seconds after backwash if enabled)
logFreezePIDsEvent:
  if &fd101_BW_LoggingEnabled != 0 then
    &EventID = EventID_DURING_FREEZE_PIDS
    force_log
    &EventID = EventID_NONE
  endif
  return




// Check that we're not paused and update the timers
updateTimers:
  if (|fd100Fault_fd101_Pause=OFF) then
    &fd101DirTimeAcc_s10 = &fd101DirTimeAcc_s10 + &lastScanTimeShort
    &fd101BWTimeAcc_s10 = &fd101BWTimeAcc_s10 + &lastScanTimeShort
    &fd101StepTimeAcc_s10 = &fd101StepTimeAcc_s10 + &lastScanTimeShort
  endif 
  return
  
  
// Calculate the target slow-pump-speed based on the proportion of current speed
calcSlowPumpSpeed:
  &fd101_SlowPumpSpeed = (1.0 * &PC01cv) * (&fd101_SlowPumpSpeedProportion / 10000.0)
  return