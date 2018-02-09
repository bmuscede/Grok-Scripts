////////////////////////////////////////////////////////////////////////
// Function Dependency
// By: Bryan J Muscedere
//
// Lists all the functions that are depended on
// by all other functions in the project. Creates
// a function graph and the performs transitive
// closure on that graph.
////////////////////////////////////////////////////////////////////////

//Creates an empty set.
$INSTANCE = eset;

//Loads in the input TA.
input = $1;
getta(input);

//Get the file/file names.
file = $INSTANCE . {"cObjectFile"};

//Get the function/function names.
function = sort($INSTANCE . {"cFunction"});
functionNames = rng (file * @label);

//Next, we take the links and project it with the functions.
functionRelations = cLinks * function;
functionCalls = functionRelations+;

//Print each function and what it depends on.
for item in function {
        //Gets all functions that are used by it.
        matchedItems = rng ({item} * functionCalls);

	if (#matchedItems > 0) {
		//Prints the label.
		print rng ({item} * @label); 
	
		//Prints each item.
		for match in matchedItems {
			itemLabel = rng ({match} * @label);
			itemLabel;
		}

		//Adds empty lines.
		print ""
	}
}
