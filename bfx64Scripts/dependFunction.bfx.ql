///////////////////////////////////////////////////
// Depend on Function
// 
// By: Bryan J Muscedere
// Date: July 18th, 2016
//
// Lists all the functions that depend on a specific
// function in the project. Creates
// a function graph, inverses it and the performs transitive
// closure on that graph.
///////////////////////////////////////////////////

//Creates an empty set.
$INSTANCE = eset;

//Loads in the input TA.
input = $1;
getta(input);

//Get the file/file names.
file = $INSTANCE . {"cObjectFile"};

//Get the function/function names.
function = sort($INSTANCE . {"cFunction"});
functionNames = rng (file o @label);

//Next, we take the links and project it with the functions.
//This line is the only different one from functionDepend.bfx.ql
functionRelations = inv (function * cLinks);
functionCalls = functionRelations*;

//Print each function and what it depends on.
for item in function {
        //Gets all functions that are used by it.
        matchedItems = rng ({item} * functionRelations);

	if (#matchedItems > 0) {
		//Prints the label.
		print rng ({item} o @label); 
	
		//Prints each item.
		for match in matchedItems {
			itemLabel = rng ({match} o @label);
			itemLabel;
		}

		//Adds empty lines.
		print ""
	}
}
