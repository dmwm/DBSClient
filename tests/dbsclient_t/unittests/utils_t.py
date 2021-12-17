"""
various utilities unittests
"""

import os
import sys
import unittest

from dbs.apis.dbsClient import compress, decompress, fixUrlPath

class DBSClientUtils_t(unittest.TestCase):

    def __init__(self, methodName='runGoTest'):
        super(DBSClientUtils_t, self).__init__(methodName)

    def testCompress(self):
        """test compress and decompress functions"""
        data = """{"foo":1}\n{"foo":2}\n{"foo":3}\n"""
        comp_data = compress(data)
        orig_data = decompress(comp_data)
        self.assertTrue(data == orig_data)
        # test bytes input
        data = b"""{"foo":1}\n{"foo":2}\n{"foo":3}\n"""
        comp_data = compress(data)
        orig_data = bytes(decompress(comp_data), encoding='utf-8')
        self.assertTrue(data == orig_data)

    def testfixUrlPath(self):
        """test fixUrlPath function"""
        url = "http://dbs.com/dbs/int/global/DBSReader"
        res = fixUrlPath("http://dbs.com/dbs/int/global/DBSReader/")
        self.assertTrue(res == url)
        res = fixUrlPath("http://dbs.com////dbs/int/global/DBSReader/")
        self.assertTrue(res == url)
        res = fixUrlPath("http://dbs.com////dbs/int/////global////DBSReader/")
        self.assertTrue(res == url)
        try:
            res = fixUrlPath("//dbs.com////dbs/int/////global////DBSReader/")
        except Exception as e:
            if 'wrong URL pattern' not in str(e):
                self.fail("Wrong exception was raised.")
            else:
                pass

if __name__ == "__main__":
    SUITE = unittest.TestLoader().loadTestsFromTestCase(DBSClientUtils_t)
    unittest.TextTestRunner(verbosity=2).run(SUITE)
