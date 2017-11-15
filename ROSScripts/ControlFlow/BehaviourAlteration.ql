////////////////////////////////////////////////////////////////////////
// Behaviour Alteration
// By: Bryan J Muscedere
//
// Detects all interactions where some callback function
// writes to a variable that goes on to affect the
// program's control structure. This can occur in
// the current function or other functions in the component.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

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
(inv @label) o callbackControlVars o @label;
print "";

//Next, we want to get the components which directly affect this component.
directDst = (subs o call) . dom (callbackControlVars);
directComp = direct o directDst;
directComp = contain o directComp o (inv (contain));

//Finally, we get the components which indirectly affect this component.
direct = (contain o direct) o (inv (contain));
indirect = direct+;
indirectComp = indirect o (contain . directDst);
indirectComp = indirectComp - directComp;

//Now, we display communications.
print "Components Affecting the Behaviours of Other Components - Direct:";
(inv @label) o directComp o @label;
print "";
print "Components Affecting the Behaviours of Other Components - Indirect:";
(inv @label) o indirectComp o @label;
