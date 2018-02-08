$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "PUBLISHER ALTERATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets the relations important for all phases.
direct = contain o publish o subscribe o call;
indirect = contain o publish o subscribe o inv contain;
indirect = indirect+;

callbackFuncs = rng(subscribe o call);
masterRel = varInfluence + varInfFunc + call + write;
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
	print {item} . @label;
	print "";
	
	print "Writes to Topics:"
	inv @label . ({item} . pubAlter);
	print "";

	dirInf = direct . {item};
	print "Influenced By - Direct:";
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
