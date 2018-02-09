////////////////////////////////////////////////////////////////////////
// Function Depends On
// By: Bryan J Muscedere
//
//Prints the dependencies for a function based on some call graph.
//This will look at any function calls BELOW some function.
////////////////////////////////////////////////////////////////////////

//Generates the empty set and loads TA file.
$INSTANCE = eset;
getta($1);

//Gets the functions.
funcs = $INSTANCE . {"cFunction"};
funcID = @label . {$2};
funcLookup = funcs ^ funcID;

//Checks if the function exists.
if (#funcLookup < 1) {
	print "Function not found!";
	exit;
}

//Next, generates a call graph.
callGraph = call*;

print "Functions that depend:"

dep = {funcID} . callGraph;
if (#dep < 1){
	print "<NONE>";
	exit;
}

dep;
