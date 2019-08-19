Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA291D77
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53183 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726808AbfHSG6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:31 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNO004602;
        Mon, 19 Aug 2019 09:58:31 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 12/14] tests: Fix test locating process
Date:   Mon, 19 Aug 2019 09:58:25 +0300
Message-Id: <20190819065827.26921-13-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a module-specific load_tests method in __init__.py. It currently
locates all existing tests under its directory (files should start
with 'test_') and runs them without any parameters. In order to run a
test with a specific set of parameters, user can add the relevant
lines in __init__.py (example provided in the file).

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 run_tests.py      | 20 +++++++-------------
 tests/__init__.py | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/run_tests.py b/run_tests.py
index dbee92d942bd..4f6b212dab9f 100644
--- a/run_tests.py
+++ b/run_tests.py
@@ -1,22 +1,16 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved.  See COPYING file
-import unittest,os,os.path,fnmatch
-import tests
 
+import unittest
 
+
+# Run from /usr/share/doc/rdma-core-<version>
 def test_all():
-    # FIXME: This implementation is for older Python versions, will
-    # be replaced with discover()
-    return test_suite
+    module = __import__('tests')
+    loader = unittest.TestLoader()
+    suite = loader.loadTestsFromModule(module)
+    return suite
 
-module = __import__("tests")
-fns = [os.path.splitext(I)[0] for I in fnmatch.filter(os.listdir(module.__path__[0]),"*.py")]
-fns.remove("__init__")
-for I in fns:
-    __import__("tests." + I)
-test_suite = unittest.TestSuite(unittest.defaultTestLoader.loadTestsFromNames(fns,module))
 
 if __name__ == '__main__':
     unittest.main(defaultTest="test_all")
-
-
diff --git a/tests/__init__.py b/tests/__init__.py
index e69de29bb2d1..7a2efdfb6e6b 100644
--- a/tests/__init__.py
+++ b/tests/__init__.py
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc . All rights reserved. See COPYING file
+
+import unittest
+
+
+def load_tests(loader, standard_tests, pattern):
+    loader = unittest.TestLoader()
+    suite = loader.discover('tests')
+    return suite
+#   To run only some test cases / parametrized tests:
+#   1. Add RDMATestCase to the imports:
+#    from tests.base import RDMATestCase
+#   2. Replace the current TestSuite with a customized one and add tests to it
+#      (parameters are optional)
+#    suite = unittest.TestSuite()
+#    suite.addTest(RDMATestCase.parametrize(YourTestCase, dev_name='rocep0s8f0', ...))
-- 
2.21.0

