////////////////////////////////////////////////////////////////////////
// Global Variables
// By: Bryan J Muscedere
//
//Prints all the global variables in an
//analyzed program. Ignores any local
//or parameter based variables.
////////////////////////////////////////////////////////////////////////

//Initializes QL.
$INSTANCE = eset;
getta($1);

//Selects the variable set.
gVar = ($INSTANCE . {"cVariable"}) ^ (@scopeType . {"global"});

//Prints the results.
print "Global Variables:";
globalNames =  gVar . @label; 

if (#globalNames < 1){
	print "<NONE>";
	exit;
}

globalNames;
