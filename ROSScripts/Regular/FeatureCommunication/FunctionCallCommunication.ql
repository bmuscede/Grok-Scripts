////////////////////////////////////////////////////////////////////////
// Function Call Communication
// By: Bryan J Muscedere
//
// This detector resolves which components message other components
// directly and indirectly. These messages could be sent via function
// calls or ROS messages. Any indirect messages have a viable function/ROS
// path from start to finish.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Generates a list of classes pointing back to themselves.
classes = $INSTANCE . {"cClass"}
classes = (classes o contain) o inv contain;

//Next, combines publish and subscribe.
rosComm = publish o subscribe;

//Resolves the entire path to function calls.
fullCall = (call o rosComm o call) + call;

//Now gets the classes each function is in.
parentFullCall = contain o fullCall o inv contain;
parentFullCall = parentFullCall - classes;

//Prints the direct results.
print "Direct Component Communication:";
if #parentFullCall > 0 {
	sort(inv @label o parentFullCall o @label, 0);
} else {
	print "<None>";
}
print "";

//Now we do the same with indirect.
callGraph = fullCall+;
parentInFullCall = contain o callGraph o inv contain;
parentInFullCall = parentInFullCall - classes;
parentInFullCall = parentInFullCall - parentFullCall;

//Prints the indirect results.
print "Indirect Component Communication:";
if #parentInFullCall > 0 {
	sort(inv @label o parentInFullCall o @label, 0);
} else {
	print "<None>";
}
