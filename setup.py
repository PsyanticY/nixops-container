import sys
import subprocess

from distutils.core import setup, Command

setup(name='nixops-container',
      version='@version@',
      description='NixOps backend for NixOS Container',
      url='https://github.com/PsyanticY/nixops-container',
      maintainer='PsyanticY',
      maintainer_email='iuns@outlook.fr',
      packages=['nixopscontainer', 'nixopscontainer.backends'],
      entry_points={'nixops': ['container = nixopscontainer.plugin']},
      py_modules=['plugin']
)


