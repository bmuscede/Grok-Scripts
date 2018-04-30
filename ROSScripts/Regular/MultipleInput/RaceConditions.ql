////////////////////////////////////////////////////////////////////////
// Race Conditions
// By: Bryan J Muscedere
//
// Detects variables that are modified by two different components
// through two different callback functions.
////////////////////////////////////////////////////////////////////////

//Prints a simple header.
print "-----------------";
print "RACE CONDITIONS";
print "-----------------";
print "";

//Sets the input file and loads.
$INSTANCE = eset;
inputFile = $1;
getta(inputFile);

//Get a list of callback functions.
callbackFunc = rng (subscribe o call);

//Determines all the variables that are modified by each callback function.
vars = callbackFunc o write;
inset = indegree(vars);

//Purges variables written to by less than 2 functions.
inset = inset [ &1 > 1 ];

print "Number of Race Condition Variables:";
if #inset < 1 {
	print "<NONE>";
	print "";
	quit;
} else {
	#inset;
	print "";
}

//Gets more information about the relation.
for curVar in dom inset {
	specific = vars . {curVar};
	
	//Deal with cases where multiple callbacks modify.
	uP = {curVar} . @label;
	for printWorkAround in dom uP { print "For the " + printWorkAround + " variable:" };

	//Gets the callback functions that push to that variable.
	callbacks = dom specific;
	callbacks . @label;
	print "";
}
