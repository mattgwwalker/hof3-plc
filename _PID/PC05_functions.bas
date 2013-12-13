// Freeze PC05 with CV01 in a fully-open state 
PC05freezeOpen:
  if &PC05freezeState = PC05freezeState_NORMAL then
    &PC05freezeValue = &PC05cv
    &PC05freezeState = PC05freezeState_FROZEN
  endif
  &PC05cv = 0 // CV01 fully-open
return



// Freeze PC05 with CV01 in its previous state
PC05freezePrevious:
  if &PC05freezeState = PC05freezeState_NORMAL then
    &PC05freezeValue = &PC05cv
    &PC05freezeState = PC05freezeState_FROZEN
  endif
  &PC05cv = &PC05freezeValue
return


  
// Unfreeze PC05
PC05unfreeze:
  if &PC05freezeState = PC05freezeState_FROZEN then
    &PC05cv = &PC05freezeValue
    &PC05freezeState = PC05freezeState_NORMAL
  endif
return

