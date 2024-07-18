// Commands recognizable by Crate Controller.
#define S_NOP          0x00
#define S_READY        0x00
#define S_FIELD        0x01
#define S_RMEAS        0x02
#define S_SHOWPOINT    0x03
#define S_TOUCHPOINT   0x04
#define S_DETOUCH      0x05
#define S_LOADRUN      0x06
#define S_LAYOUT       0x07
#define S_MEASUREBUS   0x08
#define S_CALIBRATE    0x09
#define S_RESET        0x0A
#define S_CHECKZERO    0x0B
#define S_DEFBOARD     0x0C
#define S_FINDPAD      0x0D
#define S_HVMEAS       0x0E
#define S_HVINIT       0x0F
#define S_ERROR        0x10
#define S_DUMP         0x11
#define S_DEBUG        0x12
#define S_STROKES      0x13
#define S_TEST         0x14
#define S_GROUP        0x15
#define S_LAMEAS       0x16
#define S_LAINIT       0x17
#define S_EXACTR       0x18
#define S_EXTERN       0x19
#define S_EXTINIT      0x1A
#define S_CMEAS        0x1B
#define S_EXACTINIT    0x1C
#define S_RINIT        0x1D
#define S_CRTINIT      0x1E
#define S_INPORT       0x20
#define S_OUTPORT      0x21
#define S_STROKE       0x22
#define S_LOCKDOOR     0x23
#define S_MARK         0x24
#define S_FASTC        0x25
#define S_SYSTEM       0x28            // Answers only - view bus etc.
#define S_MESSAGE      0x29
#define S_INPORT32     0x30
#define S_OUTPORT32    0x31
#define S_LMAUTO       0x32            // Communication with L&M automation
#define S_RLINIT       0x35            // Inductance initialization
#define S_VIDEOCAM     0x40            // Communication with Firewire camera
#define S_PMDUMP       0x41            // Post-mortem dump
#define S_MOVE         0x81

// S_MOVE subcommands.
#define M_NOP          S_NOP           // Dummy measurement: do nothing
#define M_FIELD        S_FIELD         // Field measurement
#define M_RMEAS        S_RMEAS         // Resistance measurement
#define M_LAYOUT       S_LAYOUT        // Pseudomeasurement: get layout
#define M_MEASUREBUS   S_MEASUREBUS    // Make direct bus measurements
#define M_CALIBRATE    S_CALIBRATE     // Find position of printed line
#define M_CHECKZERO    S_CHECKZERO     // Check zero sensors: rail
#define M_FINDPAD      S_FINDPAD       // Scan pad locally
#define M_HVMEAS       S_HVMEAS        // High voltage: 2 fingers follow
#define M_DEBUG        S_DEBUG         // General debugging subcommand
#define M_LAMEAS       S_LAMEAS        // LATEST measurement
#define M_LAINIT       S_LAINIT        // External LATEST calibration
#define M_EXACTR       S_EXACTR        // Accurate resistance measurement
#define M_EXTERN       S_EXTERN        // Measurements using external device
#define M_CMEAS        S_CMEAS         // High capacity measurement
#define M_EXACTLIM     0x1C            // Accurate R with per-command limits
#define M_SHCONN       0x1F            // Check for connection to shuttle
#define M_MEASUREZ     S_INPORT        // Measure Z surface, micrometers
#define M_MARK         S_MARK          // Plot bitmap using camera
#define M_FASTC        S_FASTC         // Fast capacity measurement
#define M_RRETEST      0x26            // Resistance retest
#define M_RQUAD        0x27            // 4-wire resistance measurement
#define M_ERETEST      0x28            // Accurate resistance retest
#define M_RLMEAS       0x2A            // Inductivity measurement
#define M_BURN         0x2B            // Burn-in test
#define M_CONTCAP      0x2C            // Contact check capacity calibration
#define M_CAIR         0x2D            // Internal field/fast C calibration
#define M_CRT          0x2E            // Charge rise time measurement
#define M_CRTAIR       0x2F            // Internal charge rise time calibration
#define M_LARETEST     0x32            // LATEST retest
#define M_CONTKELV     0x3C            // Kelvin contact check
#define M_SELFTEST     0x40            // Self-test: finger, antenna, mode
#define M_RELAYSTEST   0x41            // Relays self-test: finger
#define M_LAMANUAL     0x42            // Manual LATEST measurement
#define M_LAMANCAL     0x43            // Manual LATEST calibration
#define M_LACAL        0x44            // LATEST calibration with heads
#define M_UI           0x45            // Volt-ampere characteristics
#define M_UIEX         0x46            // Extended volt-ampere characteristics
#define M_MULTIC       0x48            // Multiple capacity using AC
#define M_UNIC         0x49            // Universal capacity measurement
#define M_DIVIDER      0x4A            // Voltage divider measurement
#define M_COMP         0x4B            // Component test
#define M_RLIM         0x4E            // Resistance with per-command limits
#define M_RRELIM       0x4F            // Fast resistance retest with limits
#define M_RLDIFF       0x50            // Differential inductance measurement
#define M_SAME         0x80            // MOVE: remain at the same pad
#define M_MOVE         0x81            // MOVE: move to pad
#define M_UP           0x82            // MOVE: move finger up
#define M_DOWN         0x83            // MOVE: move finger down
#define M_GROUND       0x84            // MOVE: reference finger
#define M_SAFEMASK     0x85            // MOVE: field-safe fingers
#define M_CHECK0       0x86            // MOVE: check zero
#define M_PANEL        0x87            // MOVE: set panel & group ID
#define M_SHIELD       0x88            // MOVE: head is connected to ground
#define M_MOVEC        0x89            // MOVE: to pad with corrections
#define M_MOVEN        0x8C            // MOVE: to pad with nanometer accuracy
#define M_PARK         0x90            // MOVE: move in park position
#define M_MOVEZ        0x91            // MOVE: to pad with Z
#define M_ENCODER      0x92            // MOVE: to absolute encoder phases
#define M_NET          0x97            // MOVE: set panel, group & net ID
#define M_MOVEZC       0x99            // MOVE: to pad with Z & corrections
#define M_SHUTTLE      0x9B            // MOVE: select shuttle
#define M_SHUTTLEY     0x9C            // MOVE: set Y shuttle coordinate
#define M_NETS         0xA7            // MOVE: set panel, group & net IDs
#define M_MOVEX        0xC1            // MOVE: to pad w/o XY check
#define M_MASTER       0xC2            // MOVE: pass measurement to master card
#define M_SLAVE        0xC3            // MOVE: pass measurement to slave card
#define M_MOVEXC       0xC9            // MOVE: to pad, corr, no XY check
#define M_MOVECAM      0xCA            // MOVE: head camera, corr, no XY check
#define M_MOVECAMN     0xCB            // MOVE: head cam, nanometer accuracy
#define M_MOVENX       0xCC            // MOVE: with nanometer accuracy, no chk
#define M_MOVEZX       0xD1            // MOVE: to pad, with Z, w/o XY check
#define M_MOVEZXC      0xD9            // MOVE: to pad, Z & corr, w/o check
// Measurement prefixes.
#define M_LIMITHI      0xE2            // Retest if value is higher than limit
#define M_LIMITLO      0xE3            // Retest if value is lower than limit
#define M_POSTAIR      0xE4            // Measure Cair after main measurement
#define M_LIGHTOFF     0xE5            // Lights must be turned off
#define M_AVERAGE      0xE6            // Calculate average
#define M_MEDIAN       0xE7            // Calculate median
#define M_KEEPORDER    0xE8            // Keep order of measurements


// Error codes from Crate Controller.
#define E_NOCRATDATA   0x00            // (Crate ROM) No programm
#define E_NOFINGDATA   0x01            // No finger programm/data
#define E_CONFIGURE    0x02            // Actual fingers differ from layout
#define E_BADFVERS     0x03            // Old finger controller software
#define E_FIELDSAFE    0x04            // FIELDSAFE line absent or damaged
#define E_FINGTEST     0x05
#define E_ZMOVEMENT    0x06            // Z-movement error
#define E_COMMUTATOR   0x07            // Damaged analog multiplexor card
#define E_PHASELOST    0x08            // Step-motor is out of phase
#define E_ENCBOOT      0x09            // Encoder bootstrap error
#define E_TMEAS        0x0A            // Temperature sensor damaged
#define E_STOPMODE     0x0B            // Stop mode active
#define E_EARTHQUAKE   0x0C            // Earthquake sensor activated
#define E_HEADMEAS     0x0D            // Error in meas system of head ctrl
#define E_TIMEOUT      0x10            // Timeout in head controller
#define E_IOERROR      0x20
#define E_SETZEROS     0x21
#define E_WRONGCOORD   0x22
#define E_SYNC         0x23
#define E_BADCOMMAND   0x24
#define E_BADCMDSIZE   0x25
#define E_TABLEOVERF   0x26
#define E_CALIBRATE    0x27
#define E_BADDATA      0x28
#define E_PADNOTFOUND  0x29
#define E_IBMERROR     0x2A            // Error detected by IBM controller
#define E_DIVBYZERO    0x2B            // Division by zero
#define E_MARK         0x2C            // Error drawind bitmap on PCB
#define E_CONTACT      0x50            // Broken cable (solid probe only)
#define E_HISHIFT      0x51            // DC hi-res shift out of range
#define E_SHORTCUT     0x52            // Needle or bus shortened to shield
#define E_WAITTMOUT    0x53            // Timeout while waiting 100 mksec
#define E_INITMEAS     0x54            // Error initialising meas card
#define E_BADCAP       0x55            // Bad own DC capacity of cable
#define E_DCMEAS       0x56            // DC initialization error
#define E_ONHEAD       0x57            // On-head initialization error
#define E_HVMEAS       0x58            // HV initialization error
#define E_CRTMEAS      0x59            // MSD initialization error
#define E_LAMEAS       0x5A            // LATEST initialization error
#define E_EXTDEV       0x5F            // Error reported by external device
#define E_BOXSENS      0xE0            // Door sensors do not work
#define E_NOLOCK       0xE1            // Can't lock door
#define E_PNEUMOSENS   0xE2            // Lock sensors do not work
#define E_PNEUMOSYS    0xE3            // Door is opened but locked
#define E_NOUNLOCK     0xE4            // Can't unlock door
#define E_NO24V        0xE5            // No 24 volts
#define E_NOVACUUM     0xE6            // No vacuum
#define E_SPSERR       0xE8            // SPS (loader) error

// Type of error.
#define E_REC          0x0000          // Error more or less recovered
#define E_UNREC        0x0100          // Error may cause total system crash
#define E_SOFT         0x0000          // Error caused by software
#define E_HARD         0x0200          // Error caused by hardware
#define E_FINGER       0x0000          // Error caused by finger or rail
#define E_CRATE        0x0400          // Error caused by crate controller
#define E_SLAVE        0x0800          // Error caused by slave or master
#define E_MEAS         0x1000          // Error in measurements card
#define E_AFMCU        0x2000          // Error in IBM AFMCU unit
#define E_GENERAL      0x8000          // Error due to locks, pumps etc.
#define E_SRCMASK      0x9C00          // Mask for source of error

// Status bits of field measurements.
#define FM_NOHDW       0x8000          // Measurement card absent, data invalid
#define FM_RDATA       0x6000          // Mask for feedback resistor
#define   FM_R1K       0x4000          // On-head feedback resistor 1 K
#define   FM_R10K      0x2000          // On-head feedback resistor 10 K
#define   FM_R100K     0x0000          // Feedback resistor 100 K (default)
#define   FM_R1000K    0x6000          // On-head feedback resistor 1000 K
#define FM_OVERLOAD    0x1000          // Mux overloaded, data unreliable
#define FM_BAD         0x0800          // Unstable field, data invalid
#define FM_NOCT2       0x0400          // No contact in second point(s)
#define FM_NOCT1       0x0200          // No contact in first point
#define FM_C1VAC       0x0100          // Capacity measured with 1/10 V signal
#define FM_POSTCAL     0x0080          // Postcalibration in the air
#define FM_AMUXPH      0x0040          // Phase rotation measured after AMUX
#define FM_SHORT       0x0020          // Short to antenna
#define FM_CALIBR      0x0008          // Capacity was calibrated in the air
#define FM_NETS        0x0004          // A2: Net/head pairs attached
#define FM_FREQ        0x0004          // A5: C/field frequencies attached
#define FM_AFING       0x0002          // Finger antennae were used
#define FM_CAPX1       0x0001          // Measured with x1/x10 amplification

// Status bits in resistance measurements.
#define RM_NOHDW       0x8000          // Measurement card absent, data invalid
#define RM_EXTMEAS     0x4000          // Measured with external device
#define RM_AVERAGE     0x2000          // Resistance is average or median
#define RM_UNSTABLE    0x1000          // Measured after several retests
#define RM_BAD         0x0800          // Unstable R, data invalid
#define RM_NOCT2       0x0400          // No contact in second point(s)
#define RM_NOCT1       0x0200          // No contact in first point
#define RM_MICROOHM    0x0100          // Data in microohms/ohms
#define RM_HICONT2     0x0080          // High resistance in second point(s)
#define RM_HICONT1     0x0040          // High resistance in first point
#define RM_BADACC      0x0001          // Bad accuracy due to P/I limitations

// Status bits of HV measurements.
#define HM_NOHDW       0x8000          // HV initialization failed
#define HM_AVERAGE     0x2000          // Resistance is average or median
#define HM_UNSTABLE    0x1000          // Measured after several retests
#define HM_NOCT2       0x0400          // No contact in second point(s)
#define HM_NOCT1       0x0200          // No contact in first point
#define HM_GNDSHORT    0x0080          // Possible shortcut to ground (shuttle)
#define HM_MATCH       0x0040          // Channel currents don't match
#define HM_BREAK       0x0020          // Breakdown detected
#define HM_SUPPLY      0x0010          // Voltage supply out of order
#define HM_UEXT        0x0008          // External voltage exists
#define HM_DISCHARGE   0x0004          // Unable to discharge load
#define HM_UNSTABLER   0x0002          // Unable to make stable measurement
#define HM_UNSTABLEU   0x0001          // Unable to reach stable voltage

// Status bits of fast C and multiple C measurements.
#define AM_NOHDW       0x8000          // Measurement card absent, data invalid
#define AM_RDATA       0x6000          // Mask for feedback resistor
#define   AM_R1K       0x4000          // On-head feedback resistor 1 K
#define   AM_R10K      0x2000          // On-head feedback resistor 10 K
#define   AM_R100K     0x0000          // Feedback resistor 100 K (default)
#define   AM_R1000K    0x6000          // On-head feedback resistor 1000 K
#define AM_OVERLOAD    0x1000          // Mux overloaded, data unreliable
#define AM_BAD         0x0800          // Unstable field, data invalid
#define AM_NOCT2       0x0400          // No contact in second point(s)
#define AM_NOCT1       0x0200          // No contact in first point
#define AM_ART         0x0180          // Mask to extract art of measurements
#define   AM_AC        0x0000          // AC measurement
#define   AM_DIS       0x0080          // Charge-discharge measurement
#define   AM_POSTAC    0x0100          // AC with postcalibration in the air
#define   AM_BRIDGE    0x0180          // AC bridge measurement
#define AM_AMUXPH      0x0040          // Phase rotation measured after AMUX
#define AM_SHORT       0x0020          // Short to antenna
#define AM_SHSKIP      0x0010          // Short possible but wasn't tested
#define AM_CALIBR      0x0008          // Capacity was calibrated in the air
#define AM_NETS        0x0004          // A2: Net/head pairs attached
#define AM_FREQ        0x0004          // A5: AC C frequency attached
#define AM_AFING       0x0002          // Finger antennae were used
#define AM_CAPX1       0x0001          // Measured with x1/x10 amplification

/*
// Status bits of universal C measurements.
#define KM_NOHDW       0x8000          // Measurement card absent, data invalid
#define KM_EXTMEAS     0x4000          // Measured with external device
#define KM_NOCAL       0x2000          // Measurements are not calibrated
#define KM_OVERLOAD    0x1000          // Mux overloaded, data unreliable
#define KM_BAD         0x0800          // Unstable field, data invalid
#define KM_NOCT2       0x0400          // No contact in second point(s)
#define KM_NOCT1       0x0200          // No contact in first point
#define KM_ART         0x0180          // Mask to extract art of measurements
#define   KM_AC        0x0000          // AC measurement
#define   KM_DIS       0x0080          // Charge-discharge measurement
#define   KM_BRIDGE    0x0180          // AC bridge measurement
#define KM_RPAR        0x0040          // Parallel resistance attached
#define KM_SHORT       0x0020          // Short to antenna
#define KM_SHSKIP      0x0010          // Short possible but wasn't tested
#define KM_CALIBR      0x0008          // Capacity was calibrated in the air

// Status bits of connection to shuttle check.
#define SM_NOHDW       0x8000          // Measurement card absent, data invalid
#define SM_NOCT        0x0200          // No contact
#define SM_BREAK       0x0020          // Breakdown detected
#define SM_HVINIT      0x0010          // HV requested but not initialized
#define SM_HVBAD       0x0004          // Bad hmeas, probably there is a short
#define SM_CBAD        0x0002          // Bad cmeas, probably there is a short
#define SM_RBAD        0x0001          // Bad rmeas, probably there is a short

// Status bits of inductivity and LATEST measurement.
#define LM_NOHDW       0x8000          // Measurement card absent, data invalid
#define LM_EXTMEAS     0x4000          // Measured with external device
#define LM_NOCAL       0x2000          // Measurements are not calibrated
#define LM_UNSTABLE    0x1000          // Measured after several retests
#define LM_BAD         0x0800          // Unstable R and/or L, data invalid
#define LM_NOCT2       0x0400          // No contact in second point(s)
#define LM_NOCT1       0x0200          // No contact in first point
#define LM_MICROOHM    0x0100          // Resistance in microohms/ohms
#define LM_REF         0x0080          // This is the reference measurement
#define LM_DIST        0x0040          // Large distance from reference points
#define LM_OPEN        0x0020          // Open (R>30 Ohm) detected
#define LM_DAMAGE      0x0010          // LATEST or connection out of order
#define LM_TIMEOUT     0x0002          // Timeout during measurements
#define LM_AVERAGE     0x0001          // Values are average or median

// Status bits of volt-ampere measurement.
#define UM_NOHDW       0x8000          // Meas card absent or no initialization
#define UM_LIMIT       0x1000          // Voltage limit was reached
#define UM_BAD         0x0800          // Some measurements are invalid
#define UM_NOCT2       0x0400          // No contact in second point(s)
#define UM_NOCT1       0x0200          // No contact in first point
#define UM_HIGHI       0x0001          // Current source may be unable to set I

// Status bits of CRT measurement.
#define TM_NOHDW       0x8000          // Meas card absent or no initialization
#define TM_AVERAGE     0x2000          // Values are average or median
#define TM_UNSTABLE    0x1000          // Measured after several attempts
#define TM_BAD         0x0800          // Unstable measurements, data invalid
#define TM_NOCT2       0x0400          // No contact in second point(s)
#define TM_NOCT1       0x0200          // No contact in first point
#define TM_SHORT       0x0100          // Short to antenna
#define TM_BREAK       0x0020          // Breakdown detected
#define TM_SUPPLY      0x0010          // Voltage supply out of order
#define TM_CALIBR      0x0008          // CRT was calibrated in the air
#define TM_DISCHARGE   0x0004          // Unable to discharge load

// Status bits of external measurement.
#define EX_NOHDW       0x8000          // Hardware absent or damaged
#define EX_BAD         0x0800          // Data invalid
#define EX_NOCT2       0x0400          // No contact in second point(s)
#define EX_NOCT1       0x0200          // No contact in first point
#define EX_LENGTH      0x0040          // Length of answer exceeds 999 bytes
#define EX_BREAK       0x0020          // Break of serial connection detected
#define EX_IOERR       0x0010          // Serial I/O error detected
#define EX_BADCMD      0x0008          // Bad parameters in the command
#define EX_TMOUT       0x0002          // Timeout during measurements

// Status bits of divider measurement.
#define DM_NOHDW       0x8000          // Meas card absent, data invalid
#define DM_UNSTABLE    0x1000          // Measured after several retests
#define DM_BAD         0x0800          // Unstable R, data invalid
#define DM_NOCT2       0x0400          // No contact in power or ground
#define DM_NOCT1       0x0200          // No contact in middle point
#define DM_RVALID      0x0040          // Valid rpower and rgnd
#define DM_PARVALID    0x0020          // Valid rpar
#define DM_BADACC      0x0001          // Bad accuracy due to U/I limitations
*/
