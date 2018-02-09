////////////////////////////////////////////////////////////////////////
// Behaviour Alteration
// By: Bryan J Muscedere
//
// Detects whether a variable that modifies a control structure
// is written to by a callback function. Follows the flow of the
// data up until the variable.
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

//Gets the relations important for all phases.
direct = contain o publish o subscribe o call;
indirect = contain o publish o subscribe o inv contain;
indirect = indirect+;

//Generates relations 
callbackFuncs = rng(subscribe o call);
controlFlowVars = @isControlFlow . {"\"1\""};
masterRel = varWrite + call + write;
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
	print {item} . @label;
	print "";

	print "Affects Variables:"
	inv @label . ({item} . behAlter);
	print "";

	print "Influenced By - Direct:"
	dirInf = direct . {item};
	if (#dirInf > 0) {
		print inv @label . dirInf;
	} else {
		print "<NONE>";
	}
	print "";

	inInf = indirect . (direct . {item});
	print "Influenced By - Indirect:";
	inInf = inInf - dirInf;
	if (#inInf > 0) {
		print inv @label . inInf;
	} else {
		print "<NONE>";
	}

        print "---------------------------------------------------------";
}
