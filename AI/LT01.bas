//LT01 - Feed Tank Level

if &LT01_100 > 300 then // 300 = 3%
  // Level is over the minimum threshold for detection and something is
  // being detected
  &fd100FeedTankState = fd100TankState_NOT_EMPTY
endif