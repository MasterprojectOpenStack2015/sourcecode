Dependable Cloud Computing with OpenStack
=========================================

This repository contains the source code for the masters project on dependability testing of OpenStack 
at the chair of [Operating Systems and Middle Ware](http://www.dcl.hpi.uni-potsdam.de/)
at the [Hasso-Plattner-Institute](http://hpi.de/) in the Summer Term of 2015.

Documentation
-------------

The documentation is split in several parts.

1. In the [documentation](documentation) folder you can find technical details about the software contained in this repository.
2. The [MasterprojectOpenStack2015/report](https://github.com/MasterprojectOpenStack2015/report) repository contains worthy documentation.

Installation
------------

1. Setup a fresh [Ubuntu 14.4](http://www.ubuntu.com/download/desktop).
2. Make sure you have an internet connection.
3. Clone this repository

        git clone https://github.com/MasterprojectOpenStack2015/sourcecode.git

4. Enter the repository and start the installation.

        cd sourcecode
        ./install.sh

    This took us about 15 minutes. You need to enter the root password twice. 
    The expected output can be found in the [documentation folder](documentation/install.sh.output.txt).

5. To run an experiment, get help from this script.

        ./run_experiment.sh 

    The expected output can be found in the [folder of the experiment](experiments).
