Getting and Cleaning Data Peer Assignments
======================

Step1 loads the raw datas, and concatinate them. 
Step2 calculates mean and standard deriviation. They are stored to variable "one.means" and "one.sds" for each. 

To keep code simple, Step4 has done before Step3.
Step4 is simply add colum name gotten from features.txt to the raw data. 

On Step3, at first I loaded and created activity description data which is subject and label(numeric). 
Then I tried to the associate numeric labels on the data to descriptive name on activity_lavels.txt by using merge function.
The merge function destroies sort order, It's bad for when binding description data and raw data. 
So binding data before binding. 
...it's not clear all problems...
After merge function, all data classes became factor.. 
So actual merge has done at the end (after Step5).

Step5, tapply is not available for dataframe, so splitting dataframe into activity groups and subject groups. 
split function creates a list of dataframes, so I prepared "lrbind" function which returns a dataframe bind each of list elements. 
