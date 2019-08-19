Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E423891D79
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfHSG6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:38 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53151 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726390AbfHSG6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:30 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUND004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 01/14] pyverbs/tests: Rename base class
Date:   Mon, 19 Aug 2019 09:58:14 +0300
Message-Id: <20190819065827.26921-2-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rename PyverbsTestCase to PyverbsAPITestCase as a preparation for
addition of feature-based tests.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/tests/addr.py   | 4 ++--
 pyverbs/tests/base.py   | 2 +-
 pyverbs/tests/cq.py     | 8 ++++----
 pyverbs/tests/device.py | 4 ++--
 pyverbs/tests/mr.py     | 8 ++++----
 pyverbs/tests/pd.py     | 4 ++--
 pyverbs/tests/qp.py     | 4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/pyverbs/tests/addr.py b/pyverbs/tests/addr.py
index 1326eec0d0f6..1c56f56bd0bd 100644
--- a/pyverbs/tests/addr.py
+++ b/pyverbs/tests/addr.py
@@ -1,15 +1,15 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.  See COPYING file
 
+from pyverbs.tests.base import PyverbsAPITestCase
 from pyverbs.addr import GlobalRoute, AHAttr, AH
 from pyverbs.pyverbs_error import PyverbsError
-from pyverbs.tests.base import PyverbsTestCase
 import pyverbs.device as d
 import pyverbs.enums as e
 from pyverbs.pd import PD
 from pyverbs.cq import WC
 
-class AHTest(PyverbsTestCase):
+class AHTest(PyverbsAPITestCase):
     """
     Test various functionalities of the AH class.
     """
diff --git a/pyverbs/tests/base.py b/pyverbs/tests/base.py
index 9541e61b0d55..a1eae2becdc0 100644
--- a/pyverbs/tests/base.py
+++ b/pyverbs/tests/base.py
@@ -5,7 +5,7 @@ import unittest
 
 import pyverbs.device as d
 
-class PyverbsTestCase(unittest.TestCase):
+class PyverbsAPITestCase(unittest.TestCase):
     def setUp(self):
         """
         Opens the devices and queries them
diff --git a/pyverbs/tests/cq.py b/pyverbs/tests/cq.py
index 38f145f865ba..e1e56d363011 100644
--- a/pyverbs/tests/cq.py
+++ b/pyverbs/tests/cq.py
@@ -7,12 +7,12 @@ import random
 
 from pyverbs.cq import CompChannel, CQ, CqInitAttrEx, CQEX
 from pyverbs.pyverbs_error import PyverbsError
-from pyverbs.tests.base import PyverbsTestCase
+from pyverbs.tests.base import PyverbsAPITestCase
 import pyverbs.tests.utils as u
 import pyverbs.enums as e
 
 
-class CQTest(PyverbsTestCase):
+class CQTest(PyverbsAPITestCase):
     """
     Test various functionalities of the CQ class.
     """
@@ -84,7 +84,7 @@ class CQTest(PyverbsTestCase):
                 cq.close()
 
 
-class CCTest(PyverbsTestCase):
+class CCTest(PyverbsAPITestCase):
     """
     Test various functionalities of the Completion Channel class.
     """
@@ -105,7 +105,7 @@ class CCTest(PyverbsTestCase):
             cc.close()
 
 
-class CQEXTest(PyverbsTestCase):
+class CQEXTest(PyverbsAPITestCase):
     """
     Test various functionalities of the CQEX class.
     """
diff --git a/pyverbs/tests/device.py b/pyverbs/tests/device.py
index 54ff438d12fa..63f195156119 100644
--- a/pyverbs/tests/device.py
+++ b/pyverbs/tests/device.py
@@ -8,7 +8,7 @@ import resource
 import random
 
 from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
-from pyverbs.tests.base import PyverbsTestCase
+from pyverbs.tests.base import PyverbsAPITestCase
 import pyverbs.tests.utils as u
 import pyverbs.device as d
 
@@ -137,7 +137,7 @@ class DeviceTest(unittest.TestCase):
                         format(p=port))
 
 
-class DMTest(PyverbsTestCase):
+class DMTest(PyverbsAPITestCase):
     """
     Test various functionalities of the DM class.
     """
diff --git a/pyverbs/tests/mr.py b/pyverbs/tests/mr.py
index e303fd575de4..4be3987fc18b 100644
--- a/pyverbs/tests/mr.py
+++ b/pyverbs/tests/mr.py
@@ -7,7 +7,7 @@ from itertools import combinations as com
 import random
 
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
-from pyverbs.tests.base import PyverbsTestCase
+from pyverbs.tests.base import PyverbsAPITestCase
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.mr import MR, MW, DMMR
 import pyverbs.tests.utils as u
@@ -18,7 +18,7 @@ import pyverbs.enums as e
 MAX_IO_LEN = 1048576
 
 
-class MRTest(PyverbsTestCase):
+class MRTest(PyverbsAPITestCase):
     """
     Test various functionalities of the MR class.
     """
@@ -154,7 +154,7 @@ class MRTest(PyverbsTestCase):
                         mr.buf
 
 
-class MWTest(PyverbsTestCase):
+class MWTest(PyverbsAPITestCase):
     """
     Test various functionalities of the MW class.
     """
@@ -200,7 +200,7 @@ class MWTest(PyverbsTestCase):
                                        format(t=mw_type))
 
 
-class DMMRTest(PyverbsTestCase):
+class DMMRTest(PyverbsAPITestCase):
     """
     Test various functionalities of the DMMR class.
     """
diff --git a/pyverbs/tests/pd.py b/pyverbs/tests/pd.py
index 5072a4a35de1..87528db7d437 100644
--- a/pyverbs/tests/pd.py
+++ b/pyverbs/tests/pd.py
@@ -5,13 +5,13 @@ Test module for pyverbs' pd module.
 """
 import random
 
-from pyverbs.tests.base import PyverbsTestCase
+from pyverbs.tests.base import PyverbsAPITestCase
 from pyverbs.base import PyverbsRDMAErrno
 import pyverbs.device as d
 from pyverbs.pd import PD
 
 
-class PDTest(PyverbsTestCase):
+class PDTest(PyverbsAPITestCase):
     """
     Test various functionalities of the PD class.
     """
diff --git a/pyverbs/tests/qp.py b/pyverbs/tests/qp.py
index be152d4ca5bd..bbf28244f641 100644
--- a/pyverbs/tests/qp.py
+++ b/pyverbs/tests/qp.py
@@ -5,7 +5,7 @@ Test module for pyverbs' qp module.
 """
 import random
 
-from pyverbs.tests.base import PyverbsTestCase
+from pyverbs.tests.base import PyverbsAPITestCase
 from pyverbs.qp import QPInitAttr, QPAttr, QP
 import pyverbs.tests.utils as u
 import pyverbs.enums as e
@@ -13,7 +13,7 @@ from pyverbs.pd import PD
 from pyverbs.cq import CQ
 
 
-class QPTest(PyverbsTestCase):
+class QPTest(PyverbsAPITestCase):
     """
     Test various functionalities of the QP class.
     """
-- 
2.21.0

