Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E447F91D72
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfHSG6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53157 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbfHSG6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:30 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNE004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 02/14] pyverbs: Move tests to a stand-alone directory
Date:   Mon, 19 Aug 2019 09:58:15 +0300
Message-Id: <20190819065827.26921-3-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819065827.26921-1-noaos@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Unittests can be added regardless of pyverbs, change the directory
hierarchy to reflect that.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 tests/CMakeLists.txt                            | 14 ++++++++++++++
 {pyverbs/tests => tests}/__init__.py            |  0
 {pyverbs/tests => tests}/base.py                |  0
 pyverbs/tests/addr.py => tests/test_addr.py     |  2 +-
 pyverbs/tests/cq.py => tests/test_cq.py         |  4 ++--
 pyverbs/tests/device.py => tests/test_device.py |  4 ++--
 pyverbs/tests/mr.py => tests/test_mr.py         |  4 ++--
 pyverbs/tests/pd.py => tests/test_pd.py         |  2 +-
 pyverbs/tests/qp.py => tests/test_qp.py         |  4 ++--
 {pyverbs/tests => tests}/utils.py               |  0
 10 files changed, 24 insertions(+), 10 deletions(-)
 create mode 100644 tests/CMakeLists.txt
 rename {pyverbs/tests => tests}/__init__.py (100%)
 rename {pyverbs/tests => tests}/base.py (100%)
 rename pyverbs/tests/addr.py => tests/test_addr.py (98%)
 rename pyverbs/tests/cq.py => tests/test_cq.py (98%)
 rename pyverbs/tests/device.py => tests/test_device.py (99%)
 rename pyverbs/tests/mr.py => tests/test_mr.py (99%)
 rename pyverbs/tests/pd.py => tests/test_pd.py (97%)
 rename pyverbs/tests/qp.py => tests/test_qp.py (99%)
 rename {pyverbs/tests => tests}/utils.py (100%)

diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
new file mode 100644
index 000000000000..f1ba542fab90
--- /dev/null
+++ b/tests/CMakeLists.txt
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019, Mellanox Technologies. All rights reserved. See COPYING file
+
+rdma_python_test(tests
+  __init__.py
+  test_addr.py
+  base.py
+  test_cq.py
+  test_device.py
+  test_mr.py
+  test_pd.py
+  test_qp.py
+  utils.py
+  )
diff --git a/pyverbs/tests/__init__.py b/tests/__init__.py
similarity index 100%
rename from pyverbs/tests/__init__.py
rename to tests/__init__.py
diff --git a/pyverbs/tests/base.py b/tests/base.py
similarity index 100%
rename from pyverbs/tests/base.py
rename to tests/base.py
diff --git a/pyverbs/tests/addr.py b/tests/test_addr.py
similarity index 98%
rename from pyverbs/tests/addr.py
rename to tests/test_addr.py
index 1c56f56bd0bd..9cc801226e69 100644
--- a/pyverbs/tests/addr.py
+++ b/tests/test_addr.py
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.  See COPYING file
 
-from pyverbs.tests.base import PyverbsAPITestCase
 from pyverbs.addr import GlobalRoute, AHAttr, AH
 from pyverbs.pyverbs_error import PyverbsError
+from tests.base import PyverbsAPITestCase
 import pyverbs.device as d
 import pyverbs.enums as e
 from pyverbs.pd import PD
diff --git a/pyverbs/tests/cq.py b/tests/test_cq.py
similarity index 98%
rename from pyverbs/tests/cq.py
rename to tests/test_cq.py
index e1e56d363011..7848f39c9c63 100644
--- a/pyverbs/tests/cq.py
+++ b/tests/test_cq.py
@@ -7,9 +7,9 @@ import random
 
 from pyverbs.cq import CompChannel, CQ, CqInitAttrEx, CQEX
 from pyverbs.pyverbs_error import PyverbsError
-from pyverbs.tests.base import PyverbsAPITestCase
-import pyverbs.tests.utils as u
+from tests.base import PyverbsAPITestCase
 import pyverbs.enums as e
+import tests.utils as u
 
 
 class CQTest(PyverbsAPITestCase):
diff --git a/pyverbs/tests/device.py b/tests/test_device.py
similarity index 99%
rename from pyverbs/tests/device.py
rename to tests/test_device.py
index 63f195156119..e395e793c28f 100644
--- a/pyverbs/tests/device.py
+++ b/tests/test_device.py
@@ -8,8 +8,8 @@ import resource
 import random
 
 from pyverbs.pyverbs_error import PyverbsError, PyverbsRDMAError
-from pyverbs.tests.base import PyverbsAPITestCase
-import pyverbs.tests.utils as u
+from tests.base import PyverbsAPITestCase
+import tests.utils as u
 import pyverbs.device as d
 
 PAGE_SIZE = resource.getpagesize()
diff --git a/pyverbs/tests/mr.py b/tests/test_mr.py
similarity index 99%
rename from pyverbs/tests/mr.py
rename to tests/test_mr.py
index 4be3987fc18b..e87fb33624ed 100644
--- a/pyverbs/tests/mr.py
+++ b/tests/test_mr.py
@@ -7,13 +7,13 @@ from itertools import combinations as com
 import random
 
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
-from pyverbs.tests.base import PyverbsAPITestCase
+from tests.base import PyverbsAPITestCase
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.mr import MR, MW, DMMR
-import pyverbs.tests.utils as u
 import pyverbs.device as d
 from pyverbs.pd import PD
 import pyverbs.enums as e
+import tests.utils as u
 
 MAX_IO_LEN = 1048576
 
diff --git a/pyverbs/tests/pd.py b/tests/test_pd.py
similarity index 97%
rename from pyverbs/tests/pd.py
rename to tests/test_pd.py
index 87528db7d437..978cf4900146 100644
--- a/pyverbs/tests/pd.py
+++ b/tests/test_pd.py
@@ -5,7 +5,7 @@ Test module for pyverbs' pd module.
 """
 import random
 
-from pyverbs.tests.base import PyverbsAPITestCase
+from tests.base import PyverbsAPITestCase
 from pyverbs.base import PyverbsRDMAErrno
 import pyverbs.device as d
 from pyverbs.pd import PD
diff --git a/pyverbs/tests/qp.py b/tests/test_qp.py
similarity index 99%
rename from pyverbs/tests/qp.py
rename to tests/test_qp.py
index bbf28244f641..1ce98388871b 100644
--- a/pyverbs/tests/qp.py
+++ b/tests/test_qp.py
@@ -5,12 +5,12 @@ Test module for pyverbs' qp module.
 """
 import random
 
-from pyverbs.tests.base import PyverbsAPITestCase
 from pyverbs.qp import QPInitAttr, QPAttr, QP
-import pyverbs.tests.utils as u
+from tests.base import PyverbsAPITestCase
 import pyverbs.enums as e
 from pyverbs.pd import PD
 from pyverbs.cq import CQ
+import tests.utils as u
 
 
 class QPTest(PyverbsAPITestCase):
diff --git a/pyverbs/tests/utils.py b/tests/utils.py
similarity index 100%
rename from pyverbs/tests/utils.py
rename to tests/utils.py
-- 
2.21.0

