Colcon python installation bug
==============================

This repository contains an example python project that triggers a colcon-core bug in version 0.9.0.
In particular, if you build this package with colcon-core 0.9.0, then you'll end up with the `colcon_py_bug` console script in `install/colcon_py_bug/bin/colcon_py_bug`, rather than the expected `install/colcon_py_bug/lib/colcon_py_bug/colcon_py_bug`.

As another point of interest, if setup.cfg is modified to use underscores instead of dashes for `script-dir` and `install-scripts`, then we install to the correct place.

Finally, there is a stupid bash script in here called hand-build.bash, which takes small parts out of colcon-core and can replicate the bug independent of colcon.
As it stands, it needs a certain directory structure to work.

Investigation
=============

This is certainly caused by the changes in https://github.com/colcon/colcon-core/pull/512 .
In particular, we think that because we are setting sys.prefix, but not sys.base_prefix in the
sitecustomize.py file, we are running into this logic: https://github.com/pypa/setuptools/blob/1a45c10cb0ec6c374308a8a3921ca70d1ddf389f/setuptools/dist.py#L682-L700 .
That is, setuptools is thinking we are in a venv, and so skips the `install-scripts` key (but not the `install_scripts` key, which is why it works if we change the key).

Unfortunately we cannot set sys.base_prefix, because of something to do with sysconfig (not sure about this one).

It is still unclear what the solution is.

A change at the end.
