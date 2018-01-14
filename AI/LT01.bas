//LT01 - Feed Tank Level

if &LT01_100 > LT01_MIN_RELIABLE_LEVEL then
  // Level is over the minimum threshold for detection and something is
  // being detected
  &fd100FeedTankState = fd100TankState_NOT_EMPTY
endif