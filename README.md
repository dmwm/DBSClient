[![Linux](https://svgshare.com/i/Zhy.svg)](https://svgshare.com/i/Zhy.svg) [![macOS](https://svgshare.com/i/ZjP.svg)](https://svgshare.com/i/ZjP.svg)
# DBS3-Client

The **Data Bookkeeping Service 3** (DBS 3) provides an improved event data catalog for Monte Carlo and recorded data of the CMS experiment. It provides the necessary information used for tracking datasets, for example the data processing history, files and runs associated with a given dataset, and much more.

DBS 3 has been completely re-designed and re-implemented in Python on the basis of a CherryPy based environment for developing RESTful (Representational State Transfer) web services, which is commonly used within the data management and workload management (DMWM) group of CMS. DBS 3 is using the Java Script Object Notation (JSON) dataformat for interchanging information and Oracle as database backend.

DBS3-Client is the python client of DBS3. It enable to user to use DBS3 through Python.

# 1. Dependencies

## 1.1 Python dependancies

Dbs3-client have 2 python dependencies.
| Dependency's name | Pypi link | version |
|-------------------|-----------|---------|
| dbs3-pycurl       | [dbs3-pycurl · PyPI](https://pypi.org/project/dbs3-pycurl/) | 3.17.1 |
|pycurl| [pycurl · PyPI](https://pypi.org/project/pycurl/) |7.43.0.6|


***

You can use any Python version higher or equal than 3.8.2.

![python-version](https://img.shields.io/badge/python%20version-%3E%3D3.8.2-blue?style=flat&logo=python)

## 1.2 Libcurl

*Note: If libcurl is already installed, you can skip this step.*
To use libcurl, is highly recommanded to use linux or MacOS.
Dbs3-client use pycurl, which requires libcurl. We will see in this section how to get libcurl. Run the following command:
- Redhat base:

`sudo yum install libcurl-devel`

- Debian base:

`sudo apt-get install libcurl-devel`

# 2. Install Python

In this first part we are going to install Python 3 and pip. We are going to follow the following [tutorial](https://thelazylog.com/install-python-as-local-user-on-linux/) in the next sections.

## 2.1 Installation of Python 3.8.2

We are going to install Python 3.8.2. *Note : You can use any Python version higher than 3.8.2.*

```sh
mkdir $HOME/python
cd $HOME/python
wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
tar zxfv Python-3.8.2.tgz
find $HOME/python -type d | xargs chmod 0755
cd Python-3.8.2
./configure --prefix=$HOME/python
```

If you  get an "No acceptable C compiler found in $PATH" error while running the last command, it mean that python could not find gcc. Please then run the following  command:
- Redhat base:

```sh
sudo yum groupinstall "Development Tools"
sudo yum install openssl-devel
sudo yum -y install libffi-devel
```

- Debian base:

```sh
sudo apt-get install build-essential
sudo apt-get install openssl-devel
sudo apt-get -y install libffi-devel
```

Solution found on [stackoverflow](https://stackoverflow.com/questions/19816275/python-no-acceptable-c-compiler-found-in-path-when-installing-python).
You will then be able to redo the previous command (`./configure --prefix=$HOME/python`).

To finish run the following:

```sh
make && make install
export PATH=$HOME/python/Python-3.8.2/:$PATH
export PYTHONPATH=$HOME/python/Python-3.8.2
```

## 2.2 Installation of pip

Pypi (Python Package Index) is a repository of software for the Python programming language. In other word, Pypi is where most libraries are stored and updated. Anyone can download any library on Pypi and upload his own library. To get a library from Pypi we need pip. Two way to install pip and one way to update if you already have pip. You can find the official tutorial [here](https://pip.pypa.io/en/stable/installation/). To know if you have pip already installed:

`pip --version`

If it is installed go to [Changing pip version](#Changing-pip-version) else go to [Ensurepip](#Ensurepip) or [Get-pip](#Get-pip).

### Ensurepip

Python comes with an [`ensurepip`](https://docs.python.org/3/library/ensurepip.html#module-ensurepip "(in Python v3.9)") [module](https://pip.pypa.io/en/stable/installation/#python), which can install pip in a Python environment.
- Linux/MacOS:

`python -m ensurepip --upgrade`

### Get-pip

This is a Python script that uses some bootstrapping logic to install pip.
-   Download the script, from  [get-pip.py](https://bootstrap.pypa.io/get-pip.py).
-   Open a terminal/command prompt,  `cd`  to the folder containing the  `get-pip.py`  file and run:

`python get-pip.py`

### Changing pip version

If you already have an old version of pip3 or you need to change the version of your pip, You can run the next command (we are getting the 21.2.2 version in the next example):

```sh
export PATH=$HOME/python/bin:$PATH
pip3 install pip==21.2.2
```

## 2.3 Ensure python and pip are installed

To ensure that python and pip are installed we are going to run the `which` command.
The following command:

    which python

Should return:

> ~/python/Python-3.8.2/python

We are going to do the same thing for pip:

    which pip

Which should return:

> ~/.local/bin/pip

We can also check their versions:

    python --version
    pip --version
 
Be sure to have a **python** version higher than **3.8.2** (version 3.8.2 is recommanded) and **pip** version higher than **21.2.2**.

You can now export those path:

```sh
export PATH=$HOME/python/Python-3.8.2/:$HOME/.local/bin:$PATH
export PYTHONPATH=$HOME/python/Python-3.8.2/:$PYTHONPATH
export LD_LIBRARY_PATH="$(python -c 'import site; print(site.getsitepackages()[0])')":$LD_LIBRARY_PATH
```

## 2.4 Dowload pycurl

PycURL is a Python interface to [libcurl](https://curl.haxx.se/libcurl/), the multiprotocol file transfer library. Similarly to the [urllib](http://docs.python.org/library/urllib.html) Python module, PycURL can be used to fetch objects identified by a URL from a Python program.

Dbs3-client use pycurl and to avoid error, you will need to run:

```sh
export PYCURL_SSL_LIBRARY=nss
pip install --compile --install-option="--with-nss" --no-cache-dir pycurl==7.43.0.6
```

## 2.5 Download DBS3-Client from pypi

You now have **python3** and **pip** installed. You are finally able to download libraries from pypi.
On pypi you will be able to find [dbs3-client](https://pypi.org/project/dbs3-client/).

### a. Download dbs3-client

As any library on pypi, you can download dbs3-client using the following command:

    pip install dbs3-client

If you need a specific **version** of it, you can precise the version wanted like the following example (getting the 3.17.0 version of dbs3-client):

    pip install dbs3-client==3.17.0

### b. Export variable

You have now succesfully installed DBSClient. Before we start using it, you need to export the DBS3-Client_Root to the site package:

```sh
export DBS3_CLIENT_ROOT="$(python -c 'import site; print(site.getsitepackages()[0])')"/DbsClient/
```

We will now set up the key and certificate. First we will convert our userkey.pem into rsa key:

    openssl rsa -in $HOME/.globus/f_userkey.pem -out $HOME/.globus/rsauserkey.pem

You can also export your certificate and key to make your python script easier (if you export, you won't have to tell python where your certificate and key are):

```sh
export X509_USER_CERT=$HOME/.globus/usercert.pem
export X509_USER_KEY=$HOME/.globus/rsauserkey.pem
```

# 3. Ensure everything work
## 3.1 Ensure python libraries work

We can quickly check if library work using the python interpreter in the terminal. You can load python interpreter with:

`python`

Then you can try to import dbsClient and RestClient (which is dbs3-pycurl):

```python
from dbsClient.apis.dbsClient import *
from RestClient.RestApi import RestApi
```

If there is no error message, you library works.

## 3.2 Try to read

You can run the following python script to ensure you can read:

```python
# DBS-3 imports
from dbsClient.apis.dbsClient import *
url="https://cmsweb-testbed.cern.ch/dbs/prod/global/DBSReader/"
# API Object
dbs3api = DbsApi(url=url)

# print(dbs3api.listDataTiers())

print(dbs3api.listDataTiers(data_tier_name='AOD'))
```

## 3.3 Try to write

You can run the following python script to ensure you can write:

```python
from dbsClient.apis.dbsClient import *
import os

url="https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/"
# API Object
dbs3api = DbsApi(url=url)

for j in range(101, 102):
    acq_era={'acquisition_era_name': 'FirstName_LastName%s' %(j), 'description': 'testing_insert_era2',
         'start_date':1234567890}

    print(dbs3api.insertAcquisitionEra(acq_era))


print(dbs3api.listAcquisitionEras_ci(acquisition_era_name='FirstName_LastName%'))

# print("case seneitive")

# print(dbs3api.listAcquisitionEras(acquisition_era_name='FirstName_LastName%'))
print(dbs3api.listDataTiers(data_tier_name='AOD'))
```
