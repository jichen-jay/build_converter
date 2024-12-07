# setup.py
from setuptools import setup
from Cython.Build import cythonize

setup(
    name="my_converter",
    ext_modules=cythonize("src/convert.pyx"),
    package_dir={"": "./src"},
)
