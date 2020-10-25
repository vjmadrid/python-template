# python-template

This project represents a template for the development of a complete project with Python

Features:

* Provides a standard at the directory structure level
* Provides a standard definition for the use of applications/modules
* Provides a standard at the level of configuration files
* Provides a Makefile that takes care of the operational management on the project -> Similar to Maven for Java
* Provides a basic support stack for testing
* Provides a basic support stack for QA
* Provides a basic support stack for Docker





## Description

- [README](#README)
- [LICENSE](#LICENSE)
- [.gitignore](#.gitignore)
- [configure-project.sh](#configure-project.sh)
- [Makefile](#Makefile)
- [requirements.txt](#requirements.txt)
- [setup.cfg](#setup.cfg)
- [pytest.ini](#pytest.ini)
- [/example/](#/example/)
- [/tests/](#/tests/)
- [base.Dockerfile](#base.Dockerfile)
- [dev.Dockerfile](#dev.Dockerfile)
- [pro.Dockerfile](#pro.Dockerfile)



### <a name="README">README</a>

File in Markdown format that describes the project, its characteristics and how to use it



### <a name="LICENSE">LICENSE</a>

File describing the license used for this project template



### <a name=".gitignore">.gitignore</a>

File control over uploading certain types of "not allowed" files to the Git code repository



### <a name="configure-project.sh">configure-project.sh</a>

Shell Script that takes care of configuring and adapting the template for use in a "real" project

It is in charge of capturing certain arguments:

* **MODULE** : Name of the module to be used
* **DOCKER-REGISTRY** : Name of the Docker Registry to be used

Once the arguments have been obtained, it renames and replaces certain values in all files and modules for use with the new parameters

Command to run the script

```bash
sh configure-project.sh MODULE="<module-name>" DOCKER-REGISTRY="<docker-registry-name>"

# Example
sh configure-project.sh MODULE="project-x" DOCKER-REGISTRY="docker.pkg.github.com/acme/project-x"
```



### <a name="Makefile">Makefile</a>

Project management file that automates common tasks such as building, testing, linting or cleaning the project

It has been built very similar to Apache Maven in the Java world

Command to run the script

```bash
make help
```



### <a name="requirements.txt">requirements.txt</a>

File containing the list of project dependencies (dependency + version)



### <a name="setup.cfg">setup.cfg</a>

File that centralizes the configuration of a project

Normally each technology makes use of its own configuration file, but this ends up creating a project with too many configuration points preventing maintenance and increasing the possibility of failure

>Note:
>
>Pytest cannot be added to setup.cfg
>
>Pytest docs tell you that you can use setup.cfg, it's not exactly true
>
>there are some bugs like interpolation errors



### <a name="pytest.ini">pytest.ini</a>

File used for the configuration of the Pytest stack



### <a name="/example/">/example/</a>

Directory where the source code of the application or module / package will be located

It should have the same name as the application or module / package

It consists of the following elements : 

* **app.py** : File containing the business logic (in this case it is basic to show that the package is well configured)
* **__init__.py** : File indicating that it is a Python package 
* **__main__.py** : File that allows you to run the application or module / package
* **/resources** : Directory that stores all the static content of the application or module / package

Command to run the package

```bash
python -m <package-name>

python -m example
```



### <a name="/tests/">tests</a>

Directory where you can find the test files related to the application and/or the modules / packages used

The entire project is located globally

It consists of the following elements : 

* **context.py** : Pytest stack control file that imports the files of the module used
* **conftest.py** : Pytest stack control file that takes care of specifying Pytest fixtures, hooks or loading external plugins
* **test_app.py** : Test file corresponding to app.py in source directory



### <a name="base.Dockerfile">base.Dockerfile</a>

Execution file of a custom container to facilitate testing during development



### <a name="dev.Dockerfile">dev.Dockerfile</a>

Application container execution file for the DEV environment



### <a name="pro.Dockerfile">pro.Dockerfile</a>

Application container execution file for the PRO environment




## Technological Stack

* [Python 3](https://www.python.org/) 
* [Pip](https://www.python.org/)  - Dependency Management
* [Docker](https://www.docker.com/) - Container Technology
* [Pyenv](https://github.com/pyenv/pyenv) - Python Version Management Tool
* [Pyenv-Virtualenv](https://github.com/pyenv/pyenv-virtualenv) - Virtual Environment (virtualenvs) Management Tool for use with pyenv
* [Venv](https://github.com/python/cpython/tree/3.9/Lib/venv/) - Module provided by Python for the management of virtual environments (virtualenvs)

Dependencies with architecture projects

N/A

Third Party Dependencies

* **Flask** [1.1.2] : 
* **pytest** [6.1.1] : 
* **pytest-xdist** [2.1.0] : 
* **pytest-cov** [2.10.1] : 
* **flake8** [[xxx] : 
* **pylint** [xxx] : 
* **bandit** [xxx] : 





## Prerequisites

Define what elements are needed to install the software

* Python 3 installed (3.9.0+ version required)
* Pip installed  (20.0.0+)
* Docker installed (19+)








## Installation

Steps to follow

* Start a terminal
* To be located in the PATH of installation (the place where the project is located)
* Verify that the file "Makefile" is available

Execute the following command

```bash
make help
```





## Testing

N/A





## Deploy

N/A





## Use

N/A

Resource

Comment ASCII Title
http://patorjk.com/software/taag/#p=display&f=Standard&t=context.py





## Versioning

**Note :** [SemVer](http://semver.org/) is used for the versioning. 
To see the available versions access the repository tags





## Authors

* **Víctor Madrid**