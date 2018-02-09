# ROS Scripts - *Scripts for the Rex Extractor*

This folder contains Grok scripts for models created by the Rex extractor. The Rex extractor can be found in [this GitHub repository](https://github.com/bmuscede/Rex). If a model that wasn't created by Rex is used, the script will likely generate an error.

There are three categories of scripts:
1. **Feature Communications** - Looks at communications between features in a program.
2. **Multiple Input** - Looks at instances where multiple features communicate to a single feature.
3. **Control Flow** - Looks at instances where the communication from one feature changes the behaviour of another.

Additionally, there is a folder containing obfuscated scripts. This folder contains each script from the previous three folders that have been obfuscated to just print the IDs of entities rather than the "human-readable" label.
