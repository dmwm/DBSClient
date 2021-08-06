#!/bin/bash
# install

can_run=true

# Test python version
version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
if [[ -z "$version" ]]
then
    echo "No Python!"
    can_run=false
fi

parsedVersion=$(echo "${version//./}")
if [[ "$parsedVersion" >= "360" && "$can_run"=true ]]
then
    echo $parsedVersion
    echo "Valid version"
else
    echo "Invalid version. You need a version of python equal or higher than 3.6.0"
    can_run=false
fi

if [ "$can_run"=true ]
then
    FILE=./var.sh
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

    source ./var.sh
    export PATH=$PythonFolder:$HOME/.local/bin:$PATH
    export PYTHONPATH=$PythonFolder:$PYTHONPATH
    export DBS3_CLIENT_ROOT=$SitePackageFolder/DbsClient/
    export LD_LIBRARY_PATH=$SitePackageFolder:$LD_LIBRARY_PATH
    export X509_USER_CERT=$HOME/.globus/usercert.pem
    export X509_USER_KEY=$HOME/.globus/userkey.pem

    # test
    if [ "$1" = "test" ];
    then
        export DBS_WRITER_URL=https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/
        export DBS_READER_URL=https://cmsweb-testbed.cern.ch/dbs/prod/global/DBSReader/
        
        echo $DBS_WRITER_URL
        echo $DBS_READER_URL
    fi


    echo $DBS3_CLIENT
fi
