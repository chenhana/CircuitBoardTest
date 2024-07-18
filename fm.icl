// This include file contains all definitions necessary to use the set of
// routines which allow SCRIPT2 programms to create files in Microsoft Write
// format. These files can include both formatted text and graphics.

#define WRI_MINBUF   2816              // Min allowed buffer size
// Possible values of parameter justify in subroutine Paragraph:
#define WRI_FORMAT   0x0000            // Text is formatted (default)
#define WRI_LEFT     0x0004            // Text is left-aligned
#define WRI_RIGHT    0x0008            // Text is right-aligned
#define WRI_CENTERED 0x000C            // Text is centered
#define WRI_HEADER   0x0010            // Treat paragraph as header
#define WRI_FOOTER   0x0020            // Treat paragraph as footer
#define WRI_NOFIRST  0x0040            // Do not print on the first page
// Possible values of parameter font in subroutine Fmt:
#define WRI_TIMES    0                 // Times New Roman (default)
#define WRI_ARIAL    1                 // Arial
#define WRI_COURIER  2                 // Courier
#define WRI_COURNEW  3                 // Courier New
#define WRI_PRINTER  4                 // LinePrinter
#define WRI_SYMBOL   6                 // Symbol
#define WRI_WING     7                 // WingDings
// Bit definitions of parameter bolditalic in subroutine Fmt:
#define WRI_NORMAL   0x00              // Normal letters
#define WRI_BOLD     0x01              // Bold letters
#define WRI_ITALIC   0x02              // Italic letters

external handle WRITE.Open(char *name,char *buf,int buflen)
external int WRITE.Paragraph(handle f,char *buf,int justify)
external int WRITE.Fmt(handle f,char *buf,int font,int bolditalic,int size)
external int WRITE.Font(handle f,char *buf,int otfont)
external int WRITE.Addpagenumber(handle f,char *buf)
external int WRITE.Addpicture(handle f,char *buf,handle graph,                 \
  int x0,int y0,int x1,int y1)
external int WRITE.Addtext(handle f,char *buf,char *text)
external int WRITE.Close(handle f,char *buf)

