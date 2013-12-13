
// Log backwash event
logBackwashEvent:
  &EventID = EventID_BACKWASH_STARTED
  force_log
  &EventID = EventID_NONE
  return


// Log direction change event
logDirectionChangeEvent:
  &EventID = EventID_DIRECTION_CHANGE_STARTED
  force_log
  &EventID = EventID_NONE
  return


// Log maximum backwash pressure
logMaxBackwashPressure:
    &EventID = EventID_MAX_BACKWASH_PRESSURE
    force_log
    &EventID = EventID_NONE
  return


// Log during-backwash events (every scan of backwash if enabled)
logDuringBackwashEvent:
  if &fd101_BW_LoggingEnabled != 0 then
    &EventID = EventID_DURING_BACKWASH
    force_log
    &EventID = EventID_NONE
  endif
  return


// Log during-backwash-retract events (every scan of backwash retract if enabled)
logDuringBackwashRetractEvent:
  if &fd101_BW_LoggingEnabled != 0 then
    &EventID = EventID_DURING_BACKWASH_RETRACT
    force_log
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


// Reduce pump speed for direction changes
reducePumpSpeedForDirChange:
  // Copy current pump speed
  &fd101_PreviousPumpSpeed = &PC01cv
  // Decrease pump speed (proportion is between 0 and 10,000)
  &PC01cv = (1.0 * &PC01cv) * (&fd101_Dir_PumpSpeedProportion / 10000.0) 
  return
  

// Reduce pump speed for backwash
reducePumpSpeedForBackwash:
  // Copy current pump speed
  &fd101_PreviousPumpSpeed = &PC01cv
  // Decrease pump speed (proportion is between 0 and 10,000)
  &PC01cv = (1.0 * &PC01cv) * (&fd101_BW_PumpSpeedProportion / 10000.0) 
  return
