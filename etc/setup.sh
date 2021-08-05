#!/bin/bash
# install
mkdir ~/etc/
FILE=~/etc/var.sh
if [ ! -f $FILE ];
then
    >$FILE
    echo "PythonFolder=$(dirname "$(which python)")" >> $FILE
    echo "SitePackageFolder=$(python -c 'import site; print(site.getsitepackages()[0])')" >> $FILE 
    
    # Loading pycurl
    pip uninstall pycurl
    export PYCURL_SSL_LIBRARY=nss
    pip install --compile --install-option="--with-nss" --no-cache-dir pycurl
fi

source ~/etc/var.sh
export PATH=$PythonFolder:$PATH
export PYTHONPATH=$PythonFolder
export PATH=$HOME/.local/bin:$PATH
export DBS3_CLIENT=$SitePackageFolder/DbsClient/
export LD_LIBRARY_PATH=$(which curl)
export X509_USER_CERT=$HOME/.globus/usercert.pem
export X509_USER_KEY=$HOME/.globus/userkey.pem

# test
if [ "$1" = "test" ];
then
    export DBS_WRITER_URL=https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/
    export DBS_READER_URL=https://cmsweb-prod.cern.ch/dbs/prod/global/DBSReader/
fi


echo $DBS3_CLIENT
