#!/bin/csh
# install

set can_run=True

# Test python version
set version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
if (( -z "$version" ))
then
    echo "No Python!"
    set can_run=False
fi

set parsedVersion=$(echo "${version//./}")
if (( "$parsedVersion" -lt "360" && "$parsedVersion" -gt "380" && $can_run=True ))
then
    echo "Valid version"
else
    echo "Invalid version"
    set can_run=False
fi

# Create the directory etc if needed
if ( ! -d /etc/ );
then
    mkdir /etc/
fi

if [ $can_run=True ]
then
    set FILE=~/etc/var.sh
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

    source ~/etc/var.sh
    export PATH=$PythonFolder:$PATH
    export PYTHONPATH=$PythonFolder
    export PATH=$HOME/.local/bin:$PATH
    export DBS3_CLIENT=$SitePackageFolder/DbsClient/
    export LD_LIBRARY_PATH=/usr/bin/
    export X509_USER_CERT=$HOME/.globus/usercert.pem
    export X509_USER_KEY=$HOME/.globus/userkey.pem

    # test
    if ( "$1" = "test" )
    then
        export DBS_WRITER_URL=https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/
        export DBS_READER_URL=https://cmsweb-prod.cern.ch/dbs/prod/global/DBSReader/
        
        echo $DBS_WRITER_URL
        echo $DBS_READER_URL
    endif


    echo $DBS3_CLIENT
fi

