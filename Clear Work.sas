******************************************************************;
*	Description: Deletes all datasets, footnotes, titles, and user
*	generated macro variables. 
*	Programming Date: 29May2018	
*	Programmer: Troy Kukulka (tkukulka@biorasi.com)
*	Usage Notes: Macro will automatically kill all work library
*	datasets, Footnotes, Titles, and User defined macro variables
*	but the Path variable. If any of these need to be saved and
*	carried over, DO NOT use this macro.
*	Revision History - (Date -- Programmer -- Change)
*	
*
*
*****************************************************************;


%macro ClearWork;
/* CLEAR USER DEFINED MACRO VARIABLES EXCEPT FOR PATH */
data vars;
	set sashelp.vmacro;
run;

data _null_;
	set vars;
		temp=lag(name);
		if 
			scope='GLOBAL' and 
			substr(name,1,3) ne 'SYS' and
			name ne 'PATH' and 
			temp ne name 

		then call execute('%symdel '||trim(left(name))||';');
run;

/* CLEAR CONTENTS OF WORK DIRECTORY */
proc datasets lib=work nolist kill;
quit;

/* CLEAR TITLES AND FOOTNOTES */
title;
footnote;

%mend ClearWork;
