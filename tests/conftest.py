# ******************************************************
#                   __ _            _                 
#   ___ ___  _ __  / _| |_ ___  ___| |_   _ __  _   _ 
#  / __/ _ \| '_ \| |_| __/ _ \/ __| __| | '_ \| | | |
# | (_| (_) | | | |  _| ||  __/\__ \ |_ _| |_) | |_| |
#  \___\___/|_| |_|_|  \__\___||___/\__(_) .__/ \__, |
#                                        |_|    |___/ 
#
# ******************************************************

# Define fixtures, hooks or loading external plugins for pytest



import logging
import pytest

LOGGER = logging.getLogger(__name__)

@pytest.fixture(scope='function')
def example_fixture():
    LOGGER.info("Setting Up Example Fixture...")
    yield
    LOGGER.info("Tearing Down Example Fixture...")