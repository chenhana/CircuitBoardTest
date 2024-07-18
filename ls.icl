#define BLACK        0
#define BLUE         1
#define GREEN        2
#define CYAN         3
#define RED          4
#define MAGENTA      5
#define BROWN        6
#define GRAY         7
#define DARKGRAY     8
#define LIGHTBLUE    9
#define LIGHTGREEN   10
#define LIGHTCYAN    11
#define LIGHTRED     12
#define LIGHTMAGENTA 13
#define YELLOW       14
#define WHITE        15
#define LIGHTGRAY    16
#define WHITEBLUE    17
#define WHITEGREEN   18
#define WHITECYAN    19
#define PINK         20
#define WHITEMAGENTA 21
#define LIGHTYELLOW  22
#define STRANGE      23

#define DEFCOLOR     255
#define VIDEOFILL    LIGHTMAGENTA

#define MAINFONT     0
#define FIXEDFONT    1
#define INFOFONT     2
#define TERMINALFONT 3
#define COURIERFONT  3                 // For compatibility with old versions
#define SMALLFONT    4
#define MEDIUMFONT   5
#define LARGEFONT    6
#define HUGEFONT     7
#define FIXEDSYS     8                 
#define TIMESFONT    9             
#define DEFFONT      255

#define M_CHECKED    0x00000001        // Control is pressed or checked
#define M_BORDER     0x00000002        // Draw also border
#define M_LEFT       0x00000004        // Text is left-aligned      
#define M_RIGHT      0x00000008        // Text is right-aligned
#define M_CENTERED   0x0000000C        // Text is centered
#define M_NOMINIMIZE 0x00000010        // Minimize button absent
#define M_TOPMOST    0x00000020        // Window is topmost
#define M_MODAL      0x00000040        // Window is modal
#define M_SIZE       0x00000080        // Window is resizable
#define M_PERCENT    0x00000100        // Progress bar is in percents
#define M_SELECTION  0x00000200        // Selection in graph window allowed
#define M_PASSWORD   0x00000400        // Edit replaces chars by asterisks
#define M_NOOWNER    0x00000800        // Window can be moved into background
#define M_HSCROLL    0x00001000        // Window has a horizontal scroll bar
#define M_VSCROLL    0x00002000        // Window has a vertical scroll bar
#define M_TSTAMP     0x00004000        // Window displays time stamps
#define M_NOTAB      0x00008000        // Window not selectable using TAB
#define M_DBLCLICK   0x00010000        // Button activated by doubleclick only
#define M_REPEAT     0x00020000        // Button repeats the signals
#define M_NOEDIT     0x00040000        // Editor works as viewer only

#define M_AUTORIGHT  0x01000000        // Keep with right parent's border
#define M_AUTOWIDTH  0x02000000        // Resize X synchronously with parent
#define M_AUTOCENTER 0x04000000        // Center in X direction
#define M_AUTOHALFW  0x08000000        // Resize X synchronously with center
#define M_AUTOBOTTOM 0x10000000        // Keep with bottom parent's border
#define M_AUTOHEIGHT 0x20000000        // Resize Y synchronously with parent
#define M_AUTOHALFH  0x40000000        // Resize Y synchronously with center

#define NOPARITY     0x0000            // Possible parity settings for
#define ODDPARITY    0x0001            // function Fserial().
#define EVENPARITY   0x0002
#define DTR_ON       0x0100            // DTR output always on
#define RTS_ON       0x0200            // RTS output always on
#define USE_CTS      0x0400            // Monitor CTS
#define USE_DSR      0x0800            // Monitor DSR
#define HANDSHAKE    0x1000            // Enable DTR handshake

#define MAXINT       0x7FFFFFFF        // Maximal positive integer value
#define MININT       0x80000000        // Minimal negative integer value

// How to generate video model (parameter modelmode).
#define MODEL_SMART  0x01              // Remove nonsignificant parts
#define MODEL_BIG    0x02              // Generate slower accurate model
#define MODEL_MIRROR 0x08              // Generate mirrored model (Graphmodel)

// Synthetic models, parameters a/b in pixels.
#define SYNT_CIRCLE  0                 // Circle, external/internal diameters
#define SYNT_RECT    1                 // Rectangle, width/height
#define SYNT_LEFT    5                 // 2 rects, left higer, distance/side
#define SYNT_RIGHT   6                 // 2 rects, right higher, distance/side
#define SYNT_CROSS   7                 // Cross, length/width

// Colour of synthetic model
#define WHITEONBLACK 0                 // White model on black background
#define BLACKONWHITE 1                 // Black model on white background

// Privileged functions, accessible only from the main task.
external int SYS.Kill(int instance);
external int SYS.Quit();
external int SYS.Debugmode(int mode,int dummy1,int dummy2,int dummy3);
external handle SYS.Getmainwindow();
external handle SYS.Getsyslist();
external int SYS.Setsyslist(handle list);
external int SYS.Killwinproc(char *name);

// Privileged functions that are not available in Test Player.
external int SYS.Remote(char *host,int port);

// Common functions implemented in C language
external int SYS.Version(int *hi,int *lo,int *os);
external int SYS.Start(char *module,int prio,char *argv);
external int SYS.Compile(char *filename,int debuginfo);
external int SYS.Moduledata(int index,char *name,                              \
  int *size,int *instances,int *codetype);
external int SYS.Rundata(int index,char *name,                                 \
  int *active,int *prio,int *runtime,int *cputime);
external int SYS.Statistics(int index,int *used,int *total,int *size);
external int SYS.Message(int process,int length,char *data);
external int SYS.Broadcast(int length,char *data);
external int SYS.Readatf(char *atfname,char *dataname);
external int SYS.Recogn(handle hfid);
external int SYS.Recognize(handle hfid,                                        \
  int x0,int y0,int x1,int y1,float *found);
external int SYS.Recognangle(handle hfid,                                      \
  int x0,int y0,int x1,int y1,float *found,float angle,int clip);
external int SYS.Recdata(handle hfid,                                          \
  int x,int y,float *corr,float *dummy,char *moddata,char *imgdata);
external int SYS.Slavepresent();
external int SYS.Send(int length,char *data,int user);
external int SYS.Sendimm(int buffer,int length,char *data);
external int SYS.Sendtext(char *command,int user);
external int SYS.Sendtextimm(int buffer,char *command);
external int SYS.Softreset(int user);
external int SYS.Softimm(int ident);
external int SYS.Hardreset(int user);
external int SYS.Hardimm(int ident);
external int SYS.Killsend(int ident);
external int SYS.Killimm(int buffer);
external int SYS.Video(handle hw,int chan,                                     \
  int mirr,float zoom,int bri,int ctr);
external int SYS.Videoex(handle hw,int chan,                                   \
  int mirr,float zoom,int bri,int ctr,int mode);
external int SYS.Videoangle(handle hw,int chan,                                \
  int mirr,float zoom,int bri,int ctr,int mode,float angle);
external int SYS.Getvideo(int chan,                                            \
  int x0,int x1,int xn,int y0,int y1,int yn,char *buf);
external int SYS.Getcolorvideo(int chan,                                       \
  int x0,int x1,int xn,int y0,int y1,int yn,char *buf);
external int SYS.Openbitmap(int chan,char *path);                                                  
external int SYS.Videosize(int channel,int *dx,int *dy,int *nframes);
external int SYS.Videoparms(int chan,int *bri,int *ctr,int *dummy);
external int SYS.Framecount(int channel);
external int SYS.Nextframe(int channel)
external int SYS.Autoset(int chan,int videoautoset);
external handle SYS.Syntmodel(int chan,int type,                               \
  float a,float b,float c,float fi,int color);
external handle SYS.Videomodel(int chan,                                       \
  int x0,int y0,int dx,int dy,int modelmode);
external handle SYS.Modelangle(int chan,                                       \
  int x0,int y0,int dx,int dy,int modelmode,float angle,int clip);
external handle SYS.Graphmodel(int chan,                                       \
  handle hgraph,int x0,int y0,int asblack,int aswhite,int modelmode);
external int SYS.Drawmodel(handle hmodel,int showexact,handle hgraph,          \
  int x,int y,int color,int r);
external int SYS.Deletemodel(handle hm);
external int SYS.Writebmp(handle hw,int x0,int y0,int x1,int y1,               \
  handle file,int mode);
external int SYS.Saveframe(int chan,char *file,int mode,                       \
  char *comment,float scale);
external int SYS.Datamatrix(int chan,int matrixcolor,int matrixdots,           \
  float dotsize,float anglemin,float anglemax,char *code,int *corners);
//external int SYS.Dmatrix(int chan,char *code,int *corners);
external int SYS.Winexec(char *cmdline);
external int SYS.Linfit(int nin,float *xin,float *yin,float *dyin,             \
  int nout,float *xout,float *yout);
external int SYS.Splinefit(int nin,float *xin,float *yin,float *dyin,          \
  int nout,float *xout,float *yout);
external int SYS.Polyfit(int nin,float *xin,float *yin,int order,              \
  int nout,float *xout,float *yout);
external int SYS.Interpol(int nin,float *xin,float *yin,                       \
  int nout,float *xout,float *yout);
external int SYS.Browse(handle hw,char *name,char *title,int mode);
external int SYS.Browsedir(handle hw,char *dir,char *comment,int mode);
external int SYS.Fft(int n,float *rein,float *imin,float *reout,float *imout);
external int SYS.Scriptdir(char *name);
external int SYS.Findfiles(char *pattern,char *buf);
external int SYS.Rkf(function f,int n,float y[],float t0,float t1)
external int SYS.Exttemperature(float *temp)
external int SYS.Exthumidity(float *hum)

// Functions that succeed only in Test Player.
external int SYS.Getemurec(int index,char *prec,char *answer);
external int SYS.Boardname(char *name);
external int SYS.Emuname(char *name);
external int SYS.Loadfiducials(char *name);
external int SYS.Getfiducial(int fiducial,int model,int variant,               \
  int info[],char *data);
external int SYS.GetfiducialEx(int fiducial,int model,int variant,               \
  int info[],char *data,char *pCamData, char *pSniperData);
external int SYS.Getpanelinfo(int panelspersample[],int list[])
external int SYS.Getpanelinfoex(int panelspersample[],int list[],              \
  int panelident[],int sampleident[],int reserved[])
external int SYS.Getlotrun(int lot[],int run[],int reserved[])
external int SYS.Getpadxy(int panel,int pad,int net[],int index[],int head[],  \
  int x[],int y[],int r[],int acc[],int dx[],int dy[])
external int SYS.Addfault(int replace,int type,int subtype,int testtype,       \
  int testsubtype,int panel,int pad1,int pad2,                                 \
  float value,float corr,float reserved)
external int SYS.Setlasterror(int errorcode,char *errortext)

// Common functions written in SCRIPT2.
external int SERV.Addextention(char *filename,char *defext);
external int SERV.Ohmstotext(float r,int status,char *s);
external int SERV.Milliohmstotext(float r,int status,char *s);
external int SERV.Pftotext(float c,char *s);
external int SERV.Cmdimm(int ident,char *cmd);
external int SERV.Parsecmd(char *cmd,char *buf);
external int SERV.Parsecmdext(char *cmd,char *buf,char *error)

