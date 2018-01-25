////////////////////////////////////////////////////////////////////////
// Publisher Alteration
// By: Bryan J Muscedere
//
// Gets a list of publishers under control structures.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "PUBLISHER ALTERATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets a list of subscribers.
subs = $INSTANCE . {"rosSubscriber"};

//Get the direct component calls.
direct = publish o subscribe;

//Get any variables that have a control flow of 1.
controlVars = @isControlFlow . {"\"1\""};
callbackFuncs = subs . call;
callbackVars = callbackFuncs o write;
callbackControlVars = callbackVars o controlVars;

//Display the subscribers and the variables they write to.
print "Variables Written To In Callback Functions:";
if #callbackControlVars > 0 {
        inv @label o callbackVars o @label;
} else {
        print "<NONE>";
}
print "";

//Gets the transitive closure of write influences.
transWrite = varWrite+;
transWrite = callbackVars o transWrite o controlVars;
callbackControlVars = callbackControlVars + transWrite;

//Now, gets the components that cause others to publish.
callbackToPub = callbackControlVars o varInfluence;

//Pushes up the range of the relation.
direct = compContain o contain o (publish o subscribe o call o callbackToPub) o inv contain o inv compContain;

print "Components that Affect An Other Component's Publish Behaviour - Direct:"
if #direct > 0 {
	inv @label o direct o @label;
} else  {
	print "<NONE>";
}
print "";

//Gets the indirect cases from a dataflow basis.
totalMsg = (publish o subscribe) + call;
totalMsg = totalMsg+;
indirect = totalMsg o (call . dom callbackToPub);

//Pushes up the relation.
indirect = compContain o contain o indirect o inv contain o inv compContain;
indirect = indirect - direct;

print "Components that Affect An Other Component's Publish Behaviour - Indirect:"
if #indirect > 0 {
	inv @label o indirect o @label;
} else {
	print "<NONE>";
}

print "";
