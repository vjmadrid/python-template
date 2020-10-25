# ***************************************************************************************
#                   __ _                                                            _   
#   ___ ___  _ __  / _(_) __ _ _   _ _ __ ___       _ __  _ __ ___  _   _  ___  ___| |_ 
#  / __/ _ \| '_ \| |_| |/ _` | | | | '__/ _ \_____| '_ \| '__/ _ \| | | |/ _ \/ __| __|
# | (_| (_) | | | |  _| | (_| | |_| | | |  __/_____| |_) | | | (_) | |_| |  __/ (__| |_ 
#  \___\___/|_| |_|_| |_|\__, |\__,_|_|  \___|     | .__/|_|  \___/ \__, |\___|\___|\__|
#                        |___/                     |_|              |___/               
#                    
# ***************************************************************************************



# **********************************
# 			sh Setup
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
# 			Project Setup
# **********************************

PROJECT_NAME='python-template'

DEFAULT_TEMPLATE_MODULE='projectx'
DEFAULT_TEMPLATE_REGISTRY='docker.pkg.github.com/acme/projectx'



# **********************************
# 			Argument capture
# **********************************

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            MODULE)      MODULE=${VALUE} ;;
            DOCKER-REGISTRY)    DOCKER-REGISTRY=${VALUE} ;;
            *)   
    esac    

done



# **********************************
# 			Scrip Execution
# **********************************

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Configure project..."
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ---< ${TEXT_CYAN}${PROJECT_NAME}${RESET_FORMATTING} >---"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Arguments"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- MODULE \t\t\t: ${TEXT_GREEN}${MODULE}${RESET_FORMATTING}"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- REGISTRY \t\t\t: ${TEXT_GREEN}${REGISTRY}${RESET_FORMATTING}"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] Default Settings"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DEFAULT_TEMPLATE_MODULE \t: ${TEXT_GREEN}${DEFAULT_TEMPLATE_MODULE}${RESET_FORMATTING}"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]\t- DEFAULT_TEMPLATE_REGISTRY \t: ${TEXT_GREEN}${DEFAULT_TEMPLATE_REGISTRY}${RESET_FORMATTING}"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

# Example de modulo 
# ./configure_project.sh MODULE="projectx" DOCKER-REGISTRY="docker.pkg.github.com/vjmadrid/projectx"

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}configure-project:prepare-module${RESET_FORMATTING} ${BOLD}(prepare-module)${RESET_FORMATTING} ---"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]* Prepare Module ->  ${TEXT_GREEN}mv ${DEFAULT_TEMPLATE_MODULE} ${MODULE} ${RESET_FORMATTING}"
cp -R -a $DEFAULT_TEMPLATE_MODULE $MODULE
# mv $DEFAULT_TEMPLATE_MODULE $MODULE

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}configure-project:prepare-config${RESET_FORMATTING} ${BOLD}(prepare-config)${RESET_FORMATTING} ---"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare Makefile..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" Makefile
sed -i '' -e "s~$DEFAULT_TEMPLATE_REGISTRY~$DOCKER-REGISTRY/g;~" Makefile

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare setup.cfg..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" setup.cfg

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}configure-project:prepare-test-config${RESET_FORMATTING} ${BOLD}(prepare-test-config)${RESET_FORMATTING} ---"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare pytest.ini..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" pytest.ini

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare tests/context.py..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" tests/context.py

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare tests/test_app.py..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" tests/test_app.py

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}configure-project:prepare-docker-config${RESET_FORMATTING} ${BOLD}(prepare-docker-config)${RESET_FORMATTING} ---"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare dev.Dockerfile..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" dev.Dockerfile

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare pro.Dockerfile..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" pro.Dockerfile

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}configure-project:prepare-sonar-config${RESET_FORMATTING} ${BOLD}(prepare-sonar-config)${RESET_FORMATTING} ---"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] * Prepare sonar-project.properties..."
sed -i '' -e "s/$DEFAULT_TEMPLATE_MODULE/$MODULE/g" sonar-project.properties

# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}project:run${RESET_FORMATTING} ${BOLD}(prepare-run)${RESET_FORMATTING} ---"
# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
# make run

# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}project:test${RESET_FORMATTING} ${BOLD}(prepare-test)${RESET_FORMATTING} ---"
# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
# make test

# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] --- ${TEXT_GREEN}project:build-docker-dev${RESET_FORMATTING} ${BOLD}(build-docker-dev)${RESET_FORMATTING} ---"
# echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
# make build-docker-dev

echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}]"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ${TEXT_GREEN}EXECUTION SUCCESS${RESET_FORMATTING}"
echo -e "[${TEXT_BLUE}INFO${RESET_FORMATTING}] ------------------------------------------------------------------------"
