///////////////////////////////////////////////////
// Global Variable Discovery
// 
// By: Bryan J Muscedere
// Date: July 18th, 2016
//
// Finds global variables that are used by more
// than one function.
///////////////////////////////////////////////////

//Creates an empty set.
$INSTANCE = eset;

//Loads in the input TA.
input = $1;
getta(input);

//Get the cObject files.
objects = $INSTANCE . {"cObject"};

//Next, determine the object scope.
links = cLinks * objects;
for item in objects
	if (#(links . {item}) <= 1)
		objects = objects - {item};

//Finally, gets the names
objNames = rng (objects o @label); 

//Outputs all data.
print "Number of global variables with multiple references: " + #objects;
if (#objects == 0)
	quit;
print "";
print "Names of these variables: ";
sort(objNames);
