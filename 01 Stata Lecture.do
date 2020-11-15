***Using the .do file

*Type 'doedit' in the command window to start a .do file.
*You can write your commands here and save it.
*You can select the command and press 'Ctrl+D' to run it.
*'Ctrl+R' also runs the command but silently; doesn't show the result.

display "Hello world!" //displays "Hello world" in the result window
						//(see how to make comments in command line)

*To exit Stata

exit /*exits Stata program*/ /*(another way to make comments)*/

*You can execute the .do file by writing 'do filename.do' in the command line.



***File management: directories and folders

*To change the working directory

cd "D:\" 

*To make a new directory in the current working directory 

mkdir "D:\AST-308_Nabil Awan"

*To make the newly created directory our working directory

cd "D:\AST-308_Nabil Awan"

*To check or verify whether the present working directory is our desired directory

pwd

/*then you can transfer necessary data files and .do files in the
 present working directory*/ /*(learn how I used commenting)*/


 
***Using log files
 
/*A typical process is first to create the do file,
 then execute the do file, and finally read the resulting log file.*/
 
*Set up log file

set logtype text

log using logfile1_15April14.txt, append \\ use option 'append' instead of 'replace' to add new logs to the existing log file



***Change default settings

set mem 100m /* Allocating 100 megabyte(s) of RAM for Stata SE to read the
data file into memory. */

set more off /* This prevents the Stata output viewer from pausing the
process. */



***Use built in Stata dataset

sysuse auto.dta

*Summary statistics

summarize

*Simple regression of mileage on weight

regress mpg weight

*Close log file and exit Stata

log close //close log

exit, clear //exit Stata

/*Now see the how the log file saves all our works
 in it since setting up the log file until now, the
 later works will not be saved in the due due to
 the 'log close' command put here.*/



***To get help about any command

help reg //for example



***Entry/read data in Stata

*Entry data using GUI (GUI: Graphical User Interface)

edit //takes you to the GUI data editor and let you enter/edit data

*Entry data using CLI (CLI: Command Line Interface)

input hhid sex str10 location
10030 1 urban
10031 0 rural
10032 1 rural
end

/*For any string variable we need to specify
 the maximum number of characters the string will have
 using str#, here # is 10 which indicates that
 location have maximum characters 10.*/

browse //to see the data

*Label a variable

label variable hhid "Household identification number"
label variable sex "Gender of the respondent"
label variable location "location of the respondent"

*label variable values

label define gender 0 "Male" 1 "Female" 

label values sex gender

labelbook //shows the variables with value labels

save mydatafile //to save the dataset in the pwd
 
*To read a space-delimited file use

infile using "adult.dct", using ("adult.dat") 

*Some other dictionary file examples

clear

quietly infile using test1a

list

clear

quietly infile using test1b

list

clear

quietly infile using test2

list

clear

quietly infile using test3.dct

list


/*If you get documentation with the data that you are trying to
 read into Stata, you should always use the 'assert' command
 to check that the data follow the description set out in the documentation.
 For instance, in the previous example, the documentation said that
 there were 7 yes/no questions coded as 1=yes and 0=no.
 After reading in your data, you should check that. */

assert yesno1==0 | yesno1==1

assert yesno2==0 | yesno2==1

assert yesno3==0 | yesno3==1

assert yesno4==0 | yesno4==1

assert yesno5==0 | yesno5==1

assert yesno6==0 | yesno6==1

assert yesno7==0 | yesno7==1 

/*Another piece of advice for reading large text files
 is to use 'in' expresssion to limit the dictionary to read
 just one observation. This limit will allow you to
 test your dictionary and see if it is working properly.

If that looks OK, I might continue reading in the entire dataset,
 or I might read in the first five lines to further test my dictionary,
 which brings up an important point*/ 

clear 
 
infile using test1a in 1

list
 
*Comma/tab separated file with variable names on line 1

insheet using "comma sep vals.txt"
clear
insheet using "tab sep vals.txt"

/*this reads the variables from the first line
but when we want to introduce a variable as categorical,
we will need to specify that*/



*Use data from the web

use http://www.ats.ucla.edu/stat/data/hs0, clear

/*or you can use the 'webuse' command...*/

use http://www.stata-press.com/data/r13/lifeexp 

*or,

webuse lifeexp 

//webuse is a synonym for use http://www.stata-press.com/data/r13/

*Report URL from which datasets will be obtained

webuse query

*Specify URL from which dataset will be obtained

webuse set http://www.zzz.edu/users/~sue

/*webuse will become a synonym for use 
http://www.zzz.edu/users/~sue/ for the rest of the
session*/

*Reset URL to default

webuse set

/*the URL will be reset to the default,
http://www.stata-press.com/data/r13/ */

/*Sometimes, the data file may be too big to be read in. We will have to reset the amount of memory allocated to Stata.*/

clear
use http://www.ats.ucla.edu/stat/data/large
memory

clear
set memory 5m
use http://www.ats.ucla.edu/stat/data/large, clear
 
*Read data from .csv files

dir //if the file is not in the pwd then have to write the full path

insheet using hs0.csv, clear

//or

insheet using "D:\AST-308_Nabil Awan\hs0.csv", clear

describe //describes the dataset

/*When the variable names are not written in the first row of the .csv file,
 define the variables after 'insheet' first.*/

insheet gender id race ses schtyp prgtype read write math science socst using hs0_noname.csv, clear

count //shows the number of total counts

*Read a space-delimited file (.raw file) using 'infile' command 

infile gender id race ses schtyp str10 prgtype read write math science socst using hs0.raw, clear

*Read ASCII files using 'infix' command

/*The other type of commonly used ASCII data 
format is fixed format. It always requires a codebook 
to specify which column(s) corresponds to which variable. 
Here is small example of this type of data with a codebook. 
Notice how we make use of the codebook in the 'infix' command below.*/

clear
infix id 1-2 a1 3-4 t1 5-6 gender 7 a2 8-9 t2 10-11 tgender 12 using schdat.fix

/*Also see the use of 'compress' command that
 reduces the size of the data set*/

clear
input id female race ses str3 schtype prog read write math science socst
147 1 1 3 pub 1 47 62 53 53 61
108 0 1 2 pub 2 34 33 41 36 36
 18 0 3 2 pub 3 50 33 49 44 36
153 0 1 2 pub 3 39 31 40 39 51
 50 0 2 2 pub 2 50 59 42 53 61
 51 1 2 1 pub 2 42 36 42 31 39
102 0 1 1 pub 1 52 41 51 53 56
 57 1 1 2 pub 1 71 65 72 66 56
160 1 1 2 pub 1 55 65 55 50 61
136 0 1 2 pub 1 65 59 70 63 51
end

describe
compress //converts float into int and byte whenever possible and reduce size
save hsb10 



***Examining the dataset and variables

browse //to only see the data, cannot edit, to edit write 'edit' 

*Examine data using 'list' command

clear

sysuse auto
list
list in 1/10
list mpg weight
list mpg weight in 1/20
list if mpg>20
list mpg weight if mpg>20
list mpg weight if mpg>20 in 1/10

*Examine data using 'assert' command

assert mpg>0
assert mpg<0

*Examine dataset and variables using 'describe' command

describe, detail
 
*Find the details about variables using 'codebook' command

lookfor price

codebook price //for example

*Some more uses of 'list' command

use http://www.ats.ucla.edu/stat/data/hs0, clear

describe
list
list gender-read //specially see this
codebook 



***Exploring data

/*continued from the previously loaded data set*/

log using unit2.txt, text replace //to save log in a text file

summarize
summarize read math science write
display 9.48^2                          /* note: variance is the sd (9.48) squared */
summarize write, detail
sum write if read>=60                   /* note: sum is abbreviation of summarize */
sum write if prgtype=="academic"
sum write in 1/40

tabstat read write math, by(prgtype) stat(n mean sd)

tabstat write, by(prgtype) stat(n mean sd p25 p50 p75)

*Exploring data by plots and graphs

stem write //generates an ASCII stem-and-leaf plot
stem write, lines(2)

histogram write, normal //generates a histogram
histogram write, normal start(30) width(5)

kdensity write, normal //produces a smoothed density plot. 
kdensity write, normal width(5)  /* a smoother kdensity plot */
kdensity math, normal

graph box write //generates a box plot
graph box write, over(prgtype) 

//hist command is used to display histograms for categorical variables

histogram ses
histogram ses, discrete
tabulate ses
tab write       /* note: tab is abbreviation of tabulate */

/*The tab1 command is a convenience command to produce
multiple one-way frequency tables*/

tab1 gender schtyp prgtype

*Two-way crosstabulation.

tab prgtype ses 

*Two-way crosstabulation with row and column percents.

tab prgtype ses, row col 

correlate write read science
correlate write read science, covariance
correlate write read science, means 
correlate write read science, means covariance
pwcorr write read science, obs
scatter write read
scatter write read, jitter(2) //Jittering to prevent overplotting in statistical graphics
twoway (scatter read write, mlabel(id))

*You can also define the marker type and color

twoway (scatter write read, msymbol(square) msize(small) mcolor(black))

*You can also define the marker by ID

twoway (scatter read write, mlabel(id))

twoway (scatter read write if id <=10, mlabel(id) mlabposition(12) mlabsize(large) mlabcolor(red))
//here mlabposition(#) is the clock position called 'clockposstyle' in Stata
// so,  0 <= # <= 12, # an integer 

*Connect the scatter plots

twoway (scatter read write, connect(l)) // help scatter to see connecttypes

twoway (scatter read write, connect(l) sort)

twoway (scatter read write, connect(i) sort)

graph matrix read science write, half 

/*We have completed all of the analyses in this unit, 
so it is time to close the log file.*/

log close 

/*Now, let's see what is in our log file.*/ 

view unit2.txt 

//*Exploring students.dta data*//

use students.dta, clear

describe

summarize

tab major

rename newspaperreadershiptimeswk readnews
 
tab readnews

rename averagescoregrade score

table gender, contents(freq mean age mean score)

table major, contents(freq mean age mean sat mean score mean readnews)

tabstat age sat score heightin readnews, s(mean median sd var count range min max)

tabstat age sat score heightin readnews, s(mean median sd var count range min max) by(gender)

tab gender

tab gender studentstatus, column row

tab gender major, sum(sat) //sum for summary (mean, std and freq of SAT)

bysort studentstatus: tab gender major, column row

bysort studentstatus: tab gender major, sum(sat)



***Generating new variables

generate score2 = score/100
generate readnews2 = readnews*4

*Creating constants

generate x = 5
generate y = 4*15
generate z = y/x

*Indexing

generate idall=_n

move idall id

label variable idall "General student ID"

generate total=_N

move total id

label variable total "Total students in the sample"

sort major
by major: gen idmajor=_n
browse major idmajor

gsort -id
gsort id, gen(idsort) //also generates a variable named 'idsort' containing 1,2,3,...
gsort -id, gen(idsortneg) //gives 1 to the maximum id this time.

drop idsort idsortneg

generate fullname = lastname + ", " + firstname
label variable fullname "Student full name"
browse id fullname lastname firstname

gen fem_grad=(gender=="Female" & studentstatus=="Undergraduate")

tab fem_grad

gen fem_less25=(gender=="Female" & age<26)

tab fem_less25

edit



***Recoding a variable

recode age (18 19 = 1 "18 to 19") ///
(20/29 = 2 "20 to 29") ///
(30/39 = 3 "30 to 39") (else=.), generate(agegroups) label(agegroups) //this 'label' defines name of the value label.

count

tab agegroups

/* Stata has another way of generating new variables called egen
 which stands for extended generation.
 The egen command is a useful tool for many of specialized situations. */

egen agegroups2=cut(age), at(18, 20, 30, 40)
tab agegroups2

drop agegroups2

egen agegroups2=cut(age), at(18, 20, 30, 40) label
tab agegroups2

egen agegroups3=cut(age), group(3)
tab agegroups3

drop agegroups3

egen agegroups3=cut(age), group(3) label
tab agegroups3

replace readnews = . if readnews>5
tab readnews, missing
tab readnews, nomissing

replace gender = "F" if gender == "Female"
replace gender = "M" if gender == "Male"
tab gender



***MODIFYING DATA

*Demonstration and explanation

use http://www.ats.ucla.edu/stat/data/hs0, clear

/* Let's use the codebook command to see what our variables look like.
  Because we have not listed any variables after the command, 
  Stata will show us the codebook for all of the variables. */ 

codebook

/* First, let's order the variables in a way that makes sense.
  While there are several possible orderings that are logical,
  we will put the id variable first, followed by the demographic variables,
  such as gender, ses and prgtype.
  We will put the variables regarding the test scores at the end.*/ 

order id gender 

/* Now let's include some variable and value labels
 so that we know a little more about the variables. */ 

label variable schtyp "type of school"
label define scl 1 public 2 private
label values schtyp scl
codebook schtyp
list schtyp in 1/10
list schtyp in 1/10, nolabel

/* Now let's create a new numeric version of the string variable prgtype.
  We will call our new variable prog. */

encode prgtype, gen(prog)
label variable prog "type of program"
codebook prog
list prog in 1/10
list prog in 1/10, nolabel

/* The variable gender may give us trouble in the future
 because it is difficult to know what the 1s and 2s mean. */

rename gender female
recode female (1=0)(2=1)
label define fm 1 female 0 male
label values female fm
codebook female
list female in 1/10
list female in 1/10, nolabel

* Let's recode the value 5 in the variable race to be missing. 

codebook race

list race if race == 5
recode race 5 = .
list race if race == .

* Now let's create a variable that is a total of some of the test scores.

generate total = read + write + math + science
summarize total

/* Note that there are five missing values of total because
 there are five missing values of science. */

* Now let's see if we can assign some letter grades to these test scores. 

recode total (0/140=0 F) (141/180=1 D) (181/210=2 C) (211/234=3 B) (235/300=4 A), gen(grade)
//or
recode total (0/140=0 "F") (141/180=1 "D") (181/210=2 "C") (211/234=3 "B") (235/300=4 "A"), gen(grade2)

label variable grade "combined grades of read, write, math, science"
codebook grade
list read write math science total grade in 1/10
list read write math science total grade in 1/10, nolabel

/* Let's label the dataset itself so that we will remember what the data are.
  We can also add some notes to the data set. */

label data "High School and Beyond"

notes female:  the variable gender was renamed to female
notes race:  values of race coded as 5 were recoded to be missing
notes

/* In our first example, we will use egen to create standard scores
 for the variable read. */

egen zread = std(read)
summarize zread
list read zread in 1/10

* Next we will create a variable that has the mean of read for each level of ses. 

egen readmean = mean(read), by(ses)
list read ses readmean in 1/10

/* Now we will compute the average of several variables for each observation.
 Please note that there will be a mean for observation 9
 even though it has a missing value for science. */

egen row_mean = rowmean(read write math science)
list read write math science row_mean in 1/10

* These are just a few of the many useful egen functions built-in to Stata.

* Finally, we will save our data and continue on to the next unit.

save hs1



***MANAGING DATA

*Demonstration and explanation

/* Suppose we are undergraduates working on our honors project
 and we wish to analyze just a subset of the hs0 data file.
 In fact, we are studying "good readers" and just want to focus on the
 students who had a reading score of 60 and higher.
 The following shows how we can take the hs0 data file
 and make a separate folder called honors and store a copy of our data
 which just has the students with reading scores of 60 or higher. */

use http://www.ats.ucla.edu/stat/data/hs0, clear 
 
pwd
dir
ls
keep if read >= 60
describe
summarize read
mkdir honors
cd "D:\AST-308_Nabil Awan\honors"
save hsgoodread, replace
pwd

*Example continued - Keeping variables

/* Further suppose that our data file had many, many variables,
 say 2000 variables, but we only care about just a handful of them,
 id, female, read and write.
 We can subset our data file to keep just those variables as shown below. */ 

*let us rename the 'gender' variable as 'female' again 
rename gender female
recode female (1=0)(2=1)
label define fm 1 female 0 male
label values female fm
codebook female
list female in 1/10
list female in 1/10, nolabel

*Now we keep id, female, read and write and then save the dataset. 
keep id female read write
save hskept, replace
describe
list in 1/20

*Example continued - Dropping variables

/* Instead of wanting to keep just a handful of variables,
 it is possible that we might want to get rid of
 just a handful of variables in our data file.
 Below we show how we could get rid of the variables ses and prog. */ 

use hsgoodread, clear
drop ses prgtype
save hsdropped, replace
describe
list in 1/10

*Example - Appending data

/* Now we have moved on to our hs0 data again. We will create a file
  with the data for the males (called hsmale) and
  a file for the females (called hsfemale).

  We need to combine these files together to be able to analyze them.
  In this example, we are adding cases,
  sometimes called "stacking" datasets. */

**Now we create 'hsmale' dataset first.

use http://www.ats.ucla.edu/stat/data/hs0, clear   

*let us rename the 'gender' variable as 'female' again 
rename gender female
recode female (1=0)(2=1)
label define fm 1 female 0 male
label values female fm
codebook female
list female in 1/10 //for checking
list female in 1/10, nolabel //for checking

keep if female == 0 
save hsmale, replace

**Now we create 'hsfemale' dataset.

use http://www.ats.ucla.edu/stat/data/hs0, clear   

*let us rename the 'gender' variable as 'female' again 
rename gender female
recode female (1=0)(2=1)
label define fm 1 female 0 male
label values female fm
codebook female
list female in 1/10 //for checking
list female in 1/10, nolabel //for checking

keep if female == 1 
save hsfemale, replace

dir

use hsmale, clear
tabulate female
append using hsfemale
tabulate female
browse
save hsappended, replace

*Example - Merging data

/* Now we will create two files.
 A file that has the demographic information (called hsdemo)
 and a file with the test scores (called hstest).
 We wish to merge these files together.
 First, we need to open, sort and save each data file.
 Each data file must be sorted by the same variable.
 Next, we use the 'merge' command to merge the two datasets. */
 
use hsappended, clear
list
keep id race ses female 
sort id
save hsdemo, replace

use hsappended, clear
list
keep id read write math science socst 
sort id
save hstest, replace

dir

use hsdemo, clear
merge id using hstest

list

tab _merge

save hsmerged

*merging the files in our pwd: hsdropped.dat and hskept.dat  

dir

use hskept, clear
sort id
save hskept, replace

use hsdropped, clear
sort id
save hsdropped, replace

use hskept, clear
merge id using hsdropped

tab _merge //merge=3 means obs came from both master and using datasets, 1 means from master dataset, 2 means from using dataset.


/* Ref: http://www.ssc.wisc.edu/sscc/pubs/sfr-combine.htm */
