////////////////////////////////////////////////////////////////////////
// Dataflow Communication
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

//Gets a list of the direct communication.
reach = compContain o (contain o (publish o subscribe) o inv contain) o inv compContain;
direct = comms ^ reach;
indirect = comms - reach;

//Prints communication.
print "Direct Messages:";
if #direct > 0 {
	inv @label o direct o @label;
} else {
	print "<None>";
}
print "";
print "Indirect Messages:";
if #indirect > 0 {
        inv @label o indirect o @label;
} else {
        print "<None>";
}
