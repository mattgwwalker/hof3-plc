//FD102 CIP Chemical Dose Sequence

//Clear Sequence Outputs... these are then set on below
&fd102ProgOut01 = 0
&tempStepNum = &fd102StepNum

select &tempStepNum
 case  fd102StepNum_RESET:
  if ((|fd100_fd102_chemdoseEn1 = ON)\
   and (&fd100FillSource = fd100FillSource_AUTO_CHEM)) then
    &tempStepNum = fd102StepNum_DOSECHEM
  endif
  
 case  fd102StepNum_DOSECHEM:
  if ((&fd102StepTimeAcc_m >= &fd102StepTimePre_DOSECHEM_m) \
  and (&fd102StepTimeAcc_s10 >= &fd102StepTimePre_DOSECHEM_s10)) then
   &tempStepNum = fd102StepNum_PURGE
  endif
  if ((|fd100_fd102_chemdoseEn1 = OFF)\
   or (&fd100FillSource != fd100FillSource_AUTO_CHEM)) then
    &tempStepNum = fd102StepNum_RESET
  endif
  
 case  fd102StepNum_PURGE:
  if ((&fd102StepTimeAcc_m >= &fd102StepTimePre_PURGE_m) \
  and (&fd102StepTimeAcc_s10 >= &fd102StepTimePre_PURGE_s10)) then
   &tempStepNum = fd102StepNum_END
  endif
  if ((|fd100_fd102_chemdoseEn1 = OFF)\
   or (&fd100FillSource != fd100FillSource_AUTO_CHEM)) then
    &tempStepNum = fd102StepNum_RESET
  endif
 
 case  fd102StepNum_END:
  if ((|fd100_fd102_chemdoseEn1 = OFF)\
   or (&fd100FillSource != fd100FillSource_AUTO_CHEM)) then
    &tempStepNum = fd102StepNum_RESET
  endif    
        
 default:
  &tempStepNum = fd102StepNum_RESET
endsel

IF (&tempStepNum != &fd102StepNum) THEN
 &fd102StepNum = &tempStepNum
 &fd102StepTimeAcc_s10 = 0
 &fd102StepTimeAcc_m = 0
 select &tempStepNum
  case  fd102StepNum_RESET:
  
  case  fd102StepNum_DOSECHEM:
  
  case  fd102StepNum_PURGE:
 
  case  fd102StepNum_END:         
  
  default:
 endsel
ENDIF

select &tempStepNum
 case  fd102StepNum_RESET:
 
 case  fd102StepNum_DOSECHEM:
  if (|fd100Fault_fd102_Pause=OFF) then
   &fd102StepTimeAcc_s10 = &fd102StepTimeAcc_s10 + &lastScanTimeShort
  endif
  |fd102_DV06=ON
  |fd102_IV09=ON
  |fd102_PP02=ON
  |fd102_fd100_dosingChem=ON
  
 case  fd102StepNum_PURGE:
  if (|fd100Fault_fd102_Pause=OFF) then
   &fd102StepTimeAcc_s10 = &fd102StepTimeAcc_s10 + &lastScanTimeShort
  endif
  |fd102_DV06=ON
  |fd102_IV10=ON
  |fd102_fd100_dosingChem=ON
 
 case  fd102StepNum_END:    
         
 default:
endsel

if (&fd102StepTimeAcc_s10 > 599) then
  &fd102StepTimeAcc_s10 = 0
  &fd102StepTimeAcc_m = &fd102StepTimeAcc_m + 1
endif
if (&fd102StepTimeAcc_m > 32000) then
  &fd102StepTimeAcc_m = 32000
endif

