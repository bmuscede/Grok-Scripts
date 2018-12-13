////////////////////////////////////////////////////////////////////////
// Publisher Alteration [OBFUSCATED]
// By: Bryan J Muscedere
//
// Detects whether a callback function "eventually" modifies a 
// variable that participates in the decision portion of a control
// structure that causes a publish call to operate. That or whether
// a publish call is made in the body of a function that is activated
// by a callback function.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "PUBLISHER ALTERATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

transContain = contain+;

//Gets the relations important for all phases.
direct = transContain o publish o subscribe o call;
indirect = transContain o publish o subscribe o inv transContain;
indirect = indirect+;

callbackFuncs = rng(subscribe o call);
masterRel = varWrite + varInfluence + varInfFunc + call + write;
masterRel = masterRel+;

//Gets all publisher alterations.
pubAlter = callbackFuncs o masterRel o publish;

//Print the results.
if #pubAlter > 0 {
	print "There are " + #pubAlter + " cases of publisher alteration.";
	print "";
} else {
	print "There are no cases of publisher alteration.";
	quit;
}

//Loops through and presents the results.
for item in dom pubAlter {
	print "---------------------------------------------------------";
	item;
	print "";
	
	print "Writes to Topics:"
	{item} . pubAlter;
	print "";

	dirInf = direct . {item};
	print "Influenced By - Direct:";
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
