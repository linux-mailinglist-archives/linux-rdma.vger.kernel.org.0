Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB54C3D7066
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhG0HcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 03:32:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12315 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhG0Hb6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 03:31:58 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYpJy61vBz7ydR;
        Tue, 27 Jul 2021 15:27:14 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:57 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:57 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 09/10] pyverbs/hns: Initial support for HNS direct verbs
Date:   Tue, 27 Jul 2021 15:28:20 +0800
Message-ID: <1627370901-10054-10-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
References: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add initial support for HNS direct verbs. For now, DCA direct verbs are
supported.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 pyverbs/CMakeLists.txt                |   1 +
 pyverbs/providers/hns/CMakeLists.txt  |   7 ++
 pyverbs/providers/hns/__init__.pxd    |   0
 pyverbs/providers/hns/__init__.py     |   0
 pyverbs/providers/hns/hns_enums.pyx   |   1 +
 pyverbs/providers/hns/hnsdv.pxd       |  25 ++++++
 pyverbs/providers/hns/hnsdv.pyx       | 158 ++++++++++++++++++++++++++++++++++
 pyverbs/providers/hns/hnsdv_enums.pxd |  21 +++++
 pyverbs/providers/hns/libhns.pxd      |  28 ++++++
 9 files changed, 241 insertions(+)
 create mode 100644 pyverbs/providers/hns/CMakeLists.txt
 create mode 100644 pyverbs/providers/hns/__init__.pxd
 create mode 100644 pyverbs/providers/hns/__init__.py
 create mode 120000 pyverbs/providers/hns/hns_enums.pyx
 create mode 100644 pyverbs/providers/hns/hnsdv.pxd
 create mode 100644 pyverbs/providers/hns/hnsdv.pyx
 create mode 100644 pyverbs/providers/hns/hnsdv_enums.pxd
 create mode 100644 pyverbs/providers/hns/libhns.pxd

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index c532b4c..80f6e2b 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -44,4 +44,5 @@ rdma_python_module(pyverbs
 if (HAVE_COHERENT_DMA)
 add_subdirectory(providers/mlx5)
 add_subdirectory(providers/efa)
+add_subdirectory(providers/hns)
 endif()
diff --git a/pyverbs/providers/hns/CMakeLists.txt b/pyverbs/providers/hns/CMakeLists.txt
new file mode 100644
index 0000000..bb60f16
--- /dev/null
+++ b/pyverbs/providers/hns/CMakeLists.txt
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+rdma_cython_module(pyverbs/providers/hns hns
+  hns_enums.pyx
+  hnsdv.pyx
+)
diff --git a/pyverbs/providers/hns/__init__.pxd b/pyverbs/providers/hns/__init__.pxd
new file mode 100644
index 0000000..e69de29
diff --git a/pyverbs/providers/hns/__init__.py b/pyverbs/providers/hns/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/pyverbs/providers/hns/hns_enums.pyx b/pyverbs/providers/hns/hns_enums.pyx
new file mode 120000
index 0000000..33b3389
--- /dev/null
+++ b/pyverbs/providers/hns/hns_enums.pyx
@@ -0,0 +1 @@
+hnsdv_enums.pxd
\ No newline at end of file
diff --git a/pyverbs/providers/hns/hnsdv.pxd b/pyverbs/providers/hns/hnsdv.pxd
new file mode 100644
index 0000000..b23fab8
--- /dev/null
+++ b/pyverbs/providers/hns/hnsdv.pxd
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+#cython: language_level=3
+
+from pyverbs.base cimport PyverbsObject
+cimport pyverbs.providers.hns.libhns as dv
+from pyverbs.device cimport Context
+from pyverbs.qp cimport QP, QPEx
+
+
+cdef class HnsContext(Context):
+    cpdef close(self)
+
+cdef class HnsDVContextAttr(PyverbsObject):
+    cdef dv.hnsdv_context_attr attr
+
+cdef class HnsDVContext(PyverbsObject):
+    pass
+
+cdef class HnsDVQPInitAttr(PyverbsObject):
+    cdef dv.hnsdv_qp_init_attr attr
+
+cdef class HnsQP(QPEx):
+    pass
diff --git a/pyverbs/providers/hns/hnsdv.pyx b/pyverbs/providers/hns/hnsdv.pyx
new file mode 100644
index 0000000..4642255
--- /dev/null
+++ b/pyverbs/providers/hns/hnsdv.pyx
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+from libc.stdint cimport uintptr_t, uint8_t, uint16_t, uint32_t
+import logging
+
+from pyverbs.pyverbs_error import PyverbsUserError
+
+cimport pyverbs.providers.hns.hnsdv_enums as dve
+cimport pyverbs.providers.hns.libhns as dv
+
+from pyverbs.qp cimport QPInitAttrEx, QPEx
+from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.base cimport close_weakrefs
+from pyverbs.pd cimport PD
+
+cdef class HnsDVContextAttr(PyverbsObject):
+    """
+    Represent hnsdv_context_attr struct. This class is used to open an hns
+    device.
+    """
+    def __init__(self, flags=0, comp_mask=0, dca_qps=1):
+        super().__init__()
+        self.attr.flags = flags
+        self.attr.comp_mask = comp_mask
+        if dca_qps > 0:
+            self.attr.comp_mask |= dve.HNSDV_CONTEXT_MASK_DCA_PRIME_QPS
+            self.attr.dca_prime_qps = dca_qps
+
+    def __str__(self):
+        print_format = '{:20}: {:<20}\n'
+        return print_format.format('flags', self.attr.flags) +\
+               print_format.format('comp_mask', self.attr.comp_mask)
+
+    @property
+    def flags(self):
+        return self.attr.flags
+    @flags.setter
+    def flags(self, val):
+        self.attr.flags = val
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask = val
+
+cdef class HnsContext(Context):
+    """
+    Represent hns context, which extends Context.
+    """
+    def __init__(self, HnsDVContextAttr attr not None, name=''):
+        """
+        Open an hns device using the given attributes
+        :param name: The RDMA device's name (used by parent class)
+        :param attr: hns-specific device attributes
+        :return: None
+        """
+        super().__init__(name=name, attr=attr)
+        if not dv.hnsdv_is_supported(self.device):
+            raise PyverbsUserError('This is not an HNS device')
+        self.context = dv.hnsdv_open_device(self.device, &attr.attr)
+        if self.context == NULL:
+            raise PyverbsRDMAErrno('Failed to open hns context on {dev}'
+                                   .format(dev=self.name))
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        if self.context != NULL:
+            super(HnsContext, self).close()
+
+cdef class HnsDVQPInitAttr(PyverbsObject):
+    """
+    Represents hnsdv_qp_init_attr struct, initial attributes used for hns QP
+    creation.
+    """
+    def __init__(self, comp_mask=0, create_flags=0):
+        """
+        Initializes an HnsDVQPInitAttr object with the given user data.
+        :param comp_mask: A bitmask specifying which fields are valid
+        :param create_flags: A bitwise OR of hnsdv_qp_create_flags
+        :return: An initialized HnsDVQPInitAttr object
+        """
+        super().__init__()
+        self.attr.comp_mask = comp_mask
+        self.attr.create_flags = create_flags
+
+    def __str__(self):
+        print_format = '{:20}: {:<20}\n'
+        return print_format.format('Comp mask',
+                                   qp_comp_mask_to_str(self.attr.comp_mask)) +\
+               print_format.format('Create flags',
+                                   qp_create_flags_to_str(self.attr.create_flags))
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask = val
+
+    @property
+    def create_flags(self):
+        return self.attr.create_flags
+    @create_flags.setter
+    def create_flags(self, val):
+        self.attr.create_flags = val
+
+cdef class HnsQP(QPEx):
+    def __init__(self, Context context, QPInitAttrEx init_attr,
+                 HnsDVQPInitAttr dv_init_attr):
+        """
+        Initializes an hns QP according to the user-provided data.
+        :param context: Context object
+        :param init_attr: QPInitAttrEx object
+        :return: An initialized HnsQP
+        """
+        cdef PD pd
+
+        # Initialize the logger here as the parent's __init__ is called after
+        # the QP is allocated. Allocation can fail, which will lead to exceptions
+        # thrown during object's teardown.
+        self.logger = logging.getLogger(self.__class__.__name__)
+        if init_attr.pd is not None:
+            pd = <PD>init_attr.pd
+            pd.add_ref(self)
+        self.qp = \
+            dv.hnsdv_create_qp(context.context,
+                                &init_attr.attr,
+                                &dv_init_attr.attr if dv_init_attr is not None
+                                else NULL)
+        if self.qp == NULL:
+            raise PyverbsRDMAErrno('Failed to create HNS QP.\nQPInitAttrEx '
+                                   'attributes:\n{}\nHNSDVQPInitAttr:\n{}'.
+                                   format(init_attr, dv_init_attr))
+        super().__init__(context, init_attr)
+
+def bitmask_to_str(bits, values):
+    numeric_bits = bits
+    res = ''
+    for t in values.keys():
+        if t & bits:
+            res += values[t] + ', '
+            bits -= t
+        if bits == 0:
+            break
+    return res[:-2] + ' ({})'.format(numeric_bits) # Remove last comma and space
+
+def qp_comp_mask_to_str(flags):
+    l = {dve.HNSDV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS: 'Create flags'}
+    return bitmask_to_str(flags, l)
+
+def qp_create_flags_to_str(flags):
+    l = {dve.HNSDV_QP_CREATE_ENABLE_DCA_MODE: 'Enable DCA'}
+    return bitmask_to_str(flags, l)
diff --git a/pyverbs/providers/hns/hnsdv_enums.pxd b/pyverbs/providers/hns/hnsdv_enums.pxd
new file mode 100644
index 0000000..9fa43af
--- /dev/null
+++ b/pyverbs/providers/hns/hnsdv_enums.pxd
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+#cython: language_level=3
+
+cdef extern from 'infiniband/hnsdv.h':
+
+    cpdef enum hnsdv_context_attr_flags:
+        HNSDV_CONTEXT_FLAGS_DCA	= 1 << 0
+
+    cpdef enum hnsdv_context_comp_mask:
+        HNSDV_CONTEXT_MASK_DCA_PRIME_QPS	= 1 << 0
+        HNSDV_CONTEXT_MASK_DCA_UNIT_SIZE	= 1 << 1
+        HNSDV_CONTEXT_MASK_DCA_MAX_SIZE		= 1 << 2
+        HNSDV_CONTEXT_MASK_DCA_MIN_SIZE		= 1 << 3
+
+    cpdef enum hnsdv_qp_init_attr_mask:
+        HNSDV_QP_INIT_ATTR_MASK_QP_CREATE_FLAGS	= 1 << 0
+
+    cpdef enum hnsdv_qp_create_flags:
+        HNSDV_QP_CREATE_ENABLE_DCA_MODE		= 1 << 0
diff --git a/pyverbs/providers/hns/libhns.pxd b/pyverbs/providers/hns/libhns.pxd
new file mode 100644
index 0000000..c1e4ec3
--- /dev/null
+++ b/pyverbs/providers/hns/libhns.pxd
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2021 HiSilicon Limited. All rights reserved.
+
+from libc.stdint cimport uint8_t, uint16_t, uint32_t, uint64_t
+from libcpp cimport bool
+
+cimport pyverbs.libibverbs as v
+
+cdef extern from 'infiniband/hnsdv.h':
+
+    cdef struct hnsdv_context_attr:
+        uint64_t flags
+        uint64_t comp_mask
+        uint32_t dca_prime_qps
+        uint32_t dca_unit_size
+        uint64_t dca_max_size
+        uint64_t dca_min_size
+
+    cdef struct hnsdv_qp_init_attr:
+        uint64_t comp_mask
+        uint32_t create_flags
+
+    bool hnsdv_is_supported(v.ibv_device *device)
+    v.ibv_context* hnsdv_open_device(v.ibv_device *device,
+                                     hnsdv_context_attr *attr)
+    v.ibv_qp *hnsdv_create_qp(v.ibv_context *context,
+                              v.ibv_qp_init_attr_ex *qp_attr,
+                              hnsdv_qp_init_attr *hns_qp_attr)
-- 
2.8.1

