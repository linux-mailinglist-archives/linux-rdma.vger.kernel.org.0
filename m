Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450CC64868
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfGJOb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 10:31:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47974 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727190AbfGJOb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 10:31:57 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Jul 2019 17:31:51 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x6AEVpIj004077;
        Wed, 10 Jul 2019 17:31:51 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-core 1/4] pyverbs: Fix Cython future warning during build
Date:   Wed, 10 Jul 2019 17:22:48 +0300
Message-Id: <20190710142251.9396-2-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710142251.9396-1-noaos@mellanox.com>
References: <20190710142251.9396-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since Cython 0.29, a language_level directive is required in pxd
files. This currently appears as a FutureWarning e.g.:
FutureWarning: Cython directive 'language_level' not set, using 2 for
now (Py2). This will change in a later release!

This patch updates pyverbs' pxd files with this directive.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewd-by: Maor Gottlieb <maorg@mellanox.com>
---
 pyverbs/addr.pxd             | 2 ++
 pyverbs/base.pxd             | 2 ++
 pyverbs/cq.pxd               | 3 +++
 pyverbs/device.pxd           | 2 ++
 pyverbs/libibverbs_enums.pxd | 3 +++
 pyverbs/mr.pxd               | 2 ++
 pyverbs/pd.pxd               | 3 +++
 pyverbs/qp.pxd               | 3 +++
 pyverbs/wr.pxd               | 2 ++
 9 files changed, 22 insertions(+)

diff --git a/pyverbs/addr.pxd b/pyverbs/addr.pxd
index 389c2d5bdb2e..e7322e8d7fdd 100644
--- a/pyverbs/addr.pxd
+++ b/pyverbs/addr.pxd
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved. See COPYING file
 
+#cython: language_level=3
+
 from .base cimport PyverbsObject, PyverbsCM
 from pyverbs cimport libibverbs as v
 
diff --git a/pyverbs/base.pxd b/pyverbs/base.pxd
index fa661edb5315..e85f7c020e1c 100644
--- a/pyverbs/base.pxd
+++ b/pyverbs/base.pxd
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
 
+#cython: language_level=3
+
 cdef class PyverbsObject(object):
     cdef object __weakref__
     cdef object logger
diff --git a/pyverbs/cq.pxd b/pyverbs/cq.pxd
index 0e3bcdfffb7e..9b8df5dcae39 100644
--- a/pyverbs/cq.pxd
+++ b/pyverbs/cq.pxd
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+
+#cython: language_level=3
+
 from pyverbs.base cimport PyverbsObject, PyverbsCM
 cimport pyverbs.libibverbs as v
 
diff --git a/pyverbs/device.pxd b/pyverbs/device.pxd
index 3cb52bde4603..44c8bc3cbcbc 100644
--- a/pyverbs/device.pxd
+++ b/pyverbs/device.pxd
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved. See COPYING file
 
+#cython: language_level=3
+
 from .base cimport PyverbsObject, PyverbsCM
 cimport pyverbs.libibverbs as v
 
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 85b5092c486f..c347ef31dd2b 100644
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2018, Mellanox Technologies. All rights reserved.
 
+#cython: language_level=3
+
+
 cdef extern from '<infiniband/verbs.h>':
 
     cpdef enum ibv_transport_type:
diff --git a/pyverbs/mr.pxd b/pyverbs/mr.pxd
index 2d76f2dfbe7c..fb46611e6f42 100644
--- a/pyverbs/mr.pxd
+++ b/pyverbs/mr.pxd
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved. See COPYING file
 
+#cython: language_level=3
+
 from pyverbs.base cimport PyverbsCM
 from . cimport libibverbs as v
 
diff --git a/pyverbs/pd.pxd b/pyverbs/pd.pxd
index 07c9158b27eb..e0861b301b7c 100644
--- a/pyverbs/pd.pxd
+++ b/pyverbs/pd.pxd
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+
+#cython: language_level=3
+
 from pyverbs.device cimport Context
 cimport pyverbs.libibverbs as v
 from .base cimport PyverbsCM
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
index d85bc28992ad..29b9ec4a0221 100644
--- a/pyverbs/qp.pxd
+++ b/pyverbs/qp.pxd
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.
+
+#cython: language_level=3
+
 from pyverbs.base cimport PyverbsObject, PyverbsCM
 cimport pyverbs.libibverbs as v
 
diff --git a/pyverbs/wr.pxd b/pyverbs/wr.pxd
index 64b16091116a..e259249ef7f8 100644
--- a/pyverbs/wr.pxd
+++ b/pyverbs/wr.pxd
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved. See COPYING file
 
+#cython: language_level=3
+
 from .base cimport PyverbsCM
 from pyverbs cimport libibverbs as v
 
-- 
2.21.0

