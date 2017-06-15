/**********************************************************
Source: https://communities.sas.com/t5/tkb/articleprintpage/tkb-id/library/article-id/1669
A SAS template style that follows Stephen Few's style guidelines 
**********************************************************/

%macro RGB2CX(r,g,b);
 cx%sysfunc(putn(&r.,hex2.))%sysfunc(putn(&g.,hex2.))%sysfunc(putn(&b.,hex2.))
%mend RGB2CX;

*** light is used for large data objects, such as a bar or box;
%let lightgrey    = %rgb2cx(140,140,140);
%let lightblue    = %rgb2cx(136,189,230);
%let lightorange  = %rgb2cx(251,178, 88);
%let lightgreen   = %rgb2cx(144,205,151);
%let lightpink    = %rgb2cx(246,170,201);
%let lightbrown   = %rgb2cx(191,165, 84);
%let lightpurple  = %rgb2cx(188,153,199);
%let lightyellow  = %rgb2cx(237,221, 70);
%let lightred     = %rgb2cx(240,126,110);

*** medium is used for small data objects such as data points and lines;
%let mediumgrey   = %rgb2cx( 77, 77, 77);
%let mediumblue   = %rgb2cx( 93,165,218);
%let mediumorange = %rgb2cx(250,164, 58);
%let mediumgreen  = %rgb2cx( 96,189,104);
%let mediumpink   = %rgb2cx(241,124,176);
%let mediumbrown  = %rgb2cx(178,145, 47);
%let mediumpurple = %rgb2cx(178,118,178);
%let mediumyellow = %rgb2cx(222,207, 63);
%let mediumred    = %rgb2cx(241, 88, 84);

*** dark and bright highlighter is used for objects, such as a single bar;
%let darkgrey     = %rgb2cx(  0,  0,  0);
%let darkblue     = %rgb2cx( 38, 93,171);
%let darkorange   = %rgb2cx(223, 92, 36);
%let darkgreen    = %rgb2cx(  5,151, 72);
%let darkpink     = %rgb2cx(229, 18,111);
%let darkbrown    = %rgb2cx(157,114, 42);
%let darkpurple   = %rgb2cx(123, 58,150);
%let darkyellow   = %rgb2cx(199,180, 46);
%let darkred      = %rgb2cx(203, 32, 39);
** I use this color as cell background in some reports;
%let very_light_grey=E2EDF4;

proc template;
 define style Styles.Few;
 parent = Styles.RTF;

 replace fonts /
 'TitleFont'           = ("Tahoma" ,14pt,Bold) /* Titles from TITLE statements         */
 'TitleFont2'          = ("Tahoma" ,14pt,Bold) /* Procedure title: The _____ Procedure */
 'StrongFont'          = ("Tahoma" ,10pt,Bold)
 'EmphasisFont'        = ("Tahoma" ,10pt,Italic)
 'headingEmphasisFont' = ("Tahoma" ,10pt,Italic)
 'headingFont'         = ("Tahoma" ,10pt)      /* Table column and row headings        */
 'docFont'             = ("Tahoma" ,10pt)      /* Data in table cells                  */
 'footFont'            = ("Tahoma" , 8pt)      /* Footnotes from FOOTNOTE statements   */
 'FixedEmphasisFont'   = ("Courier",10pt,Italic)
 'FixedStrongFont'     = ("Courier",10pt,Bold)
 'FixedHeadingFont'    = ("Courier",10pt,Bold)
 'BatchFixedFont'      = ("Courier",7pt)
 'FixedFont'           = ("Courier",10pt);

 replace color_list /
 'link' = &darkblue. /* links                            */
 'bgH'  = white      /* row and column header background */
 'fg'   = black      /* text color                       */
 'bg'   = white;     /* page background color            */;

 replace Body from Document /
 bottommargin = 0.25in
 topmargin    = 0.25in
 rightmargin  = 0.25in
 leftmargin   = 0.25in;

 replace Table from Output /
 frame       = void   /* outside borders: void, box, above/below, vsides/hsides, lhs/rhs */
 rules       = groups /* internal borders: none, all, cols, rows, groups                 */
 cellpadding = 3pt    /* the space between table cell contents and the cell border       */
 cellspacing = 0pt    /* the space between table cells, allows background to show        */
 borderwidth = 2pt    /* the width of the borders and rules                              */;

 style SystemFooter from SystemFooter /
 font = fonts("footFont");

 replace GraphFonts /
 'GraphDataFont'    =("Tahoma",10pt) 
 'GraphUnicodeFont' =("Tahoma",10pt) 
 'GraphValueFont'   =("Tahoma",10pt) 
 'GraphLabelFont'   =("Tahoma",10pt) 
 'GraphLabel2Font'  =("Tahoma",10pt) 
 'GraphFootnoteFont'=("Tahoma",8pt) 
 'GraphTitleFont'   =("Tahoma",14pt) 
 'GraphTitle1Font'  =("Tahoma",14pt) 
 'GraphAnnoFont'    =("Tahoma",10pt);

 replace  colors /               /* Abstract colors used in the default style */
 'headerfgemph'   = color_list('fg')
 'headerbgemph'   = color_list('bgH')
 'headerfgstrong' = color_list('fg')
 'headerbgstrong' = color_list('bgH')
 'headerfg'       = color_list('fg')
 'headerbg'       = color_list('bgH')
 'datafgemph'     = color_list('fg')
 'databgemph'     = color_list('bg')
 'datafgstrong'   = color_list('fg')
 'databgstrong'   = color_list('bg')
 'datafg'         = color_list('fg')
 'databg'         = color_list('bg')
 'batchbg'        = color_list('bg')
 'batchfg'        = color_list('fg')
 'tableborder'    = &mediumgrey.
 'tablebg'        = color_list('bg')
 'notefg'         = color_list('fg')
 'notebg'         = color_list('bg')
 'bylinefg'       = color_list('fg')
 'bylinebg'       = color_list('bg')
 'captionfg'      = color_list('fg')
 'captionbg'      = color_list('bg')
 'proctitlefg'    = color_list('fg')
 'proctitlebg'    = color_list('bg')
 'titlefg'        = color_list('fg')
 'titlebg'        = color_list('bg')
 'systitlefg'     = color_list('fg')
 'systitlebg'     = color_list('bg')
 'Conentryfg'     = color_list('fg')
 'Confolderfg'    = color_list('fg')
 'Contitlefg'     = color_list('fg')
 'link2'          = color_list('link')
 'link1'          = color_list('link')
 'contentfg'      = color_list('fg')
 'contentbg'      = color_list('bg')
 'docfg'          = color_list('fg')
 'docbg'          = color_list('bg');

 replace GraphColors /    /* Abstract colors used in graph styles */
 'ginsetheader'     = colors('docbg')
 'ginset'           = white
 'greferencelines'  = &mediumgrey.
 'gheader'          = colors('docbg')
 'gtext'            = &mediumgrey.
 'glabel'           = &mediumgrey.
 'gborderlines'     = &mediumgrey.
 'goutlines'        = &mediumgrey.
 'ggrid'            = &lightgrey.
 'gaxis'            = &lightgrey.
 'gshadow'          = &lightgrey.
 'glegend'          = white
 'gfloor'           = white
 'gwalls'           = _undef_
            
 'gcdata1'          = &mediumblue.
 'gcdata2'          = &mediumorange.
 'gcdata3'          = &mediumgreen.
 'gcdata4'          = &mediumpink.
 'gcdata5'          = &mediumbrown.
 'gcdata6'          = &mediumpurple.
 'gcdata7'          = &mediumyellow.
 'gcdata8'          = &mediumred.
 'gcdata9'          = &mediumgrey.
 'gcdata10'         = &darkblue.
 'gcdata11'         = &darkorange.
 'gcdata12'         = &darkred.

 'gdata1'           = &mediumgrey.
 'gdata2'           = &mediumgrey.
 'gdata3'           = &mediumgrey.
 'gdata4'           = &mediumgrey.
 'gdata5'           = &mediumgrey.
 'gdata6'           = &mediumgrey.
 'gdata7'           = &mediumgrey.
 'gdata8'           = &mediumgrey.
 'gdata9'           = &mediumgrey.
 'gdata10'          = &mediumgrey.
 'gdata11'          = &mediumgrey.
 'gdata12'          = &mediumgrey. 

 'gcmiss'           = &lightgrey.
 'gmiss'            = &lightgrey.
 'gablock'          = cxF1F0F6
 'gblock'           = cxD7DFEF
 'gcclipping'       = cxDC531F
 'gclipping'        = cxE7774F
 'gcstars'          = &mediumgrey.
 'gstars'           = cxB9CFE7
 'gcruntest'        = cxBF4D4D
 'gruntest'         = cxCAE3FF
 'gccontrollim'     = cxBFC7D9
 'gcontrollim'      = cxE6F2FF
 'gcerror'          = &mediumgrey.
 'gerror'           = cxB9CFE7
 'gcpredictlim'     = cx003178
 'gpredictlim'      = cxB9CFE7
 'gcpredict'        = cx003178
 'gpredict'         = cx003178
 'gcconfidence2'    = cx003178
 'gcconfidence'     = cx003178
 'gconfidence2'     = cxB9CFE7
 'gconfidence'      = cxB9CFE7
 'gcfit2'           = cx003178
 'gcfit'            = cx003178
 'gfit2'            = cx003178
 'gfit'             = cx003178
 'gcoutlier'        = &mediumgrey.
 'goutlier'         = cxB9CFE7
 'gcdata'           = &mediumgrey.
 'gdata'            = cxB9CFE7

 'gconramp3cend'    = cxFF0000
 'gconramp3cneutral'= cxFF00FF
 'gconramp3cstart'  = cx0000FF
 'gramp3cend'       = cxDD6060
 'gramp3cneutral'   = white
 'gramp3cstart'     = cx6497EB

 'gconramp2cend'    = cx6497EB
 'gconramp2cstart'  = white
 'gramp2cend'       = cx5E528B
 'gramp2cstart'     = cxEDEBF6;

 class graphwalls / 
 frameborder=off;

 class graphbackground / 
 color=white;

 style GraphData1  from GraphData1  /linestyle=1 markersymbol = "circle";
 style GraphData2  from GraphData2  /linestyle=1 markersymbol = "circle";
 style GraphData3  from GraphData3  /linestyle=1 markersymbol = "circle";
 style GraphData4  from GraphData4  /linestyle=1 markersymbol = "circle";
 style GraphData5  from GraphData5  /linestyle=1 markersymbol = "circle";
 style GraphData6  from GraphData6  /linestyle=1 markersymbol = "circle";
 style GraphData7  from GraphData7  /linestyle=1 markersymbol = "circle";
 style GraphData8  from GraphData8  /linestyle=1 markersymbol = "circle";
 style GraphData9  from GraphData9  /linestyle=1 markersymbol = "circle";
 style GraphData10 from GraphData10 /linestyle=1 markersymbol = "circle";
 style GraphData11 from GraphData11 /linestyle=1 markersymbol = "circle";
 style GraphData12 from GraphData12 /linestyle=1 markersymbol = "circle";

 style GraphBorderLines from GraphBorderLines / 
 LineThickness=0; 

 style GraphBackground / 
 transparency=1  ;  

end;
run; 
