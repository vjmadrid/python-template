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



MODULE := projectx

TAG :=v1.0
DIRTY_TAG := $(shell git describe --tags --always --dirty)

DOCKER_REGISTRY=docker.pkg.github.com/acme/projectx
DOCKER_IMAGE := $(DOCKER_REGISTRY)/$(MODULE)

IMAGE_PYTHON_DEV=3.9.0-buster



# **********************************
# 			Makefile Setup
# **********************************

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



# Pip Settings
#	* PIP_PATH 				: Variable containing the installed Pip path in the system
#	* PIP_VERSION 			: Variable containing the version of Pip installed in the system (pip + Version)

PIP_PATH := $(shell which pip)
PIP_VERSION :=  $(shell pip --version)



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



# **********************************
# 			Docker Settings
# **********************************

# Docker Settings
#	* DOCKER_PATH 				: Variable containing the installed Docker path in the system
#	* DOCKER_VERSION 			: Variable containing the version of Docker installed in the system (Python + Version)

DOCKER_PATH := $(shell which docker)
DOCKER_VERSION_NUMBER := $(shell docker --version)



# Docker Build Settings
#	* DOCKER_BUILD_CONTEXT 		: Docker execution context
#	* DOCKER_FILE_NAME 			: Name of the docker construction file (Default)

DOCKER_BUILD_CONTEXT=.
DOCKER_FILE_NAME=Dockerfile



# Image / Container Settings
#	* BASE_DOCKER_FILE_NAME 		: Name used in the file for the construction of the Docker base image
#	* BASE_DOCKER_IMAGE_NAME 		: Name "Tag" of the image used for the Docker base image
#	* DEV_DOCKER_FILE_NAME 			: Name used in the file for the construction of the Docker dev image
#	* DEV_DOCKER_IMAGE 				: Name "Tag" of the image used for the Docker dev image
#	* PRO_DOCKER_FILE_NAME 			: Name used in the file for the construction of the Docker pro image
#	* PRO_DOCKER_IMAGE 				: Name "Tag" of the image used for the Docker pro image

BASE_DOCKER_FILE_NAME="base.$(DOCKER_FILE_NAME)"
BASE_DOCKER_IMAGE_NAME=python-$(IMAGE_PYTHON_DEV)-tools

DEV_DOCKER_FILE_NAME="dev.$(DOCKER_FILE_NAME)"
DEV_DOCKER_IMAGE := $(DOCKER_REGISTRY)/$(MODULE)-dev

PRO_DOCKER_FILE_NAME="pro.$(DOCKER_FILE_NAME)"
PRO_DOCKER_IMAGE := $(DOCKER_REGISTRY)/$(MODULE)





# ***************************************
#  	  ____                           _ 
# 	 / ___| ___ _ __   ___ _ __ __ _| |
#	| |  _ / _ \ '_ \ / _ \ '__/ _` | |
#	| |_| |  __/ | | |  __/ | | (_| | |
#	 \____|\___|_| |_|\___|_|  \__,_|_|
#
# ***************************************

TEST=KK


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
# check_environment_variable
# 	* Check if environment variable exist
# 	* ARG_ENV_VAR : Environment variable captured by parameter
#	* ARG_TYPE : Type of behaviour expected in the absence of the environment variable
#		ERROR	: Error + undefined + exit
#		WARN	: Warning + undefined
#		OTHER	: Info + undefined
# **********************************

check_environment_variable:
ifdef $(ARG_ENV_VAR)

# Define description text
ifeq ($(ARG_TEXT),)
	$(eval DESCRIPTION := "\t* Check $(ARG_ENV_VAR) Environment Var -> ")
else
	$(eval DESCRIPTION := $(ARG_TEXT))
endif

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_GREEN}$($(ARG_ENV_VAR))${RESET_FORMATTING}"
else

# Define description text
ifeq ($(ARG_TEXT),)
	$(eval DESCRIPTION := "\t* Check $(ARG_ENV_VAR) Environment Var -> ")
else
	$(eval DESCRIPTION := $(ARG_TEXT))
endif

ifeq ($(ARG_TYPE),ERROR)
	@echo -e "[${TEXT_RED}ERROR${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_RED}$(ARG_ENV_VAR) is undefined${RESET_FORMATTING}"
	@exit 1
endif

ifeq ($(ARG_TYPE),WARN)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_YELLOW}$(ARG_ENV_VAR) is undefined${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_GREEN}$(ARG_ENV_VAR) is undefined${RESET_FORMATTING}"
endif

endif



# **********************************
# check_argument
#	* check if argument exist
# **********************************

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



# **********************************
# check_file
#	* check if file exist
# 	* Checks if the required parameter is passed ARG_FILE
#	* Check if the file exists
#		OK : Info
#		NO : Error + exit
# **********************************

check_file:
ifeq ($(ARG_FILE),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_FILE Argument -> ${TEXT_YELLOW}ARG_FILE is undefined${RESET_FORMATTING}"
else

	@if [ -f "./$(ARG_FILE)" ]; then \
		echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Check if exist file -> ${TEXT_GREEN}$(ARG_FILE) exist${RESET_FORMATTING}"; \
	else \
		echo -e "[${TEXT_RED}ERROR${RESET_FORMATTING}] Check if exist file -> ${TEXT_RED}$(ARG_FILE) NO exist${RESET_FORMATTING}"; \
		exit 1; \
	fi \

endif



# **********************************
# check_variable
#	* check if variable exist
# 	* Checks if the required parameter is passed ARG_TEXT
#	* required parameter ARG_TEXT_VALUE
# **********************************


check_variable:
ifeq ($(ARG_PARAMETER),)

ifeq ($(ARG_TEXT),)
	$(eval DESCRIPTION := "\t* Check ARG_PARAMETER Argument ->")
else
	$(eval DESCRIPTION := $(ARG_TEXT))
endif

	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_YELLOW}ARG_PARAMETER is undefined${RESET_FORMATTING}"
else

ifeq ($(ARG_TEXT),)
	$(eval DESCRIPTION := "\t* Check $(ARG_PARAMETER) Argument ->")
else
	$(eval DESCRIPTION := $(ARG_TEXT))
endif

ifeq ($($(ARG_PARAMETER)),)
	@echo -e "[${TEXT_RED}ERROR${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_RED}$(ARG_TEXT_VALUE) is not installed${RESET_FORMATTING}"
	exit 1
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] $(DESCRIPTION) ${TEXT_GREEN}$(ARG_TEXT_VALUE) is installed${RESET_FORMATTING}"
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
# initial-template
# 	* Initial template for the implementation of a Makefile goal
# **********************************

initial-template:
	$(shell date '+%s' > _time_.txt)
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
# end-template
#	* Final template for the execution of a Makefile goal
# **********************************

# end template Settings ***
# 	* EXECUTION_END_DATE : Variable containing the end date of the execution of the makefile
# 	* EXECUTION_INIT_DATE_MILISECONDS : Variable containing the end date of the Makefile execution in milliseconds

EXECUTION_END_DATE := $(shell date)
EXECUTION_END_DATE_MILISECONDS := $(shell date '+%s')

end-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]" 
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}BUILD SUCCESS${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Total time: $$(($$(date +%s)-$(shell cat _time_.txt))) s"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Finished at: $(EXECUTION_END_DATE)"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
	$(shell rm _time_.txt)



# **********************************
# initial-goal-template
#	* Template shown as a title in the execution of each goal in the Makefile
# **********************************

initial-goal-template:
ifeq ($(ARG_GOAL),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_GOAL Argument -> ${TEXT_YELLOW}ARG_GOAL is undefined${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:$(ARG_GOAL)${RESET_FORMATTING} ${BOLD}($(ARG_GOAL))${RESET_FORMATTING} ---"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
endif



# **********************************
# full-template
#	* Template that displays the full message during the execution of a goal in the Makefile
# **********************************

full-template:
ifeq ($(ARG_COMMON_PART),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_COMMON_PART Argument -> ${TEXT_YELLOW}ARG_COMMON_PART is undefined${RESET_FORMATTING}"
else
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) $(ARG_COMMON_PART)
	@$(MAKE_CMD) end-template
endif


# **********************************
# text-template
#	* Template that allows you to display a text in the established format
#	* Allows you to add an empty line at the front and back
# **********************************

text-template:
ifeq ($(ARG_ACTIVE_BEFORE),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_ACTIVE_BEFORE Argument -> ${TEXT_YELLOW}ARG_ACTIVE_BEFORE is undefined${RESET_FORMATTING}"
else
ifeq ($(ARG_ACTIVE_BEFORE),True)
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
endif
endif

ifeq ($(ARG_TXT),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_TXT Argument -> ${TEXT_YELLOW}ARG_TXT is undefined${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] $(ARG_TXT)"
endif

ifeq ($(ARG_ACTIVE_AFTER),)
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]\t* Check ARG_ACTIVE_AFTER Argument -> ${TEXT_YELLOW}ARG_ACTIVE_AFTER is undefined${RESET_FORMATTING}"
else
ifeq ($(ARG_ACTIVE_AFTER),True)
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
endif
endif



# *****************************************
# 			 ___        __       
#			|_ _|_ __  / _| ___  
# 		 	 | || '_ \| |_ / _ \ 
# 		 	 | || | | |  _| (_) |
#			|___|_| |_|_|  \___/ 
#
# *****************************************

# **********************************
# help
#	* show help goals info
# **********************************

help:
	@echo -e ""
	@echo -e "Usage: ${TEXT_GREEN}make [<goal>]${RESET_FORMATTING}"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}help${RESET_FORMATTING}\t\t\t show ${TEXT_BLUE}all help goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-info${RESET_FORMATTING}\t\t show ${TEXT_BLUE}all info goals${RESET_FORMATTING} info"
	@echo -e ""
	@echo -e "Prepare Project Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}help-os-goals${RESET_FORMATTING}\t\t show ${TEXT_BLUE}OS goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-python-goals${RESET_FORMATTING}\t show ${TEXT_BLUE}Python goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-pyenv-goals${RESET_FORMATTING}\t show ${TEXT_BLUE}Pyenv goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-pyenv-venv-goals${RESET_FORMATTING}\t show ${TEXT_BLUE}Pyenv Env goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-venv-goals${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Venv goals${RESET_FORMATTING} info"
	@echo -e ""
	@echo -e "Project Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}help-general-goals${RESET_FORMATTING}\t show ${TEXT_BLUE}General Actions goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-test-goals${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Test Actions goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-qa-goals${RESET_FORMATTING}\t\t show ${TEXT_BLUE}QA Actions goals${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}help-docker-goals${RESET_FORMATTING}\t show ${TEXT_BLUE}Docker Actions goals${RESET_FORMATTING} info"
	@echo -e ""



# **********************************
# help-info
#	* show type goal info
# **********************************

help-info:
	@echo -e ""
	@echo -e "Usage: ${TEXT_GREEN}make [<info-goal>]${RESET_FORMATTING}"
	@echo -e ""
	@echo -e "Prepare Project Info Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}info-os${RESET_FORMATTING}\t\t\t show ${TEXT_BLUE}OS${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}info-python${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Python${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}info-pyenv${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Pyenv${RESET_FORMATTING} info"
	@echo -e "\t${TEXT_GREEN}info-venv${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Venv${RESET_FORMATTING} info"
	@echo -e ""



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
# help-os-goals
#	* Help OS goals
# **********************************

help-os-goals:
	@echo -e ""
	@echo -e "Usage: ${TEXT_GREEN}make [<os-goal>]${RESET_FORMATTING}"
	@echo -e ""
	@echo -e "OS Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}info-os${RESET_FORMATTING}\t\t\t show ${TEXT_BLUE}OS${RESET_FORMATTING} information"
	@echo -e "\t${TEXT_GREEN}info-shell${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Shell${RESET_FORMATTING} information"
	@echo -e ""



# **********************************
# info-os 
#	* show OS Setting Info
# **********************************

info-os-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-os

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="OS Settings"

	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=OS_DETECTED ARG_TYPE=WARN ARG_TEXT=" - OS \t\t:"
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=CCFLAGS ARG_TYPE=WARN ARG_TEXT=" - CCFLAGS \t:"

info-os: 
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-os-common



# **********************************
# info-shell 
#	* show Shell Setting Info
# **********************************

info-shell-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-shell

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Shell Settings"

	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=SHELL ARG_TYPE=WARN ARG_TEXT=" - Shell \t\t:"
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=SHELL_FILE ARG_TYPE=WARN ARG_TEXT=" - Shell File \t:"

info-shell: 
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-shell-common



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
# help-python-goals
#	*  Help Python goals
# **********************************

help-python-goals:
	@echo -e ""
	@echo -e "Usage: ${TEXT_GREEN}make [<python-goal>]${RESET_FORMATTING}"
	@echo -e ""
	@echo -e "Python Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}check-python${RESET_FORMATTING}\t\t check the validity of the execution environment for the use of ${TEXT_BLUE}Python${RESET_FORMATTING}"
	@echo -e "\t${TEXT_GREEN}info-python${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Python${RESET_FORMATTING} information"
	@echo -e ""
	@echo -e "Pip Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}info-pip${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Python${RESET_FORMATTING} information"
	@echo -e "\t${TEXT_GREEN}upgrade-pip${RESET_FORMATTING}\t\t upgrade ${TEXT_BLUE}Pip${RESET_FORMATTING}"
	@echo -e ""



# **********************************
# check-python
#	* check the validity of the execution environment for the use of Python
#		Check Python installation
# **********************************

check-python-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=check-python

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Check Python Installation :" 

	@$(MAKE_CMD) check_variable ARG_PARAMETER=PYTHON_PATH ARG_TEXT="\t* Check Python Path \t->" ARG_TEXT_VALUE="Python"
	@$(MAKE_CMD) check_variable ARG_PARAMETER=PIP_PATH ARG_TEXT="\t* Check Pip Path \t->" ARG_TEXT_VALUE="Pip"
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Results :"
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="The execution environment for the use of Python is ${TEXT_GREEN}SUCCESS${RESET_FORMATTING}"

check-python:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=check-python-common



# **********************************
# info-pip
#	* pip Setting Info
#	* previously executed : check-python-common
# **********************************

info-pip-common:
	@$(MAKE_CMD) check-python-common
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-pip

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Pip Settings"
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="- Pip Path \t\t: ${TEXT_GREEN}$(PIP_PATH)${RESET_FORMATTING}"
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="- Pip Version \t\t: ${TEXT_GREEN}$(PIP_VERSION)${RESET_FORMATTING}"

info-pip: 
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-pip-common



# **********************************
# info-python
#	* python Setting Info
#	* previously executed : check-python-common
# **********************************

info-python-common:
	@$(MAKE_CMD) check-python-common
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-python

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Python Settings"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Python Path \t\t: ${TEXT_GREEN}$(PYTHON_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Python Version \t: ${TEXT_GREEN}$(PYTHON_VERSION)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Python Version Number \t: ${TEXT_GREEN}$(PYTHON_VERSION_NUMBER)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Python Version Code \t: ${TEXT_GREEN}$(PYTHON_VERSION_CODE)${RESET_FORMATTING}"

info-python: 
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-python-common



# **********************************
# upgrade-pip
#	* Upgrade pip
# **********************************

info-upgrade-pip-template:
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True ARG_TXT="To Upgrade pip in your local shell require manual run :"
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False ARG_TXT="\t${TEXT_GREEN}$(PACKAGE_CMD) install --upgrade $(PACKAGE_TOOL)${RESET_FORMATTING}"  

upgrade-pip-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=upgrade-pip

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Upgrade pip -> ${TEXT_GREEN}$(PACKAGE_CMD) install --upgrade $(PACKAGE_TOOL)${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install --upgrade $(PACKAGE_TOOL)

upgrade-pip:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=upgrade-pip-common



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
# help-pyenv-goals
#	* Help Pyenv goals
# **********************************

help-pyenv-goals:
	@echo -e ""
	@echo -e "Usage: ${TEXT_GREEN}make [<pyenv-goal>]${RESET_FORMATTING}"
	@echo -e ""
	@echo -e "Pyenv Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}check-pyenv${RESET_FORMATTING}\t\t check the validity of the execution environment for the use of ${TEXT_BLUE}Pyenv${RESET_FORMATTING}"
	@echo -e "\t${TEXT_GREEN}info-pyenv${RESET_FORMATTING}\t\t show ${TEXT_BLUE}Pyenv${RESET_FORMATTING} information"
	@echo -e ""



# **********************************
# check-pyenv
#	* check the validity of the execution environment for the use of pyenv
# **********************************

check-pyenv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=check-pyenv

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Check environment variables :" 

	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_ROOT ARG_TYPE=ERROR
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_SHELL ARG_TYPE=ERROR
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_VERSION ARG_TYPE=WARN

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True ARG_TXT="Results :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}The execution environment for the use of pyenv is SUCCESS${RESET_FORMATTING}"

check-pyenv:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=check-pyenv-common



# **********************************
# 		info-pyenv
# **********************************

info-pyenv-template-general-settings:
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="General Settings"

	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_ROOT ARG_TYPE=WARN ARG_TEXT=' - PYENV_ROOT \\t\\t\\t:'
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_VERSION ARG_TYPE=WARN ARG_TEXT=' - PYENV_VERSION \\t\\t\\t:'
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_SHELL ARG_TYPE=WARN ARG_TEXT=' - PYENV_SHELL \\t\\t\\t:'
	@$(MAKE_CMD) check_environment_variable ARG_ENV_VAR=PYENV_VIRTUALENV_INIT ARG_TYPE=WARN ARG_TEXT=' - PYENV_VIRTUALENV_INIT \\t\\t:'



# **********************************
# help-pyenv-venv-goals
#	* Help Pyenv venv goals
# **********************************

help-pyenv-venv-goals:
	@echo -e ""
	@echo -e "Usage: ${TEXT_GREEN}make [<pyenv-env-goal>]${RESET_FORMATTING}"
	@echo -e ""
	@echo -e "Pyenv Env Goals"
	@echo -e ""
	@echo -e "\t${TEXT_GREEN}show-pyenv-venv${RESET_FORMATTING}\t\t\t show available virtual environments for pyenv use"
	@echo -e "\t${TEXT_GREEN}create-pyenv-venv${RESET_FORMATTING}\t\t create virtual environment for pyenv use"
	@echo -e "\t${TEXT_GREEN}destroy-pyenv-venv${RESET_FORMATTING}\t\t destroy virtual environment for pyenv use"
	@echo -e ""




info-pyenv-template-python-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Pyenv Python Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Python Active Path \t\t: ${TEXT_GREEN}$(PYENV_PYTHON_ACTIVE_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Version Python Active \t: ${TEXT_GREEN}$(PYENV_PYTHON_ACTIVE_VERSION)${RESET_FORMATTING}"

info-pyenv-template-python-version-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Python Version Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Versions Path \t\t: ${TEXT_GREEN}$(PYENV_VERSIONS_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Version Active Path \t\t: ${TEXT_GREEN}$(PYENV_VERSION_ACTIVE_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Envs Path \t\t\t: ${TEXT_GREEN}$(PYENV_ENVS_ACTIVE_PATH)${RESET_FORMATTING}"

info-pyenv-template-python-venv-active-settings:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Python Pyenv Virtual Environment Active Settings"

ifndef PYENV_VERSION
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}] - PYENV_VERSION \t\t: ${TEXT_YELLOW}PYENV_VERSION is undefined${RESET_FORMATTING}"
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]"
	@echo -e "[${TEXT_YELLOW}WARN${RESET_FORMATTING}]  ${TEXT_YELLOW}No Python Pyenv Virtual Environment is activated${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - PYENV_VERSION \t\t: ${TEXT_GREEN}$(PYENV_VERSION)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - PYENV_VIRTUAL_ENV \t\t: ${TEXT_GREEN}$(PYENV_VIRTUAL_ENV)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - PYENV_ACTIVATE_SHELL \t\t: ${TEXT_GREEN}$(PYENV_ACTIVATE_SHELL)${RESET_FORMATTING}"
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

info-pyenv-template:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-pyenv

ifdef PYENV_ROOT
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
info-pyenv: 
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-pyenv-template



# **********************************
# 		show-pyenv-venv
# **********************************

# *** show-pyenv-venv : show available virtual environments for pyenv use***
NUM_AVAILABLE_PYENV_ENVIROMENTS := $(shell ls $(PYENV_ENVS_ACTIVE_PATH) | wc -l | sed -e 's/^[ \t]*//')

show-pyenv-venv:
	@$(MAKE_CMD) initial-template
	@$(MAKE_CMD) check-pyenv-common
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) initial-goal-template ARG_GOAL=show-pyenv-venv
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Show Pyenv Virtual Environments \t-> ${TEXT_GREEN}$(PYENV_CMD) virtualenvs${RESET_FORMATTING}"
	@$(PYENV_CMD) virtualenvs

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Show available Pyenv Virtual Environments  -> ${TEXT_GREEN}ls $(PYENV_ENVS_ACTIVE_PATH)${RESET_FORMATTING}"
	
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
# create-pyenv-venv
#	* create virtual environment for pyenv use
# **********************************

create-pyenv-venv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=create-pyenv-venv

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Select Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Create Pyenv Virtual Environment -> ${TEXT_GREEN}$(PYENV_CMD) ${VIRTUALENV_TOOL} $(PYTHON_VERSION_NUMBER) $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@$(PYENV_CMD) ${VIRTUALENV_TOOL} $(PYTHON_VERSION_NUMBER) $(VIRTUAL_ENV_NAME)

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="To Activate the Virtual Environment in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}$(PYENV_CMD) activate $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

create-pyenv-venv:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=create-pyenv-venv-common



# **********************************
# destroy-pyenv-venv
#	* destroy virtual environment for pyenv use
# **********************************

destroy-pyenv-venv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=destroy-pyenv-venv

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Show Pyenv Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	
ifdef PYENV_VERSION
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Show Active Pyenv Virtual Environments \t-> ${TEXT_GREEN}$(PYENV_VERSION)${RESET_FORMATTING}"
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="To Deactivate the Virtual Environment in your local shell require manual run :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}$(PYENV_CMD) deactivate ${RESET_FORMATTING}"

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Then run this target again :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make destroy-pyenv-venv${RESET_FORMATTING}"

else
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Show Active Pyenv Virtual Environments \t-> ${TEXT_GREEN}Pyenv Virtual Environment is not active${RESET_FORMATTING}"
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=False  ARG_TXT="Uninstall Pyenv Virtual Environment -> ${TEXT_GREEN}$(PYENV_CMD) uninstall -f $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@$(PYENV_CMD) uninstall -f $(VIRTUAL_ENV_NAME)

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Results :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}Destroy Pyenv Virtual Environment is SUCCESS${RESET_FORMATTING}"
endif

destroy-pyenv-venv:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=destroy-pyenv-venv-common





# *****************************************
# 		 __     __              
# 		 \ \   / /__ _ ____   __
#  		  \ \ / / _ \ '_ \ \ / /
#   	   \ V /  __/ | | \ V / 
#    		\_/ \___|_| |_|\_/  
#
# *****************************************

# **********************************
# help-venv-goals
# 	* venv goals
# **********************************

# *** help-venv-goals : venv goals ***
help-venv-goals:
	@echo -e "Venv Goals:"
	@echo -e "\t${TEXT_GREEN}info-venv${RESET_FORMATTING}\t\t\t show venv information"
	@echo -e "\t${TEXT_GREEN}check-venv${RESET_FORMATTING}\t\t\t check the validity of the execution environment for the use of venv"
	@echo -e "\t${TEXT_GREEN}create-venv${RESET_FORMATTING}\t\t\t create virtual environment for venv use"
	@echo -e "\t${TEXT_GREEN}destroy-venv${RESET_FORMATTING}\t\t\t destroy virtual environment for venv use"



# **********************************
# info-venv
#	* Goal Venv Setting Info
# **********************************

info-venv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-venv

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Virtual Env"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Virtual Env Default Name Prefix \t: ${TEXT_GREEN}$(DEFAULT_VIRTUAL_ENV_NAME_PREFIX)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] - Virtual Env Default Name \t\t: ${TEXT_GREEN}$(DEFAULT_VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

info-venv: 
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-venv-common



# **********************************
# check-venv
#	* check the validity of the execution environment for the use of venv 
# **********************************

info-venv-active-template:
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="To Activate the Virtual Environment in your local shell require manual run :"

ifeq ($(OS_DETECTED),Windows)
    @echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\tDefault : ${TEXT_GREEN}C:>$(VIRTUAL_ENV_NAME)/Scripts/activate.bat${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\tPowershell : ${TEXT_GREEN}C:>$(VIRTUAL_ENV_NAME)/Scripts/Activate.ps1${RESET_FORMATTING}"
else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}source $(VIRTUAL_ENV_NAME)/bin/activate${RESET_FORMATTING}"
endif

check-venv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=check-venv

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

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Check environment variables :"
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

check-venv:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=check-venv-common



# **********************************
# create-venv
# 	* create virtual environment for venv use
# **********************************

create-venv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=create-venv

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Select Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Create Venv Virtual Environment -> ${TEXT_GREEN}$(PYTHON_CMD) -m venv $(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"
	@$(PYTHON_CMD) -m venv $(VIRTUAL_ENV_NAME)

	@$(MAKE_CMD) info-venv-active-template

	@$(MAKE_CMD) info-upgrade-pip-template

create-venv:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=create-venv-common



# **********************************
# 		destroy-venv
# **********************************

# *** destroy-venv-common : destroy virtual environment for venv use (common part)***
destroy-venv-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=destroy-venv

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Show Pyenv Virtual Environment Name -> ${TEXT_GREEN}$(VIRTUAL_ENV_NAME)${RESET_FORMATTING}"

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

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Then run this target again :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make destroy-venv${RESET_FORMATTING}"

else
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Show Active Venv Virtual Environments \t-> ${TEXT_GREEN}Venv Virtual Environment is not active${RESET_FORMATTING}"

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Delete Venv Virtual Environment -> ${TEXT_GREEN}rm -r $(VIRTUAL_ENV_NAME)/${RESET_FORMATTING}"
	@rm -r $(VIRTUAL_ENV_NAME)/

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Results :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}Destroy Venv Virtual Environment is SUCCESS${RESET_FORMATTING}"
endif

# *** destroy-venv : destroy virtual environment for venv use***
destroy-venv:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=destroy-venv-common




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
# clean
#	* cleanup all temporary files
# **********************************

clean-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=clean

	@rm -rf .pytest_cache **/__pycache__ .coverage coverage.xml build dist

clean:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=clean-common



# **********************************
# freeze
#	* write the requirements to file
# **********************************

freeze-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=freeze

	@$(PACKAGE_TOOL) freeze > requirements.txt

freeze:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=freeze-common



# **********************************
# install
#	* install dependencies from the requirements.txt file
#	* install the package in a virtual environment
# **********************************

install-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=install

	@${PACKAGE_CMD} install -r requirements.txt

install:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=install-common



# **********************************
# run
#	* execute module
# **********************************

run-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=run

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Run Module $(MODULE)  -> ${TEXT_GREEN}$(PYTHON_CMD) -m $(MODULE)${RESET_FORMATTING}"

run:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=install-common
	@$(PYTHON_CMD) -m $(MODULE)



# **********************************
# run-flask
#	* execute module with flask
# **********************************

run-flask-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=run-flask

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=True  ARG_TXT="Run Flask -> ${TEXT_GREEN}$(PYTHON_CMD) flask run${RESET_FORMATTING}"
	
run-flask:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=run-flask-common
	@$(PYTHON_CMD) -m flask run



# **********************************
# docs
#	* update documentation using Sphinx
# **********************************

docs-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=docs

docs:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=docs-common



# **********************************
# readme
#	*  update usage in readme
# **********************************

readme-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=readme

readme:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=readme-common



# **********************************
# publish
#	*  publish changes to GitHub/PyPI
# **********************************

publish-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=publish

publish:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=publish-common





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
# install-test-technology-stack
#	* Install the testing technology stack selected for the version of Python used
# **********************************

install-test-technology-stack-common:
	@$(MAKE_CMD) upgrade-pip
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) initial-goal-template ARG_GOAL=install-test-technology-stack

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=False ARG_ACTIVE_AFTER=False  ARG_TXT="Install package "pytest" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pytest${RESET_FORMATTING}"	
	@$(PACKAGE_CMD) install pytest

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=False  ARG_TXT="Install package "pytest-xdist" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pytest-xdist${RESET_FORMATTING}"	
	@$(PACKAGE_CMD) install pytest-xdist

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=False  ARG_TXT="Install package "pytest-cov" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pytest-cov${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install pytest-cov

install-test-technology-stack:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=install-test-technology-stack-common



# **********************************
# test
#	* run the test suite, report coverage
# **********************************


test-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=test

	@pytest

test:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=test-common



# **********************************
# tox
#	*  run the tests on all Python versions
# **********************************

tox-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=tox

tox:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=tox-common



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
# install-qa-technology-stack
#	*  Install the QA technology stack selected for the version of Python used
# **********************************

install-qa-technology-stack-common:
	@$(MAKE_CMD) upgrade-pip
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=install-qa-technology-stack

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=False  ARG_TXT="Install package "flake8" -> ${TEXT_GREEN}$(PACKAGE_CMD) install flake8${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install flake8

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=False  ARG_TXT="Install package "pylint" -> ${TEXT_GREEN}$(PACKAGE_CMD) install pylint${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install pylint

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=False  ARG_TXT="Install package "bandit" -> ${TEXT_GREEN}$(PACKAGE_CMD) install bandit${RESET_FORMATTING}"
	@$(PACKAGE_CMD) install bandit

install-qa-technology-stack:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=install-qa-technology-stack-common



# **********************************
# 		pylint
# **********************************

pylint-common: 
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=pylint
	
	@pylint --rcfile=setup.cfg **/*.py

pylint:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=pylint-common



# **********************************
# 		bandit
# **********************************

bandit-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=bandit

	@bandit -r --ini setup.cfg

bandit:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=bandit-common



# **********************************
# 		flake8
# **********************************

# *** bandit-common : xxx  (flake8 part)***
flake8-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=flake8

	@flake8

flake8:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=flake8-common



# **********************************
# check
#	* check coding style (PEP-8, PEP-257)
# **********************************

check-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=check

	@$(MAKE_CMD) flake8-common

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) pylint-common

	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) bandit-common

check:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=check-common



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
# info-docker 
#	* Docker Setting Info
# **********************************

info-docker-template:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Docker Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Docker Path \t\t\t: ${TEXT_GREEN}$(DOCKER_PATH)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Docker Version \t\t: ${TEXT_GREEN}$(DOCKER_VERSION_NUMBER)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_BUILD_CONTEXT \t\t: ${TEXT_GREEN}$(DOCKER_BUILD_CONTEXT)${RESET_FORMATTING}"

info-docker-template-registry:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Docker Registry Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_REGISTRY \t\t: ${TEXT_GREEN}$(DOCKER_REGISTRY)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DOCKER_IMAGE \t\t\t: ${TEXT_GREEN}$(DOCKER_IMAGE)${RESET_FORMATTING}"

info-docker-template-build:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Build Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Module \t\t\t: ${TEXT_GREEN}$(MODULE)${RESET_FORMATTING}"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Tag \t\t\t\t: ${TEXT_GREEN}$(TAG)${RESET_FORMATTING}"

info-docker-template-build-dev:
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Dev Build Settings"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- Dev Docker File \t\t: ${TEXT_GREEN}$(DEV_DOCKER_FILE_NAME)${RESET_FORMATTING}"
	
info-docker-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=info-docker

	@$(MAKE_CMD) info-docker-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) info-docker-template-build
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) info-docker-template-build-dev
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

	@$(MAKE_CMD) info-docker-template-registry

info-docker:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=info-docker-common



# **********************************
# clean-docker 
# **********************************

clean-docker-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=clean-docker
	
	@$(DOCKER_CMD) system prune -f --filter "label=name=$(MODULE)"

clean-docker:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=clean-docker-common



# **********************************
# build-docker-dev-tool
#	* build Docker image for DEV TOOL environment
# **********************************

build-docker-dev-tool-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=build-docker-dev-tool

	@$(MAKE_CMD) check_file ARG_FILE=$(BASE_DOCKER_FILE_NAME)

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Building Development Tool image with labels -> ${TEXT_GREEN}$(DOCKER_CMD) build -t "$(DOCKER_REGISTRY)/$(BASE_DOCKER_IMAGE_NAME)" -f $(BASE_DOCKER_FILE_NAME) .${RESET_FORMATTING}"
	@$(DOCKER_CMD) build -t "$(DOCKER_REGISTRY)/$(BASE_DOCKER_IMAGE_NAME)" -f $(BASE_DOCKER_FILE_NAME) .

build-docker-dev-tool:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=build-docker-dev-tool-common



# **********************************
# build-docker-dev
#	* build Docker image for DEV environment
# **********************************

build-docker-dev-use-template:
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Use :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t${TEXT_GREEN}make build-docker-dev-sue-template NAME=<NAME> VERSION=<VERSION> ${RESET_FORMATTING}";
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Case :"
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] make build-docker-dev-sue-template NAME=myproject VERSION=1.0.0"

build-docker-dev-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=build-docker-dev
	
	@$(MAKE_CMD) check_file ARG_FILE=$(DEV_DOCKER_FILE_NAME)

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Prepare $(DEV_DOCKER_FILE_NAME) ->  ${TEXT_GREEN}Update References : $(MODULE) and $(TAG)${RESET_FORMATTING}"
	@sed -i "" \
		-e "s/{NAME}/$(MODULE)/g" \
		-e "s/{VERSION}/$(TAG)/g" \
		$(DEV_DOCKER_FILE_NAME) \
		
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Building Development image with labels -> ${TEXT_GREEN}$(DOCKER_CMD) build -t $(DEV_DOCKER_IMAGE):$(TAG) -f $(DEV_DOCKER_FILE_NAME) $(DOCKER_BUILD_CONTEXT)${RESET_FORMATTING}"
	@$(DOCKER_CMD) build -t $(DEV_DOCKER_IMAGE):$(TAG) -f $(DEV_DOCKER_FILE_NAME) $(DOCKER_BUILD_CONTEXT)

build-docker-dev:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=build-docker-dev-common



# **********************************
# build-docker-pro
#	* build Docker image for PRO environment
# **********************************

build-docker-pro-common:
	@$(MAKE_CMD) initial-goal-template ARG_GOAL=build-docker-pro

	@$(MAKE_CMD) check_file ARG_FILE=$(PRO_DOCKER_FILE_NAME)
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Prepare $(PRO_DOCKER_FILE_NAME) ->  ${TEXT_GREEN}Update References : $(MODULE) and $(TAG)${RESET_FORMATTING}"
	@sed -i "" \
		-e "s/{NAME}/$(MODULE)/g" \
		-e "s/{VERSION}/$(TAG)/g" \
		$(PRO_DOCKER_FILE_NAME) \
	
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Building Production image with labels -> ${TEXT_GREEN}$(DOCKER_CMD) build -t $(PRO_DOCKER_IMAGE):$(TAG) -f $(PRO_DOCKER_FILE_NAME) $(DOCKER_BUILD_CONTEXT)${RESET_FORMATTING}"
	@$(DOCKER_CMD) build -t $(PRO_DOCKER_IMAGE):$(TAG) -f $(PRO_DOCKER_FILE_NAME) $(DOCKER_BUILD_CONTEXT)

build-docker-pro:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=build-docker-pro-common



# *** build-docker-prod : Docker goals ***
# # make build-dev NAME=victor VERSION=1.0.0
build-docker-prod2:
	@$(MAKE_CMD) initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:build-docker-prod${RESET_FORMATTING} ${BOLD}(default-build-docker-prod)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"
	
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
	@$(MAKE_CMD) info-docker-template-build

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Check arguments :"
	@$(MAKE_CMD) check_argument ARG_PARAMETER=NAME
	@$(MAKE_CMD) check_argument ARG_PARAMETER=VERSION

ifdef NAME
ifdef VERSION
	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Building Development image with labels -> ${TEXT_GREEN}$(DOCKER_CMD) build -t $(DOCKER_IMAGE):$(TAG) -f dev.Dockerfile${RESET_FORMATTING}"

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



# **********************************
# shell-docker
#	* Execute Shell in the containerized build environment
#	* Example : make shell CMD="-c 'date > datefile'"
# **********************************

shell-docker:
	@docker run                     \
		-ti                         \
		--rm                        \
		--entrypoint /bin/bash      \
		-u $$(id -u):$$(id -g)      \
		$(DEV_DOCKER_IMAGE):$(TAG)	\
		$(CMD)



# **********************************
# push-docker
#	* push the image to Docker Registry
#	* Optional use VERSION ARGUMEN 
#	* Example : make push VERSION=1.2.3
# **********************************

push-docker-common:
	@$(MAKE_CMD) initial-template
	@echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}makefile:push-docker${RESET_FORMATTING} ${BOLD}(default-push-docker)${RESET_FORMATTING} @ ${TEXT_CYAN}${MODULE}${RESET_FORMATTING} ---"

	@$(MAKE_CMD) text-template ARG_ACTIVE_BEFORE=True ARG_ACTIVE_AFTER=True  ARG_TXT="Pushing image to GitHub Docker Registry -> ${TEXT_GREEN}$(DOCKER_CMD) push $(IMAGE):$(VERSION)${RESET_FORMATTING}"
	@$(DOCKER_CMD) push $(IMAGE):$(VERSION)

push-docker:
	@$(MAKE_CMD) full-template ARG_COMMON_PART=push-docker-common



# **********************************		
#		  _  _____ ____  
#		 | |/ ( _ ) ___| 
#		 | ' // _ \___ \ 
#		 | . \ (_) |__) |
#		 |_|\_\___/____/ 
#                 
# **********************************


.PHONY: clean test
