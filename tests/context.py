# ******************************************************
#                  _            _                 
#   ___ ___  _ __ | |_ _____  _| |_   _ __  _   _ 
#  / __/ _ \| '_ \| __/ _ \ \/ / __| | '_ \| | | |
# | (_| (_) | | | | ||  __/>  <| |_ _| |_) | |_| |
#  \___\___/|_| |_|\__\___/_/\_\\__(_) .__/ \__, |
#                                    |_|    |___/ 
#
# ******************************************************

# Support for imports of source code files from xxx directory by manipulating class path



import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import acme  # noqa # pylint: disable=unused-import, wrong-import-position
