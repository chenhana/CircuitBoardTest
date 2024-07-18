// Possible values of parameter justify in subroutines RParagraph etc.:
#define _RTFJUSTIFY  0x0000000C        // Type of text justification
#define RTF_FORMAT   0x00000000        // Text is formatted (default)
#define RTF_INDENT   0x00000001        // Paragraph is indented
#define RTF_LEFT     0x00000004        // Text is left-aligned
#define RTF_RIGHT    0x00000008        // Text is right-aligned
#define RTF_CENTERED 0x0000000C        // Text is centered
#define RTF_HEADER   0x00000010        // Treat paragraph as header
#define RTF_FOOTER   0x00000020        // Treat paragraph as footer
#define RTF_FIRST    0x00000040        // Header/footer for the first page only
#define _RTFBKGND    0x00000F00        // Type of background
#define RTF_WHITEBG  0x00000000        // White background
#define RTF_LIGHTBG  0x00000200        // Lightgray background
#define RTF_GRAYBG   0x00000400        // Gray background
#define RTF_DARKBG   0x00000800        // Darkgray background
#define RTF_BLACKBG  0x00000F00        // Black background
#define _RTFBORDER   0x00007000        // Type of border
#define RTF_NOBORDER 0x00000000        // No border around paragraph
#define RTF_THINBRD  0x00001000        // Thin border around paragraph
#define RTF_BORDER   0x00002000        // Normal border around paragraph
#define RTF_THICKBRD 0x00003000        // Thick border around paragraph
#define RTF_DBLBRD   0x00004000        // Double border around paragraph
#define RTF_SHADOW   0x00008000        // Shadowed together with the border
#define _RTFSPACE    0x00030000        // Type of space between paragraphs
#define RTF_THINSP   0x00010000        // Thin space before and after paragraph
#define RTF_SPACE    0x00020000        // Space before and after paragraph
#define RTF_THICKSP  0x00030000        // Thick space before and after paragraph
#define _RTFKEEP     0x00300000        // Paragraph keeping flags
#define RTF_KEEPNEXT 0x00100000        // Keep with next paragraph
#define RTF_TOGETHER 0x00200000        // Keep all paragraph lines together
// Possible values of parameter font in subroutine RFmt:
#define RTF_TIMES    0                 // Times New Roman (default)
#define RTF_ARIAL    1                 // Arial
#define RTF_COURIER  2                 // Courier
#define RTF_COURNEW  3                 // Courier New
#define RTF_PRINTER  4                 // LinePrinter
#define RTF_SYMBOL   6                 // Symbol
#define RTF_WING     7                 // WingDings
// Bit definitions of parameter mode in subroutine RFmt:
#define RTF_NORMAL   0x00              // Normal letters
#define RTF_BOLD     0x01              // Bold letters
#define RTF_ITALIC   0x02              // Italic letters
#define RTF_SUB      0x04              // Subscript
#define RTF_SUPER    0x08              // Superscript
#define _RTFULINE    0x70              // Type of underlining
#define RTF_UL       0x10              // Simple underline
#define RTF_ULTHICK  0x20              // Thick underline
#define RTF_ULDOUBLE 0x30              // Double underline
#define RTF_STRIKED  0x40              // Strikethrough
// Most of dimensions in the RTF file are specified in twips. RTFADD routines,
// however, request points or millimeters. 20 twips = 1 point = 1/72 inch, so
// 1 mm = 56.693 twips.

handle _rf                             // File in RTF format
int    _inpar                          // 1: paragraph, 2: header, 3: footer
int    _intable                        // 1: table
int    _startx,_currx                  // First and current X of table
int    _font,_prevfont                 // Current/previous font
int    _size,_prevsize                 // Current/previous font size
int    _mode,_prevmode                 // Current/previous font features
int    _colour,_prevcolour             // Current/previous text colour
int    _nc                             // Number of characters in line
int    _addspace                       // Add space after commands

int    _brdoffs[128]                   // Offsets of last 32 borders in table
int    _brdtype[32]                    // Type of border around last 32 cells
int    _nrow                           // Number of finished rows in table
int    _ncell                          // Number of cells in current row
int    _tjustify                       // Justification of table
int    _tkeepmode                      // Keeping flags of table

// Adds RTF command to the file
function int _WCmd(format text)
  int i
  if _rf==NULL return -1
  _addspace=1
  i=Strlen(text)
  if _nc+i>=78 then
    fprintf(_rf,"\n"); _nc=0
  endif
  fprintf(_rf,"%s",text)
  _nc=_nc+i
  if _nc>=68 then
    fprintf(_rf,"\n"); _nc=0; _addspace=0;
  endif
end

// Creates and prepares RTF file
function int ROpen(char *name)
  int red[24]=  { 0,0,0,0,128,128,128,192,128,0,0,0,255,255,255,255,           \
    232,224,224,224,255,255,255,192 }
  int green[24]={ 0,0,128,128,0,0,128,192,128,0,255,255,0,0,255,255,           \
    232,224,255,255,224,224,255,128 }
  int blue[24]= { 0,128,0,128,0,128,0,192,128,255,0,255,0,255,0,255,           \
    232,255,224,255,224,255,224,64 }
  char buf[520],drv[3],dir[260],fna[260],ext[260]
  int i,j,hi,lo,os
  if _rf!=NULL return -1               // Write file creation in process
  if name[0]=='\0' return -1           // Empty name is not allowed
  Fnsplit(name,drv,dir,fna,ext)
  if ext[0]=='\0' Strcpy(ext,".rtf")
  Fnmerge(buf,drv,dir,fna,ext)
  _rf=Fopen(buf,"w+b")
  if _rf==NULL return -1
  _nc=0; _addspace=0;
  _WCmd("{\\rtf1\\ansi \\deff0\\deflang1024")
  _WCmd("{\\fonttbl")
  _WCmd("{\\f0\\froman\\fprq2{\\*\\falt Tms Rmn} Times New Roman;}")
  _WCmd("{\\f1\\fswiss\\fprq2 Arial;}")
  _WCmd("{\\f2\\fmodern\\fprq1 Courier;}")
  _WCmd("{\\f3\\fmodern\\fprq1 Courier New;}")
  _WCmd("{\\f4\\fmodern\\fprq1 LinePrinter;}")
  _WCmd("{\\f5\\froman\\fprq2{\\*\\falt Tms Rmn} Times New Roman;}")
  _WCmd("{\\f6\\ftech\\fprq2 Symbol;}")
  _WCmd("{\\f7\\fnil\\fprq2 WingDings;}}")
  _WCmd("{\\colortbl")
  for i=0,i<24,i++
    _WCmd("\\red%i\\green%i\\blue%i;",red[i],green[i],blue[i])
  enddo
  _WCmd("}")
  SYS.Version(&hi,&lo,&os)
  j=0
  for i=0,i<260,i++ do                 // Backslash in RTF has special meaning,
    if name[i]=='\\' then              // correct file name.
      buf[j]='\\'; j++; endif
    buf[j]=name[i]; j++
    if name[i]=='\0' break
  enddo
  _WCmd("{\\info{\\title %s}{\\author OLLYTEST v%i.%i}",buf,hi,lo)
  if $GLOBAL.operator[0]!='\0' then
    for i=0,i<64,i++
      buf[i]=$GLOBAL.operator[i]
      if buf[i]=='\0' break
    enddo
    _WCmd("{\\operator %s}",buf)
  endif
  Strtime(buf,"\\yr%Y\\mo%m\\dy%d\\hr%H\\min%M\\sec%S",0,0)
  _WCmd("{\\creatim%s}}\\f0\\i0\\b0\\fs24\\cf0\\brsp20",buf)
  _WCmd("\\paperw11907\\paperh16834\\margl1985\\margr851")
  _WCmd("\\margt1701\\margb1134\\gutter0\\widowctrl\\makebackup")
  _WCmd("\\prcolbl\\lyprtmet")
  _inpar=0; _intable=0; _startx=0; _currx=0; _ncell=0
  _prevfont=RTF_TIMES; _font=RTF_TIMES // Default font
  _prevsize=24; _size=24               // Default font size 12 points
  _prevmode=0; _mode=RTF_NORMAL        // Default is plain text
  _prevcolour=0; _colour=0             // Default is black colour
  _tkeepmode=0
  return 0
end

// Sets the beginning of the new paragraph
function int RParagraph(int justify)
  int i
  if _rf==NULL return -1
  if _inpar==0 then
    _WCmd("\\pard\\plain"); _prevmode=RTF_NORMAL;
  else if _inpar==2 || _inpar==3 then
    _WCmd("\\par }")                   // Close header or footer
  else if _intable==0 then
    _WCmd("\\par\\pard")
  else
    _WCmd("\\cell\\pard")
  endif
      if (justify & RTF_FIRST)!=0 _WCmd("\\titlepg")
  if (justify & RTF_HEADER)!=0 then
    _WCmd("{\\header%s",(justify & RTF_FIRST)!=0?"f":"")
    _inpar=2
  else if (justify & RTF_FOOTER)!=0 then
    _WCmd("{\\footer%s",(justify & RTF_FIRST)!=0?"f":"")
    _inpar=3
  else
    if (justify & RTF_KEEPNEXT) _WCmd("\\keepn")
    if (justify & RTF_TOGETHER) _WCmd("\\keep")
    _inpar=1
  endif
  i=justify & _RTFJUSTIFY
  _WCmd("\\%s",i==RTF_FORMAT?"qj":(i==RTF_LEFT?"ql":(i==RTF_RIGHT?"qr":"qc")))
  if i!=RTF_CENTERED && (justify & RTF_INDENT)!=0 _WCmd("\\fi300")
  i=(justify & _RTFBKGND)/256
  if i!=0 then
    if _intable==0 then
      _WCmd("\\cbpat15\\cfpat0\\shading%i",i*625)
    else
      _WCmd("\\clcbpat15\\clcfpat0\\clshdng%i",i*625)
    endif
  endif
  i=justify & _RTFBORDER
  if i!=0 then
    if (justify & RTF_HEADER)!=0 then
      _WCmd("\\brdrb")
    else if (justify & RTF_FOOTER)!=0 then
      _WCmd("\\brdrt")
    else
      _WCmd("\\box")
    endif
    if i==RTF_THINBRD then
      _WCmd("\\brdrs\\brdrw15")
    else if i==RTF_BORDER then
      _WCmd("\\brdrs\\brdrw30")
    else if i==RTF_THICKBRD then
      _WCmd("\\brdrth\\brdrw30")
    else
      _WCmd("\\brdrdb\\brdrw15")
    endif
    if _colour!=BLACK _WCmd("\\brdrcf%i",_colour)
    if (justify & RTF_SHADOW)!=0 _WCmd("\\brdrsh")
  endif
  i=justify & _RTFSPACE
  if i!=0 then
    if i==RTF_THINSP then
      _WCmd("\\sb30\\sa30")
    else if i==RTF_SPACE then
      _WCmd("\\sb75\\sa75")
    else
      _WCmd("\\sb150\\sa150")
    endif
  endif
  _prevfont=-1; _prevsize=-1; _prevcolour=-1
end

// Service function, actualizes border data of the finished row in the table.
// Parameter islast!=0 means that this is the last row.
function int _RBorders(int islast)
  int i,j,b,tborder,save
  char s[64]
  if _inpar!=0 _WCmd("\\cell\\pard")
  _WCmd("\\intbl\\row\\pard")
  _prevmode=RTF_NORMAL
  save=Ftell(_rf)                      // Save actual position in file
  _ncell=Min(_ncell,32)                // Correct possible error
  tborder=_tjustify & _RTFBORDER
  for i=0,i<_ncell,i++
    for j=0,j<4,j++
      b=_brdtype[i]
      if (j==0 && i==0) || (j==1 && _nrow==0) ||                               \
        (j==2 && i==_ncell-1) || (j==3 && islast!=0)                           \
        b=Max(tborder,b)               // Take into account border around table
      if (j==0 && i>0)                                                         \
        b=Max(_brdtype[i-1],b)         // Check for the left neighbour
      if (j==2 && i<_ncell-1)                                                  \
        b=Max(_brdtype[i+1],b)         // Check for the right neighbour
      if b==RTF_NOBORDER continue
      sprintf(s,"\\clbrdr%c",j==0?'l':(j==1?'t':(j==2?'r':'b')))
      if b==RTF_THINBRD then
        sprintf(s+8,"\\brdrs \\brdrw15")
      else if b==RTF_BORDER then
        sprintf(s+8,"\\brdrs \\brdrw30")
      else if b==RTF_THICKBRD then
        sprintf(s+8,"\\brdrth\\brdrw30")
      else
        sprintf(s+8,"\\brdrdb\\brdrw15")
      endif
      Fseek(_rf,_brdoffs[i*4+j],0)
      Fwrite(s,23,_rf)
    enddo
  enddo
  Fseek(_rf,save,0)                    // Restore actual position in file
  if islast!=0 && (_tjustify & _RTFSPACE)!=0 then
    _WCmd("{\\sl-%i\\par}",(_tjustify & _RTFSPACE)==RTF_THINSP?30:             \
    ((_tjustify & _RTFSPACE)==RTF_SPACE?75:150))
    _WCmd("\\plain"); _prevmode=RTF_NORMAL;
  endif
  _inpar=0; _intable=0; _ncell=0
end

// Finishes current table.
function int REndtable()
  if _rf==NULL return -1
  if _intable==0 return 0              // Correct possible error
  _RBorders(1)
  _tkeepmode=0
end

// Creates new table
function int RTable(int justify,float x0,float dy)
  int i,j; char c
  if _rf==NULL return -1
  if _inpar==2 || _inpar==3 return -1  // Table in header/footer not allowed
  if _intable==0 then
    _tjustify=justify
    _nrow=0                            // Start new table
  else
    _RBorders(0)                       // Finish previous row
    _nrow++
  endif
  _tkeepmode=justify & _RTFKEEP
  _ncell=0
  if _inpar!=0 then
    _WCmd("\\par")                     // Finish previous plain text
    _inpar=0
  endif
  if _nrow==0 && (justify & _RTFSPACE)!=0 then
    _WCmd("{\\sl-%i\\par}",(justify & _RTFSPACE)==RTF_THINSP?30:               \
    ((justify & _RTFSPACE)==RTF_SPACE?75:150))
  endif
  _startx=x0*56.693
  if (justify & _RTFJUSTIFY)==RTF_CENTERED then
    _startx=-108; c='c'
  else if (justify & _RTFJUSTIFY)==RTF_RIGHT then
    c='r'
  else
    c='l'
  endif
  _WCmd("\\trowd\\trgaph108\\trleft%i\\trq%c",_startx,c)
  if dy!=0.0 then
    _WCmd("\\trrh%i",dy*56.693)        // Negative values also allowed in trrh
  endif
  _intable=1; _currx=_startx
end

function int RCell(int justify,float dx)
  int j,width
  if _rf==NULL return -1
  if _intable==0 RTable(justify,2,0)   // Correct possible error
  RParagraph((justify & (~(_RTFBORDER|_RTFKEEP))) | _tkeepmode)
  // Exclude border data
  width=dx*56.693
  _currx=_currx+width
  if _ncell<32 then
    _brdtype[_ncell]=justify & _RTFBORDER
    for j=0,j<4,j++                    // Stub for borders around the cell
      if _nc+23>=78 then
        fprintf(_rf,"\n"); _nc=0
      endif
      _brdoffs[_ncell*4+j]=Ftell(_rf)
      fprintf(_rf,"\\nobordr\\brdrs \\brdrw15")
      _nc=_nc+23
      if (justify & _RTFBORDER)==RTF_NOBORDER then
        _WCmd("\\brdrcf%i",WHITE)
      endif
    enddo
    _ncell++
  endif
  _WCmd("\\cellx%i\\intbl",_currx)
  return width
end

function int RCelltwips(int justify,int width)
  int j
  if _rf==NULL return -1
  if _intable==0 RTable(justify,2,0)   // Correct possible error
  RParagraph((justify & (~(_RTFBORDER|_RTFKEEP))) | _tkeepmode)
  _currx=_currx+width
  if _ncell<32 then
    _brdtype[_ncell]=justify & _RTFBORDER
    for j=0,j<4,j++                    // Stub for borders around the cell
      if _nc+23>=78 then
        fprintf(_rf,"\n"); _nc=0
      endif
      _brdoffs[_ncell*4+j]=Ftell(_rf)
      fprintf(_rf,"\\nobordr\\brdrs \\brdrw15")
      _nc=_nc+23
    enddo
    _ncell++
  endif
  _WCmd("\\cellx%i\\intbl",_currx)
  return width
end

// Sets the format of the text
function int RFmt(int font,int mode,float size)
  if _rf==NULL return -1
  if font<0 || font>=8 font=RTF_TIMES  // Default font
  if (mode & (RTF_SUPER|RTF_SUB))!=0 size=size*0.7
  if size<=0.0 size=12.0               // Default font size
  if size>256.0 size=256.0             // Maximal allowed font size
  if _inpar==2 || _inpar==3 then       // Header or footer: set font directly
    _WCmd("\\plain\\f%i\\fs%i",font,size*2)
    _WCmd("\\i%s\\b%s",(mode & RTF_ITALIC)?"":"0",(mode & RTF_BOLD)?"":"0")
    _WCmd("%s",(mode & RTF_SUB)?"\\dn6":((mode & RTF_SUPER)?"\\up6":"\\up0"))
    _WCmd("%s",(mode & _RTFULINE)==0?"\\ul0":                                  \
      ((mode & _RTFULINE)==RTF_UL?"\\ul":                                      \
      ((mode & _RTFULINE)==RTF_ULTHICK?"\\ulth":"\\uldb")))
    _WCmd("\\strike%s",(mode & RTF_STRIKED)?"":"0")
  else                                 // Not a header/footer: optimize
    _font=font
    _mode=mode
    _size=size*2.0
  endif
end

// Simplified version of RFmt, uses standard SCRIPT2 definitions
function int RFont(int otfont)
  if otfont==FIXEDFONT then
    RFmt(RTF_COURIER,RTF_BOLD,12)
  else if otfont==INFOFONT then
    RFmt(RTF_ARIAL,RTF_ITALIC,12)
  else if otfont==TERMINALFONT then
    RFmt(RTF_COURNEW,RTF_NORMAL,10)
  else if otfont==SMALLFONT then
    RFmt(RTF_ARIAL,RTF_NORMAL,9)
  else if otfont==MEDIUMFONT then
    RFmt(RTF_TIMES,RTF_BOLD,15)
  else if otfont==LARGEFONT then
    RFmt(RTF_TIMES,RTF_BOLD,30)
  else if otfont==HUGEFONT then
    RFmt(RTF_TIMES,RTF_BOLD,48)
  else
    RFmt(RTF_ARIAL,RTF_NORMAL,12)
  endif              
end

// Changes colour of the text
function int RColour(int colour)
  if (colour<0 || colour>=24) colour=0
  _colour=colour
end

// Adds text to the RTF file
function int RAddtext(char *text)
  char c,buf[128]
  int i,j,save
  if _rf==NULL return -1
  if _inpar==0 RParagraph(RTF_FORMAT)  // Correct possible error
  if _inpar!=2 && _inpar!=3 then
    if _font!=_prevfont _WCmd("\\f%i",_font)
    if _size!=_prevsize _WCmd("\\fs%i",_size)
    if ((_mode^_prevmode) & RTF_BOLD)!=0 then
      _WCmd("\\b%s",(_mode & RTF_BOLD)?"":"0")
    endif
    if ((_mode^_prevmode) & RTF_ITALIC)!=0 then
      _WCmd("\\i%s",(_mode & RTF_ITALIC)?"":"0")
    endif
    if _colour!=_prevcolour _WCmd("\\cf%i",_colour)
    if ((_mode^_prevmode) & (RTF_SUB|RTF_SUPER))!=0 then
      if (_mode & RTF_SUB)!=0 then
        _WCmd("\\dn6")
      else if (_mode & RTF_SUPER)!=0 then
        _WCmd("\\up6")
      else
        _WCmd("\\up0")
      endif
    endif
    if ((_mode^_prevmode) & _RTFULINE)!=0 then
      i=_mode & _RTFULINE
      if i==RTF_UL then
        _WCmd("\\ul")
      else if i==RTF_ULTHICK then
        _WCmd("\\ulth")
      else if i==RTF_ULDOUBLE then
        _WCmd("\\uldb")
      else
        _WCmd("\\ul0")
      endif
    endif
    if ((_mode^_prevmode) & RTF_STRIKED)!=0 then
      _WCmd("\\strike%s",(_mode & RTF_STRIKED)?"":"0")
    endif
    _prevfont=_font; _prevsize=_size
    _prevmode=_mode; _prevcolour=_colour
  endif
  if _addspace!=0 then
    fprintf(_rf," "); _nc++; _addspace=0
  endif
  i=0                                  // Index in text
  j=0                                  // Number of characters in buf
  save=0
  while 1 do
    c=text[i]
    if c=='\0' then
      save=1
    else if c=='\\' || c=='{' || c=='}' || c=='\n' || c=='\r' then
      buf[j]='\\'; j++;
      buf[j]=c; i++; j++
    else if c=='\t' then               // Tab
      Memcpy(buf+j,"\\tab ",5); i++; j=j+5
    else
      buf[j]=c; i++; j++
    endif
    if (Isalnum(c)==0 && j+_nc>=68) || (j+_nc>=78) save=2
    if save!=0 then
      buf[j]='\0'; fprintf(_rf,"%s",buf); _nc=_nc+j
      if save==2 then
        fprintf(_rf,"\n"); _nc=0
      endif
      j=0; save=0
    endif
    if c=='\0' break
  enddo
end

function int RAddfmt(format text)
  return RAddtext(text)
end

// Cuts picture from graph window and inserts it into the RTF text scaled by
// factor zoom.
function int RAddpiczoom(handle graph,int x0,int y0,int x1,int y1,int mode,    \
  float zoom)
  int i,init,meta,rsiz,last
  char s[64]
  if _rf==NULL return -1
  if x0<0 x0=0; if x1-x0>999 x1=x0+999
  if y0<0 y0=0; if y1-y0>999 y1=y0+999
  if x1<=x0 || y1<=y0 return -1        // Invalid input data
  init=Ftell(_rf)
  _WCmd("{\\pict\\wmetafile8\\picw%i\\pich%i",(x1-x0)*26.5,(y1-y0)*26.5)
  _WCmd("\\picwgoal%i\\pichgoal%i",(x1-x0)*15,(y1-y0)*15)
  if zoom!=1.0 then
    _WCmd("\\picscalex%i\\picscaley%i",zoom*100.0+0.5,zoom*100.0+0.5)
  endif
  fprintf(_rf," \n")
  meta=Ftell(_rf)
  fprintf(_rf,"010009000003000000000000000000000000")
  fprintf(_rf,"050000000b0200000000\n")
  fprintf(_rf,"050000000c02%02x%02x%02x%02x",                                  \
    (y1-y0) & 0xFF,((y1-y0)>>8) & 0xFF,(x1-x0) & 0xFF,((x1-x0)>>8) & 0xFF)
  fprintf(_rf,"05000000090200000000")
  fprintf(_rf,"050000000102ffffff00")
  fprintf(_rf,"0400000007010300\n")
  rsiz=Ftell(_rf)
  fprintf(_rf,"00000000430f2000cc000000%02x%02x%02x%02x",                      \
    (y1-y0) & 0xFF,((y1-y0)>>8) & 0xFF,(x1-x0) & 0xFF,((x1-x0)>>8) & 0xFF)
  fprintf(_rf,"00000000%02x%02x%02x%02x00000000\n",                            \
    (y1-y0) & 0xFF,((y1-y0)>>8) & 0xFF,(x1-x0) & 0xFF,((x1-x0)>>8) & 0xFF)
  i=SYS.Writebmp(graph,x0,y0,x1,y1,_rf,mode | 0x80)
  if i==0 then
    Fseek(_rf,init,0)                  // Unable to get bitmap!
    return -1
  endif
  fprintf(_rf,"030000000000}\n")
  last=Ftell(_rf)
  i=i/2+14
  sprintf(s,"%08x",i+36)
  Fseek(_rf,meta+12,0)
  Fwrite(s+6,2,_rf); Fwrite(s+4,2,_rf); Fwrite(s+2,2,_rf); Fwrite(s,2,_rf);
  sprintf(s,"%08x",i)
  Fseek(_rf,meta+24,0)
  Fwrite(s+6,2,_rf); Fwrite(s+4,2,_rf); Fwrite(s+2,2,_rf); Fwrite(s,2,_rf);
  Fseek(_rf,rsiz,0)
  Fwrite(s+6,2,_rf); Fwrite(s+4,2,_rf); Fwrite(s+2,2,_rf); Fwrite(s,2,_rf);
  Fseek(_rf,last,0)
  _nc=0; _addspace=0
end

// Cuts picture from graph window and inserts it into the RTF text
function int RAddpicture(handle graph,int x0,int y0,int x1,int y1,int mode)
  return RAddpiczoom(graph,x0,y0,x1,y1,mode,1.0)
end

// Inserts page number into the RTF text
function int RAddpagenumber()
  if _rf==NULL return -1
  RAddtext("")                         // Actualize formatting mode
  _WCmd("\\chpgn")
end

// Inserts hard page break into the RTF text
function int RNewpage()
  if _rf==NULL return -1
  _WCmd("\\page \n")
  _nc=0; _addspace=0
end

// Closes RTF file
function int RClose()
  if _rf==NULL return -1
  if _intable!=0 REndtable()
  if (_inpar!=0) _WCmd("\\par")
  _WCmd("}\n")
  Fclose(_rf)
  _rf=NULL
end

