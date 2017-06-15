ods noproctitle; /*suppress "the freq procedure" title */


proc sort 	data= sashelp.stocks  	out= sorted;
	by date stock; 
run;

proc transpose data=sorted out=transposed(drop= _name_);
	by Date;
	id Stock;
	var Close;
run;

proc print data= transposed(obs=10) noobs;
run;

proc sgplot data=transposed ;
	series x=Date y=IBM/ lineattrs=(thickness=3)	name="IBM";
	series x=Date y=Microsoft/ lineattrs=(thickness=3)	name="Microsoft"; 
	series x=Date y=Intel/ lineattrs=(thickness=3) name="Intel";
	title "Évolution du prix des actions de trois grandes sociétés";
	YAXIS LABEL = '$';
	xaxis label = "Date";
quit;
%include "&_sasdevp.actu\_sas_eg\_Recherche\MACROS UTILES\Liste Macros\STYLE_FEW.sas";
/* load  styles.few */

ods _all_ close; /* having more than one ods destination open will mess 
					with the file names of the generated PNGs. */

ods html /* We open the ODS destination right after closing everything else */
	image_dpi=300 
	gpath="h:\actu\_sas_eg\COS028\temp\" /* path where the PNGs will be created*/
	style=Styles.Few; /* I like this style better */

ods graphics on /
	reset =all 
	width=2.5in 
	height=2in 
	imagename="WikiSGPLOT" /* The PNGs will be named WikiSGPLOT.png ; 
							WikiSGPLOT1.png ; WikiSGPLOT2.png.. etc.*/
	imagemap=on;


* create WikiSGPLOT.png;
proc sgplot data=transposed ;
	series x=Date y=IBM/ lineattrs=(thickness=3)	name="IBM";
	series x=Date y=Microsoft/ lineattrs=(thickness=3)	name="Microsoft"; 
	series x=Date y=Intel/ lineattrs=(thickness=3) name="Intel";
	title "Évolution du prix des actions de trois grandes sociétés";
	YAXIS LABEL = '$';
	xaxis label = "Date";
quit;
* create WikiSGPLOT1;
proc sgplot data=sorted;
vbox close / category= stock groupdisplay = cluster
lineattrs = (pattern=solid)
whiskerattrs=(pattern=solid); 
  xaxis display=(nolabel);
  yaxis grid;
  keylegend / location=inside position=topright across=1;
  title "Distribution of closing prices for the last X days";
run;

* create WikiSGPLOT2;
proc sgpanel data=sorted;
	panelby stock;
	series x=Date y= close / lineattrs=(thickness=3)	name="Close";
	title "Panelled graphs";
quit;

ods html close;

/** load macro sparky2***/
%include "&_sasdevp.actu\_sas_eg\_Recherche\MACROS UTILES\Liste Macros\MACRO_SPARKY2.sas";

* stockIBM.png;
%sparky2( 
	sorted, /* input database */
	stock, /*variable that we will filter on. Ex: Province*/
	'IBM', /* value that we want to keep. Ex: QC */
	"h:\actu\_sas_eg\COS028\temp\", /*where we want to PNG to be saved */
	Date, /* X-axis of the graph */
	Close )

* stockMicrosoft.png;
%sparky2( 
	sorted, /* input database */
	stock, /*variable that we will filter on. Ex: Province*/
	'Microsoft', /* value that we want to keep. Ex: QC */
	"h:\actu\_sas_eg\COS028\temp\", /*where we want to PNG to be saved */
	Date, /* X-axis of the graph */
	Close )

* stockIntel.png;

%sparky2( 
	sorted, /* input database */
	stock, /*variable that we will filter on. Ex: Province*/
	'Intel', /* value that we want to keep. Ex: QC */
	"h:\actu\_sas_eg\COS028\temp\", /*where we want to PNG to be saved */
	Date, /* X-axis of the graph */
	Close )


* database with last values;

proc sql;
	create table last_values as
	select distinct 
		stock, 
		date, 
		close 
	from sorted
	group by stock
	having date=max(date);
quit;

data forreport;
	length image $256.;
	set last_values;
	if stock="IBM" then image= "h:\actu\_sas_eg\COS028\temp\stockIBM.png";
	else if stock="Microsoft" then image= "h:\actu\_sas_eg\COS028\temp\stockMicrosoft.png";
	else if stock="Intel" then image= "h:\actu\_sas_eg\COS028\temp\stockIntel.png";
run;

options 
	orientation=portrait
	PAPERSIZE = /*LEGAL*/ LETTEr
	nodate nonumber
	leftmargin = .15 cm rightmargin = .15 cm
	bottommargin = .15 cm topmargin = .15 cm
	center 
	missing = ""	;

ods pdf 
	startpage=no /* pas de page break entre les procs*/
	file="h:\actu\_sas_eg\COS028\temp\Report.pdf"
	notoc  /* no table of content */
	style = styles.Few 
	dpi=300;

ods escapechar = '^'; 
title1  
               	j=l "^S={preimage='h:\actu\_sas_eg\COS028\temp\logodesj.png'}" 
                j=c "^S={vjust=top}" "Title has the company logo"
				j=r "^S={vjust=top}" "Feb 17";

*footnote1 j=l "Footnote1";
*footnote2 j=l "Footnote2";



ods pdf text= "A Proc REPORT including the graphs generated using Proc SGPLOT and Proc SGPLANEL";

data images;
	image1="h:\actu\_sas_eg\COS028\temp\WikiSGPLOT.png";
	image2="h:\actu\_sas_eg\COS028\temp\WikiSGPLOT1.png";
	image3="h:\actu\_sas_eg\COS028\temp\WikiSGPLOT2.png";
run;



proc report data=images nofs ls=120 ps=40 ; 
 column image1 image2 image3;
 define image1 / "" display style={cellwidth=2.5in};
 define image2 / "" display style={cellwidth=2.5in};
 define image3 / "" display style={cellwidth=2.5in};
 compute image1;
 	call define(_col_,"Style","Style=[PREimage='"!!image1!!"']"); 
 	image1=""; *<<< Avoid image location being printed; 
 endcomp;
 compute image2;
	 call define(_col_,"Style","Style=[PREimage='"!!image2!!"']"); 
	 image2=""; *<<< Avoid image location being printed; 
 endcomp;
  compute image3;
	 call define(_col_,"Style","Style=[PREimage='"!!image3!!"']"); 
	 image3=""; *<<< Avoid image location being printed; 
 endcomp;
run; 


		  
ods pdf text= "A Proc REPORT with a sparkline generated using macro SPARKY2";

proc report data=forreport nofs ls=120 ps=40 
	split="*"
	style(report)=
		[]
	style(header)=
		[just=r]
	style(column)=
		[just=r];
	; /* nofs is used to turn off the procedure’s interactive features.*/

	column Stock Close  image;
	define Stock / "Stock" display;
	define Close / "Last closing price  " display format= nlnum10.;
	define image / "Tendance 12 derniers mois" display style={cellwidth=1in};
	compute image;
	call define(_col_,"Style","Style=[PREimage='"!!image!!"']"); 
	image=""; *<<< Avoid image location being printed; 
	endcomp;
run;

ods pdf text= "A Proc FREQ";


proc freq  data= sorted;
tables stock;
run;

ods pdf text= "Proc PRINT sashelp.stocks";
proc print data= sashelp.stocks(obs=10) noobs;
run;

ods pdf text=
	"^S={fontsize = 8pt color=&lightgrey.}  ^{newline}
	Notes: ^{newline}
	1. The footnotes are in light grey. ^{newline}
	2. Some extra note.";

ods pdf close;

/*** send email with attached report.*/

filename mymail email
    subject = "Weekly report on stock prices"
 attach  = "\\SASDGAG01.dgdom.net\Disk_H\actu\_sas_eg\COS028\temp\Report.pdf"
 to=("simon.coulombe@dgag.ca")
 from="<simon.coulombe@dgag.ca>";

data _null_;
 file mymail ; 
 put "bonjour,";
 put "du texte";
 put "cordialement";
run;

 

	
 
