#!/usr/bin/env python
import os
import sys
from setuptools import setup

# version of DBSClient in github
package_version = "4.0.1"

# Requirements file for pip dependencies
requirements = "requirements.txt"


def parse_requirements(requirements_file):
    """
      Create a list for the 'install_requires' component of the setup function
      by parsing a requirements file
    """

    if os.path.exists(requirements_file):
        # return a list that contains each line of the requirements file
        return open(requirements_file, 'r').read().splitlines()
    else:
        print("ERROR: requirements file " + requirements_file + " not found.")
        sys.exit(1)


setup(name="dbs3-client",
      version=package_version,
      maintainer="CMS DWMWM Group",
      maintainer_email="hn-cms-dmDevelopment@cern.ch",
      packages=['dbs.apis',
                'dbs.exceptions'],
      package_dir={'': 'src/python'},
      install_requires=parse_requirements(requirements),
      url="https://github.com/dmwm/DBSClient/tree/3.17.8",
      # url="https://github.com/dmwm/DBSClient/tree/change2dbsDir",
      license="Apache License, Version 2.0",
      )

