Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16C691D7B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfHSG6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:38 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53184 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726717AbfHSG6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNP004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 13/14] Documentation: Add background for rdma-core tests
Date:   Mon, 19 Aug 2019 09:58:26 +0300
Message-Id: <20190819065827.26921-14-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

testing.md describes the design behind the tests' infrastructure and
provides explanations for:
- How to run tests.
- How to control which tests to run and with which parameters.
- How to add tests.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 Documentation/testing.md | 126 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/testing.md

diff --git a/Documentation/testing.md b/Documentation/testing.md
new file mode 100644
index 000000000000..218dc36be478
--- /dev/null
+++ b/Documentation/testing.md
@@ -0,0 +1,126 @@
+# Testing in rdma-core
+
+rdma-core now offers an infrastructure for quick and easy additions of feature-
+specific tests.
+
+## Design
+### Resources Management
+`BaseResources` class is the basic objects aggregator available. It includes a
+Context and a PD.
+Inheriting from it is `TrafficResources` class, which also holds a MR, CQ and
+QP, making it enough to support loopback traffic testing. It exposes methods for
+creation of these objects which can be overridden by inheriting classes.
+Inheriting from `TrafficResources` are currently two class:
+- `RCResources`
+- `UDResources`
+
+Both add traffic-specific constants. `UDResources` for example overrides
+create_mr and adds the size of the GRH header to the message size. `RCResources`
+exposes a wrapper to modify the QP to RTS.
+
+### Tests-related Classes
+`unittest.TestCase` is a logical test unit in Python's unittest module.
+`RDMATestCase` inherits from it and adds the option to accept parameters
+(example will follow below) or use a random set of valid parameters:
+- If no device was provided, it iterates over the existing devices, for each
+  port of each device, it checks which GID indexes are valid (in RoCE, only
+  IPv4 and IPv6 based GIDs are used). Each <dev, port, gid> is added to an array
+  and one entry is selected.
+- If a device was provided, the same process is done for all ports of this
+  device, and so on.
+
+### Traffic Utilities
+tests/utils.py offers a few wrappers for common traffic operations, making the
+use of default values even shorter. Those traffic utilities accept an
+aggregation object as their first parameter and rely on that object to have
+valid RDMA resources for proper functioning.
+- get_[send, recv]_wr() creates a [Send, Recv]WR object with a single SGE. It
+  also sets the MR content to be 'c's for client side or 's's for server side
+  (this is later validated).
+- post_send() posts a single send request to the aggregation object's QP. If the
+  QP is a UD QP, an address vector will be added to the send WR.
+- post_recv() posts the given RecvWR <num> times, so it can be used to fill the
+  RQ prior to traffic as well as during traffic.
+- poll_cq() polls <num> completions from the CQ and raises an exception on a
+  non-success status.
+- validate() verifies that the data in the MR is as expected ('c's for server,
+  's's for client).
+- traffic() runs <num> iterations of send/recv between 2 players.
+
+## How to run rdma-core's tests
+The tests are not a Python package, as such they can be found under
+/usr/share/doc/rdma-core-{version}.
+In order to run all tests:
+```
+cd /usr/share/doc/rdma-core-26.0
+python3 run_tests.py
+```
+Output will be something like:
+```
+$ python3 run_tests.py
+..........................................ss...............
+----------------------------------------------------------------------
+Ran 59 tests in 13.268s
+
+OK (skipped=2)
+```
+A dot represents a passing test. 's' means a skipped test. 'E' means a test
+that failed.
+
+Tests can also be executed in verbose mode:
+```
+$ python3 run_tests.py -v
+test_create_ah (test_addr.AHTest) ... ok
+test_create_ah_roce (test_addr.AHTest) ... ok
+test_destroy_ah (test_addr.AHTest) ... ok
+test_create_comp_channel (test_cq.CCTest) ... ok
+< many more lines here>
+test_odp_rc_traffic (test_odp.OdpTestCase) ... skipped 'No dev/port/GID combinations, please check your setup and try again'
+test_odp_ud_traffic (test_odp.OdpTestCase) ... skipped 'No dev/port/GID combinations, please check your setup and try again'
+<more lines>
+
+----------------------------------------------------------------------
+Ran 59 tests in 12.857s
+
+OK (skipped=2)
+```
+Verbose mode provides the reason for skipping the test (if one was provided by
+the test developer).
+
+### Customized Execution
+tests/__init__.py defines a `load_tests` function that returns a
+unittest.TestSuite with the tests that will be executed.
+The default implementation collects all test_* methods from all the classes that
+inherit from `unittest.TestCase` (or `RDMATestCase`) and located in files under
+tests directory which names starts with test_.
+Users can replace that and create a suite that contains only a few selected
+tests:
+```
+suite = unittest.TestSuite()
+suite.addTest(RDMATestCase.parametrize(YourTestCase))
+```
+We're using 'parametrize' as it instantiates the TestCase for us.
+'parametrize' can accept arguments as well (device name, IB port, GID index and
+PKey index):
+```
+suite = unittest.TestSuite()
+suite.addTest(RDMATestCase.parametrize(YourTestCase, dev_name='devname'))
+```
+
+## Writing Tests
+The following section explains how to add a new test, using tests/test_odp.py
+as an example. It's a simple test that runs ping-pong over a few different
+traffic types.
+
+ODP requires capability check, so a decorator was added to tests/utils.py.
+The first change for ODP execution is when registering a memory region (need to
+set the ON_DEMAND access flag), so we do as follows:
+1. Create the players by inheriting from `RCResources` (for RC traffic).
+2. In the player, override create_mr() and add the decorator to it. It will run
+   before the actual call to ibv_reg_mr and if ODP caps are off, the test will
+   be skipped.
+ 3. Create the `OdpTestCase` by inheriting from `RDMATestCase`.
+ 4. In the test case, add a method starting with test_, to let the unittest
+    infrastructure that this is a test.
+ 5. In the test method, create the players (which already check the ODP caps)
+    and call the traffic() function, providing it the two players.
-- 
2.21.0

