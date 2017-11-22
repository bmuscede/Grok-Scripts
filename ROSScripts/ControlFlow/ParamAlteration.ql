////////////////////////////////////////////////////////////////////////
// Param Alteration
// By: Bryan J Muscedere
//
// Detects all interactions where some callback function
// parameter causes a publication to another component.
////////////////////////////////////////////////////////////////////////

$INSTANCE = eset;

//Sets the input file and loads.
inputFile = $1;
getta(inputFile);

//Gets the param variables.
paramVariables = @isParam . {"\"1\""};
callbackVariables = rng (subscribe o call o contain);
vars = paramVariables ^ callbackVariables;

//Determines
