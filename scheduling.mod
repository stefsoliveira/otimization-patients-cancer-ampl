set patient; #no. of patients to be allocated 
set days;  #planning horizon 
set shift; #no. of shift in a day - morning and afternoon
set S; #shift with no patients allocated
set D; #day corresponding to have no patients allocated
set N; 

param availability{i in patient, j in days};
param costpershift{i in patient, j in days, s in shift};
param emptycost{n in N, l in D, m in S};

var patientavailability{i in patient,j in days,s in shift} binary; # = 1 if patient i is available on jth day working on sth shift, 0 otherwise
var emptyshift{n in N, l in D, m in S} integer;
#var produce = thisOplModel;


#Objective function

minimize Cost: sum{i in patient, j in days, s in shift} costpershift[i,j,s]*patientavailability[i,j,s]+ sum{ n in N, l in D, m in S}emptycost[n,l,m]*emptyshift[n,l,m];


#constraints

#maximum no. of shifts per day
subject to maximum_shifts_perday {i in patient,j in days}:
 sum{s in shift} patientavailability[i,j,s]*availability[i,j] <= 1;

#patients per shift
subject to schedule{j in days, s in shift, l in D, m in S}: 
sum{i in patient} availability[i,j]*patientavailability[i,j,s] + sum{n in N} emptyshift[n,l,m]=4;