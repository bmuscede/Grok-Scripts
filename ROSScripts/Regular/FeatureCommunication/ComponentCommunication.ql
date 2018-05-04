////////////////////////////////////////////////////////////////////////
// Component Communication
// By: Bryan J Muscedere
//
// Detects the flow of information between features.
// Sees how information flows from one component to another
// via publishers and subscribers.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "COMPONENT-BASED COMMUNICATION (DEPRECIATED)";
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
	inv @label o (compContain o direct o inv compContain) o @label;
}

//Finally, resolve the plain-English class names.
print "";
print "Indirect Messages:";
if (#indirect < 1){
	print "<NONE>";
} else {
	inv @label o (compContain o indirect o inv compContain) o @label;
}

print "";
