// This macro is run every time the power is cycled.

reset_macro:
  |SP1=OFF
  |SP2=OFF
  |SP3=OFF
  |SP4=OFF

  &displayStepNumber = 0
  &fd100StepNum = 0
  &fd100StepTimeAcc = 0
  &fd101StepNum = 0
  &fd101StepTimeAcc = 0
  &R01 = 1.0
  &R01_last = 1.0
  &V1 = 0.0
  &V1x_last = 0.0
  &V2x = 0.0
  &V3x = 0.0

  // Set all valves to automatic
  &IV01cmd = 1
  &IV02cmd = 1
  &IV03cmd = 1
  &IV04cmd = 1
  &IV05cmd = 1
  &IV06cmd = 1
  &IV07cmd = 1
  &IV08cmd = 1
  &IV09cmd = 1
  &IV10cmd = 1
  &IV15cmd = 1
  &IV16cmd = 1
  &DV01cmd = 1
  &DV02cmd = 1
  &DV03cmd = 1
  &DV04cmd = 1
  &DV05cmd = 1
  &DV06cmd = 1

  // Set all pumps to automatic
  &PP01cmd = 1
  &PP02cmd = 1
  &PP03cmd = 1
  
  // Set PID controllers to auto
  &PC01cmd = 1
  &DPC01cmd = 1
end

