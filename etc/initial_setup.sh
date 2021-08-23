if [ -z $( which curl ) ]
then
    sudo yum install libcurl-devel
    sudo yum groupinstall "Development Tools"
    sudo yum install openssl-devel
    sudo yum -y install libffi-devel
fi

version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
parsedVersion=$(echo "${version//./}")
if [[ -z "$version" || "$parsedVersion" -ge 382 && "$can_run"="true" ]]
then
    mkdir $HOME/python
    cd $HOME/python
    wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
    tar zxfv Python-3.8.2.tgz
    find $HOME/python -type d | xargs chmod 0755
    cd Python-3.8.2
    ./configure --prefix=$HOME/python
    make && make install
    export PATH=$HOME/python/Python-3.8.2/:$PATH
    export PYTHONPATH=$HOME/python/Python-3.8.2
    export PATH=$HOME/python/bin:$PATH
    pip3 install pip==21.2.2
fi

export PATH=$HOME/python/Python-3.8.2/:$HOME/.local/bin:$PATH
export PYTHONPATH=$HOME/python/Python-3.8.2/:$PYTHONPATH
export LD_LIBRARY_PATH="$(python -c 'import site; print(site.getsitepackages()[0])')":$LD_LIBRARY_PATH
export PYCURL_SSL_LIBRARY=nss
pip install --compile --install-option="--with-nss" --no-cache-dir pycurl==7.43.0.6

pip install dbs3-client
export DBS3_CLIENT_ROOT="$(python -c 'import site; print(site.getsitepackages()[0])')"/DbsClient/
openssl rsa -in $HOME/.globus/f_userkey.pem -out $HOME/.globus/rsauserkey.pem
export X509_USER_CERT=$HOME/.globus/usercert.pem
export X509_USER_KEY=$HOME/.globus/rsauserkey.pem
