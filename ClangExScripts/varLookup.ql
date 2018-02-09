////////////////////////////////////////////////////////////////////////
// Variable Lookup
// By: Bryan J Muscedere
//
// Prints interesting parameters about
// a variable. This includes its
// visibility, and call structure.
////////////////////////////////////////////////////////////////////////

//Create the empty set and load the TA.
$INSTANCE = eset;
getta($1);

//Next, resolve what the user looked up.
variables = $INSTANCE . {"cVariable"};
varID = @label . $2;
if (#(variables ^ varID) < 1) {
	print "<VARIABLE NOT FOUND>";
	exit;
}

//We now print the data.
print "Name:" $2;
print ""

//Print data associated.
print "Variable Information:"
print "\tVisibility: " varID . @scopeType

print "----------------------------------"
print "Variable Access:"


