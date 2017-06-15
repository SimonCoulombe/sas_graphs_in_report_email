/**************************************************************** 
  Convert decimal RGB triplet (r,g,b) to hexadecimal SAS color.
  The r, g, and b parameters are integers in the range 0-255 

  Source: http://blogs.sas.com/content/iml/files/2016/03/CurryModel.txt
*****************************************************************/

%macro RGB2CX(r,g,b);
 cx%sysfunc(putn(&r.,hex2.))%sysfunc(putn(&g.,hex2.))%sysfunc(putn(&b.,hex2.))
%mend RGB2CX;
