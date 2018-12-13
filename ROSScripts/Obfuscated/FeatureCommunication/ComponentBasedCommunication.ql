////////////////////////////////////////////////////////////////////////
// Dataflow Communication [OBFUSCATED]
// By: Bryan J Muscedere
//
// This detector resolves which components message other components
// directly and indirectly. These messages could be sent via function
// calls or ROS messages. Any indirect messages have a viable function/ROS
// path from start to finish.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "COMPONENT-BASED-COMMUNICATION COMMUNICATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

transContain = contain+;

//Gets the direct communications
direct = transContain o (publish o subscribe) o (inv transContain);

//Combines publishers and subscribers with function calls.
rosComm = publish o subscribe;
fullCall = rosComm + call;
fullCall = fullCall+;

//Gets a list of publishers and subscribers.
publishSet = $INSTANCE . {"rosPublisher"};
subscribeSet = $INSTANCE . {"rosSubscriber"};

//Ensures publishers start and subscribers end.
comms = publishSet o fullCall o subscribeSet;

//Gets the indirect communication.
indirect = transContain o comms o inv transContain;
indirect = indirect - direct;

//Prints communication.
print "Direct Messages:";
if #direct > 0 {
	compContain o direct o inv compContain;
} else {
	print "<NONE>";
}
print "";

print "Indirect Messages:";
if #indirect > 0 {
        compContain o indirect o inv compContain;
} else {
        print "<NONE>";
}
print "";
