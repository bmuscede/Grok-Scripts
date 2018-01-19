////////////////////////////////////////////////////////////////////////
// Publisher Alteration [OBFUSCATED]
// By: Bryan J Muscedere
//
// Gets a list of publishers under control structures.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

//Sets the input file and loads.
$INSTANCE = eset;
inputFile = $1;
getta(inputFile);

//Next, gets a set of variables written to inside callback functions.
subs = $INSTANCE . {"rosSubscriber"};
callbackFuncs = subs . call;
callbackVars = callbackFuncs o write;

//Takes the varWrites and computes the transitive closure.
writeGraph = varWrite+;
callbackToPub = callbackVars o writeGraph o varInfluence;

//Print the results.
print "Callback Functions that Affect the Behaviour of Publications:"
if #callbackToPub == 0 {
	print "<NONE>";
	quit;
}
inv @label o callbackToPub o @label;
print "";

//Get the direct calls.
compCalls = contain o publish o subscribe o call o callbackToPub o inv contain;

print "Components that Cause Another Component to Publish:";
if #compCalls > 0 {
	inv @label o (compContain o compCalls o inv compContain) o @label;
} else {
	print "<NONE>";
}
