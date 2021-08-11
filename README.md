[![Linux](https://svgshare.com/i/Zhy.svg)](https://svgshare.com/i/Zhy.svg) [![macOS](https://svgshare.com/i/ZjP.svg)](https://svgshare.com/i/ZjP.svg)
# DBS3-Client
The **Data Bookkeeping Service 3** (DBS 3) provides an improved event data catalog for Monte Carlo and recorded data of the CMS experiment. It 
provides the necessary information used for tracking datasets, for example the data processing history, files and runs associated with a given 
dataset, and much more. DBS 3 has been completely re-designed and re-implemented in Python on the basis of a CherryPy based environment for 
developing RESTful (Representational State Transfer) web services, which is commonly used within the data management and workload management (DMWM) 
group of CMS. DBS 3 is using the Java Script Object Notation (JSON) dataformat for interchanging information and Oracle as database backend.
# 1. Install Python
In this first part we are going to install Python 3 and pip. We are going to follow the following 
[tutorial](https://thelazylog.com/install-python-as-local-user-on-linux/) in the next sections.
## 1.1 Installation of Python 3.8.2
We are going to install Python 3.8.2.
    mkdir $HOME/python
    cd $HOME/python
    wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
    tar zxfv Python-3.8.2.tgz
    find $HOME/python -type d | xargs chmod 0755
    cd Python-3.8.2
    ./configure --prefix=$HOME/python If you get an "No acceptable C compiler found in $PATH" error while running the last command, it mean that 
python could not find gcc. Please then run the following command: - Redhat base: `sudo yum groupinstall "Development Tools"` `sudo yum install 
openssl-devel` `sudo yum -y install libffi-devel` - Debian base: `sudo apt-get install build-essential` `sudo apt-get install openssl-devel` `sudo 
apt-get -y install libffi-devel` Solution found on 
[stackoverflow](https://stackoverflow.com/questions/19816275/python-no-acceptable-c-compiler-found-in-path-when-installing-python). You will then be 
able to redo the previous command (`./configure --prefix=$HOME/python`). To finish run the following: `make && make install` `export 
PATH=$HOME/python/Python-3.8.2/:$PATH` `export PYTHONPATH=$HOME/python/Python-3.8.2`
## 1.2 Installation of pip
Pypi (Python Package Index) is a repository of software for the Python programming language. In other word, Pypi is where most libraries are stored 
and updated. Anyone can download any library on Pypi and upload his own library. To get a library from Pypi we need pip. Two way to install pip. You 
can find the official tutorial [here](https://pip.pypa.io/en/stable/installation/).
### a. ensurepip
Python comes with an [`ensurepip`](https://docs.python.org/3/library/ensurepip.html#module-ensurepip "(in Python v3.9)") 
[module](https://pip.pypa.io/en/stable/installation/#python), which can install pip in a Python environment. - Linux/MacOS: `python -m ensurepip 
--upgrade` - Windows: `py -m ensurepip --upgrade`
### b. get-pip
This is a Python script that uses some bootstrapping logic to install pip. - Download the script, from 
[get-pip.py](https://bootstrap.pypa.io/get-pip.py). - Open a terminal/command prompt, `cd` to the folder containing the `get-pip.py` file and run: -- 
Linux/MacOS: `python get-pip.py` -- Windows: `py get-pip.py`
### c. Changing pip version
If you already have an old version of pip3 or you need to change the version of your pip, You can run the next command (we are getting the 21.2.2 
version in the next example):
    export PATH=$HOME/python/bin:$PATH
	pip3 install pip==21.2.2
## 1.3 Ensure python and pip are installed
To ensure that python and pip are installed we are going to run the `which` command. The following command:
    which python Should return:
> ~/python/Python-3.8.2/python
We are going to do the same thing for pip:
    which pip Which should return:
> ~/.local/bin/pip
We can also check their versions:
    python --version
    pip --version
 
Be sure to have a **python** version higher than **3.8.2** (version 3.8.2 is recommanded) and **pip** version higher than **21.0.0**. You can now 
export those path:
    export PATH=$HOME/python/Python-3.8.2/:$HOME/.local/bin:$PATH
	export PYTHONPATH=$HOME/python/Python-3.8.2/:$PYTHONPATH
	export LD_LIBRARY_PATH="$(python -c 'import site; print(site.getsitepackages()[0])')":$LD_LIBRARY_PATH
## 1.4 Download of libcurl
*Note: If libcurl is already installed, you can skip this step.* To use libcurl, is highly recommanded to use linux or MacOS. Dbs3-client use pycurl, 
which requires libcurl. We will see in this section how to get libcurl. Run the following command: - Redhat base: `sudo yum install libcurl-devel` - 
Debian base: `sudo apt-get install libcurl-devel`
## 1.5 Dowload pycurl
PycURL is a Python interface to [libcurl](https://curl.haxx.se/libcurl/), the multiprotocol file transfer library. Similarly to the 
[urllib](http://docs.python.org/library/urllib.html) Python module, PycURL can be used to fetch objects identified by a URL from a Python program. 
Dbs3-client use pycurl and to avoid error, you will need to run:
	export PYCURL_SSL_LIBRARY=nss
    pip install --compile --install-option="--with-nss" --no-cache-dir pycurl
## 1.6 Download DBS3-Client from pypi
You now have **python3** and **pip** installed. You are finally able to download libraries from pypi. On pypi you will be able to find 
[dbs3-client](https://pypi.org/project/dbs3-client/).
### a. Download dbs3-client
As any library on pypi, you can download dbs3-client using the following command:
    pip install dbs3-client If you need a specific **version** of it, you can precise the version wanted like the following example (getting the 
3.17.0 version of dbs3-client):
    pip install dbs3-client==3.17.0
### b. Export variable
You have now succesfully installed DBSClient. Before we start using it, you need to export the DBS3-Client_Root to the site package:
    export DBS3_CLIENT_ROOT="$(python -c 'import site; print(site.getsitepackages()[0])')"/DbsClient/ You can also export your certificate and key to 
make your python script easier (if you export, you won't have to tell python where your certificate and key are):
    export X509_USER_CERT=$HOME/.globus/usercert.pem
	export X509_USER_KEY=$HOME/.globus/userkey.pem
### b. Dependencies
Dbs3-client have 2 python dependencies.
| Dependency's name | Pypi link | version | -------------------|-----------|---------| dbs3-pycurl | [dbs3-pycurl · 
| PyPI](https://pypi.org/project/dbs3-pycurl/) | 3.17.0 |
|pycurl| [pycurl · PyPI](https://pypi.org/project/pycurl/) |7.19.3|
