PROC IMPORT OUT= SASUSER.proj 
            DATAFILE= "E:\MIS\BIA672\Final\nutrition.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc sql;
select distinct(count(gender)) from SASUSER.P3;
run;

data SASUSER.p1;
 set SASUSER.proj(drop= stratificationid1 stratificationcategory1 stratificationcategoryid1 datavaluetypeid questionid 
Data_Value_Footnote_Symbol Data_Value_Footnote geolocation datasource Low_Confidence_Limit high_Confidence_Limit question 
total LocationAbbr yearstart yearend topicid data_value_unit data_value_type stratification1);
run;

data SASUSER.p2;
set SASUSER.p1;

Format Gender1 3. Income1 3. Age_years_1 3. Education1 3. Race_Ethnicity1 3. class1 3.;

	 if classid="OWS" then class1=1; 
else if classid="FV" then class1=1; 
else if classid="PA" then class1=2; 

	 if gender = "Male" then gender1 = 1;
else if gender = "Female" then gender1 =2;

	 if education = "Less than high school" then education1 = 1;
else if education = "High school graduate" then education1 = 2;
else if education = "Some college or technical school" then education1 = 3;
else if education = "College graduate" then education1 = 4;

	 if income = "Less than $15,000" then income1 = 1;
else if income = "$15,000 - $24,999" then income1 =1;
else if income = "$25,000 - $34,999" then income1 =2;
else if income = "$35,000 - $49,999" then income1 =2;
else if income = "$50,000 - $74,999" then income1 =3;
else if income = "$75,000 or greater" then income1 =4;
else if income ="Data not reported" then delete;

	 if age_years_="18 - 24" then age_years_1=1;
else if age_years_="25 - 34" then age_years_1=1;
else if age_years_="35 - 44" then age_years_1=2;
else if age_years_="45 - 54" then age_years_1=2;
else if age_years_="55 - 64" then age_years_1=3;
else if age_years_="65 or older" then age_years_1=3;

	 if race_ethnicity="2" then delete;
else if race_ethnicity="N" then race_ethnicity1=1;
else if race_ethnicity="H" then race_ethnicity1=2;
else if race_ethnicity="A" then race_ethnicity1=3;
else if race_ethnicity="O" then race_ethnicity1=4;
run;

data SASUSER.p3;
	set SASUSER.p2;

if data_value >= "0.9" && data_value <= "10" then gender1 = "2";
else if data_value >= "10.1" && data_value <= "20" then gender1 = "1";
else if data_value >= "20.1" && data_value <= "30" then gender1 = "1";
else if data_value >= "30.1" && data_value <= "40" then gender1 = "2";
else if data_value >= "40.1" && data_value <= "50" then gender1 = "2";
else if data_value >= "50.1" && data_value <= "60" then gender1 = "1";
else if data_value >= "60.1" && data_value <= "70" then gender1 = "1";
else if data_value >= "70.1" && data_value <= "77.6" then gender1 = "2";


if data_value >= "0.9" && data_value <= "5" then age_years_1 = "1";
else if data_value >= "5.1" && data_value <= "10" then age_years_1 = "2";
else if data_value >= "10.1" && data_value <= "15" then age_years_1 = "3";
else if data_value >= "15.1" && data_value <= "20" then age_years_1 = "3";
else if data_value >= "20.1" && data_value <= "25" then age_years_1 = "2";
else if data_value >= "25.1" && data_value <= "30" then age_years_1 = "1";
else if data_value >= "30.1" && data_value <= "35" then age_years_1 = "1";
else if data_value >= "35.1" && data_value <= "40" then age_years_1 = "2";
else if data_value >= "40.1" && data_value <= "45" then age_years_1 = "3";
else if data_value >= "45.1" && data_value <= "50" then age_years_1 = "3";
else if data_value >= "50.1" && data_value <= "55" then age_years_1 = "2";
else if data_value >= "55.1" && data_value <= "60" then age_years_1 = "1";
else if data_value >= "60.1" && data_value <= "65" then age_years_1 = "1";
else if data_value >= "65.1" && data_value <= "70" then age_years_1 = "2";
else if data_value >= "70.1" && data_value <= "77.6" then age_years_1 = "3";

if data_value >= "0.9" && data_value <= "5" then income1 = "3";
else if data_value >= "5.1" && data_value <= "10" then income1 = "4";
else if data_value >= "10.1" && data_value <= "15" then income1 = "1";
else if data_value >= "15.1" && data_value <= "20" then income1 = "2";
else if data_value >= "20.1" && data_value <= "25" then income1 = "2";
else if data_value >= "25.1" && data_value <= "30" then income1 = "4";
else if data_value >= "30.1" && data_value <= "35" then income1 = "2";
else if data_value >= "35.1" && data_value <= "40" then income1 = "3";
else if data_value >= "40.1" && data_value <= "45" then income1 = "1";
else if data_value >= "45.1" && data_value <= "50" then income1 = "4";
else if data_value >= "50.1" && data_value <= "55" then income1 = "1";
else if data_value >= "55.1" && data_value <= "60" then income1 = "3";
else if data_value >= "60.1" && data_value <= "65" then income1 = "2";
else if data_value >= "65.1" && data_value <= "70" then income1 = "4";
else if data_value >= "70.1" && data_value <= "77.6" then income1 = "1";

	 if data_value >= "0.9" && data_value <= "5" then race_ethnicity1 = "2";
else if data_value >= "5.1" && data_value <= "10" then race_ethnicity1 = "2";
else if data_value >= "10.1" && data_value <= "15" then race_ethnicity1 = "1";
else if data_value >= "15.1" && data_value <= "20" then race_ethnicity1 = "1";
else if data_value >= "20.1" && data_value <= "25" then race_ethnicity1 = "3";
else if data_value >= "25.1" && data_value <= "30" then race_ethnicity1 = "4";
else if data_value >= "30.1" && data_value <= "35" then race_ethnicity1 = "2";
else if data_value >= "35.1" && data_value <= "40" then race_ethnicity1 = "3";
else if data_value >= "40.1" && data_value <= "45" then race_ethnicity1 = "2";
else if data_value >= "45.1" && data_value <= "50" then race_ethnicity1 = "1";
else if data_value >= "50.1" && data_value <= "55" then race_ethnicity1 = "3";
else if data_value >= "55.1" && data_value <= "60" then race_ethnicity1 = "4";
else if data_value >= "60.1" && data_value <= "65" then race_ethnicity1 = "4";
else if data_value >= "65.1" && data_value <= "70" then race_ethnicity1 = "1";
else if data_value >= "70.1" && data_value <= "77.6" then race_ethnicity1 = "4";

	 if data_value >= "0.9" && data_value <= "5" then education1 = "4";
else if data_value >= "5.1" && data_value <= "10" then education1 = "2";
else if data_value >= "10.1" && data_value <= "15" then education1 = "3";
else if data_value >= "15.1" && data_value <= "20" then education1 = "1";
else if data_value >= "20.1" && data_value <= "25" then education1 = "3";
else if data_value >= "25.1" && data_value <= "30" then education1 = "2";
else if data_value >= "30.1" && data_value <= "35" then education1 = "1";
else if data_value >= "35.1" && data_value <= "40" then education1 = "4";
else if data_value >= "40.1" && data_value <= "45" then education1 = "3";
else if data_value >= "45.1" && data_value <= "50" then education1 = "4";
else if data_value >= "50.1" && data_value <= "55" then education1 = "1";
else if data_value >= "55.1" && data_value <= "60" then education1 = "2";
else if data_value >= "60.1" && data_value <= "65" then education1 = "1";
else if data_value >= "65.1" && data_value <= "70" then education1 = "2";
else if data_value >= "70.1" && data_value <= "77.6" then education1 = "3";

run; 

proc means data = SASUSER.p3 n nmiss;
  var _numeric_;
run;

data SASUSER.p4;
 set SASUSER.p3;
 if cmiss(of _numeric_) then delete;
run;

proc means data = SASUSER.p4 n nmiss;
  var _numeric_;
run;

data SASUSER.p4_ncarol;
   SET SASUSER.p4;
   IF (LocationID = 37) THEN OUTPUT;
run;

data SASUSER.p4_ny;
   SET SASUSER.p4;
   IF (LocationID = 36) THEN OUTPUT;
run;

data SASUSER.p4_nj;
   SET SASUSER.p4;
   IF (LocationID = 34) THEN OUTPUT;
run;

data SASUSER.p4_East;
	set SASUSER.p4;
	 if (locationID = 37) then output;
else if (locationID = 36) then output;
else if (locationID = 34) then output;
run;
/*
proc print data=SASUSER.proj4;
run;
*/
*****************************************CLUSTERING***************************;

proc fastclus data=SASUSER.p4_ncarol  out=SASUSER.p5_ncarol maxclusters=3;
   var Gender1 Education1 Race_Ethnicity1 Age_years_1 Income1 Class1;
   id Class1;
run;

proc fastclus data=SASUSER.p4_ny  out=SASUSER.p5_ny maxclusters=4;
   var Gender1 Education1 Race_Ethnicity1 Age_years_1 Income1 Class1;
   id Class1;
run;

proc fastclus data=SASUSER.p4_nj  out=SASUSER.p5_nj maxclusters=3;
   var Gender1 Education1 Race_Ethnicity1 Age_years_1 Income1 Class1;
   id Class1;
run;

proc univariate data=SASUSER.p4_nj;
var class1;
run;

proc fastclus data=SASUSER.p4_east  out=SASUSER.p5_east maxclusters=4;
   var Gender1 Education1 Race_Ethnicity1 Age_years_1 Income1 Class1;
   id Class1;
run;

***********************************************************************************;


proc candisc data=SASUSER.p5_nj out=SASUSER.p5_nj1 distance anova;
      class cluster;
      var  Gender1 Education1 Race_Ethnicity1 Age_years_1 Income1 Class1;
run;

*----------------------------------------------------------------------------------------------------------------
  To plot the canonical 1 and canonical 2 variables obtained using CANDISC procedure
*----------------------------------------------------------------------------------------------------------------;

proc sgplot data=SASUSER.p5_nj1;
   scatter y=can2 x=can1/group=cluster;
run;

***********************************FREQUENCY PLOTTING CODE************************;
PROC SGPLOT DATA = SASUSER.p5_east;
 VBAR locationdesc /  GROUP = class1 GROUPDISPLAY = CLUSTER;
 TITLE 'Olympic Countries by Region and Population Group';
RUN; 

PROC SGPLOT DATA = SASUSER.p5_east;
 VBAR locationdesc /  GROUP = Race_ethnicity1 GROUPDISPLAY = CLUSTER;
 TITLE 'Olympic Countries by Region and Population Group';
RUN; 


PROC SGPLOT DATA = SASUSER.p5_east;
 VBAR locationdesc /  GROUP = Income1 GROUPDISPLAY = CLUSTER;
 TITLE 'Olympic Countries by Region and Population Group';
RUN; 
