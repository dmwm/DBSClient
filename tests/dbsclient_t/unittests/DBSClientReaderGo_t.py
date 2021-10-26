"""
aggregation/stream unittests
"""

import os
import sys
import unittest

from dbs.apis.dbsClient import parseStream, aggAttribute, \
        aggRuns, aggReleaseVersions, aggDatasetAccessTypes, \
        aggFileLumis, aggFileParents, aggFileChildren, aggFileParentsByLumi

class DBSClientReaderGo_t(unittest.TestCase):

    def __init__(self, methodName='runGoTest'):
        super(DBSClientReaderGo_t, self).__init__(methodName)

    def testParseStream(self):
        """test parseStream function"""
        results = """{"foo":1}\n{"foo":2}\n{"foo":3}\n"""
        data = [r for r in parseStream(results)]
        self.assertTrue(len(data) == 3)
        values = []
        for rec in data:
            values.append(rec["foo"])
        self.assertTrue(values == [1, 2, 3])

    def testAggAttribute(self):
        """test aggAttribute function"""
        data = [{"foo":1, "x":1}, {"foo":2, "x":1}, {"foo":3, "x":1}]
        results = aggAttribute(data, "foo")
        self.assertTrue(results, [{"foo":[1,2,3], "x":1}])

    def testAggRuns(self):
        """test aggRuns function"""
        data = [{"run_num":1, "x":1}, {"run_num":2, "x":1}, {"run_num":3, "x":1}]
        results = aggRuns(data)
        self.assertTrue(results, [{"run_num":[1,2,3], "x":1}])

    def testAggReleaseVersions(self):
        """test aggReleaseVersions function"""
        data = [{"release_version":1, "x":1}, {"release_version":2, "x":1}, {"release_version":3, "x":1}]
        results = aggReleaseVersions(data)
        self.assertTrue(results, [{"release_version":[1,2,3], "x":1}])

    def testAggDatasetAccessTypes(self):
        """test aggDatasetAccessTypes function"""
        data = [{"dataset_access_type":1, "x":1}, {"dataset_access_type":2, "x":1}, {"dataset_access_type":3, "x":1}]
        results = aggDatasetAccessTypes(data)
        self.assertTrue(results, [{"dataset_access_type":[1,2,3], "x":1}])

    def testAggFileLumis(self):
        """test aggFileLumis function"""
        data = [
            {"logical_file_name":"lfn","lumi_section_num":1,"run_num":97},
            {"logical_file_name":"lfn","lumi_section_num":12,"run_num":98},
            {"logical_file_name":"lfn","lumi_section_num":13,"run_num":99}
        ]
        results = aggFileLumis(data)
        self.assertTrue(results, [{"logical_file_name": "lfn", "lumi_section_num":[1,2,3], "run_num":1}])

    def testAggFileParents(self):
        """test aggFileParents function"""
        data = [
            {"logical_file_name":"lfn1", "parent_logical_file_name":"parent1"},
            {"logical_file_name":"lfn1", "parent_logical_file_name":"parent2"},
            {"logical_file_name":"lfn2", "parent_logical_file_name":"parent3"}
        ]
        results = aggFileParents(data)
        expect = [
            {"logical_file_name":"lfn1", "parent_logical_file_name": ["parent1", "parent2"]},
            {"logical_file_name":"lfn2", "parent_logical_file_name": ["parent3"]}
        ]
        self.assertTrue(results, expect)

    def testAggFileChildren(self):
        """test aggFileChildren function"""
        data = [
            {"logical_file_name":"lfn1", "child_logical_file_name":"child1"},
            {"logical_file_name":"lfn1", "child_logical_file_name":"child2"},
            {"logical_file_name":"lfn2", "child_logical_file_name":"child3"}
        ]
        results = aggFileChildren(data)
        expect = [
            {"logical_file_name":"lfn1", "child_logical_file_name": ["child1", "child2"]},
            {"logical_file_name":"lfn2", "child_logical_file_name": ["child3"]}
        ]
        self.assertTrue(results, expect)

    def testiAggFileParentsByLumi(self):
        """test aggFileParentsByLumi function"""
        data = [{'cid':1, 'pid': 1}, {'cid':2, 'pid':2}]
        results = aggFileParentsByLumi(data)
        expect = [{'child_parent_id_list': [[1,1], [2,2]]}]
        self.assertTrue(results, expect)

if __name__ == "__main__":
    SUITE = unittest.TestLoader().loadTestsFromTestCase(DBSClientReaderGo_t)
    unittest.TextTestRunner(verbosity=2).run(SUITE)
