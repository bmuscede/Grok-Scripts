////////////////////////////////////////////////////////////////////////
// Loop Detection [OBFUSCATED]
// By: Bryan J Muscedere
//
// This detector determines whether there are loops in the communication
// pathway. This considers barebones communications between components
// as well as through the dataflow.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Generates a list of classes pointing back to themselves.
classes = $INSTANCE . {"cClass"}
classes = (classes o contain) o inv contain;

//Start with component loops.
print "=================================================";
print "COMPONENT LOOPS"
print "=================================================";

//Gets the components that communicate.
classComm = contain o (publish o subscribe) o (inv contain);

//Prints the results.
direct = classComm ^ classes;
print "Direct Component Loops:";
if #direct > 0 {
	direct;
} else {
	print "<NONE>";
}
print "";

//Get the indirect results.
indirect = ((classComm+) ^ classes) - direct;
print "Indirect Component Loops Loops:";
if #indirect > 0 {
	indirect;
} else {
	print "<NONE>";
}
print "";

//Next, gets dataflow component loops.
print "=================================================";
print "DATAFLOW LOOPS";
print "=================================================";

//Gets the call graph.
fullCall = (publish o subscribe) + call;
fullCall = fullCall+;

//Resolves the parents.
dataflowComm = compContain o contain o publishSet o fullCall o subscribeSet o inv contain o inv compContain;
dataflowLoop = dataflowComm ^ classes;

print "Dataflow Loops:"
if #dataflowLoop > 0 {
	dataflowLoop;
} else {
	print "<None>";
}

