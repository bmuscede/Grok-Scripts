# bfx64 Scripts - *Scripts for the bfx64 Extractor*
This folder contains Grok scripts for models created by the bfx64 extractor. The bfx64 extractor can be found in [this GitHub repository](https://github.com/bmuscede/bfx64). If a model that wasn't created by bfx64 is used, the script will likely generate an error.

There are four bfx64 scripts used to evaluate this extractor:
1. **dependFunction.bfx.ql** - Lists all functions that depend on another function.
2. **files.bfx.ql** - List all files contained in the project.
3. **functionDepend.bfx.ql** - Lists all the functions that are depended on by all other functions in the project. 
4. **globalVar.bfx.ql** - Finds global variables that are used by more than one function.

All of these scripts will resolve the IDs of the entities in the TA model to a human-readable ID.
