proc means data=work.homework(drop=Person) nolabels
           N Mean Std Min;
run;

proc freq data = work.homework;
	table wlostcat*Diet/chisq;
run;

proc freq data = work.homework;
	table wlostcat*gender/chisq;
run;

proc ttest data= work.homework H0=0;
	var weightlost;
	where Diet=2;
run;

proc ttest data= work.homework1 H0=0;
	class Diet;
	var weightlost;
run;

proc ANOVA data= work.homework;
	class Diet;
	model weightlost = Diet;
run;

proc GLM data= work.homework;
	class Diet gender;
	model weightlost = Diet gender Diet*gender;
run;