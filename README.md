# sas-analytics

The aim of this study was to investigate the weight loss after three different diets. Please create a new variable called weightlost, which represents the difference between weight before the diet treatment and the weight after 6 weeks of diet treatment. Furthermore, the researcher thinks that a weight loss of more than 5 kg is considered an effective response to the diet treatment. Please create another variable called wlostcat, which has two levels: effective if the weight loss is larger than 5kg; noeffective if the weight loss is smaller or equal than 5kg. Provide a screenshot of the data in SAS.
Output:
![image](https://user-images.githubusercontent.com/121342739/222927667-99457164-b327-48fd-82a2-ade386a6d4fa.png)

SAS Code
```
data work.homework; 
	set work.import; 
	weightlost = (pre.weight - weight6weeks); 
	if weightlost > 5 then wlostcat = "effective"; 
	if weightlost <= 5 then wlostcat = "noeffective"; 
	run; 
	proc print; 
	run;
```

Please provide two appropriate descriptive statistics for all variables (The six original variables and the two new created variables, excluding Person ID). Please presenting your results in a single summary table. You will need to manually create this table and not just attached SAS output.

![image](https://user-images.githubusercontent.com/121342739/222927252-cb90a371-5d26-4625-a83e-5d3560805e32.png)

SAS codes;
```
proc freq data= work.homework; 
	table gender Diet wlostcat; 
run; 
 
proc means data= work.homework(drop=Person gender Diet wlostcat)  
	mean std min max; 
run;
```

Is wlostcat associated with diet treatment? Conduct a hypothesis test to answer this question.
1. Step 1: Statement of the null and alternative hypothesis
 - H_0: There is no association between wlostcat and diet treatment
 - H_1: There is a significant association between wlostcat and diet treatment

2. Step 2: Significance level ∝ = 0.05
3. Step 3: Using SAS conduct chisq test

SAS output:
![image](https://user-images.githubusercontent.com/121342739/222927359-8f9757af-1d07-45dc-ac68-054ce9de5f4d.png)
 
4. Step 4: p-value is 0.0049 from the SAS output
5. Step 5: As the p-value is 0.0049, which is less than 0.05, we reject the null hypothesis. There is sufficient evidence to support the alternate hypothesis. We conclude that wlostcat and diet treatment are associated.

SAS code:
```
proc freq data = work.homework; 
table wlostcat*Diet/chisq; 
run;
```

Is wlostcat associated with gender? Conduct a hypothesis test to answer this question.
1. Step 1: Statement of the null and alternative hypothesis
- H_0: There is no association between wlostcat and gender
- H_1: There is a significant association between wlostcat and gender

2. Step 2: Significance level ∝ = 0.05
3. Step 3: Using SAS conduct chisq test
SAS output:
 ![image](https://user-images.githubusercontent.com/121342739/222927414-fcf701e6-2160-4fc5-959d-2ee3878d81bb.png)

4. Step 4: p-value is 0.9153 from the SAS output
5. Step 5: As the p-value is 0.9153, which is greater than 0.05, we fail to reject the null hypothesis. There is no sufficient evidence to support the alternate hypothesis. We conclude that wlostcat and gender are not associated.

SAS code:
```
proc freq data = work.homework; 
table wlostcat*gender/chisq; 
run;
```

For subjects on BeautyA diet, was there a significant decrease in weight from baseline (pre.weight) to after diet treatment (weight6weeks)? Conduct a hypothesis test to answer this question.
1. Step 1: Statement of the null and alternative hypothesis
- H_0: There is no significant decrease in weight from baseline (pre.weight) to after diet treatment (weight6weeks)
- H_1: There is no significant decrease in weight from baseline (pre.weight) to after diet treatment (weight6weeks)

2. Step 2: Significance level ∝ = 0.05
3. Step 3: Using SAS conduct one sample t-test for mu=0 for weightlost

SAS output:
![image](https://user-images.githubusercontent.com/121342739/222927465-964c6590-c62a-44ed-816b-c87686903aa8.png)
 
4. Step 4: p-value is <0.0001 from the SAS output
5. Step 5: As the p-value is <0.0001. The mean of the variable weightlost (weight6weeks-pre.weight) is 3.0259, which is significantly different from the test value mu=0 0.05. We conclude that there is significant decrease in weight from baseline (pre.weight) to after diet treatment (weight6weeks).

SAS code:
```
proc ttest data= work.homework H0=0; 
	var weightlost; 
	where Diet=2; 
run; 
```

Was there a difference in weight loss (weightlost) between the two diet groups (Beauty A and Beauty B)? Conduct a hypothesis test to answer this question.
1. Step 1: Statement of the null and alternative hypothesis
- H_0: There is no difference in weight loss (weightlost) between the two diet groups (Beauty A and Beauty B)
- H_1: There is significant difference in weight loss (weightlost) between the two diet groups (Beauty A and Beauty B)
2. Step 2: Significance level ∝ = 0.05
3. Step 3: Using SAS conduct independent two sample t-test

SAS output:
![image](https://user-images.githubusercontent.com/121342739/222927509-da399191-6d3c-4c90-93ff-7da593bbcca0.png)
 
4. Step 4: p-value is 0.7930 from the SAS output
5. Step 5: As the p-value is 0.7930, which is greater than 0.05, we fail to reject the null hypothesis. There is no statistically significant difference between Beauty A and Beauty B diet groups (t = -3.17, p = 0.0026). That is, Beauty B diet group has significantly higher weight loss (5.1481) than Beauty A (3.0259).

SAS code:
```
data work.homework1; 
	set work.homework; 
	if Diet = 1 then delete; 
run;

proc ttest data= work.homework1 H0=0; 
	class Diet; 
	var weightlost; 
run; 
```

Similarly, is there difference in weight loss between the three types of diet (control group, Beauty A and Beauty B)? Conduct a hypothesis test to answer this question.
1. Step 1: Statement of the null and alternative hypothesis
- H_0: There is no difference in weight loss between the three diet groups (control group, Beauty A and Beauty B)
- H_1: There is difference in weight loss between the three diet groups (control group, Beauty A and Beauty B)
2. Step 2: Significance level ∝ = 0.05
3. Step 3: Using SAS conduct one-way ANOVA test

SAS output:
  ![image](https://user-images.githubusercontent.com/121342739/222927566-4bc44983-c7fc-48dc-9eec-d578c118865c.png)

4. Step 4: p-value is 0.0032 from the SAS output
5. Step 5: As the p-value is 0.0032, which is less than 0.05, we reject the null hypothesis. There is statistically significant difference between the three diet groups (F = 6.20, p = 0.0032). We can conclude that there is significant difference in weight loss between the three diet groups.

SAS code:
```
proc ANOVA data= work.homework; 
	class Diet; 
	model weightlost = Diet; 
run; 
```

To further assess the amount of weight lost, we would also like to examine the differences across the diets after adjusting for gender. Is there a difference between the diets? Conduct a hypothesis test to answer this question.
1. Step 1: Statement of the null and alternative hypothesis
- H_0: There is no difference in weight loss across the three diets after adjusting for gender variable
- H_1: There is significant difference in weight loss across the three diet groups after adjusting for the gender variable
2. Step 2: Significance level ∝ = 0.05
3. Step 3: Using SAS conduct GLM test

SAS output:
![image](https://user-images.githubusercontent.com/121342739/222927595-83d37371-e002-460a-a4e3-dd67372e494e.png)
  
4. Step 4: p-value is 0.1143 from the SAS output
5. Step 5: As the p-value is 0.1143, which is greater than 0.05, we fail to reject the null hypothesis. There is no sufficient evidence to support the alternate hypothesis (F = 2.24, p=0.1143). We can conclude that there is no significant difference in weight loss across the three diet groups after adjusting for the gender variable.

SAS code:
```
proc GLM data= work.homework; 
	class Diet gender; 
	model weightlost = Diet gender Diet*gender; 
run;
```
