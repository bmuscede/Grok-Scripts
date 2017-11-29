////////////////////////////////////////////////////////////////////////
// Race Conditions
// By: Bryan J Muscedere
//
// Detects variables that are modified by two different components
// through two different callback functions. This 
////////////////////////////////////////////////////////////////////////

//Sets the input file and loads.
$INSTANCE = eset;
inputFile = $1;
getta(inputFile);

//Get a list of callback functions.
callbackFunc = rng (subscribe o call);

//Gets component messages to callbacks.
compMsg = publish o subscribe o call;

//Determines all the variables that are written to by each callback function.
vars = callbackFunc o write;
for item in rng vars {
	//Scowers the relation for specific entries.
	specific = vars . {item};
	if #specific > 1 {
		//Deal with cases where multiple callbacks modify. (Concatination hack)
		for sRep in ({item} . @label) {print "For the " + sRep + " variable:"};

		//For each entry in the list, gets the publishers that push to that variable.
		callbacks = dom specific;
		for cb in callbacks {
			//Get the publishers for that callback and resolves their component names.
			{cb} . @label;
			//for c in components { print "\t- " + c; }
		}
		print "";
	}
}
