#!/bin/csh
# install

set can_run=true

# Test python version
set version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
if (( -z "$version" ))
then
    echo "No Python!"
    set can_run=false
fi

set parsedVersion=$(echo "${version//./}")
if (( "$parsedVersion" > "360" && "$can_run"=true ))
then
    echo "Valid version"
else
    echo "Invalid version. You need a version of python equal or higher than 3.6.0"
    set can_run=false
fi

if [ "$can_run"=true ]
then
    set FILE=./var.sh
    if ( ! -f $FILE )
    then
        >$FILE
        echo "PythonFolder=$(dirname "$(which python)")" >> $FILE
        echo "SitePackageFolder=$(python -c 'import site; print(site.getsitepackages()[0])')" >> $FILE

        # Loading pycurl
        pip uninstall pycurl
        export PYCURL_SSL_LIBRARY=nss
        pip install --compile --install-option="--with-nss" --no-cache-dir pycurl
    endif

    source ./var.sh
    export PATH=$PythonFolder:$HOME/.local/bin:$PATH
    export PYTHONPATH=$PythonFolder:$PYTHONPATH
    export DBS3_CLIENT=$SitePackageFolder/DbsClient/
    export LD_LIBRARY_PATH=$SitePackageFolder:$LD_LIBRARY_PATH
    export X509_USER_CERT=$HOME/.globus/usercert.pem
    export X509_USER_KEY=$HOME/.globus/userkey.pem

    # test
    if ( "$1" = "test" )
    then
        export DBS_WRITER_URL=https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/
        export DBS_READER_URL=https://cmsweb-testbed.cern.ch/dbs/prod/global/DBSReader/
        
        echo $DBS_WRITER_URL
        echo $DBS_READER_URL
    endif


    echo $DBS3_CLIENT
fi

