
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


