#!/bin/bash -xe

rm -rf ../../build ../../install ../../log

mkdir -p ../../build/colcon_py_bug/prefix_override
mkdir -p ../../install/colcon_py_bug/lib/python3.8/site-packages
mkdir -p ../../log

export PYTHONPATH=/home/ubuntu/colcon_py_bug_ws/build/colcon_py_bug/prefix_override:/home/ubuntu/colcon_py_bug_ws/install/colcon_py_bug/lib/python3.8/site-packages:$PYTHONPATH


echo "import sys
sys.real_prefix = sys.prefix
sys.prefix = sys.exec_prefix = '/home/ubuntu/colcon_py_bug_ws/install/colcon_py_bug'" > ../../build/colcon_py_bug/prefix_override/sitecustomize.py


/usr/bin/python3 setup.py egg_info --egg-base ../../build/colcon_py_bug build --build-base /home/ubuntu/colcon_py_bug_ws/build/colcon_py_bug/build install --record /home/ubuntu/colcon_py_bug_ws/build/colcon_py_bug/install.log --single-version-externally-managed
