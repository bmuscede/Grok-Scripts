////////////////////////////////////////////////////////////////////////
// Loop Detection [OBFUSCATED]
// By: Bryan J Muscedere
//
// This detector determines whether there are loops in the communication
// pathway. This considers barebones communications between components.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "LOOP DETECTION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Generates a list of classes pointing back to themselves.
loopTest = id ($INSTANCE . {"cClass"});

//Generates the call graph.
fullCall = (publish o subscribe) + call;
fullCall = fullCall+;

//Generates the direct loops.
classComm = contain o (publish o subscribe) o (inv contain);
direct = classComm ^ loopTest;

//Gets a list of publishers and subscribers.
publishSet = $INSTANCE . {"rosPublisher"};
subscribeSet = $INSTANCE . {"rosSubscriber"};

//Gets the dataflow indirect results.
comm = contain o publishSet o fullCall o subscribeSet o inv contain;
indirect = comm ^ loopTest;
indirect = indirect - direct;

//Print the results
print "Direct Loops:"
if #direct > 0 {
	compContain o direct o inv compContain;
} else {
        print "<NONE>";
}
print "";		

print "Indirect Loops:"
if #indirect > 0 {
	compContain o indirect o inv compContain;
} else {
	print "<None>";
}
print "";

