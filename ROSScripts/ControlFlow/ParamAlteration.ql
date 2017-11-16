////////////////////////////////////////////////////////////////////////
// Param Alteration
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

//Gets the param variables.
paramVariables = @isParam . {"\"1\""};
callbackVariables = rng (subscribe o call o contain);
vars = paramVariables ^ callbackVariables;

//Determines the control flow from one entity to another.
writePath = vars . (varWrite*);
controlVars = @isControlFlow . {"\"1\""};
writePath = writePath . controlVars;

//Now, prints the result.
print "Components that Affect Components Through Parameters:";
if #writePath > 0 {
	//Gets interactions at the component level.
	classTo = contain . contain . writePath;
	path = subscribe o publish;
	path = path+;
	path = path o classTo;
	
	//Lifts both.
	path = compContain o path o inv compContain;
	print inv @label o path o @label;
} else {
	print "<None>";	
}
