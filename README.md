ReadMe file — Instructions
==========================

This file provides a brief description of the project's folders structure.

If this is the first time you open this project, you can start by reading 
the manual (./doc/TeX/ngasp.pdf).


Project folders are organized in this way:
    * develop/

    * develop/source/backend/
      This is the source code of the "backend" (the system core).

    * develop/webapp/
      This is the folder of the "front-end" (web application).

    * develop/webapp/tmp
      This is the temporary folder used by the back-end for storing experiment results and messages.

    * develop/source/samtoolslib/
      This is the source code of samtools library with some modifications (search for this tag: "//!").

    * develop/source/seqan/
      This is the source code of the seqan library.

    * develop/repository/
      It contains some example experiments and pipelines.

    * develop/examples/
      This folder contains data example files. Only for development purposes.

    * develop/tests/
      This folder contains development scripts for testing purposes.

    * doc/
      This folder contains development documentation about the project.

    * docker/
      This folder contains the docker files for creating the compiling- and the developing- environments.

    * gradle/
    * gradlew
    * gradlew.bat
      This folder and files are used by Jenkins, the continuous integration system.

    * LICENSE.txt
      This is the license text for this project (GNU Lesser GPL 2.1)

    * media/
      This folder contains ngasp resources such as logos, icons and images.

    * ngasp.xcodeproj
      It contains the XCode configuration for opening the ./source/backend.

    * readme.txt
      This file.

    * release/
      This folder contains the final application once it is compiled.

    * tools/
      It contains some development tools.

    * ./.git
      This folder is used by to Git.

    * ./.gitattibutes
      Here are defined some files and folders to be included but not versioned with Git.

    * ./.gitignore
      Here are defined some files and folders to be excluded versioning with Git.



