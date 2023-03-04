data work.homework;
	set work.import;
	weightlost = (pre.weight - weight6weeks);
	if weightlost > 5 then wlostcat = "effective";
	if weightlost <= 5 then wlostcat = "noeffective";
	run;
	proc print;
	run;
	
data work.homework1;
	set work.homework;
	if Diet = 1 then delete;
run;

proc freq data= work.homework;
	table gender Diet wlostcat;
run;

proc means data= work.homework(drop=Person gender Diet wlostcat) 
	mean std min max;
run;