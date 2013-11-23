//********************************************************************************
// FS01 Flow switch for main pump's seal water
//

// If it's currently on and the signal goes off, make sure the signal stays off
// for a few scans before we consider the flow switch to have changed states.
// We need this as the flow switch seems to flicker a little at low flow rates.
if |FS01_I = ON then
  // Update the counter
  if |FS01_I_Raw = ON then
    // The raw signal is the same as the value, check if we should decrement the timer
    if &FS01_StateChangeTimeAcc_s10 > 0 then
      &FS01_StateChangeTimeAcc_s10 = &FS01_StateChangeTimeAcc_s10 - &lastScanTimeShort
      if &FS01_StateChangeTimeAcc_s10 < 0 then
        &FS01_StateChangeTimeAcc_s10 = 0
      endif 
    endif
  else
    // The raw signal is different, increment the timer
    &FS01_StateChangeTimeAcc_s10 = &FS01_StateChangeTimeAcc_s10 + &lastScanTimeShort
  endif
  
  // Check if the timer's gone over our threshold, in which case swap states
  if &FS01_StateChangeTimeAcc_s10 >= FS01_COUNT_BEFORE_OFF_s10 then
    |FS01_I = OFF    
    &FS01_StateChangeTimeAcc_s10 = 0
  endif
endif


// If it's currently off and the signal goes on, make sure the signal stays on
// for a few scans before we consider the flow switch to have changed states.
if |FS01_I = OFF then
  // Update the counter
  if |FS01_I_Raw = OFF then
    // The raw signal is the same as the value, check if we should decrement the timer
    if &FS01_StateChangeTimeAcc_s10 > 0 then
      &FS01_StateChangeTimeAcc_s10 = &FS01_StateChangeTimeAcc_s10 - &lastScanTimeShort
      if &FS01_StateChangeTimeAcc_s10 < 0 then
        &FS01_StateChangeTimeAcc_s10 = 0
      endif 
    endif
  else
    // The raw signal is different, increment the timer
    &FS01_StateChangeTimeAcc_s10 = &FS01_StateChangeTimeAcc_s10 + &lastScanTimeShort
  endif
  
  // Check if the timer's gone over our threshold, in which case swap states
  if &FS01_StateChangeTimeAcc_s10 >= FS01_COUNT_BEFORE_ON_s10 then
    |FS01_I = ON    
    &FS01_StateChangeTimeAcc_s10 = 0
  endif
endif

