# ClangEx Scripts - *Scripts for the ClangEx Extractor*

This folder contains Grok scripts for models created by the ClangEx extractor. The Rex extractor can be found in [this GitHub repository](https://github.com/bmuscede/ClangEx). If a model that wasn't created by ClangEx is used, the script will likely generate an error.

There are three categories of scripts:
1. **funcDepends.ql** - Prints the dependencies for a function based on some call graph.
2. **globalVar.ql** - Prints all the global variables in an analyzed program.
3. **varLookup.ql** - Prints interesting parameters about a variable.

Additionally, each script resolves the "human-readable" label for each of the IDs. This is done by referencing the @label relation.
