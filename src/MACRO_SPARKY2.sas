/*
Definition: 
A sparkline is a small intense, simple, word-sized graphic with typographic resolution.
Sparklines mean that graphics are no longer cartoonish special occasions with captions and boxes, 
but rather sparkline graphics can be everywhere a word or number can be: embedded in a sentence, 
table, headline, map, spreadsheet, graphic. Data graphics should have the resolution of typography. 
See Edward Tufte, Beautiful Evidence, 46-63.  

source of definition: https://www.edwardtufte.com/bboard/q-and-a-fetch-msg?msg_id=0001OR&topic_id=1&topic=

Original source of macro :  Behind the Scenes with SAS®: Using Customer Graphics in SAS® Output (2013)
*/
%include "&_sasdevp.actu\_sas_eg\_Recherche\MACROS UTILES\Liste Macros\STYLE_FEW.sas";

%macro sparky2(	
	input_data,  /* input database */
	filter_var, /*variable that we will filter on. Ex: Province*/
	filter_value,   /* value that we want to keep.  Ex: QC */
	gpath, /*where we want to PNG to be saved */
	xvar,   /* X-axis of the graph */
	yvar /* Y-axis of the graph */);
/* obs va de 1 à X .. id pourrait être le code de l agent ou le nom de la province*/
ods _all_ close;
ods html 	
		image_dpi=300 
		gpath=&gpath.  /* this keeps the main directory from getting filled with many, many pngs */
		style=styles.Few; /* pour enlever les bordures et mettre la ligne grise*/

ods graphics on /
	reset =all 
	width=0.75in 
	height=0.15in 
	imagename="%qsysfunc(compress(&filter_var.,%str(%')))%qsysfunc(compress(&filter_value.,%str(%')))" 
	imagemap=on;

proc sgplot data=&input_data (where=(&filter_var.=&filter_value.)) ;
    series  x=&xvar y=&yvar / 
           lineattrs=(thickness=3)
           name="&filter_var.&filter_value.";
           xaxis display=(nolabel noline noticks novalues); /* this JUST produces the sparklines */
           yaxis display=(nolabel noline noticks novalues); /* nothing but sparklines */
					 title;
				 
run;
%mend sparky2;



/*
data graphs_indiv;
do obs=1 to 2;

do friday_week_month=1 to 12;
	comm=1000*ranuni(1);
	surcomm=0.5*comm + 100*ranuni(2);
	commtotal=comm+surcomm;

	output;
end;
end;
run;
proc sql;
create table graphs_global as
select distinct friday_week_month, sum(comm) as comm, sum(surcomm) as surcomm,
sum(commtotal) as commtotal
from graphs_indiv group by friday_week_month;
quit;

%sparky2(input_data=graphs_indiv, filter_var=obs, filter_value=1, gpath="h:\actu\_sas_eg\COS028\temp\",  xvar=friday_week_month, yvar  = comm );
ods html close;

%sparky2(input_data=graphs_indiv, filter_var=obs, filter_value=2, gpath="h:\actu\_sas_eg\COS028\temp\",  xvar=friday_week_month, yvar  = comm );
ods html close;
*/