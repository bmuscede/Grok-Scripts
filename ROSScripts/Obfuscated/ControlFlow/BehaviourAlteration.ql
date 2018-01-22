////////////////////////////////////////////////////////////////////////
// Behaviour Alteration [OBFUSCATED]
// By: Bryan J Muscedere
//
// Detects all interactions where some callback function
// writes to a variable that goes on to affect the
// program's control structure. This can occur in
// the current function or other functions in the component.
//
// This script doesn't resolve MD5 hashes of IDs.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Prints a simple header.
print "-----------------";
print "BEHAVIOUR ALTERATION";
print "-----------------";
print "";

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets a list of subscribers.
subs = $INSTANCE . {"rosSubscriber"};

//Get the direct component calls.
direct = publish o subscribe;

//Gets the variables that have a control flow of 1.
controlVars = @isControlFlow . {"\"1\""}
callbackFuncs = subs . call;
callbackVars = callbackFuncs o write;
callbackControlVars = callbackVars o controlVars;

//Display the subscribers and the variables they write to.
print "Variables Written To In Callback Functions:";
if #callbackControlVars > 0 {
	callbackControlVars;
} else {
	print "<NONE>";
}
print "";

//Next, we want to get the components which directly affect this component.
directDst = (subs o call) . dom (callbackControlVars);
directComp = direct o directDst;
directComp = contain o directComp o (inv (contain));

//Gets the indirect cases from a dataflow basis.
totalMsg = direct + call;
totalMsg = totalMsg+;
indirect = totalMsg o dom directDst;
indirect;
print ""
//Gets the upper components.
indirect = contain o indirect o inv contain;
indirect = indirect - directComp;

//Now, we display communications.
print "Components Affecting the Behaviours of Other Components - Direct:";
if #directComp > 0 {
	compContain o directComp o inv compContain;
} else {
	print "<NONE>";
}
print "";

print "Components Affecting the Behaviours of Other Components - Indirect:";
if #indirect > 0 {
	compContain o indirect o inv compContain;
} else {
	print "<NONE>";
}

print "";

