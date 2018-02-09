////////////////////////////////////////////////////////////////////////
// File List
// By: Bryan J Muscedere
//
// Lists all the files that are contained in
// the project.
////////////////////////////////////////////////////////////////////////

//Creates several empty sets.
contain = eset;
$INSTANCE = eset;

//Loads in the TA file.
input = $1;
getta(input);

//Creates a set of files and prints.
files = $INSTANCE . {"cExecutable", "cObjectFile", "cArchiveFile"};
sort(files);
