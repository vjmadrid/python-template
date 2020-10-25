# *****************************************
#                  _         __ _ _      
#  _ __ ___   __ _| | _____ / _(_) | ___ 
# | '_ ` _ \ / _` | |/ / _ \ |_| | |/ _ \
# | | | | | | (_| |   <  __/  _| | |  __/
# |_| |_| |_|\__,_|_|\_\___|_| |_|_|\___|
#                                                            
# *****************************************

#
# Author: vjmadrid
# Last Change: March 1, 2020
# URL: 



# **********************************
# 			Makefile Setup
# **********************************

# Makefile Execution
#	* EXECUTION_INIT_DATE_MILISECONDS : Variable containing the start date of the Makefile execution in milliseconds

EXECUTION_INIT_DATE_MILISECONDS := $$(date +%s)



# Text Format
#	* Variables containing the constant values of the text format 

BOLD=`tput bold`
UNDERLINE_ON=`tput smul`
UNDERLINE_OFF=`tput rmul`



# Text Color 
#	* Variables containing the constant values of the text color 

TEXT_BLUE=`tput setaf 4`
TEXT_BLACK=`tput setaf 0`
TEXT_RED=`tput setaf 1`
TEXT_GREEN=`tput setaf 2`
TEXT_YELLOW=`tput setaf 3`
TEXT_BLUE=`tput setaf 4`
TEXT_MAGENTA=`tput setaf 5`
TEXT_CYAN=`tput setaf 6`
TEXT_WHITE=`tput setaf 7`

RESET_FORMATTING=`tput sgr0`



# **********************************
# 			OS Setup
# **********************************



# OS Setup
#	* OS_DETECTED : Variable containing the value of the operating system detected
#	* CCFLAGS : Variable containing details about the processor and operating system

ifeq ($(OS),Windows_NT)
    OS_DETECTED := Windows
else
    OS_DETECTED := $(shell uname)
endif

ifeq ($(OS),Windows_NT)

    CCFLAGS += -D WIN32
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        CCFLAGS += -D AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            CCFLAGS += -D AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            CCFLAGS += -D IA32
        endif
    endif
else

    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CCFLAGS += -D LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        CCFLAGS += -D OSX
    endif

    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        CCFLAGS += -D AMD64
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        CCFLAGS += -D IA32
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        CCFLAGS += -D ARM
    endif
endif



# Shell Setup
#	* SHELL : Shell used by the system
#	* SHELL : Control file of the shell used

SHELL := /bin/zsh
SHELL_FILE := ~/.zshrc



# **********************************
# 		Python Settings
# **********************************



# Python Settings
#	* PYTHON_PATH 				: Variable containing the installed Python path in the system
#	* PYTHON_VERSION 			: Variable containing the version of Python installed in the system (Python + Version)
#	* PYTHON_VERSION_NUMBER 	: Variable containing the version number of Python installed on the system
#	* PYTHON_VERSION_CODE		: Variable containing the code number of Python installed on the system (Remove '.' and generate value)

PYTHON_PATH := $(shell which python)
PYTHON_VERSION :=  $(shell python --version)
PYTHON_VERSION_NUMBER := $(shell python -c "import platform; print(platform.python_version())")
PYTHON_VERSION_CODE:= $(subst .,,$(PYTHON_VERSION_NUMBER))



# **********************************
# 		Virtual Env Settings
# **********************************


# Virtual Env Constants
#	* DEFAULT_VIRTUAL_ENV_NAME_PREFIX 	: Variable containing the default prefix of the Python environment name used with pyenv or virtualenv
#	* DEFAULT_VIRTUAL_ENV_NAME 			: Variable containing the default name of the Python environment name used with pyenv or virtualenv -> "DEFAULT_VIRTUAL_ENV_NAME_PREFIX + PYTHON_VERSION_NUMBER

DEFAULT_VIRTUAL_ENV_NAME_PREFIX = venv
DEFAULT_VIRTUAL_ENV_NAME = $(DEFAULT_VIRTUAL_ENV_NAME_PREFIX)$(PYTHON_VERSION_NUMBER)



# **********************************
# 		Pyenv Settings
# **********************************



# Pyenv Settings
#
# General Settings
#	* PYENV_ROOT 						: Variable containing the pyenv installation path (Added by pyenv) -> directory under which Python versions and shims reside
#	* PYENV_VERSION						: Variable containing Python version used (It is defined manually -> see pyenv shell)
#	* PYENV_DEBUG						: Variable that enables debug mode
#	* PYENV_SHELL 						: Variable containing the shell detected by the pyenv installation (Added by pyenv)
#	* PYENV_VIRTUALENV_INIT				:
#
# Pyenv Python Settings
#	* PYENV_PYTHON_ACTIVE_PATH			: Variable containing the path of the active Python installation managed by pyenv
#	* PYENV_PYTHON_ACTIVE_VERSION 		: Variable containing the version of the active Python installation managed by pyenv
#
# Python Version Settings
#	* PYENV_VERSIONS_PATH				: Variable containing the path of ALL the Python installations managed by pyenv
#	* PYENV_VERSION_ACTIVE_PATH			: Variable containing the path of the version of the active Python installation managed by pyenv
#
# Python Environments Settings for...
#	* PYENV_ENVS_ACTIVE_PATH			: Variable containing the path of ALL the environments defined for the version of the active Python installation managed by pyenv
#	* DEFAULT_PYENV_ENV_ACTIVE_PATH		: Variable containing the path of the environment used with the version of the active Python installation managed by pyenv
#	* PYENV_VERSION						: Variable containing the name of the Python environment activated for pyenv (Created when you run : pyenv activates XXX)
#	* PYENV_VIRTUAL_ENV					: Variable containing the path of the Python environment activated for pyenv
#	* PYENV_ACTIVATE_SHELL				: 

PYENV_PYTHON_ACTIVE_PATH := $(shell pyenv which python)
PYENV_PYTHON_ACTIVE_VERSION := $(shell pyenv version)

PYENV_VERSIONS_PATH := $(PYENV_ROOT)/versions
PYENV_VERSION_ACTIVE_PATH := $(PYENV_VERSIONS_PATH)/$(PYTHON_VERSION_NUMBER)

PYENV_ENVS_ACTIVE_PATH := $(PYENV_VERSION_ACTIVE_PATH)/envs

DEFAULT_PYENV_ENV_ACTIVE_PATH := $(PYENV_ENVS_ACTIVE_PATH)/$(DEFAULT_VIRTUAL_ENV_NAME)



# **********************************
# 	Virtual Environment Settings
# **********************************

# Virtual Environment Settings
#	* VIRTUAL_ENV_NAME 			: Variable containing the name of the Python environment name used with pyenv or virtualenv -> "DEFAULT_VIRTUAL_ENV_NAME_PREFIX + PYTHON_VERSION_NUMBER

VIRTUAL_ENV_NAME = $(DEFAULT_VIRTUAL_ENV_NAME)



# **********************************
# 		venv Settings
# **********************************

# Virtual Environment Settings
#	* VIRTUAL_ENV				: Variable containing the path of the Python environment activated for venv (Created when you run : venv activates XXX)
VENV_ACTIVE_PATH = $(VIRTUAL_ENV)



# **********************************
# 		Tools Settings
# **********************************



# Tools Settings
#	* MAKE_TOOL 			: Makefile Tool
#	* PYTHON_TOOL 			: Python Tool
#	* PYENV_TOOL 			: Pyenv Tool
#	* VIRTUALENV_TOOL		: VIRTUALENV Tool
#	* PACKAGE_TOOL 			: Package Tool
#	* TEST_TOOL 			: Unit Test Tool
#	* DOCKER_TOOL 			: Docker Tool

MAKE_TOOL = make
PYTHON_TOOL = python
PACKAGE_TOOL = pip
PYENV_TOOL = pyenv
VIRTUALENV_TOOL = virtualenv
TEST_TOOL = pytest
DOCKER_TOOL = docker



# Commands Settings
#	* MAKE_CMD 			: Tool execution command MAKE_TOOL
#	* PYTHON_CMD 		: Tool execution command PYTHON_TOOL
#	* PACKAGE_CMD 		: Tool execution command PACKAGE_TOOL
#	* PYENV_CMD 		: Tool execution command PYENV_TOOL
#	* VIRTUALENV_CMD 	: Tool execution command VIRTUALENV_TOOL
#	* TEST_CMD 			: Tool execution command TEST_TOOL
#	* DOCKER_CMD 		: Tool execution command DOCKER_TOOL


MAKE_CMD = $(MAKE_TOOL) --no-print-directory
PYTHON_CMD = $(PYTHON_TOOL)
PYENV_CMD = ${PYENV_TOOL}
VIRTUALENV_CMD = ${VIRTUALENV_TOOL}
PACKAGE_CMD = $(PYTHON_TOOL) -m $(PACKAGE_TOOL)
TEST_CMD = $(PYTHON_TOOL) -m $(TEST_TOOL)
DOCKER_CMD = ${DOCKER_TOOL}



# **********************************
# 			Project Settings
# **********************************


PROJECT_CURRENT_PATH := $(shell pwd)
PROJECT_NAME := $(shell basename $(PROJECT_CURRENT_PATH))
#VERSION := $(shell python -c "import sys; import $(MODULE); sys.stdout.write($(MODULE).__version__)")
#SOURCES := $(shell find $(MODULE) -name '*.py') #$(shell find $(MODULE) -name '*.py')

MODULE := acme



# **********************************
# 			Docker Settings
# **********************************

# Docker Settings
#	* DOCKER_PATH 				: Variable containing the installed Docker path in the system
#	* DOCKER_VERSION 			: Variable containing the version of Docker installed in the system (Python + Version)
#	* DOCKER_BUILD_CONTEXT 		: Tool execution command MAKE_TOOL
#	* DOCKER_FILE_PATH 			: Tool execution command MAKE_TOOL

DOCKER_PATH := $(shell which docker)
DOCKER_VERSION_NUMBER := $(shell docker --version)



# Docker Build Settings

DOCKER_BUILD_CONTEXT=.
DOCKER_FILE_NAME=Dockerfile
DOCKER_FILE_PATH=$(DOCKER_FILE_NAME)

TAG :=v1.0
DIRTY_TAG := $(shell git describe --tags --always --dirty)



# Docker Registry Settings

#DOCKER_REGISTRY=docker.pkg.github.com/acme/acme
DOCKER_REGISTRY=docker.pkg.github.com/acme/acme
DOCKER_IMAGE := $(DOCKER_REGISTRY)/$(MODULE)


TEST=KK

#  "    make install    install the package in a virtual environment"
#  "    make reset      recreate the virtual environment"
#  "    make check      check coding style (PEP-8, PEP-257)"
#  "    make test       run the test suite, report coverage"
#  "    make tox        run the tests on all Python versions"
#  "    make readme     update usage in readme"
#  "    make docs       update documentation using Sphinx"
#  "    make publish    publish changes to GitHub/PyPI"


# ***************************************
#  	  ____                           _ 
# 	 / ___| ___ _ __   ___ _ __ __ _| |
#	| |  _ / _ \ '_ \ / _ \ '__/ _` | |
#	| |_| |  __/ | | |  __/ | | (_| | |
#	 \____|\___|_| |_|\___|_|  \__,_|_|
#
# ***************************************



test-condition:
	@echo $(TEST)

	@if [ "$(TEST)" = "ON" ]; then echo "PASO1 PASSED"; else echo "PASO1 FAILED"; fi
	
	@if [ "$(TEST)" = "ON" ]; then \
		echo "PASO2 PASSED"; \
	else \
		echo "PASO2 FAILED"; \
	fi

ifeq ($(TEST),ON)
	@echo "EXTERNO PASSED"
else
	@echo "EXTERNO FAILED"
endif



# **********************************
# 		check_environment_variable
# **********************************

# *** check_environment_variable : check if environment variable exist ***
check_environment_variable:
ifdef $(ARG_ENV_VAR)
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t* Check $(ARG_ENV_VAR) Environment Var -> ${TEXT_GREEN}$($(ARG_ENV_VAR))${RESET_FORMATTING}"
else
	
ifeq ($(ARG_TYPE),ERROR)
	@echo -e "[${TEXT_RED}ERROR${RESET_FORMATTING}]\t* Check $(ARG_ENV_VAR) Environment Var -> ${TEXT_RED}$(ARG_ENV_VAR) is undefined${RESET_FORMATTING}"
	@exit 1
endif

ifeq ($(ARG_TYPE),WARN)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check $(ARG_ENV_VAR) Environment Var -> ${TEXT_YELLOW}$(ARG_ENV_VAR) is undefined${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t* Check $(ARG_ENV_VAR) Environment Var -> ${TEXT_GREEN}$(ARG_ENV_VAR) is undefined${RESET_FORMATTING}"
endif

endif



# **********************************
# 		check_argument
# **********************************

# *** check_argument : check if argument exist ***
check_argument:
ifeq ($(ARG_PARAMETER),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_PARAMETER Argument -> ${TEXT_YELLOW}ARG_PARAMETER is undefined${RESET_FORMATTING}"
else

ifeq ($($(ARG_PARAMETER)),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check $(ARG_PARAMETER) Argument -> ${TEXT_YELLOW}$(ARG_PARAMETER) is undefined${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t* Check $(ARG_PARAMETER) Argument -> ${TEXT_GREEN}$($(ARG_PARAMETER))${RESET_FORMATTING}"
endif
	
endif



# *****************************************************
#	  _____                    _       _            
# 	 |_   _|__ _ __ ___  _ __ | | __ _| |_ ___  ___ 
#	   | |/ _ \ '_ ` _ \| '_ \| |/ _` | __/ _ \/ __|
#	   | |  __/ | | | | | |_) | | (_| | ||  __/\__ \
#	   |_|\___|_| |_| |_| .__/|_|\__,_|\__\___||___/
#                    |_|                       
# *****************************************************



# **********************************
# 		initial-template
# **********************************

# *** initial-template : initial template ***
initial-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Scanning for project..."
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ---< ${TEXT_CYAN}${PROJECT_NAME}${RESET_FORMATTING} >---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Project Current Path\t : ${TEXT_GREEN}$(PROJECT_CURRENT_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Project Name\t\t : ${TEXT_GREEN}$(PROJECT_NAME)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"



# **********************************
# 		end-template
# **********************************

# *** end-template : end template ***
# * EXECUTION_END_DATE : Variable containing the end date of the execution of the makefile
# * EXECUTION_INIT_DATE_MILISECONDS : Variable containing the end date of the Makefile execution in milliseconds
EXECUTION_END_DATE := $(shell date)
EXECUTION_END_DATE_MILISECONDS := $$(date +%s)

end-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}BUILD SUCCESS${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Init : $(EXECUTION_INIT_DATE_MILISECONDS) s"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] End : $(EXECUTION_END_DATE_MILISECONDS) s"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Total time: $$((EXECUTION_END_DATE_MILISECONDS-EXECUTION_INIT_DATE_MILISECONDS)) s"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Finished at: $(EXECUTION_END_DATE)"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"





# *****************************************
# 			 ___        __       
#			|_ _|_ __  / _| ___  
# 		 	 | || '_ \| |_ / _ \ 
# 		 	 | || | | |  _| (_) |
#			|___|_| |_|_|  \___/ 
#
# *****************************************



# **********************************
# 		help
# **********************************

# *** help : show help info ***
help:
	@echo -e ""
	@echo -e "Usage: make [<goal>]"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}info${RESET_FORMATTING}\t\t\t\t show ALL info"
	@echo -e ""
	@$(MAKE_CMD) help-os-goals
	@echo -e ""
	@$(MAKE_CMD) help-python-goals
	@echo -e ""
	@$(MAKE_CMD) help-pyenv-goals
	@echo -e ""
	@$(MAKE_CMD) help-pyenv-venv-goals
	@echo -e ""
	@$(MAKE_CMD) help-venv-goals
	@echo -e ""
	@$(MAKE_CMD) help-general-goals
	@echo -e ""
	@$(MAKE_CMD) help-test-goals
	@echo -e ""
	@$(MAKE_CMD) help-qa-goals
	@echo -e ""
	@$(MAKE_CMD) help-docker-goals 
	@echo -e ""



# **********************************
# 		info
# **********************************

# *** info ***
info: initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:info${RESET_FORMATTING} ${BOLD}(default-info)${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) info-os-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) info-python-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@$(MAKE_CMD) info-venv-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@$(MAKE_CMD) info-pyenv-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@$(MAKE_CMD) info-docker-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@$(MAKE_CMD) end-template





# *****************************************
#
#		   ___  ____  
#		  / _ \/ ___| 
#		 | | | \___ \ 
#		 | |_| |___) |
#		  \___/|____/ 
#              
# *****************************************



# **********************************
# 		help-os-goals
# **********************************

# *** help-os-goals : Help OS goals ***
help-os-goals:
	@echo -e "OS Goals:"
	@echo -e "\t${TEXT_GREEN}info-os${RESET_FORMATTING}\t\t\t\t show OS information"



# **********************************
# 		info-os 
# **********************************

# *** info-os-template : Common Template OS Setting Info***
info-os-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:info-os${RESET_FORMATTING} ${BOLD}(default-info-os)${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] OS Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Shell \t: ${TEXT_GREEN}$(SHELL)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Shell File \t: ${TEXT_GREEN}$(SHELL_FILE)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- OS \t\t: ${TEXT_GREEN}$(OS_DETECTED)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- CCFLAGS \t: ${TEXT_GREEN}$(CCFLAGS)${RESET_FORMATTING}"

# *** info-os : OS Setting Info***
info-os: initial-template
	@$(MAKE_CMD) info-os-template
	@$(MAKE_CMD) end-template





# *****************************************
# 	 ____        _   _                 
# 	|  _ \ _   _| |_| |__   ___  _ __  
# 	| |_) | | | | __| '_ \ / _ \| '_ \ 
# 	|  __/| |_| | |_| | | | (_) | | | |
# 	|_|    \__, |\__|_| |_|\___/|_| |_|
#      		|___/                       
#
# *****************************************



# **********************************
# 		help-python-goals
# **********************************

# *** help-python-goals : Help Python goals***
help-python-goals:
	@echo -e "Python Goals:"
	@echo -e "\t${TEXT_GREEN}info-python${RESET_FORMATTING}\t\t\t show python information"
	@echo -e "\t${TEXT_GREEN}upgrade-pip${RESET_FORMATTING}\t\t\t upgrade pip"



# **********************************
# 		info-python
# **********************************

# *** info-python-template : Common Template Python Setting Info***
info-python-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:info-python${RESET_FORMATTING} ${BOLD}(default-info-python)${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Python Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Python Path \t\t\t: ${TEXT_GREEN}$(PYTHON_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Python Version \t\t: ${TEXT_GREEN}$(PYTHON_VERSION)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Python Version Number \t: ${TEXT_GREEN}$(PYTHON_VERSION_NUMBER)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Python Version Code \t\t: ${TEXT_GREEN}$(PYTHON_VERSION_CODE)${RESET_FORMATTING}"

# *** info-python : Goal OS Setting Info***
info-python: initial-template
	@$(MAKE_CMD) info-python-template
	@$(MAKE_CMD) end-template



# **********************************
# 		upgrade-pip
# **********************************

info-upgrade-pip-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Upgrade pip in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}$(PACKAGE_CMD) install --upgrade $(PACKAGE_TOOL)${RESET_FORMATTING}"

# *** upgrade-pip : Upgrade pip***
upgrade-pip:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:upgrade-pip${RESET_FORMATTING} ${BOLD}(upgrade-pip)${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Upgrade pip -> ${TEXT_GREEN}$(PACKAGE_CMD) install --upgrade $(PACKAGE_TOOL)${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install --upgrade $(PACKAGE_TOOL)



# *****************************************
#  		____                        
# 		|  _ \ _   _  ___ _ ____   __
# 		| |_) | | | |/ _ \ '_ \ \ / /
# 		|  __/| |_| |  __/ | | \ V / 
# 		|_|    \__, |\___|_| |_|\_/  
#        		|___/                 
#
# *****************************************



# **********************************
# 		help-pyenv-goals
# **********************************

# *** help-pyenv-goals : Help Pyenv goals***
help-pyenv-goals:
	@echo -e "Pyenv Goals:"
	@echo -e "\t${TEXT_GREEN}info-pyenv${RESET_FORMATTING}\t\t\t show pyenv information"
	@echo -e "\t${TEXT_GREEN}check-pyenv${RESET_FORMATTING}\t\t\t check the validity of the execution environment for the use of pyenv"


# **********************************
# 		help-pyenv-venv-goals
# **********************************

# *** help-pyenv-venv-goals : Help Pyenv venv goals***
help-pyenv-venv-goals:
	@echo -e "Pyenv Venv Goals:"
	@echo -e "\t${TEXT_GREEN}show-pyenv-venv${RESET_FORMATTING}\t\t\t show available virtual environments for pyenv use"
	@echo -e "\t${TEXT_GREEN}create-pyenv-venv${RESET_FORMATTING}\t\t create virtual environment for pyenv use"
	@echo -e "\t${TEXT_GREEN}destroy-pyenv-venv${RESET_FORMATTING}\t\t destroy virtual environment for pyenv use"



# **********************************
# 		info-pyenv
# **********************************

info-pyenv-template-general-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] General Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_ROOT \t\t\t: ${TEXT_GREEN}$(PYENV_ROOT)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_VERSION \t\t: ${TEXT_GREEN}$(PYENV_VERSION)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_SHELL \t\t\t: ${TEXT_GREEN}$(PYENV_SHELL)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_VIRTUALENV_INIT \t: ${TEXT_GREEN}$(PYENV_VIRTUALENV_INIT)${RESET_FORMATTING}"

info-pyenv-template-python-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Pyenv Python Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Python Active Path \t\t: ${TEXT_GREEN}$(PYENV_PYTHON_ACTIVE_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Version Python Active \t: ${TEXT_GREEN}$(PYENV_PYTHON_ACTIVE_VERSION)${RESET_FORMATTING}"

info-pyenv-template-python-version-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Python Version Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Versions Path \t\t: ${TEXT_GREEN}$(PYENV_VERSIONS_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Version Active Path \t\t: ${TEXT_GREEN}$(PYENV_VERSION_ACTIVE_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Envs Path \t\t\t: ${TEXT_GREEN}$(PYENV_ENVS_ACTIVE_PATH)${RESET_FORMATTING}"

info-pyenv-template-python-venv-active-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Python Pyenv Virtual Environment Active Settings"

ifndef PYENV_VERSION
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t- PYENV_VERSION \t\t: ${TEXT_YELLOW}PYENV_VERSION is undefined${RESET_FORMATTING}"
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]"
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t ${TEXT_YELLOW}No Python Pyenv Virtual Environment is activated${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_VERSION \t\t: ${TEXT_GREEN}$(PYENV_VERSION)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_VIRTUAL_ENV \t\t: ${TEXT_GREEN}$(PYENV_VIRTUAL_ENV)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- PYENV_ACTIVATE_SHELL \t\t: ${TEXT_GREEN}$(PYENV_ACTIVATE_SHELL)${RESET_FORMATTING}"
endif

info-pyenv-template-information:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Information"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}$(PYENV_CMD)${RESET_FORMATTING} determines which Python version to use by reading from the following sources (order) :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t 1)Use ${TEXT_CYAN}PYENV_VERSION${RESET_FORMATTING} environment variable (if specified)"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t\t * Define PYENV_VERSION in the Case "Shell with Version" -> use ${TEXT_GREEN}$(PYENV_CMD) shell <version-installed>?${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t\t * Define PYENV_VERSION in the Case "Default Shell" (python version active) -> use ${TEXT_GREEN}$(PYENV_CMD) shell <version-installed>${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t 2)Use application-specific ${RESET_FORMATTING}.python-version${RESET_FORMATTING} file in the ${RESET_FORMATTING}current directory${RESET_FORMATTING} (if present) -> ${TEXT_GREEN}pyenv local${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t 3)Use ${TEXT_CYAN}.python-version${RESET_FORMATTING} file found (if any) by searching each ${RESET_FORMATTING}parent directory${RESET_FORMATTING}, until reaching the root of your filesystem"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t 4)Use global ${TEXT_CYAN}'$(pyenv root)'/version${RESET_FORMATTING} file -> ${TEXT_GREEN}use $(PYENV_CMD) global${RESET_FORMATTING}"

# *** info-pyenv-template : Common Template Pyenv Setting Info***
info-pyenv-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:info-pyenv${RESET_FORMATTING} ${BOLD}(default-info-pyenv)${RESET_FORMATTING} ---"

ifdef PYENV_ROOT
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-pyenv-template-general-settings
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-pyenv-template-python-settings
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-pyenv-template-python-version-settings

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-pyenv-template-python-venv-active-settings
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-pyenv-template-information
else
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\tPyenv is not installed"
endif

# *** info-pyenv : Pyenv Setting Info***
info-pyenv: initial-template
	@$(MAKE_CMD) info-pyenv-template
	@$(MAKE_CMD) end-template



# **********************************
# 		check-pyenv
# **********************************

# *** check-pyenv-common : check the validity of the execution environment for the use of pyenv (common part)***
check-pyenv-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:check-venv-pyenv${RESET_FORMATTING} ${BOLD}(default-clean-venv-pyenv)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Check environment variables :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_ROOT ARG_TYPE=ERROR
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_SHELL ARG_TYPE=ERROR
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_VERSION ARG_TYPE=WARN

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Results :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}The execution environment for the use of pyenv is SUCCESS${RESET_FORMATTING}"

# *** check-pyenv : check the validity of the execution environment for the use of pyenv***
check-pyenv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) check-pyenv-common
	@$(MAKE_CMD) end-template



# **********************************
# 		show-pyenv-venv
# **********************************

# *** show-pyenv-venv : show available virtual environments for pyenv use***
NUM_AVAILABLE_PYENV_ENVIROMENTS := $(shell ls $(PYENV_ENVS_ACTIVE_PATH) | wc -l | sed -e 's/^[ \t]*//')

show-pyenv-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) check-pyenv-common
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:show-pyenv-venv${RESET_FORMATTING} ${BOLD}(default-show-pyenv-venv)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Pyenv Virtual Environments \t-> ${TEXT_GREEN}$(PYENV_CMD) virtualenvs${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(PYENV_CMD) virtualenvs

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show available Pyenv Virtual Environments  -> ${TEXT_GREEN}ls $(PYENV_ENVS_ACTIVE_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

ifeq ($(NUM_AVAILABLE_PYENV_ENVIROMENTS),0)
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Pyenv Virtual Environments not exist"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] $(shell ls $(PYENV_ENVS_ACTIVE_PATH))"
endif

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
ifdef PYENV_VERSION
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Active Pyenv Virtual Environments \t-> ${TEXT_GREEN}$(PYENV_VERSION)${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}] Show Active Pyenv Virtual Environments \t-> ${TEXT_YELLOW}Pyenv Virtual Environment is not active${RESET_FORMATTING}"
endif

	@$(MAKE_CMD) end-template



# **********************************
# 		create-pyenv-venv
# **********************************

# *** create-pyenv-venv-common : install virtual environment for pyenv use (common part)***
create-pyenv-venv-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:create-pyenv-venv${RESET_FORMATTING} ${BOLD}(default-create-pyenv-venv)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Select Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Create Pyenv Virtual Environment -> ${TEXT_GREEN}$(PYENV_CMD) ${VIRTUALENV_TOOL} $(PYTHON_VERSION_NUMBER) $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(PYENV_CMD) ${VIRTUALENV_TOOL} $(PYTHON_VERSION_NUMBER) $(VIRTUAL_ENV_NAME)

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Activate the Virtual Environment in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}$(PYENV_CMD) activate $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

# *** create-pyenv-venv : create virtual environment for pyenv use***
create-pyenv-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) create-pyenv-venv-common
	@$(MAKE_CMD) end-template



# **********************************
# 		destroy-pyenv-venv
# **********************************

# *** destroy-pyenv-venv-common : destroy virtual environment for pyenv use (common part)***
destroy-pyenv-venv-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:destroy-pyenv-venv${RESET_FORMATTING} ${BOLD}(default-destroy-pyenv-venv)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Pyenv Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
ifdef PYENV_VERSION
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Active Pyenv Virtual Environments \t-> ${TEXT_GREEN}$(PYENV_VERSION)${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Deactivate the Virtual Environment in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}$(PYENV_CMD) deactivate ${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Then run this target again :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make destroy-pyenv-venv${RESET_FORMATTING}"

else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Active Pyenv Virtual Environments \t-> ${TEXT_GREEN}Pyenv Virtual Environment is not active${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Uninstall Pyenv Virtual Environment -> ${TEXT_GREEN}$(PYENV_CMD) uninstall -f $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@$(PYENV_CMD) uninstall -f $(VIRTUAL_ENV_NAME)

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Results :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}Destroy Pyenv Virtual Environment is SUCCESS${RESET_FORMATTING}"
endif

# *** destroy-pyenv-venv : destroy virtual environment for pyenv use***
destroy-pyenv-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) destroy-pyenv-venv-common
	@$(MAKE_CMD) end-template





# *****************************************
# 		 __     __              
# 		 \ \   / /__ _ ____   __
#  		  \ \ / / _ \ '_ \ \ / /
#   	   \ V /  __/ | | \ V / 
#    		\_/ \___|_| |_|\_/  
#
# *****************************************



# **********************************
# 		help-venv-goals
# **********************************

# *** help-venv-goals : venv goals ***
help-venv-goals:
	@echo -e "Venv Goals:"
	@echo -e "\t${TEXT_GREEN}info-venv${RESET_FORMATTING}\t\t\t show venv information"
	@echo -e "\t${TEXT_GREEN}check-venv${RESET_FORMATTING}\t\t\t check the validity of the execution environment for the use of venv"
	@echo -e "\t${TEXT_GREEN}create-venv${RESET_FORMATTING}\t\t\t create virtual environment for venv use"
	@echo -e "\t${TEXT_GREEN}destroy-venv${RESET_FORMATTING}\t\t\t destroy virtual environment for venv use"



# **********************************
# 		info-venv
# **********************************

# *** info-venv-template : Common Template Venv Setting Info***
info-venv-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:info-venv${RESET_FORMATTING} ${BOLD}(default-info-venv)${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Virtual Env"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Virtual Env Default Name Prefix \t: ${TEXT_GREEN}$(DEFAULT_VIRTUAL_ENV_NAME_PREFIX)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Virtual Env Default Name \t\t: ${TEXT_GREEN}$(DEFAULT_VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

# *** info-venv : Goal Venv Setting Info***
info-venv: initial-template
	@$(MAKE_CMD) info-venv-template
	@$(MAKE_CMD) end-template



# **********************************
# 		check-venv
# **********************************

info-venv-active-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Activate the Virtual Environment in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

ifeq ($(OS_DETECTED),Windows)
    @echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\tDefault : ${TEXT_GREEN}C:>$(VIRTUAL_ENV_NAME)/Scripts/activate.bat${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\tPowershell : ${TEXT_GREEN}C:>$(VIRTUAL_ENV_NAME)/Scripts/Activate.ps1${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}source $(VIRTUAL_ENV_NAME)/bin/activate${RESET_FORMATTING}"
endif



# *** check-venv-common : check the validity of the execution environment for the use of venv (common part)***
check-venv-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:check-venv${RESET_FORMATTING} ${BOLD}(default-check-venv)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@if [ $(PYTHON_VERSION_CODE) -gt 360 ]; then \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Verify that your Python version is higher than 3.6.0 -> ${TEXT_GREEN}$(PYTHON_VERSION_NUMBER)${RESET_FORMATTING}"; \
	else \
		echo -e "[${TEXT_RED}ERROR${RESET_FORMATTING}] Verify that your Python version is higher than 3.6.0 -> ${TEXT_YELLOW}$(PYTHON_VERSION_NUMBER) is invalid${RESET_FORMATTING}"; \
		exit 1; \
	fi

ifdef PYENV_VERSION
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}] Check if there is a virtual environment created for pyenv -> ${TEXT_YELLOW}$(PYENV_VERSION) is defined${RESET_FORMATTING}"
	exit 1
endif

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@if [ -d "./$(DEFAULT_VIRTUAL_ENV_NAME)" ]; then \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Check if exist venv directory -> ${TEXT_GREEN}$(DEFAULT_VIRTUAL_ENV_NAME) exist${RESET_FORMATTING}"; \
	else \
		echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}] Check if exist venv directory -> ${TEXT_YELLOW}$(DEFAULT_VIRTUAL_ENV_NAME) NO exist${RESET_FORMATTING}"; \
	fi \

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Check environment variables :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=VIRTUAL_ENV ARG_TYPE=WARN
ifndef VIRTUAL_ENV

	@if [ -d "./$(DEFAULT_VIRTUAL_ENV_NAME)" ]; then \
		$(MAKE_CMD) info-venv-active-template; \
	else \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Create the Virtual Environment in your local shell require manual run :"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make create-venv${RESET_FORMATTING}"; \
	fi \

else

	@if [ -d "./$(DEFAULT_VIRTUAL_ENV_NAME)" ]; then \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Results :"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}The execution environment for the use of venv is SUCCESS${RESET_FORMATTING}"; \
	else \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Create the Virtual Environment in your local shell require manual run :"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"; \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make create-venv${RESET_FORMATTING}"; \
	fi \

endif



# *** check-venv : check the validity of the execution environment for the use of venv***
check-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) check-venv-common
	@$(MAKE_CMD) end-template



# **********************************
# 		create-venv
# **********************************

# *** create-venv-common : create virtual environment for venv use (common part)***
create-venv-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:create-venv${RESET_FORMATTING} ${BOLD}(default-create-venv)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Select Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Create Venv Virtual Environment -> ${TEXT_GREEN}$(PYTHON_CMD) -m venv $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@$(PYTHON_CMD) -m venv $(VIRTUAL_ENV_NAME)

	@$(MAKE_CMD) info-venv-active-template

	@$(MAKE_CMD) info-upgrade-pip-template



# *** create-venv : create virtual environment for venv use***
create-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) create-venv-common
	@$(MAKE_CMD) end-template




# **********************************
# 		destroy-venv
# **********************************

# *** destroy-venv-common : destroy virtual environment for venv use (common part)***
destroy-venv-common:
	@echo "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:destroy-venv ${RESET_FORMATTING} ${BOLD}(default-destroy-venv )${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Pyenv Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
ifdef VIRTUAL_ENV
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Active Pyenv Virtual Environments \t-> ${TEXT_GREEN}$(VIRTUAL_ENV)${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] To Deactivate the Virtual Environment in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

ifeq ($(OS_DETECTED),Windows)
    @echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\tDefault : ${TEXT_GREEN}C:>$(VIRTUAL_ENV_NAME)/Scripts/deactivate.bat${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\Powershell : ${TEXT_GREEN}C:>$(VIRTUAL_ENV_NAME)/Scripts/Deactivate.ps1${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}source deactivate${RESET_FORMATTING}"
endif

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Then run this target again :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make destroy-venv${RESET_FORMATTING}"

else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Active Venv Virtual Environments \t-> ${TEXT_GREEN}Venv Virtual Environment is not active${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Delete Venv Virtual Environment -> ${TEXT_GREEN}rm -r $(VIRTUAL_ENV_NAME)/${RESET_FORMATTING}"
	@rm -r $(VIRTUAL_ENV_NAME)/

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Results :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}Destroy Venv Virtual Environment is SUCCESS${RESET_FORMATTING}"
endif

# *** destroy-venv : destroy virtual environment for venv use***
destroy-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) destroy-venv-common
	@$(MAKE_CMD) end-template





# *****************************************
#   		 ____             _     
#  			/ ___| ___   __ _| |___ 
# 		   | |  _ / _ \ / _` | / __|
# 		   | |_| | (_) | (_| | \__ \
#  			\____|\___/ \__,_|_|___/
#                          
# *****************************************



# **********************************
# 		help-general-goals
# **********************************

# *** help-general-goals : General goals ***
help-general-goals:
	@echo -e "General Goals:"
	@echo -e "\t${TEXT_GREEN}info${RESET_FORMATTING}\t\t\t\t show project info"
	@echo -e "\t${TEXT_GREEN}clean${RESET_FORMATTING}\t\t\t\t cleanup all temporary files"
	@echo -e "\t${TEXT_GREEN}freeze ${RESET_FORMATTING}\t\t\t\t write the requirements to file"



# **********************************
# 		clean
# **********************************

# *** clean : cleanup all temporary files ***
clean:
	@$(MAKE_CMD) initial-template
	@echo "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:clean${RESET_FORMATTING} ${BOLD}(default-clean)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@rm -rf .pytest_cache **/__pycache__ .coverage coverage.xml build dist
	@$(MAKE_CMD) end-template



# **********************************
# 		freeze
# **********************************

# *** freeze : write the requirements to file ***
freeze:
	@$(MAKE_CMD) initial-template
	@echo "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:freeze${RESET_FORMATTING} ${BOLD}(default-freeze)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@$(PACKAGE_TOOL) freeze > requirements.txt
	@$(MAKE_CMD) end-template



# **********************************
# 		install
# **********************************

# *** install ***
install:
	@$(MAKE_CMD) initial-template
	@echo "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:install${RESET_FORMATTING} ${BOLD}(default-install)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@${PACKAGE_CMD} install -r requirements.txt
	# @${PACKAGE_CMD} install -e .
	@$(MAKE_CMD) end-template



# **********************************
# 		run
# **********************************

# *** run ***
run: clean
	@$(MAKE_CMD) initial-template
	@echo "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:run${RESET_FORMATTING} ${BOLD}(default-run)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@python -m flask run
	@$(MAKE_CMD) end-template




# *****************************************
#		   _____         _   
# 		  |_   _|__  ___| |_ 
# 	  		| |/ _ \/ __| __|
#		   	| |  __/\__ \ |_ 
#		   	|_|\___||___/\__|
#                    
# *****************************************



# **********************************
# 		help-test-goals
# **********************************

# *** help-test-goals : Test goals ***
help-test-goals:
	@echo -e "Test Goals:"
	@echo -e "\t${TEXT_GREEN}install-test-technology-stack${RESET_FORMATTING}\t install the testing technology stack selected for the version of Python used"



# **********************************
# 	install-test-technology-stack
# **********************************

# *** install-test-technology-stack : Install the testing technology stack selected for the version of Python used ***
install-test-technology-stack:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) upgrade-pip
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:install-test-technology-stack${RESET_FORMATTING} ${BOLD}(default-install-test-technology-stack)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Install package "pytest" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pytest${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install pytest

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Install package "pytest-xdist" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pytest-xdist${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install pytest-xdist

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Install package "pytest-cov" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pytest-cov${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install pytest-cov



# **********************************
# 		test
# **********************************

# *** test : Test goals ***
test:
	@$(MAKE_CMD) initial-template
	@echo "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:test${RESET_FORMATTING} ${BOLD}(default-test)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@pytest





# **********************************		
#		   ___      _    
#		  / _ \    / \   
#		 | | | |  / _ \  
#		 | |_| | / ___ \ 
#		  \__\_\/_/   \_\
#                 
# **********************************



# **********************************
# 		help-qa-goals 
# **********************************

# *** help-qa-goals : QA goals ***
help-qa-goals:
	@echo -e "QA Goals:"
	@echo -e "\t${TEXT_GREEN}install-qa-technology-stack${RESET_FORMATTING}\t install the QA technology stack selected for the version of Python used"
	@echo -e "\t${TEXT_GREEN}xxx${RESET_FORMATTING}\t\t\t xxx"



# **********************************
# 	install-qa-technology-stack
# **********************************

# *** install-qa-technology-stack : Install the QA technology stack selected for the version of Python used ***
install-qa-technology-stack:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) upgrade-pip
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:install-qa-technology-stack${RESET_FORMATTING} ${BOLD}(default-install-qa-technology-stack)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Install package "flake8" -> ${TEXT_GREEN}$(PACKAGE_CMD) install flake8${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install flake8

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Install package "pylint" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pylint${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install pylint

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Install package "bandit" -> ${TEXT_GREEN}$(PACKAGE_CMD) install bandit${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install bandit



# **********************************
# 		pylint
# **********************************

# *** pylint-common : xxx  (common part)***
pylint-common: 
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- Executing ${TEXT_GREEN}makefile:pylint${RESET_FORMATTING} ${BOLD}(default-pylint)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@pylint --rcfile=setup.cfg **/*.py

# *** pylint : xxx ***
pylint:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) pylint-common
	@$(MAKE_CMD) end-template



# **********************************
# 		bandit
# **********************************

# *** bandit-common : xxx  (common part)***
bandit-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- Executing ${TEXT_GREEN}makefile:bandit${RESET_FORMATTING} ${BOLD}(default-bandit)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@bandit -r --ini setup.cfg

# *** bandit : xxx ***
bandit:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) bandit-common
	@$(MAKE_CMD) end-template


# **********************************
# 		flake8
# **********************************

# *** bandit-common : xxx  (flake8 part)***
flake8-common:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- Executing ${TEXT_GREEN}makefile:flake8${RESET_FORMATTING} ${BOLD}(default-flake8)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@flake8

# *** flake8 : xxx ***
flake8:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) flake8-common
	@$(MAKE_CMD) end-template



# **********************************
# 		lint
# **********************************

# *** lint ***
lint:
	@$(MAKE_CMD) initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:lint${RESET_FORMATTING} ${BOLD}(default-lint)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) flake8-common

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) pylint-common

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) bandit-common
	

	@$(MAKE_CMD) end-template






# **********************************		
# 	 ____             _             
#	|  _ \  ___   ___| | _____ _ __ 
#	| | | |/ _ \ / __| |/ / _ \ '__|
#	| |_| | (_) | (__|   <  __/ |   
#	|____/ \___/ \___|_|\_\___|_|   
#
# **********************************



# **********************************
# 		help-docker-goals 
# **********************************

# *** help-docker-goals : Docker goals ***
help-docker-goals:
	@echo -e "Docker Goals:"
	@echo -e "\t${TEXT_GREEN}clean-docker${RESET_FORMATTING}\t\t\t xxx"
	@echo -e "\t${TEXT_GREEN}build-docker-dev${RESET_FORMATTING}\t\t xxx"



# **********************************
# 		info-docker 
# **********************************



# *** info-docker-template : Common Template Docker Setting Info***
info-docker-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Docker Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Docker Path \t\t\t: ${TEXT_GREEN}$(DOCKER_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Docker Version \t\t: ${TEXT_GREEN}$(DOCKER_VERSION_NUMBER)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_BUILD_CONTEXT \t\t: ${TEXT_GREEN}$(DOCKER_BUILD_CONTEXT)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_FILE_PATH \t\t: ${TEXT_GREEN}$(DOCKER_FILE_PATH)${RESET_FORMATTING}"

info-docker-template-registry:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Docker Registry Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_REGISTRY \t\t: ${TEXT_GREEN}$(DOCKER_REGISTRY)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_IMAGE \t\t\t: ${TEXT_GREEN}$(DOCKER_IMAGE)${RESET_FORMATTING}"

info-docker-template-build:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Build Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Module \t\t\t: ${TEXT_GREEN}$(MODULE)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Tag \t\t\t\t: ${TEXT_GREEN}$(TAG)${RESET_FORMATTING}"

# *** info-docker : Docker Setting Info***
info-docker: initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:info-docker${RESET_FORMATTING} ${BOLD}(default-info-docker)${RESET_FORMATTING} ---"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-docker-template

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-docker-template-build

	
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-docker-template-registry

	
	
	@$(MAKE_CMD) end-template



# **********************************
# 		clean-docker 
# **********************************



# *** clean-docker : Docker goals ***
clean-docker:
	@$(MAKE_CMD) initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:clean-docker${RESET_FORMATTING} ${BOLD}(default-clean-docker)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@$(DOCKER_CMD) system prune -f --filter "label=name=$(MODULE)"
	@$(MAKE_CMD) end-template



# **********************************
# 		build-docker-dev
# **********************************


# *** build-docker-dev-use-template : info template for the use ***
build-docker-dev-use-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Use :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make build-docker-dev-sue-template NAME=<NAME> VERSION=<VERSION> ${RESET_FORMATTING}";
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Case :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] make build-docker-dev-sue-template NAME=project-x VERSION=1.0.0"

# *** build-docker-dev : Docker goals ***
# # make build-dev NAME=victor VERSION=1.0.0
build-docker-dev:
	@$(MAKE_CMD) initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:build-docker-dev${RESET_FORMATTING} ${BOLD}(default-build-docker-dev)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-docker-template-build

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Check arguments :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) check_argument ARG_PARAMETER=NAME
	@$(MAKE_CMD) check_argument ARG_PARAMETER=VERSION

ifdef NAME
ifdef VERSION
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Building Development image with labels -> ${TEXT_GREEN}$(DOCKER_CMD) build -t $(DOCKER_IMAGE):$(TAG) -f dev.Dockerfile${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	#@sed                                 \ 
	#	-e 's|{NAME}|$(MODULE)|g'        \
	#	-e 's|{VERSION}|$(TAG)|g'        \
	#	dev.Dockerfile | $(DOCKER_CMD) build -t $(DOCKER_IMAGE):$(TAG) -f- .
else
	@$(MAKE_CMD) build-docker-dev-use-template
endif
else
	@$(MAKE_CMD) build-docker-dev-use-template
endif

	
	
	@$(MAKE_CMD) end-template



# **********************************
# 		build-docker-prod
# **********************************


# *** build-docker-prod : Docker goals ***
build-docker-prod:
	@$(MAKE_CMD) initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:build-docker-prod${RESET_FORMATTING} ${BOLD}(default-build-docker-prod)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Pushing image to GitHub Docker Registry -> ${TEXT_GREEN}$(DOCKER_CMD) push $(IMAGE):$(VERSION)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(DOCKER_CMD) push $(IMAGE):$(VERSION)







# **********************************		
#		  _  _____ ____  
#		 | |/ ( _ ) ___| 
#		 | ' // _ \___ \ 
#		 | . \ (_) |__) |
#		 |_|\_\___/____/ 
#                 
# **********************************







.PHONY: clean test
