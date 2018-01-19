////////////////////////////////////////////////////////////////////////
// Multiple Publishers [OBFUSCATED]
// By: Bryan J Muscedere
//
// Detects components that are messaged by multiple components
// and where those messages feed to the same callback function.
// This only deals with direct communications since indirect are
// irrelevant for this script. This script doesn't work if a callback 
// function is used by multiple topics.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "MULTIPLE PUBLISHERS";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets topics that are written to.
direct = publish o subscribe;
direct = contain o direct;

//Gets the indegree
inset = indegree(direct);
inset = inset - (inset o {2});

//Prints the results.
print "Callback Functions that have Multiple Component Communications:"
if (#inset > 0){
	print "<NONE>";
	print "";
	quit;
} else {
	inset;
	print "";
}

//Now, dives deeper.
for item in dom(inset) {
	cbFunc = {item} . call;
	cFunction = rng(cbFunc);
	cClass = rng(dom(contain o rng{item}));

	//Fix to be able to print names. For loop converts sets to strings for some reason.
	//It means I can print them using the concatination operator.
	//This seems to be a QL specific glitch.
	for subItem in cFunction { for subsubItem in cClass { print "Callback Function " + subItem + " (" + subsubItem + ") - " } }
	
	//Get the publishers.
	direct . {item};
	print "";	
}

print "";
