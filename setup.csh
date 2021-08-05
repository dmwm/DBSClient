pip uninstall pycurl
export PYCURL_SSL_LIBRARY=nss
pip install --compile --install-option="--with-nss" --no-cache-dir pycurl
export DBS_WRITER_URL=https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/
export DBS_READER_URL=https://cmsweb-prod.cern.ch/dbs/prod/global/DBSReader/
export X509_USER_CERT=$HOME/.globus/usercert.pem
export X509_USER_KEY=$HOME/.globus/userkey.pem
export DBS3_CLIENT_ROOT=$HOME/python/lib/python3.8/site-packages/dbsClient/
