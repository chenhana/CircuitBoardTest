// Layout of buffer  "_wbuf" used in all calls in this file:
// $short(_wbuf+0)   - current position in current text buffer
// $short(_wbuf+2)   - current paragraph of current text buffer
// $short(_wbuf+4)   - current pointer to character formatting information
// $short(_wbuf+6)   - current pointer to paragraph formatting information
// $long(_wbuf+8)    - last paragraph start
// $long(_wbuf+12)   - last character descriptor start
// $short(_wbuf+16)  - number of pictures in the file
// $short(_wbuf+18)  - offset of valid data in current text buffer
// $long(_wbuf+20)   - base of unique object names
// $short(_wbuf+24)  - start of character formatting information
// $short(_wbuf+26)  - end of character formatting information
// $short(_wbuf+28)  - start of paragraph formatting information
// $short(_wbuf+30)  - end of paragraph formatting information
// $char(_wbuf+32)   - alignment of current text paragraph
// $char(_wbuf+33)   - current paragraph is picture
// $char(_wbuf+40)   - underlined/font/italic/bold of current character block
// $char(_wbuf+41)   - font size of current character block
// 128..255          - current text buffer
//                   - character formatting info (each entry 8 bytes long)
//                   - paragraph formatting info (each entry 8 bytes long)

#define _WRIBUFSIZE  32512             // Size of formatting buffer

// Possible values of parameter justify in subroutine WParagraph:
#define WRI_FORMAT   0x0000            // Text is formatted (default)
#define WRI_LEFT     0x0004            // Text is left-aligned
#define WRI_RIGHT    0x0008            // Text is right-aligned
#define WRI_CENTERED 0x000C            // Text is centered
#define WRI_HEADER   0x0010            // Treat paragraph as header
#define WRI_FOOTER   0x0020            // Treat paragraph as footer
#define WRI_NOFIRST  0x0040            // Do not print on the first page
// Possible values of parameter font in subroutine WFmt:
#define WRI_TIMES    0                 // Times New Roman (default)
#define WRI_ARIAL    1                 // Arial
#define WRI_COURIER  2                 // Courier
#define WRI_COURNEW  3                 // Courier New
#define WRI_PRINTER  4                 // LinePrinter
#define WRI_SYMBOL   6                 // Symbol
#define WRI_WING     7                 // WingDings
// Bit definitions of parameter bolditalic in subroutine WFmt:
#define WRI_NORMAL   0x00              // Normal letters
#define WRI_BOLD     0x01              // Bold letters
#define WRI_ITALIC   0x02              // Italic letters
#define WRI_UL       0x80              // Simple underline

char _wbuf[_WRIBUFSIZE]
handle _wf

function int _WWritetext(char *text)
  int i,j,ofs
  ofs=0
  i=Strlen(text)
  j=$short(_wbuf+0)
  while 1 do
    if i==0 then
      break
    else if (i+j<128) then
      Memcpy(_wbuf+128+j,text+ofs,i)
      break
    else
      Memcpy(_wbuf+128+j,text+ofs,128-j)
      Fwrite(_wbuf+128+$short(_wbuf+18),128-$short(_wbuf+18),_wf)
      $short(_wbuf+18)=0               // Clear valid text data offset
      $short(_wbuf+2)=$short(_wbuf+2)+1
      ofs=ofs+128-j
      i=i-(128-j)
      j=0
    endif
  enddo
  $short(_wbuf+0)=j+i
end

// Creates and prepares MSWrite-compatible file
function int WOpen(char *name)
  int nentries
  if _wf!=NULL return -1               // Write file creation in process
  nentries=(_WRIBUFSIZE-256)/16
  $short(_wbuf+0)=0                    // Current position in buffer
  $short(_wbuf+2)=1                    // Current text paragraph in buffer
  $short(_wbuf+24)=256                 // Start of character information
  $short(_wbuf+26)=256+nentries*8      // End of character information
  $short(_wbuf+28)=256+nentries*8      // Start of paragraph information
  $short(_wbuf+30)=256+nentries*16     // End of paragraph information
  $short(_wbuf+4)=$short(_wbuf+24)     // Character formatting information
  $short(_wbuf+6)=$short(_wbuf+28)     // Paragraph formatting information
  $long(_wbuf+8)=128                   // Last paragraph start
  $long(_wbuf+12)=128                  // Last character descriptor start
  $short(_wbuf+16)=0                   // No pictures till now
  $short(_wbuf+18)=0                   // Initial offset of valid text data
  $long(_wbuf+20)=Random(0x7FFFFFFF)   // Set base of unique object names
  $char(_wbuf+32)=WRI_FORMAT           // Justified alignment as default
  $char(_wbuf+33)=0                    // Current paragraph is not a picture
  $char(_wbuf+40)=0                    // System font as default
  $char(_wbuf+41)=24                   // Font size 12 points as default
  _wf=Fopen(name,"w+b")
  Fwrite(_wbuf,128,_wf)                // Placeholder for Write header
  if _wf==NULL return -1
  return 0
end

// Sets the beginning of the new paragraph
function int WParagraph(int justify)
  int i,j
  i=$short(_wbuf+2)*128+$short(_wbuf+0)
  if i>$long(_wbuf+8) then
    _WWritetext("\r\n")
    i=i+2
    j=$short(_wbuf+6)
    $long(_wbuf+j)=i                   // End of previous text paragraph
    if j<$short(_wbuf+30) then
      $long(_wbuf+8)=i                 // Replace with start of new paragraph
      $char(_wbuf+j+4)=$char(_wbuf+32) // Store properties of previous paragraph
      $char(_wbuf+j+5)=$char(_wbuf+33)
      j=j+8                            // Size of internal paragraph descriptor
      $short(_wbuf+6)=j
    endif
  endif
  $char(_wbuf+32)=justify
  $char(_wbuf+33)=0
end

function int WFmt(int font,int bolditalic,float size)
  int i,j
  i=$short(_wbuf+2)*128+$short(_wbuf+0)
  if size<=0.0 size=12.0               // Default font size
  if size>127.0 size=127.0             // Maximal allowed font size
  if i>$long(_wbuf+12) then
    j=$short(_wbuf+4)
    $long(_wbuf+j)=i                   // End of previous character block
    if j<$short(_wbuf+26) then
      $long(_wbuf+12)=i                // Replace with start of new block
      $char(_wbuf+j+4)=$char(_wbuf+40) // Store properties of previous block
      $char(_wbuf+j+5)=$char(_wbuf+41)
      j=j+8                            // Size of internal block descriptor
      $short(_wbuf+4)=j
    endif
  endif
  $char(_wbuf+40)=(font & 7)*4+(bolditalic & 0x83)
  $char(_wbuf+41)=size*2.0             // Size in halfpoints!
end

// Simplified version of WFmt, uses standard SCRIPT2 definitions
function int WFont(int otfont)
  if otfont==FIXEDFONT then
    WFmt(WRI_COURIER,WRI_BOLD,12)
  else if otfont==INFOFONT then
    WFmt(WRI_ARIAL,WRI_ITALIC,12)
  else if otfont==TERMINALFONT then
    WFmt(WRI_COURNEW,WRI_NORMAL,10)
  else if otfont==SMALLFONT then
    WFmt(WRI_ARIAL,WRI_NORMAL,9)
  else if otfont==MEDIUMFONT then
    WFmt(WRI_TIMES,WRI_BOLD,15)
  else if otfont==LARGEFONT then
    WFmt(WRI_TIMES,WRI_BOLD,30)
  else if otfont==HUGEFONT then
    WFmt(WRI_TIMES,WRI_BOLD,48)
  else
    WFmt(WRI_ARIAL,WRI_NORMAL,12)
  endif
end

// Adds text to the Write-compatible file
function int WAddtext(char *text)
  int i,j;
  i=0; j=0;
  while 1 do                           // Eliminate characters that has special
    text[j]=text[i]                    // meaning in Write
    if text[i]==0 break
    if text[i]!='\r' && text[i]!='\n' j=j+1
    i=i+1
  enddo
  _WWritetext(text)
end

// Adds page number to the Write-compatible file
function int WAddpagenumber()
  int i,j
  char s[2]
  i=$short(_wbuf+2)*128+$short(_wbuf+0)
  if i>$long(_wbuf+12) then
    j=$short(_wbuf+4)
    $long(_wbuf+j)=i                   // End of previous character block
    if j<$short(_wbuf+26) then
      $long(_wbuf+12)=i                // Replace with start of new block
      $char(_wbuf+j+4)=$char(_wbuf+40) // Store properties of previous block
      $char(_wbuf+j+5)=$char(_wbuf+41)
      j=j+8                            // Size of internal block descriptor
      $short(_wbuf+4)=j
    endif
  endif
  s[0]=1; s[1]=0; _WWritetext(s)
  i=$short(_wbuf+2)*128+$short(_wbuf+0)
  j=$short(_wbuf+4)
  $long(_wbuf+j)=i                     // End of page number character block
  if j<$short(_wbuf+26) then
    $long(_wbuf+12)=i                  // Replace with start of new block
    $char(_wbuf+j+4)=$char(_wbuf+40)|0x40
    $char(_wbuf+j+5)=$char(_wbuf+41)
    j=j+8                              // Size of internal block descriptor
    $short(_wbuf+4)=j
  endif
end

// Cuts picture from graph window and inserts it into the Write-compatible file
function int WAddpicture(handle graph,int x0,int y0,int x1,int y1,int mode)
  char hdr[83],pro[26]
  int i,posolehdr,posoleend,sizex,sizey
  if x0<0 x0=0; if x1-x0>999 x1=x0+999
  if y0<0 y0=0; if y1-y0>999 y1=y0+999
  if x1<=x0 || y1<=y0 return -1        // Invalid input data
  WParagraph($char(_wbuf+32))          // Close previous text paragraph
  if ($short(_wbuf+0)-$short(_wbuf+18)>0)
    Fwrite(_wbuf+128+$short(_wbuf+18),$short(_wbuf+0)-$short(_wbuf+18),_wf);
  $short(_wbuf+18)=$short(_wbuf+0);
  $char(hdr+0)=0xE4                    // hdr.mm - OLE object description
  $short(hdr+6)=2                      // hdr.objectType - embedded object
  $short(hdr+10)=1440;                 // Stub for horizontal size
  $short(hdr+12)=1440;                 // Stub for vertical size
  $long(hdr+24)=$long(_wbuf+20)+$short(_wbuf+16)
  $short(hdr+30)=40                    // Number of bytes in the header (fixed)
  $short(hdr+36)=1000                  // X scaling factor 1:1
  $short(hdr+38)=1000                  // Y scaling factor 1:1
  $long(hdr+40)=0x00000501             // OLE version number
  $long(hdr+44)=2                      // OLE format ID
  $long(hdr+48)=7                      // Length of class string
  Memcpy(hdr+52,"PBrush\0",7)          // Class string: Paintbrush picture
  $long(hdr+59)=0                      // Topic string absent
  $long(hdr+63)=12                     // Length of item string
  posolehdr=Ftell(_wf)                 // Fix begin of OLE header
  Fwrite(hdr,83,_wf)                   // Write stubbed OLE header
  i=SYS.Writebmp(graph,x0,y0,x1,y1,_wf,mode & 0x7F)
  if i==0 then                         // Unable to get bitmap!
    Fseek(_wf,posolehdr,0)
    return -1                          // Discard OLE header
  endif
  $long(hdr+79)=i                      // Size of native bitmap data
  $long(pro+0)=0x00000501              // OLE version number
  $long(pro+4)=0                       // No presentation object
  Fwrite(pro,8,_wf)                    // Write empty presentation object
  $long(hdr+16)=i+43+8                 // Object data size (with presentation)
  posoleend=Ftell(_wf)                 // Fix end of OLE
  Fseek(_wf,posolehdr+83,0)
  Fread(pro,26,_wf)                    // Read bitmap header
  sizex=$long(pro+18)                  // X bitmap size, pixels
  sizey=$long(pro+22)                  // Y bitmap size, pixels
  $short(hdr+10)=sizex*15;             // Horizontal picture size, 1/1440 inch
  $short(hdr+12)=sizey*15;             // Vertical picture size, 1/1440 inch
  sprintf(hdr+67,"0 0 %3i %3i",sizex,sizey)
  Fseek(_wf,posolehdr,0)
  Fwrite(hdr,83,_wf)                   // Write actual OLE header
  Fseek(_wf,posoleend,0)
  $short(_wbuf+0)=posoleend%128        // Correct text buffer properties
  $short(_wbuf+2)=posoleend/128
  $short(_wbuf+18)=posoleend%128
  $char(_wbuf+33)=1                    // Current paragraph is a picture
  WParagraph($char(_wbuf+32))          // Close OLE paragraph
  $short(_wbuf+16)=$short(_wbuf+16)+1  // Increment number of pictures
end

// Closes Write-compatible file
function int WClose()
  char fontname[8,16] = {                                                      \
    "Times New Roman","Arial","Courier","Courier New",                         \
    "LinePrinter","Times New Roman","Symbol","WingDings" };
  char s[128]                          // Write file header
  char t[128]                          // Table paragraph
  int i,j,k,p,q,len,par
  WParagraph($char(_wbuf+32))          // Add last paragraph format
  WFmt($char(_wbuf+40)>>2,$char(_wbuf+40) & 3,                                 \
    $char(_wbuf+41))                   // Add last character format
  len=$short(_wbuf+0)                  // Current position
  par=$short(_wbuf+2)                  // Current paragraph
  if $short(_wbuf+16)==0 then
    $short(s+0)=0xBE31;                // Write file without OLE objects
  else
    $short(s+0)=0xBE32;                // Write file with OLE objects
  endif
  $short(s+4)=0xAB00;                  // Tool (hell if I know what it is)
  $long(s+14)=par*128+len              // Text length
  if (len!=0) then
    for i=len,i<128,i=i+1              // Quite unnecessary, just a cosmetical
      _wbuf[128+i]=0                   // operation!
    enddo
    Fwrite(_wbuf+128+$short(_wbuf+18),                                         \
      128-$short(_wbuf+18),_wf)        // Flush last paragraph
    par=par+1
  endif
  // Store character information (the so called character section)
  i=$short(_wbuf+24)                   // Offset of character formatting data
  j=$short(_wbuf+4)                    // End of character formatting data
  q=128                                // First character covered by page
  while 1 do
    k=0                                // Number of FODs on the current page
    $long(t+0)=q                       // First character covered by page
    while 1 do
      if i>=j break                    // No more FODs
      if k>=10 break                   // Max number of FODs per page
      $long(t+4+k*6)=$long(_wbuf+i)    // FOD.fcLim - first uncovered byte
      $short(t+8+k*6)=60+k*6           // FOD.bfprop - offset to FPROP
      $char(t+64+k*6)=5                // FPROP.cch - length of CHP prefix
      $char(t+66+k*6)=$char(_wbuf+4+i) & 0x3F // CHP.ftc+CHP.fItalic+CHP.fBold
      $char(t+67+k*6)=$char(_wbuf+5+i) // CHP.hps - font size in halfpoints
      $char(t+68+k*6)=$char(_wbuf+4+i) & 0x40 // CHP.fSpecial
      if ($char(_wbuf+4+i) & 0x80) then// Underlined
        $char(t+68+k*6)=$char(t+68+k*6) | 1
      endif
      $char(t+69+k*6)=0                // Ignored by Write
      q=$long(_wbuf+i)
      i=i+8
      k=k+1
    enddo
    t[127]=k                           // Number of FODs on the current page
    Fwrite(t,128,_wf)
    par=par+1
    if i>=j break                      // Character section completed
  enddo
  // Store paragraph information (paragraph section)
  $short(s+18)=par                     // Page for start of paragraph info
  for i=0,i<128,i=i+1
    t[i]=0                             // Set unused bytes to default zero
  enddo
  i=$short(_wbuf+28)                   // Offset of paragraph formatting data
  j=$short(_wbuf+6)                    // End of character formatting data
  q=128                                // First character covered by page
  while 1 do
    k=0                                // Number of FODs on the current page
    $long(t+0)=q                       // First character covered by page
    while 1 do
      if i>=j break                    // No more FODs
      if k>=5 break                    // Max number of FODs per page
      $long(t+4+k*6)=$long(_wbuf+i)    // FOD.fcLim - first uncovered byte
      $short(t+8+k*6)=30+k*18          // FOD.bfprop - offset to FPROP
      $char(t+34+k*18)=17              // FPROP.cch - length of PAP prefix
      $char(t+35+k*18)=60              // Undocumented but must be so
      p=$char(_wbuf+4+i) & WRI_CENTERED
      if p==WRI_FORMAT then $char(t+36+k*18)=3;
      else if p==WRI_LEFT then $char(t+36+k*18)=0;
      else if p==WRI_RIGHT then $char(t+36+k*18)=2;
      else $char(t+36+k*18)=1; endif;  // PAP.jc - paragraph justification
      $char(t+37+k*18)=30              // Undocumented but must be so
      $short(t+43+k*18)=300            // PAP.dxaLeft1 - first-line indent
      $short(t+45+k*18)=200            // PAP.dyaLine - interline spacing
      if $char(_wbuf+5+i)==0 then
        q=0                            // Text paragraph
        if ($char(_wbuf+4+i) & WRI_HEADER)!=0 then
          q=q|0x02                     // Mark as header
          if ($char(_wbuf+4+i) & WRI_NOFIRST)==0 q=q|0x08
        else if ($char(_wbuf+4+i) & WRI_FOOTER)!=0 then
          q=q|0x03                     // Mark as footer
          if ($char(_wbuf+4+i) & WRI_NOFIRST)==0 q=q|0x08
        endif
      else
        q=0x10                         // OLE (picture) paragraph
      endif
      $char(t+51+k*18)=q
      q=$long(_wbuf+i)
      i=i+8
      k=k+1
    enddo
    t[127]=k                           // Number of FODs on the current page
    Fwrite(t,128,_wf)
    par=par+1
    if i>=j break                      // Character section completed
  enddo
  $short(s+20)=par                     // Footnote table is absent
  $short(s+22)=par                     // Page of section property is absent
  $short(s+24)=par                     // Page of section table is absent
  $short(s+26)=par                     // Page table is absent
  // Store font information
  $short(s+28)=par                     // Page of font face-name table
  $short(t+0)=8                        // We have 8 (predefined) fonts
  i=0                                  // Currently processed font
  j=2                                  // Pointer in paragraph
  while 1 do
    k=0                                // Number of fonts on the current page
    while 1 do
      if j>128-20 break                // No more fonts fit into the page
      if i>=8 break
      $short(t+j)=2+Strlen(fontname[i])
      j=j+2
      $char(t+j)=0                     // Don't care about font family
      j=j+1
      Strcpy(t+j,fontname[i])
      j=j+1+Strlen(fontname[i])
      i=i+1
    enddo
    $short(t+j)=(i>=8?0:0xffff)
    Fwrite(t,128,_wf)
    j=0; par=par+1
    if i>=8 break
  enddo
  $short(s+96)=par                     // Count of pages in whole table
  Fseek(_wf,0,0)                       // Store prepared Write header
  Fwrite(s,128,_wf)
  Fclose(_wf)
  _wf=NULL                             // That's all, folks!
end

