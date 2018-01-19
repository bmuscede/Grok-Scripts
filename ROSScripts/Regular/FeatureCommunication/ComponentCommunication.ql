////////////////////////////////////////////////////////////////////////
// Component Communication
// By: Bryan J Muscedere
//
// Detects the flow of information between features.
// Sees how information flows from one component to another
// via publishers and subscribers.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Ges the direct communications.
direct = publish o subscribe;

//Now, resolves the classes.
direct = contain o direct;
direct = direct o (inv (contain));

//Finally, resolve the plain-English class names. 
print "Direct Messages:"
if (#direct < 1){
	print "<None>";
} else {
	inv @label o (compContain o direct o inv compContain) o @label;
}

//Gets the indirect communications.
indirect = direct+;
indirect = indirect - direct;
indirect = compContain o indirect o inv compContain;

//Finally, resolve the plain-English class names.
print "";
print "Indirect Messages:";
if (#indirect < 1){
	print "<None>";
} else {
	inv @label o indirect o @label;
}
