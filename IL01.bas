//********************************************************************************
//IL01 Push Button LED Light
//

if (|fd100Fault_IL01fault = ON) then
 &IL01timerAcc = &IL01timerAcc + &lastScanTimeShort
 if (&IL01timerAcc<=&IL01faultOnTime) then
  |IL01_O = ON
 else
  |IL01_O = OFF
  if (&IL01timerAcc>(&IL01faultOnTime+&IL01faultOffTime)) then
   &IL01timerAcc=0
  endif
 endif

elsif (|fd100_IL01waiting = ON) then
 &IL01timerAcc = &IL01timerAcc + &lastScanTimeShort
 if (&IL01timerAcc<=&IL01waitingOnTime) then
  |IL01_O = ON
 else
  |IL01_O = OFF
  if (&IL01timerAcc>(&IL01waitingOnTime+&IL01waitingOffTime)) then
   &IL01timerAcc=0
  endif
 endif

elsif (|fd100_IL01 = ON) then
 &IL01timerAcc = 0
 |IL01_O = ON
else
 |IL01_O = OFF
 &IL01timerAcc = 0
endif






