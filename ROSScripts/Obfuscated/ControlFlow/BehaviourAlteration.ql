////////////////////////////////////////////////////////////////////////
// Behaviour Alteration [OBFUSCATED]
// By: Bryan J Muscedere
//
// Detects whether a variable that modifies a control structure
// is written to by a callback function. Follows the flow of the
// data up until the variable.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "BEHAVIOUR ALTERATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets the direct and indirect relations.
direct = contain o publish o subscribe o call;
indirect = contain o publish o subscribe o inv contain;
indirect = indirect+;

//Generates relations to track the flow of data.
callbackFuncs = rng(subscribe o call);
controlFlowVars = @isControlFlow . {"\"1\""};
masterRel = varWrite + call + write + varInfFunc;
masterRel = masterRel+;

//Gets the behaviour alterations.
behAlter = callbackFuncs o masterRel o controlFlowVars;

//Print the results.
if #behAlter > 0 {
	print "There are " + #behAlter + " cases of behaviour alteration across " + #(dom behAlter) + " callback functions.";
	print "";
} else {
        print "There are no cases of behaviour alteration.";
        quit;
}

//Loops through and presents the results.
for item in dom behAlter {
	print "---------------------------------------------------------";
	item;
	print "";

	print "Affects Variables:"
	{item} . behAlter;
	print "";

	print "Influenced By - Direct:"
	dirInf = direct . {item};
	if (#dirInf > 0) {
		dirInf;
	} else {
		print "<NONE>";
	}
	print "";

	inInf = indirect . (direct . {item});
	print "Influenced By - Indirect:";
	inInf = inInf - dirInf;
	if (#inInf > 0) {
		inInf;
	} else {
		print "<NONE>";
	}

        print "---------------------------------------------------------";
}
