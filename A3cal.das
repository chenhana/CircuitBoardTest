 TITLE A3 Calibration 
// Version 07.02.97
 TEXT WINDOW Advanced Calibration & Verification for A3
 LOG OPEN \HARDWARE\a3cal.LOG
 LOG MODE 3
 TEXT LOG A3 - started %D at %T
 TEXT LOG %T
 SET ACCURACY 0.015
 SET LINEWIDTH 0.250
 SET RADIUS 150.000
 SET DELAY 250
 SET DISTANCE 2.5+RANDOM(1.5)
 SET XSTEP 25.0
 SET YSTEP 12.5
 SET VIDEOY 50.0
 SET VIDEODELAY 1000.0
 SET VIDEODELTA 0.015
 SET REFSIZE 0.5
 SET CAMERADIST 45.0
 SET VIDEOLENGTH 360.0
 SET ROTSHIFT 0.0
 SET SHRINKAGE 0.000
 SET IDEALBOARD 1
 SET MAXSHIFT 5.0
 DEFINE ZSTROKE 50.0
 DEFINE ZPRESSURE 50.0
 DEFINE ZHEIGHT 3.0
 DEFINE REALHEIGHT %70
 DEFINE ENCDIST 87.5
 DEFINE BELTDIST 0.0
 DEFINE HARDWAREPORT 0xF0
 DEFINE TEMPERATUREPORT 0x2011

 DEFINE BRAIL %99               // Rail to start from on top side
 DEFINE ERAIL %98               // Rail to end with on top side
 DEFINE XMIN %97                // fing X-coordinate to start
 DEFINE XMAX %96                // fing X-coordinate to finish 
 DEFINE XSTEP %95               // fing step in X-direction
 DEFINE XMINC %94               // cam X-coordinate to start
 DEFINE XMAXC %93               // cam X-coordinate to finish
 DEFINE XSTEPC %92              // cam Step in X-direction
 DEFINE XREF %91                // X offset of REF points
 DEFINE YREF %90                // Y offset of REF points
 DEFINE XOFFSET %79             // During verification
 DEFINE YOFFSET %78             // During verification
 DEFINE XMID %77                // Rotation center-X 
 DEFINE YMID %76                // Rotation center-Y    
 DEFINE FI %75                  // Rotation ANGLE       
 DEFINE F %74                   // Rotation ANGLE       
 DEFINE T1 %73                  // Temporal1
 DEFINE T2 %72                  // Temporal2
 DEFINE LIGHTS %71              // Type of the light source
 DEFINE DX %70
 DEFINE DY %69
 DEFINE VXMIN %68               // MIN X verification
 DEFINE VSTEPX %67              // Step X verification
 DEFINE VYMIN %66               // Step y verification
 DEFINE VSTEPY %65              // Step y verification
 DEFINE MCMGL %64               // Flag for mcm-glassboard

 DEFINE I %1 
 DEFINE J %2 
 DEFINE K %3 
 DEFINE L %4 
 DEFINE M %5 
 DEFINE N %6 
 DEFINE O %7
 DEFINE TM %9
 DEFINE XI %10
 DEFINE YI %11

 BRAIL=0
 ERAIL=LAYOUT.NFING/2-1
 XREF=3.5
 YREF=3.5
 XMIN=25
 XMAX=425
 MCMGL=0
 STROKE ZSTROKE ZPRESSURE 25.0

TEXT CLEAR
 CMD 1 GETLAYOUT
 Text 0 -Getting layout...
 TM=TIME()+15000.0
waitlayout:
 IF ANSWER[1]==0x07 GOTO layoutgot
 IF TIME()<TM GOTO waitlayout
 TEXT 5 +ATTENTION!  Tester is not ready.
 TEXT 4 Calibration procedure is unable to get layout.
 TEXT 3 * Tester is not loaded, or
 TEXT 2 * Tester is off/not connected, or
 TEXT 1 * Test Player is active
 TEXT 0 +Please correct problem and restart calibration.
 BUTTONS
 TEXT WINDOW Calibration terminated
 TEXT LOG %T Unable to get layout - calibration terminated
 STOP
layoutgot:
 CALL testerbmp
 CMD 0 DEFBOARD 0.0 0.0 450.0 400.0
 BRAIL=0
 ERAIL=LAYOUT.NFING/2-1
 XREF=3.5
 YREF=3.5
 CMD 1 INPORT TEMPERATUREPORT
 %1=INPORT[1]/10.0
 TEXT LOG %T Initial tester temperature is %1 øC
 IF %1>=22.0 && %1<=28.0 GOTO temperatureok
 IF %1<22.0 TEXT 5 +ATTENTION!  Low temperature!
 IF %1>28.0 TEXT 5 +ATTENTION!  High temperature!
 TEXT 3 Tester temperature is %1 øC. It is
 TEXT 2 recommended that during calibration
 TEXT 1 temperature lies in the range [22..28] øC.
 TEXT 0 Otherwise, accuracy is not guaranteed.
 TEXT LOG %T This temperature lies outside the recommended limits
 BUTTONS Continue
 WAIT BUTTONS
 CALL cls
 temperatureok:
  
 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 *     For normal FR4 calibration select       *
 TEXT 4 +*                 Standard                    *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 *                  Advanced                   *
 TEXT 0 ***********************************************
 BUTTONS Standard Advanced
 WAIT BUTTONS advanced
 BUTTONS
// Load FR4 Board in Shuttle
// Zero corrections
// Train Cognex
// Check board position electricaly
// Scan Layout
// Load new Layout in tester
// Calibrate fingers
// Calibrate Cameras
// Save camera layout in flayout.bin
// Save Rail0L.cor Corrections
// Load corrections
// Verify
// end
 CALL lightselect
 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *          Standard FR4 Calibration           *                       
 TEXT 5 *                                             *
 TEXT 4 ***********************************************
 CALL cls
 BRAIL=0
 ERAIL=LAYOUT.NFING/2-1
standard:
 XREF=3.5
 YREF=3.5
 DO I=0,LAYOUT.NFING,1
 CENTER I LAYOUT.CENTERX LAYOUT.CENTERY[I]
 ENDDO
 CLEAR CORR
 TEXT 5 -*         Zeroing correction tables           *
 TEXT 4 ***********************************************
 LOADCORR
 CMD 0 DEFBOARD 0.0 0.0 450.0 400.0
 CALL cognex
 CALL instfr4

 XMIN=25
 XMAX=425
 XREF=3.5
 YREF=3.5
 CALL chkboard
 CALL chkheight

 BUTTONS
 SET REFSIZE 1.5
 CLEAR SCAN

 CALL refselect
 CALL chky
 CALL testerbmp
 CALL heatup
 CLEAR SCAN
 CALL scanlayout


 BITMAP finggrid
 TEXT 5 -*            Calibrating Fingers              *
 TEXT 4 ***********************************************
 TEXT LOG %T Electrical finger calibration
 CMD 1 INPORT TEMPERATUREPORT
 WAIT CMD 1
 %1=INPORT[1]/10.0
 TEXT LOG %T Tester temperature is %1 øC

 CLEAR SCAN
 XSTEP=50
 CALL scstrfin
 CALL elscan

 CMD 1 INPORT TEMPERATUREPORT
 %1=INPORT[1]/10.0
 TEXT LOG %T Tester temperature is %1 øC

 CALL badpoints
 CALL xycorrection

 TEXT INFO
 TEXT 0 -Calculating corrections...
 DO %2=0,2*LAYOUT.NFING-1,1
  %1=C_CORR(%2,ENCDIST,BELTDIST,0.20)
  TEXT LOG %T Finger %F2: %1 points bad on the first pass
  IF %1!=0 %1=C_CORR(%2,ENCDIST,BELTDIST,0.20)
  IF %1!=0 TEXT LOG %T Finger %F2: %1 points bad on the second pass
  IF %1!=0 %1=C_CORR(%2,ENCDIST,BELTDIST,0.20)
  IF %1!=0 TEXT LOG %T Finger %F2: %1 points bad on the third pass!!!
 ENDDO
 LOADCORR

 TEXT 5 -*         Calibrating video cameras           *
 TEXT 4 ***********************************************
 TEXT LOG %T Video cameras calibration
 CLEAR SCAN
 XMINC=25
 XMAXC=425
 XSTEPC=50
 CALL scstrcam

 VIDEO 0.5
 IF LIGHTS==0 CALL videoscan
 IF LIGHTS==1 CALL mvideoscan
 IF LIGHTS==2 CALL xvideoscan

 %1=C_VIDEOCORR(2*LAYOUT.NFING,0.2)+C_VIDEOCORR(2*LAYOUT.NFING+1,0.2)
 TEXT 1 -%1 points considered bad on the first pass
 TEXT LOG %T %1 points considered bad on the first pass
 TEXT 0
 %1=C_VIDEOCORR(2*LAYOUT.NFING,0.2)+C_VIDEOCORR(2*LAYOUT.NFING+1,0.2)
 TEXT 0 -%1 points considered bad on the second pass
 TEXT LOG %T %1 points considered bad on the second pass
 LOADCORR
 DELAY 1000
 
TEXT 0 -Saving layout and correction data...
savelayout:
 %1=SAVELAYOUT(\hardware\f_layout.bin)
 IF %1!=0 GOTO layoutsaved
 TEXT 4 +ATTENTION!  Layout not saved!
 TEXT 3 This means that entire calibration will be
 TEXT 2 cancelled! Please select proper layout name
 TEXT 1 (default is \HARDWARE\F_LAYOUT.BIN) or press
 TEXT 0 Close to quit calibration.
 GOTO savelayout
layoutsaved:
 TEXT LOG %T Layout (%D) succesfully saved
 DO %2=0,2*LAYOUT.NFING+1,1
savecorr:
  %1=SAVECORR(%2,\hardware\rail0l.cor)
  IF %1!=0 GOTO corrsaved
  TEXT 5 +ATTENTION!  Correction %F2 not saved!
  TEXT 4 This means that entire calibration will be
  TEXT 3 cancelled! Please select proper file name
  TEXT 2 (default is \HARDWARE\RAILnm.COR) or press
  TEXT 1 Close to quit calibration (and do not
  TEXT 0 forget to restore old layout and .COR's!)
  GOTO savecorr
corrsaved:
 ENDDO
 TEXT LOG %T Corrections (%D) succesfully saved
 IF MCMGL==1 GOTO finish
 CALL cls
 TEXT 5 -*                Verification                 *
 TEXT 4 ***********************************************
 CLEAR SCAN
 DO M=BRAIL,ERAIL,1
  DO I IN M,M+LAYOUT.NFING/2
   DO K=12.5,187.5,87.5
    L=K+LAYOUT.BOTTOM[I]
    DO J=50,400,175
     PAD (I*2) J L
     PAD (I*2+1) J L
     PAD LAYOUT.NFING*2+LAYOUT.SIDE[I] J L
    ENDDO
   ENDDO
  ENDDO
 ENDDO
CALL verify2 
finish:
 BUTTONS
 TEXT INFO
 TEXT 1 +CALIBRATION FINISHED SUCCESFULLY
 TEXT 0 Tester is ready for the normal operation.
 TEXT WINDOW Calibration finished
 TEXT LOG Calibration finished succesfully %D at %T
STOP

advanced:
 
 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *   For Verification of calibration results   *
 TEXT 5 *                  Select                     *
 TEXT 4 +*                  Verify                     *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                  Next                       *
 TEXT 0 ***********************************************
 BUTTONS Next Verify 
 WAIT BUTTONS verify
// Load FR4 Board in Shuttle
// Load layout and Rail**.cor
// Train Cognex
// Check board position electricaly
// Scan FR4 board electricaly
// Scan FR4 board opticaly
// Subtract offset and rotation
// Show results graphically
// Save information in *.log file
// end

 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 *     For Partial A2 calibration Select       *
 TEXT 4 +*                 Partial                     *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                  Next                       *
 TEXT 0 ***********************************************
 BUTTONS Next Partial
 WAIT BUTTONS partial

 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 *          To leave this menu Select          *
 TEXT 4 +*                   Exit                      *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                   Next                      *
 TEXT 0 ***********************************************
 BUTTONS Next Exit 
 WAIT BUTTONS exit
GOTO advanced

 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 * For MCM-calibration with Glass-board Select *
 TEXT 4 +*                 CalMCM                      *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                  Next                       *
 TEXT 0 ***********************************************
 BUTTONS Next CalMCM
 WAIT BUTTONS calmcm
// Load Glass Board in Shuttle
// Zero corrections
// Train Cognex
// Check board position electricaly
// Scan Layout
// Load new Layout in tester
// Calibrate fingers
// Calibrate Cameras
// Save camera layout in flayout.bin
// Save Rail0L.cor Corrections
// Load corrections
// Verify
// end

 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 * For Measuring of the FR4 Calibration Board  *
 TEXT 5 *                 Select                      *
 TEXT 4 +*                 Measure                     *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                  Next                       *
 TEXT 0 ***********************************************
 BUTTONS Next Measure 
 WAIT BUTTONS measure
// Load FR4 Board in Shuttle
// Load layout for the Glass board from debug.ini
// Load Camera corrections Glas0L.cor
// Train Cognex
// Check board position electricaly
// Scan FR4 board opticaly
// Save Scan-results in debug.ini file
// end

 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 *    For Precise Camera calibration Select    *
 TEXT 4 +*                 GlassCam                    *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                  Next                       *
 TEXT 0 ***********************************************
 BUTTONS Next GlassCam 
 WAIT BUTTONS glasscam
// Load Glass Board in Shuttle
// Load layout for the Glass board if exists from debug.ini
// Zero corrections
// Train Cognex
// Check board position electricaly
// Scan Camera-layout
// Load new Layout in tester
// Calibrate cameras
// Save camera layout in debug.ini file
// Save Glas0L.cor Camera Corrections
// end

 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 *   For Calibration with Glass-board Select   *
 TEXT 4 +*                 CalGlass                    *
 TEXT 3 *                                             *
 TEXT 2 *          For other features select          *
 TEXT 1 -*                  Next                       *
 TEXT 0 ***********************************************
 BUTTONS Next CalGlass 
 WAIT BUTTONS calglass
// Load Glass Board in Shuttle
// Zero corrections
// Train Cognex
// Check board position electricaly
// Scan Layout
// Load new Layout in tester
// Calibrate fingers
// Calibrate Cameras
// Save camera layout in flayout.bin
// Save Rail0L.cor Corrections
// Load corrections
// Verify
// end


measure:

glasscam:

calglass:

calmcm:
 MCMGL=1
 LIGHTS=1
 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *           MCM Glass Calibration             *                       
 TEXT 5 *                                             *
 TEXT 4 ***********************************************
 CALL cls
 BRAIL=0
 ERAIL=LAYOUT.NFING/2-1
 XREF=142.5
 YREF=3.5
 DO I=0,LAYOUT.NFING,1
  CENTER I LAYOUT.CENTERX LAYOUT.CENTERY[I]
 ENDDO
 CLEAR CORR
 TEXT 5 -*         Zeroing correction tables           *
 TEXT 4 ***********************************************
 LOADCORR
 CMD 0 DEFBOARD 145.0 0.0 455.0 620.0
 CALL cognex
 // CALL instfr4

 XMIN=150
 XMAX=450
 XREF=142.5
 YREF=3.5
 CALL chkboard
 CALL chkheight

 BUTTONS
 SET REFSIZE 1.5
 CLEAR SCAN

 CALL refselect
 CALL chky
 CALL testerbmp
 CALL heatup
 CLEAR SCAN
 CALL scanlayout


 BITMAP finggrid
 TEXT 5 -*            Calibrating Fingers              *
 TEXT 4 ***********************************************
 TEXT LOG %T Electrical finger calibration
 CMD 1 INPORT TEMPERATUREPORT
 WAIT CMD 1
 %1=INPORT[1]/10.0
 TEXT LOG %T Tester temperature is %1 øC

 CLEAR SCAN
// XSTEP=50
 XSTEP=25
 CALL scstrfin
 CALL elscan

 CMD 1 INPORT TEMPERATUREPORT
 %1=INPORT[1]/10.0
 TEXT LOG %T Tester temperature is %1 øC

 CALL badpoints

 TEXT INFO
 TEXT 0 -Calculating corrections...
 DO %2=0,2*LAYOUT.NFING-1,1
  %1=C_CORR(%2,ENCDIST,BELTDIST,0.20)
  TEXT LOG %T Finger %F2: %1 points bad on the first pass
  IF %1!=0 %1=C_CORR(%2,ENCDIST,BELTDIST,0.20)
  IF %1!=0 TEXT LOG %T Finger %F2: %1 points bad on the second pass
  IF %1!=0 %1=C_CORR(%2,ENCDIST,BELTDIST,0.20)
  IF %1!=0 TEXT LOG %T Finger %F2: %1 points bad on the third pass!!!
 ENDDO
 LOADCORR
 DELAY 1000

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

GOTO savelayout


 TEXT 5 -*         Calibrating video cameras           *
 TEXT 4 ***********************************************
 TEXT LOG %T Video cameras calibration
 CLEAR SCAN
 XMINC=150
 XMAXC=450
// XSTEPC=50
 XSTEPC=25
 CALL scstrcam

 VIDEO 0.5
 CALL mvideoscan

 %1=C_VIDEOCORR(2*LAYOUT.NFING,0.2)+C_VIDEOCORR(2*LAYOUT.NFING+1,0.2)
 TEXT 1 -%1 points considered bad on the first pass
 TEXT LOG %T %1 points considered bad on the first pass
 TEXT 0
 %1=C_VIDEOCORR(2*LAYOUT.NFING,0.2)+C_VIDEOCORR(2*LAYOUT.NFING+1,0.2)
 TEXT 0 -%1 points considered bad on the second pass
 TEXT LOG %T %1 points considered bad on the second pass
 LOADCORR
 DELAY 1000
 TEXT 0 -Saving layout and correction data...
GOTO savelayout
 
partial:
// Load FR4 Board in Shuttle
// Zero corrections
// Select Rails
CALL lightselect
BRAIL=0
ERAIL=LAYOUT.NFING/2-1
T1=BRAIL+LAYOUT.NFING/2
T2=ERAIL+LAYOUT.NFING/2
GRAPH INIT // 350 x 260 pixels
 GRAPH COLOR LIGHT
  DO L=0,LAYOUT.NFING/2-1,1
    GRAPH MOVE 85 45*L+40
    GRAPH LINE 180+85 45*L+40
    GRAPH LINE 180+85 45*L+45+40
    GRAPH LINE 85 45*L+45+40
    GRAPH LINE 85 45*L+40
  ENDDO
 GRAPH DISPLAY
 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 *                                             *
 TEXT 5 *       Exclude Rails from Calibration        *
 TEXT 4 *          using positioning buttons          *
 TEXT 3 *                                             *
 TEXT 2 ***********************************************
 BUTTONS Ready
partial1:
 T1=BRAIL+LAYOUT.NFING/2
 T2=ERAIL+LAYOUT.NFING/2
 TEXT 1 +TOP     Rail %99  -  Rail %98 will be calibrated
 TEXT 0 +BOTTOM  Rail %73  -  Rail %72 will be calibrated
 I=0
 J=0
 IF PRESSED(1) GOTO partial2
 GETOFFSET I J
 BRAIL=BRAIL+J
 ERAIL=ERAIL+I
 IF BRAIL<0 BRAIL=0
 IF BRAIL>LAYOUT.NFING/2-1 BRAIL=LAYOUT.NFING/2-1
 IF ERAIL<0 ERAIL=0
 IF ERAIL>LAYOUT.NFING/2-1 ERAIL=LAYOUT.NFING/2-1
 IF ERAIL<BRAIL ERAIL=BRAIL
 IF I!=0 || J!=0 CALL showrails
 GOTO partial1
partial2:
 TEXT 7 ***********************************************
 TEXT 6 *             Partial Calibration             *
 CALL cls
GOTO standard
// Train Cognex
// Check board position electricaly
// Scan Layout
// Load new Layout in tester
// Calibrate fingers
// Calibrate Cameras
// Save camera layout in flayout.bin
// Save Rail0L.cor Corrections
// Load corrections
// Verify
// end
exit:

verify:
 CALL lightselect
 CALL testerbmp
 TEXT 7 ***********************************************
 TEXT 6 *                Verification                 *
 TEXT 5 -*             Loading corrections             *
 TEXT 4 ***********************************************
 DO I=0,2*LAYOUT.NFING+1,1
  K=READCORR(I,\hardware\rail0l.cor)
 ENDDO
 LOADCORR
 CALL cognex
 CALL refselect
 CALL chkboard
 CALL chkheight
 TEXT 5 *       Select points for verification        *
 DATA[0]=225,25,25,25,25      // start X
 DATA[1]=1,200,100,50,25	         // step X
 DATA[2]=87.5,0,0,0,0                     	// start Y
 DATA[3]=1,175,87.5,25,12.5                 // step Y
 I=3
 J=3
verify1:
 O=0
 VXMIN=DATA[0][I]
 VSTEPX=DATA[1][I]
 VYMIN=DATA[2][J]
 VSTEPY=DATA[3][J]
 GRAPH INIT // 350 x 260 pixels
 GRAPH COLOR LIGHT
 DO N=0,18,1
  GRAPH MOVE N*12.5+62 0
  GRAPH LINE N*12.5+62 260
 ENDDO
 DO N=0,16,1
  GRAPH MOVE 0 N*15+10 
  GRAPH LINE 350 N*15+10 
 ENDDO
 GRAPH COLOR RED
 DO M=VXMIN/2,(450-VXMIN)/2,VSTEPX/2
  DO N=VYMIN*1.2,(175-VYMIN)*1.2,VSTEPY*1.2
   GRAPH MOVE M-5+62 N-5+25
   GRAPH LINE M+5+62 N+5+25
   GRAPH MOVE M-5+62 N+5+25
   GRAPH LINE M+5+62 N-5+25
   O=O+1
  ENDDO
 ENDDO
 GRAPH DISPLAY
 BUTTONS READY
verify4:
 K=I
 L=J
 IF PRESSED(1) GOTO verify3
 GETOFFSET I J
 IF I<0 I=0
 IF J<0 J=0
 IF I>6 I=6
 IF J>4 J=4
 TEXT 0 %7 Points for Verification per Rail
 IF I==K && J==L GOTO verify4
 GOTO verify1
verify3:
 SET NEAREST 0.5
 CLEAR SCAN
 DO M=BRAIL,ERAIL,1
  DO I IN M,M+LAYOUT.NFING/2
   DO K=12.5+VYMIN,187.5-VYMIN,VSTEPY
    L=K+LAYOUT.BOTTOM[I]
    DO J=VXMIN,450-VXMIN,VSTEPX
     PAD (I*2) J L
     PAD (I*2+1) J L
     PAD LAYOUT.NFING*2+LAYOUT.SIDE[I] J L
    ENDDO
   ENDDO
  ENDDO
 ENDDO
verify2: 
 CALL cls
 CMD 1 INPORT TEMPERATUREPORT
 %1=INPORT[1]/10.0
 TEXT LOG Temperature at the beginning of the verification is %1 øC.
 TEXT 5 -*             Verifying Fingers               *
 TEXT 4 ***********************************************
 CALL elscan
 TEXT 5 -*             Verifying Cameras               *
 TEXT 4 ***********************************************
 IF LIGHTS==0 CALL videoscan
 IF LIGHTS==1 CALL mvideoscan
 IF LIGHTS==2 CALL xvideoscan
 CMD 3 INPORT TEMPERATUREPORT
 %1=INPORT[3]/10.0
 TEXT LOG Temperature at the end of the test is %1 øC.
 DO J IN 0,LAYOUT.NFING/2
  K=0
  DO I=J+BRAIL,J+ERAIL,1
   TEXT LOG
   TEXT LOG -------------------------- Rail %1 ----------------------------
   TEXT LOG   X   |   Y  |   dX LF| dY LF| dX RF| dY RF|dX Cam|dY Cam
   TEXT LOG 
   DO L=0,SCAN[2*I].NGRID-1,1
    %10=SCAN[2*I].GRIDX[L]
    %11=SCAN[2*I].GRIDY[L]
    %12=SCAN[2*I].MEASX[L]-%10
    %13=SCAN[2*I].MEASY[L]-%11
    %14=SCAN[2*I+1].MEASX[L]-%10
    %15=SCAN[2*I+1].MEASY[L]-%11
    %16=SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].MEASX[K]-%10
    %17=SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].MEASY[K]-%11
    TEXT LOG %10.6.3 %11.6.3 %12.6.3 %13.6.3 %14.6.3 %15.6.3 %16.6.3 %17.6.3
    K=K+1
   ENDDO
   TEXT LOG ----------------------------------------------------------------
  ENDDO
 ENDDO


 CALL xyoffset
 CALL showview
 TEXT WINDOW Calibration finished
 LOG CLOSE
 STOP
quit:
 BUTTONS
 TEXT LOG %T Calibration terminated
 LOG CLOSE
 TEXT WINDOW Calibration terminated
 STOP

showview:
 TEXT 6 *            Calibration is finished          *
 TEXT 5 -*                 Data Viewer                 *
 TEXT 4 ***********************************************
 TEXT 3 +Use mouse to see exact values of deviations
 TEXT 2 RED   - Left finger
 TEXT 1 GREEN - Right finger
 TEXT 0 BLUE  - Camera
 GRAPH INIT // 350 x 260 pixels
 DO K IN 0,LAYOUT.NFING/2
  DO I=K+BRAIL,K+ERAIL,1
   TEXT INFO RAIL %1 
   GRAPH COLOR LIGHT
   DO N=0,18,1
    GRAPH MOVE N*12.5+62 0
    GRAPH LINE N*12.5+62 259
   ENDDO
   DO N=0,16,1
    GRAPH MOVE 0 N*15+10 
    GRAPH LINE 349 N*15+10 
   ENDDO
   DO J=0,SCAN[2*I].NGRID-1,1
    XI=SCAN[2*I].GRIDX[J]/2+62 // Pixel in X direction to begin
    YI=(SCAN[2*I].GRIDY[J]-200*(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2)-12.5)*1.2+25    // Pixel in Y direction to begin
    GRAPH COLOR RED             // Left finger
    GRAPH MOVE XI YI
    GRAPH LINE XI+(SCAN[2*I].MEASX[J]-SCAN[2*I].GRIDX[J])*500 YI+(SCAN[2*I].MEASY[J]-SCAN[2*I].GRIDY[J])*500
    GRAPH COLOR GREEN           // Right finger
    GRAPH MOVE XI YI
    GRAPH LINE XI+(SCAN[2*I+1].MEASX[J]-SCAN[2*I+1].GRIDX[J])*500 YI+(SCAN[2*I+1].MEASY[J]-SCAN[2*I+1].GRIDY[J])*500
    GRAPH COLOR BLUE            // Camera
    GRAPH MOVE XI YI
    GRAPH LINE XI+(SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].MEASX[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+J]-SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].GRIDX[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+J])*500 YI+(SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].MEASY[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+J]-SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].GRIDY[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+J])*500
   ENDDO
   GRAPH DISPLAY
   BUTTONS NEXT_RAIL
mouse:
   L=MOUSEX()
   M=MOUSEY()
   DO O=0,SCAN[2*I].NGRID-1,1
     IF (ABS((SCAN[2*I].GRIDX[O]/2-L+62))>20)||(ABS(((SCAN[2*I].GRIDY[O]-200*(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2))*1.2-M+15))>10) GOTO showview1
     DX=SCAN[2*I].MEASX[O]-SCAN[2*I].GRIDX[O]
     DY=SCAN[2*I].MEASY[O]-SCAN[2*I].GRIDY[O]
     TEXT 2 Left  Finger dX=%70.3.3  dY=%69.3.3
     DX=SCAN[2*I+1].MEASX[O]-SCAN[2*I+1].GRIDX[O]
     DY=SCAN[2*I+1].MEASY[O]-SCAN[2*I+1].GRIDY[O]
     TEXT 1 Right Finger dX=%70.3.3  dY=%69.3.3
     DX=SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].MEASX[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+O]-SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].GRIDX[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+O]
     DY=SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].MEASY[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+O]-SCAN[2*LAYOUT.NFING+LAYOUT.SIDE[I]].GRIDY[(I-LAYOUT.SIDE[I]*LAYOUT.NFING/2-BRAIL)*SCAN[I].NGRID+O]
     TEXT 0 Camera       dX=%70.3.3  dY=%69.3.3
showview1:     
     ENDDO
   IF PRESSED(1)!=1 GOTO mouse
   GRAPH INIT
 TEXT 3 +Use mouse to see exact values of deviations
 TEXT 2 RED   - Left finger
 TEXT 1 GREEN - Right finger
 TEXT 0 BLUE  - Camera
  ENDDO
 ENDDO
 GOTO showview
RETURN

quit:
 BUTTONS
 TEXT INFO
 TEXT WINDOW Calibration terminated
 TEXT LOG %T Calibration terminated
 STOP

// Necessary functions

// Select REF poins
refselect:
 DO I=0,LAYOUT.NFING-2,2
  REF I 450-XREF 200-YREF+100*%1
  REF (I+1) XREF YREF+100*%1
  REF (I+LAYOUT.NFING) 450-XREF 200-YREF+100*%1
  REF (I+1+LAYOUT.NFING) XREF YREF+100*%1
 ENDDO
RETURN

// Select Rails


// Scan layout

// Calibrate Fingers

// Define scan-structure
scstrfin:
 DO I=BRAIL,ERAIL,1
  DO J=XMIN,XMAX,XSTEP
   DO K IN I,I+LAYOUT.NFING/2
    PAD K*2 J LAYOUT.CENTERY[K]-ENCDIST
    PAD K*2 J LAYOUT.CENTERY[K]+ENCDIST
    PAD K*2+1 J LAYOUT.CENTERY[K]-ENCDIST
    PAD K*2+1 J LAYOUT.CENTERY[K]+ENCDIST
   ENDDO
  ENDDO
 ENDDO
RETURN

// Calibrate Cameras
// Define scan-structure
scstrcam:
 DO I=LAYOUT.BOTTOM[BRAIL],LAYOUT.TOP[ERAIL],100.     // Std
  DO J=XMINC,XMAXC,XSTEPC
   PAD (2*LAYOUT.NFING) J I
   PAD (2*LAYOUT.NFING+1) J I 
  ENDDO
  IF I==LAYOUT.TOP[ERAIL] GOTO scstrcam1
  DO J=XMAXC,XMINC,0-XSTEPC
   PAD (2*LAYOUT.NFING) J I+50.
   PAD (2*LAYOUT.NFING+1) J I+50.
  ENDDO
scstrcam1:
 ENDDO
RETURN

// Verify Fingers

// Verify Cameras

// Compensaste offset

// Compensate rotation

// Warmup
heatup:
 TEXT 5 -*             Warmup 2 minutes                *
 TEXT 4 ***********************************************
TEXT LOG %T Heating fingers for 2 minutes
 BUTTONS Skip_Heat
 TM=TIME()+120000.0
 DO I=0,LAYOUT.NFING-1,1
  CMD I+1 MOVE (2*I)(XMIN,LAY.CENTERY[I]) (2*I+1)(XMAX,LAY.CENTERY[I]) NOP
 ENDDO
heatingloop:
 DO I=0,LAYOUT.NFING-1,1
    IF ANSWER[I+1]<0 GOTO skipheat
    J=SCAN[I].USER[0]
    K=XMIN+(J-INT(J/((XMAX-XMIN)/25))*((XMAX-XMIN)/25))*25.0+5.0+RANDOM(15.0)
    L=INT(J/((XMAX-XMIN)/25))*12.5+19.0+RANDOM(4.0)+LAYOUT.BOTTOM[I]
    IF (I>=BRAIL && I<=ERAIL)||(I>=(BRAIL+LAYOUT.NFING/2) && I<=(ERAIL+LAYOUT.NFING/2)) CMD I+1 MOVE (2*I)(K,L) (2*I+1)(K+5,L) R(2*I,2*I+1)
    J=J+1
    IF J>=((XMAX-XMIN)/25)*12 J=0
    SET SCAN[I].USER[0] J
skipheat:
 ENDDO
 IF TIME()<TM && PRESSED(0) GOTO heatingloop
 DO %1=1,LAYOUT.NFING,1
  WAIT CMD %1
 ENDDO
RETURN

// Check Board position

chkboard:
 TEXT 5 -*          Checking Board position            *
 TEXT 4 ***********************************************
 J=-1
 DO K=BRAIL,ERAIL,1
  DO I IN K,K+LAYOUT.NFING/2
   CMD 1 MOVE (2*I)(XREF,YREF+200*K) (2*I+1)(450-XREF,200+200*K-YREF) R(2*I,2*I+1)
   CMD 2 MOVE (2*I)(XREF,YREF+200*K) (2*I+1)(450-XREF,200+200*K-YREF) R(2*I+1,2*I)
   IF R[1]>2000.0 || R[2]>2000.0 J=K
  ENDDO
 ENDDO
IF J==-1 GOTO boardplacementok
boardplacementbad:
 %2=J
 TEXT 5 +ATTENTION!  Rail %2 gives high resistance.
 TEXT 4 * Needle on Rail %2 is broken, or
 TEXT 3 * Wrong calibration board, or
 TEXT 2 * Completely wrong layout, or
 TEXT 1 * Calibration board is placed incorrectly.
 TEXT 0 Press 'Continue' to correct board position
 TEXT LOG %T Calibration board test gives high resistance
 CALL step1
 GOTO chkboard
boardplacementok:
RETURN

// Check height and set stroke

chkheight:
 TEXT 5 -*Checking board deformation and setting stroke*
 TEXT 4 ***********************************************
 N=0
 DO K=BRAIL,ERAIL,1
  DO I IN K,K+LAYOUT.NFING/2
    CMD 1 MOVE (2*I) (XMAX,LAYOUT.CENTERY[K]-75) Z(2*I)
    CMD 2 MOVE (2*I) (XMAX,LAYOUT.CENTERY[K]) Z(2*I)
    CMD 3 MOVE (2*I) (XMAX,LAYOUT.CENTERY[K]+75) Z(2*I)
    CMD 4 MOVE (2*I) (LAYOUT.CENTERX,LAYOUT.CENTERY[K]-75) Z(2*I)
    CMD 5 MOVE (2*I) (LAYOUT.CENTERX,LAYOUT.CENTERY[K]) Z(2*I)
    CMD 6 MOVE (2*I) (LAYOUT.CENTERX,LAYOUT.CENTERY[K]+75) Z(2*I)
    CMD 7 MOVE (2*I) (XMIN,LAYOUT.CENTERY[K]-75) Z(2*I)
    CMD 8 MOVE (2*I) (XMIN,LAYOUT.CENTERY[K]) Z(2*I)
    CMD 9 MOVE (2*I) (XMIN,LAYOUT.CENTERY[K]+75) Z(2*I)
    M=MIN(INPORT[1],INPORT[2],INPORT[3],INPORT[4],INPORT[5],INPORT[6],INPORT[7],INPORT[8],INPORT[9])
    M=(MAX(INPORT[1],INPORT[2],INPORT[3],INPORT[4],INPORT[5],INPORT[6],INPORT[7],INPORT[8],INPORT[9])-M)/1000.0
//    TEXT 1 Z-up = %5
    IF M>N N=M
    IF I==K J=M
  ENDDO
  TEXT %3 dZ  Rail%3  = %2mm   Rail%1 = %5mm
 ENDDO
 IF N<3.0 GOTO goodheight
 J=ROUND(N,0.1)
 TEXT 3 +ATTENTION!  Deformed calibration board.
 TEXT 2 The bending of the board is %2 mm which may
 TEXT 1 result in needle damage or long run time.
 TEXT 0 * Continue at your own risk
 TEXT LOG %T Calibration board bended by %2 mm
 BUTTONS Replace Continue 
 WAIT BUTTONS chkheight1:
 CALL step1a
 GOTO chkheight
chkheight1:
 TEXT LOG %T Operator decided to continue calibration
goodheight:
 N=N+0.5
 REALHEIGHT=MAX(N+0.75,ZHEIGHT,1.0)
 STROKE ZSTROKE ZPRESSURE REALHEIGHT
 CALL cls
 TEXT 1 Z-up = %6
RETURN

//  Show tester bitmap

testerbmp:
 IF LAYOUT.NFING==8 && LAYOUT.CAMERAS==3  BITMAP a216
 IF LAYOUT.NFING==6 && LAYOUT.CAMERAS==3  BITMAP a212
 IF LAYOUT.NFING==4 && LAYOUT.CAMERAS==3  BITMAP a28
RETURN

chky:
 CLEAR SCAN
 TEXT 5 -*      Checking Y position of the board       *
 TEXT 4 ***********************************************
 DO I=2*BRAIL,2*ERAIL,2
   PAD I 225 25+100*I
   PAD I 225 175+100*I
   PAD I+1 225 25+100*I
   PAD I+1 225 175+100*I
   PAD (I+LAYOUT.NFING) 225 25+100*I
   PAD (I+LAYOUT.NFING) 225 175+100*I
   PAD (I+1+LAYOUT.NFING) 225 25+100*I
   PAD (I+1+LAYOUT.NFING) 225 175+100*I
 ENDDO
 %9=GET(DISTANCE)
 SET DISTANCE 3.5+RANDOM(1.0)
 CALL elscan
 SET DISTANCE %9
 M=0 
 L=0
 DO I=0,2*LAYOUT.NFING-1,1
  J=C_YSHIFT(I)
  TEXT LOG Finger %1  Yshift %2
  IF ABS(J)>ABS(M) M=J
  L=L+J
 ENDDO
 L=L/(2*LAYOUT.NFING)

 TEXT LOG Board shifted %4 mm
 IF ABS(M)<0.35 GOTO yplacementok
 IF ABS(M)<0.9 GOTO yshiftsmall
 TEXT CLEAR
 TEXT 3 +ATTENTION! Maximal Y board shift is %5mm
 TEXT 2 Avarage shift is %4 mm
 TEXT 1 This will result in partial loss of accuracy.
 TEXT LOG %T Very large Y board shift (%4.3.1 mm)
 IF L>0  TEXT 0 +* Pull board %4.3.1 millimeters out of the tester.
 IF L<=0 TEXT 0 +* Push board %4.3.1 millimeters in the tester.
 BUTTONS Continue
 WAIT BUTTONS
 CALL step1a
 GOTO chky
yshiftsmall:
 TEXT 3 +ATTENTION!  Maximal Y board shift is %5mm
 TEXT 2 Avarage shift is %4 mm
 TEXT 1 This will result in partial loss of accuracy.
 IF L>0  TEXT 1 * Pull board %4.3.1 mm out of the tester, or
 IF L<=0 TEXT 1 * Push board %4.3.1 mm in the tester, or
 TEXT 0 * Continue at your own risk.
 TEXT LOG %T Y board shift (%4.3.1 mm)
 BUTTONS Shift Continue 
 WAIT BUTTONS noshift
 CALL step1a
 GOTO chky
noshift:
 TEXT LOG %T Operator decided to continue calibration
yplacementok:
 CALL cls
RETURN

// Scan and reload layout

scanlayout:
BUTTONS
 TEXT 5 -*             Scanning Layout                 *
 TEXT 4 ***********************************************
 DO K=BRAIL,ERAIL,1
  DO I IN K,K+LAYOUT.NFING/2
   PAD (2*I) LAY.CENTERX LAY.CENTERY[I]
   PAD (2*I+1) LAY.CENTERX LAY.CENTERY[I]
  ENDDO
 ENDDO
 PAD (2*LAYOUT.NFING) LAY.CENTERX LAY.CENTERY[LAYOUT.NFING]
 PAD (2*LAYOUT.NFING+1) LAY.CENTERX LAY.CENTERY[LAYOUT.NFING]
 %9=GET(DISTANCE)
 SET DISTANCE 3.5+RANDOM(1.0)
 TEXT LOG %T Electrical center scanning
 CALL elscan
 SET DISTANCE %9
 TEXT INFO
 TEXT LOG %T Optical center scanning
 IF LIGHTS==0 CALL videoscan
 IF LIGHTS==1 CALL mvideoscan
 IF LIGHTS==2 CALL xvideoscan
 DO %1=0,31,1
  IF SCAN[%1].NGRID==0 GOTO continuecenter
  IF SCAN[%1].ERR[0]==0 GOTO centerok
  TEXT 5 +ATTENTION!  Center not found.
  TEXT 4 Center was not found for finger %F1, thus
  TEXT 3 layout can't be corected.
  TEXT 2 * Replace calibration board, or
  TEXT 1 * Change board placement, or
  TEXT 0 * Get exact layout manually.
  TEXT LOG %T Center not found for finger %F1, calibration terminated
  BUTTONS
  TEXT WINDOW Calibration terminated
  STOP
centerok:
  %2=SCAN[%1].MEASX[0]-SCAN[%1].GRIDX[0]
  %3=SCAN[%1].MEASY[0]-SCAN[%1].GRIDY[0]
  ADDSHIFT %1 %2 %3
continuecenter:
 ENDDO
// SOFTRESET
 TEXT 5 -*             Reloading Layout                *
 TEXT 4 ***********************************************
 CMD 1 INPORT TEMPERATUREPORT
 %1=INPORT[1]
 DEFTEMP %1
 CMD 1 LOADLAYOUT
 WAIT CMD 1
RETURN

// Electrical scanning
elscan:
 %1=C_SCAN()
 %2=ROUND(100.0-%1,1.0)
 TEXT INFO  Done: %2%%
 %8=0
 DO %4=0,LAYOUT.NFING-1,1
  %8=%8+C_SCANERR(%4)
 ENDDO
 TEXT 0 Bad pads: %8
 IF (%1>0) GOTO elscan
RETURN

// Optical scanning using light from opposite side

mvideoscan:
 VIDEO 0.5
 IF MCMGL==1 GOTO mvideoscan1
 TEXT 3 +          Set the LIGHTS of the cameras:
 TEXT 2 +                TOP to MINIMUM 
 TEXT 1 +               BOTTOM to MAXIMUM
 TEXT 0 +                and press READY
 BUTTONS Ready
 WAIT BUTTONS
 CALL cls

mvideoscan1:
 IF MCMGL==0 %1=C_VIDEOSCAN(1,0,0,0)
 IF MCMGL==1 %1=C_VIDEOSCAN(1,0,40,0)
 %2=ROUND(100.0-%1,1.0)
 TEXT INFO Done: %2%%
 %2=C_SCANERR(2*LAYOUT.NFING)+C_SCANERR(2*LAYOUT.NFING+1)
 TEXT 0 %2 crosses bad (not calibrated)
 IF %1>0 GOTO mvideoscan1
 IF MCMGL==1 GOTO mvideoscan2
 TEXT 3 +         Set the LIGHTS of the cameras:
 TEXT 2 +                TOP to MAXIMUM 
 TEXT 1 +               BOTTOM to MINIMUM
 TEXT 0 +                and press READY
 BUTTONS Ready
 WAIT BUTTONS
 CALL cls

mvideoscan2:
 IF MCMGL==0 %1=C_VIDEOSCAN(0,2,0,0)
 IF MCMGL==1 %1=C_VIDEOSCAN(0,2,40,0)
%2=ROUND(100.0-%1,1.0)
 TEXT INFO Done: %2%%
 %2=C_SCANERR(2*LAYOUT.NFING)+C_SCANERR(2*LAYOUT.NFING+1)
 TEXT 0 %2 crosses bad (not calibrated)
 IF %1>0 GOTO mvideoscan2:
RETURN

xvideoscan:
 VIDEO 1.3
 IF MCMGL==1 GOTO xvideoscan1
 CMD 1 OUTPORT 0x2004 0
 CMD 2 OUTPORT 0x2005 255
xvideoscan1:
 IF MCMGL==0 %1=C_VIDEOSCAN(1,0,0,0)
 IF MCMGL==1 %1=C_VIDEOSCAN(1,0,40,0)
 %2=ROUND(100.0-%1,1.0)
 TEXT INFO Done: %2%%
 %2=C_SCANERR(2*LAYOUT.NFING)+C_SCANERR(2*LAYOUT.NFING+1)
 TEXT 0 %2 crosses bad (not calibrated)
 IF %1>0 GOTO xvideoscan1
 IF MCMGL==1 GOTO xvideoscan2
 CMD 1 OUTPORT 0x2004 255
 CMD 2 OUTPORT 0x2005 0

xvideoscan2:
 IF MCMGL==0 %1=C_VIDEOSCAN(0,2,0,0)
 IF MCMGL==1 %1=C_VIDEOSCAN(0,2,40,0)
%2=ROUND(100.0-%1,1.0)
 TEXT INFO Done: %2%%
 %2=C_SCANERR(2*LAYOUT.NFING)+C_SCANERR(2*LAYOUT.NFING+1)
 TEXT 0 %2 crosses bad (not calibrated)
 IF %1>0 GOTO xvideoscan2:
 CMD 1 OUTPORT 0x2004 255
 CMD 2 OUTPORT 0x2005 255
RETURN

// Optical scanning
videoscan:
 VIDEO 0.5
videoscan1:
 %1=C_VIDEOSCAN(1,2)
 %2=ROUND(100.0-%1,1.0)
 TEXT INFO Done: %2%%
 %2=C_SCANERR(2*LAYOUT.NFING)+C_SCANERR(2*LAYOUT.NFING+1)
 TEXT 0 %2 crosses bad (not calibrated)
 IF (%1>0) GOTO videoscan1
RETURN

// Check badpoints

badpoints:
 DO %1=2*BRAIL,2*ERAIL,1
  DO %2 IN %1, %1+LAYOUT.NFING
   %3=SCAN[%2].NGRID
   IF SCAN[%2].ERR[0]!=0 && SCAN[%2].ERR[2]!=0 GOTO manybadpoints
   IF SCAN[%2].ERR[1]!=0 && SCAN[%2].ERR[3]!=0 GOTO manybadpoint
   IF SCAN[%2].ERR[%3-3]!=0 && SCAN[%2].ERR[%3-1]!=0 GOTO manybadpoints
   IF SCAN[%2].ERR[%3-4]!=0 && SCAN[%2].ERR[%3-2]!=0 GOTO manybadpoints
  ENDDO
 ENDDO
 GOTO nobadpoints
manybadpoints:

  TEXT CLEAR
  TEXT 6 + ----------------------------------------------
  TEXT 5 +                  ATTENTION!
  TEXT 4 +         Finger %F2 Has too many bad points
  TEXT 3 +         Calibration results are unreliable
  TEXT 2 +             Calibration terminated 
  TEXT 1 +              Please contact atg 
  TEXT 0 + ----------------------------------------------
  TEXT LOG Finger %F2 too many Bad points calibration terminated
  BUTTONS
  TEXT WINDOW Calibration terminated
  STOP
nobadpoints:
RETURN

// XY-correction
xycorrection:

//Y correction
 DO K IN 0,LAYOUT.NFING/2
  DO J=BRAIL+K,ERAIL+K,1
   DO I=0,SCAN[2*J].NGRID-1,1
    IF SCAN[2*J].GRIDY[I]<LAYOUT.CENTERY[J] SET SCAN[2*J].MEASY[I] SCAN[2*J].MEASY[I]-0.0075
    IF SCAN[2*J].GRIDY[I]>LAYOUT.CENTERY[J] SET SCAN[2*J].MEASY[I] SCAN[2*J].MEASY[I]+0.0075 
    IF SCAN[2*J+1].GRIDY[I]<LAYOUT.CENTERY[J] SET SCAN[2*J+1].MEASY[I] SCAN[2*J+1].MEASY[I]-0.0075
    IF SCAN[2*J+1].GRIDY[I]>LAYOUT.CENTERY[J] SET SCAN[2*J+1].MEASY[I] SCAN[2*J+1].MEASY[I]+0.0075 
   ENDDO
  ENDDO
 ENDDO

//X correction
 DO K IN 0,LAYOUT.NFING/2
  DO J=BRAIL+K,ERAIL+K,1
   DO I=0,SCAN[2*J].NGRID-1,1
     SET SCAN[2*J].MEASX[I] SCAN[2*J].MEASX[I]-0.005
     SET SCAN[2*J+1].MEASX[I] SCAN[2*J+1].MEASX[I]+0.005
   ENDDO
  ENDDO
 ENDDO
RETURN


xyoffset:
 XMID=0
 YMID=0
 XOFFSET=0
 YOFFSET=0
 K=0
 DO I=0,2*LAYOUT.NFING+1,1
 IF SCAN[I].NGRID==0 GOTO xyoffset1
 K=K+SCAN[I].NGRID
  DO J=0,SCAN[I].NGRID-1,1
   XMID=XMID+SCAN[I].GRIDX[J]
   YMID=YMID+SCAN[I].GRIDY[J]
   XOFFSET=SCAN[I].MEASX[J]-SCAN[I].GRIDX[J]+XOFFSET
   YOFFSET=SCAN[I].MEASY[J]-SCAN[I].GRIDY[J]+YOFFSET
  ENDDO
xyoffset1:
 ENDDO
 XOFFSET=XOFFSET/K
 YOFFSET=YOFFSET/K
 XMID=XMID/K
 YMID=YMID/K
 DO I=0,2*LAYOUT.NFING+1,1
 IF SCAN[I].NGRID==0 GOTO xyoffset2
  DO J=0,SCAN[I].NGRID-1,1
   SET SCAN[I].MEASX[J] SCAN[I].MEASX[J]-XOFFSET
   SET SCAN[I].MEASY[J] SCAN[I].MEASY[J]-YOFFSET
  ENDDO
xyoffset2:
 ENDDO
 TEXT LOG XMID=%77
 TEXT LOG YMID=%76
 TEXT LOG XOFFSET=%79
 TEXT LOG YOFFSET=%78
 CALL rotationcalc
RETURN

// Calculation of the rotation angle

rotationcalc:
 FI=0
 K=0
 M=0
 DO I=0,2*LAYOUT.NFING+1,1
 IF SCAN[I].NGRID==0 GOTO rotationcalc1
//  K=K+SCAN[I].NGRID
  DO J=0,SCAN[I].NGRID-1,1
   IF ABS(SCAN[I].GRIDY[J]-YMID)<1. && ABS(SCAN[I].GRIDX[J]-XMID)<1. GOTO rotationcalc4:
//  M=ATAN2(SCAN[I].MEASY[J]-YMID,SCAN[I].MEASX[J]-XMID)-ATAN2(SCAN[I].GRIDY[J]-YMID,SCAN[I].GRIDX[J]-XMID)
   IF ABS(SCAN[I].GRIDY[J]-YMID)<=ABS(SCAN[I].GRIDX[J]-XMID)&& (SCAN[I].GRIDX[J]-XMID>0) M=ATAN2(SCAN[I].MEASY[J]-YMID,SCAN[I].MEASX[J]-XMID)-ATAN2(SCAN[I].GRIDY[J]-YMID,SCAN[I].GRIDX[J]-XMID)
   IF ABS(SCAN[I].GRIDY[J]-YMID)<=ABS(SCAN[I].GRIDX[J]-XMID)&& (SCAN[I].GRIDX[J]-XMID<0) M=ATAN2(YMID-SCAN[I].MEASY[J],XMID-SCAN[I].MEASX[J])-ATAN2(YMID-SCAN[I].GRIDY[J],XMID-SCAN[I].GRIDX[J])
   IF ABS(SCAN[I].GRIDY[J]-YMID)>ABS(SCAN[I].GRIDX[J]-XMID) && (SCAN[I].GRIDY[J]-YMID>0) M=ATAN2(SCAN[I].GRIDX[J]-XMID,SCAN[I].GRIDY[J]-YMID)-ATAN2(SCAN[I].MEASX[J]-XMID,SCAN[I].MEASY[J]-YMID)
   IF ABS(SCAN[I].GRIDY[J]-YMID)>ABS(SCAN[I].GRIDX[J]-XMID) && (SCAN[I].GRIDY[J]-YMID<0) M=ATAN2(XMID-SCAN[I].GRIDX[J],YMID-SCAN[I].GRIDY[J])-ATAN2(XMID-SCAN[I].MEASX[J],YMID-SCAN[I].MEASY[J])
   FI=FI+M
   K=K+1
rotationcalc4:
  ENDDO
rotationcalc1:
 ENDDO
 FI=FI/K
 TEXT LOG FI=%75
 DO I=0,2*LAYOUT.NFING+1,1
 IF SCAN[I].NGRID==0 GOTO rotationcalc2
  DO J=0,SCAN[I].NGRID-1,1
  IF (SCAN[I].MEASY[J]-YMID)==0 && (SCAN[I].MEASX[J]-XMID)==0 GOTO rotationcalc3
//   F=ATAN2(SCAN[I].MEASY[J]-YMID,SCAN[I].MEASX[J]-XMID)-FI 
   IF ABS(SCAN[I].GRIDY[J]-YMID)<=ABS(SCAN[I].GRIDX[J]-XMID) F=ATAN2(SCAN[I].MEASY[J]-YMID,SCAN[I].MEASX[J]-XMID)-FI 
   IF ABS(SCAN[I].GRIDY[J]-YMID)>ABS(SCAN[I].GRIDX[J]-XMID) F=1.570796327-ATAN2(SCAN[I].MEASX[J]-XMID,SCAN[I].MEASY[J]-YMID)-FI 
   L=SQRT((SCAN[I].MEASY[J]-YMID)*(SCAN[I].MEASY[J]-YMID)+(SCAN[I].MEASX[J]-XMID)*(SCAN[I].MEASX[J]-XMID))
   SET SCAN[I].MEASX[J] L*COS(F)+XMID
   SET SCAN[I].MEASY[J] L*SIN(F)+YMID
rotationcalc3:
  ENDDO
rotationcalc2:
 ENDDO
RETURN

showrails:
GRAPH INIT // 350 x 260 pixels
  DO L=0,LAYOUT.NFING/2-1,1
    GRAPH COLOR LIGHT
    GRAPH MOVE 85 45*L+40
    GRAPH LINE 180+85 45*L+40
    GRAPH LINE 180+85 45*L+45+40
    GRAPH LINE 85 45*L+45+40
    GRAPH LINE 85 45*L+40
    IF L<BRAIL || L>ERAIL CALL showcross
 ENDDO
 GRAPH DISPLAY
RETURN

showcross:
 GRAPH COLOR RED
  GRAPH MOVE 85 45*L+40  
  GRAPH LINE 180+85 45*L+45+40
  GRAPH MOVE 180+85 45*L+40
  GRAPH LINE 85 45*L+45+40
 RETURN

cls:
 BUTTONS
 TEXT 3
 TEXT 2
 TEXT 1
 TEXT 0
RETURN

lightselect:
 TEXT CLEAR
 TEXT 7 ***********************************************
 TEXT 6 +*     Select the Type of the light source     *  
 TEXT 5 *                                             *
 TEXT 4 *    Press NORMAL if the light source and     *
 TEXT 3 *      the Camera are on the same side        *
 TEXT 2 *   Press SHINETHROUGH if the light source    *
 TEXT 1 *       from opposite side will be used       *
 TEXT 0 ***********************************************
 LIGHTS=1
 BUTTONS NORMAL SHINETHROUGH
 WAIT BUTTONS shinethr
 LIGHTS=0
shinethr:
  CMD 1 INPORT 0xE9
  IF ((LIGHTS==1)&&(INPORT[1] & 0xC0)==0) LIGHTS=2
  CMD 1 OUTPORT 0x2004 255
  CMD 2 OUTPORT 0x2005 255
CALL cls
RETURN

cognex:
 TEXT 5 -*             Bootstrapping COGNEX            *
 TEXT 4 ***********************************************
TEXT LOG %T Bootstrapping COGNEX
 COGNEX =BOOTC
 IF COGNEXERR(2)==0 GOTO cognexloaded
 TEXT 3 +ATTENTION!  Unable to initialize COGNEX.
 TEXT 2 The following error was detected while trying
 TEXT 1 to initialize COGNEX fiducial finder:
 TEXT 0 +Please correct problem and restart calibration.
 TEXT LOG %T Unable to initialize COGNEX, calibration terminated
 BUTTONS
 TEXT WINDOW Calibration terminated
 STOP
cognexloaded:
 TEXT 5 -*              Calibrating COGNEX             *
 TEXT 4 ***********************************************
 //TEXT 1 MCMGL=%64
 COGNEX =CALIBR UP 8.5 8.5    // Std
 //COGNEX =CALIBR UP 6.2 6.2      // MCM
 COGNEX =CALIBR DOWN 8.5 8.5
 TEXT 5 -*             Training COGNEX TOP             *
 TEXT 4 ***********************************************
 IF MCMGL!=1 COGNEX =DEF 1 UP CROSS 1500.0 250 0.0 %71 1
 IF MCMGL==1 COGNEX =DEF 1 UP DBLLEFT 710 240 0 1 1
 TEXT 5 -*           Training COGNEX BOTTOM            *
 TEXT 4 ***********************************************
 IF MCMGL!=1 COGNEX =DEF 2 DOWN CROSS 1500.0 250 0.0 %71 1
 IF MCMGL==1 COGNEX =DEF 2 DOWN DBLLEFT 690 235 0 1 1
COGNEX =DELAY 500.0
RETURN

instfr4:
 CALL testerbmp
 TEXT 3 +PLEASE VERIFY what and how will you calibrate:
 TEXT 2 * Board : FR4 Board
 TEXT 1 * Video : both upper and lower cameras
 TEXT 0 +Please verify this by pressing proper button.
step1:
 BUTTONS Continue Quit
 WAIT BUTTONS quit
 CALL cls
step1a:
 BITMAP pos4gold
 TEXT 5 +*          Install calibration board          *
 TEXT 4 ***********************************************
 TEXT 3 If calibration board is not yet placed, then
 TEXT 2 * Unlock and pull off the shuttle
 TEXT 1 * Install 2-sided FR4 calibration board,
 TEXT 0 * Unlock shuttle, push it in and press 'Ready'
repeatunlock:
 BUTTONS Unlock Ready
 WAIT BUTTONS skipunlock
 CMD 0 UNLOCK
 GOTO repeatunlock
skipunlock:
 CMD 1 LOCK
 WAIT CMD 1
 IF ANSWER[1]==0x10 GOTO step1a
 CALL cls
RETURN

exit:
 STOP
 END
