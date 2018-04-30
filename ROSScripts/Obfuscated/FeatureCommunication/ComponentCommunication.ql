////////////////////////////////////////////////////////////////////////
// Component Communication [OBFUSCATED]
// By: Bryan J Muscedere
//
// Detects the flow of information between features.
// Sees how information flows from one component to another
// via publishers and subscribers.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "COMPONENT-BASED COMMUNICATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Performs lifting and gets direct/indirect calls.
direct = contain o (publish o subscribe) o (inv contain);
indirect = (direct+) - direct;

//Finally, resolve the plain-English class names. 
print "Direct Messages:"
if (#direct < 1){
	print "<NONE>";
} else {
	compContain o direct o inv compContain;
}

//Finally, resolve the plain-English class names.
print "";
print "Indirect Messages:";
if (#indirect < 1){
	print "<NONE>";
} else {
	compContain o indirect o inv compContain;
}

print "";
