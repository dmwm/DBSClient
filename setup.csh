pip uninstall pycurl
export PYCURL_SSL_LIBRARY=nss
pip install --compile --install-option="--with-nss" --no-cache-dir pycurl
export DBS_WRITER_URL=https://cmsweb-testbed.cern.ch/dbs/int/global/DBSWriter/
export DBS_WRITER_URL=https://cmsweb-prod.cern.ch/dbs/prod/global/DBSReader/datatiers
export X509_USER_CERT=$Home/.globus/usercert.pem
export X509_USER_KEY=$Home/.globus/userkey.pem
