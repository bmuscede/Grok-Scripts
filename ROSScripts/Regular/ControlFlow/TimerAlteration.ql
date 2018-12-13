////////////////////////////////////////////////////////////////////////
// Timer Alteration
// By: Bryan J Muscedere
//
// Detects when a timer results in a publication to another
// feature. This can either be from a direct publication
// inside the timer (ie heartbeat message) or can be from
// a variable being written to that results in a message.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "TIMER ALTERATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

transContain = contain+;

//Gets the relations important for all phases.
direct = publish o subscribe o inv transContain;
indirect = contain o publish o subscribe o inv transContain;
indirect = indirect+;

//Gets all the timers and timer callbacks.
timers = $INSTANCE . {"rosTimer"};
tmrCallback = rng time;

//Generates a master relation.
masterRel = varWrite + varInfluence + varInfFunc + call + write;
masterRel = masterRel+;

//Gets all cases of timer alteration.
timerAlter = timers o time o tmrCallback o masterRel o publish;

//Print the results.
if #timerAlter > 0 {
	print "There are " + #timerAlter + " cases of timer alteration.";
	print "";
} else {
	print "There are no cases of timer alteration.";
	quit;
}

//Loops through and presents the results.
for timer in dom timerAlter {
	print "---------------------------------------------------------";
	print "Timer:"
	{timer} . @label;
	print "";
	
	print "Writes to Topics:"
	inv @label . ({timer} . timerAlter);
	print "";

	dirInf = {timer} . timerAlter . direct;
	print "Directly Influences:";
	if (#dirInf > 0) {
		inv @label . dirInf;
	} else {
		print "<NONE>";
	}
	print "";
	
	inInf = ({timer} . timerAlter . direct) . indirect;
	print "Indirectly Influences:";
	inInf = inInf - dirInf;
	if (#inInf > 0) {
	        inv @label . inInf;
	} else {
		print "<NONE>";
	}

	print "---------------------------------------------------------";
}
