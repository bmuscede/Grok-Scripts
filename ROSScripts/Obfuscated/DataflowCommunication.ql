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

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets a list of publishers and subscribers.
publishSet = $INSTANCE . {"rosPublisher"};
subscribeSet = $INSTANCE . {"rosSubscriber"};

//Next, combines publish and subscribe.
rosComm = publish o subscribe;

//Then combines the publish to subscribe communication with the call graph.
fullCall = rosComm + call;
fullCall = fullCall+;

//Next, upgrades the relations.
comms = publishSet o fullCall o subscribeSet;
comms = contain o comms o inv contain;
comms = compContain o comms o inv compContain;

//Prints communication.
print "Dataflow Communication:";
if #comms > 0 {
	comms;
} else {
	print "<None>";
}
