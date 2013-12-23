// DPT02_1000: Across bag-filter pressure drop

&DPT02_1000 = &PT04_1000 - &PT01_1000

if &DPT02_1000 <= &DPT02SP01 then
  // Bag filter pressure drop is below the fault level, so reset fault timer
  &DPT02_FaultTimeAcc_s10 = 0
  &DPT02_FaultTimeAcc_m = 0
else
  // Bag filter pressure drop is above the fault level, increment fault timer
  &DPT02_FaultTimeAcc_s10 = &DPT02_FaultTimeAcc_s10 + &lastScanTimeShort
endif

// Increment timer
if (&DPT02_FaultTimeAcc_s10 > 599) then
  &DPT02_FaultTimeAcc_s10 = 0
  &DPT02_FaultTimeAcc_m = &DPT02_FaultTimeAcc_m + 1
endif
if (&DPT02_FaultTimeAcc_m > 32000) then
  &DPT02_FaultTimeAcc_m = 32000
endif
