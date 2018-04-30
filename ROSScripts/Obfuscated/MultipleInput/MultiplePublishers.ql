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

//Gets subscribers that are written to.
direct = publish o subscribe;
direct = contain o direct;

//Gets the indegree
inset = indegree(direct);

//Removes items from indegree.
inset = inset [ &1 > 1 ];

//Prints the results.
print "Subscribers that have Multiple Component Communications:"
if (#inset == 0){
	print "<NONE>";
	print "";
	quit;
} else {
	compContain . dom inset;
	print "";
}

//Now, dives deeper.
for item in dom(inset) {
	cbFunc = {item} . call;
	cFunction = cbFunc;
	cClass = contain . {item};

	//Print the item.
	for subItem in cFunction { for subsubItem in cClass { print "Callback Function " + subItem + " (" + subsubItem + ") - " } }
	
	//Get the publishers.
	compContain . (direct . {item});
	print "";	
}
