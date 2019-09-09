Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBDCAD54D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbfIIJHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48364 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389597AbfIIJHV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:21 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp2028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 04/12] pyverbs: Introducing XRCD class
Date:   Mon,  9 Sep 2019 12:07:04 +0300
Message-Id: <20190909090712.11029-5-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090712.11029-1-noaos@mellanox.com>
References: <20190909090712.11029-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

Represents ibv_xrcd, The eXtended RC Domain.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 pyverbs/CMakeLists.txt       |  1 +
 pyverbs/device.pxd           |  1 +
 pyverbs/device.pyx           |  7 ++-
 pyverbs/libibverbs.pxd       |  8 ++++
 pyverbs/libibverbs_enums.pxd |  5 +++
 pyverbs/qp.pxd               |  2 +
 pyverbs/qp.pyx               | 25 ++++++++---
 pyverbs/xrcd.pxd             | 16 +++++++
 pyverbs/xrcd.pyx             | 87 ++++++++++++++++++++++++++++++++++++
 9 files changed, 145 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 pyverbs/CMakeLists.txt
 mode change 100644 => 100755 pyverbs/libibverbs.pxd
 create mode 100755 pyverbs/xrcd.pxd
 create mode 100755 pyverbs/xrcd.pyx

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
old mode 100644
new mode 100755
index da49093c2cf0..1addf10305c0
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -11,6 +11,7 @@ rdma_cython_module(pyverbs
   pd.pyx
   qp.pyx
   wr.pyx
+  xrcd.pyx
   )
 
 rdma_python_module(pyverbs
diff --git a/pyverbs/device.pxd b/pyverbs/device.pxd
index 44c8bc3cbcbc..ed2f1ca3d6ef 100644
--- a/pyverbs/device.pxd
+++ b/pyverbs/device.pxd
@@ -16,6 +16,7 @@ cdef class Context(PyverbsCM):
     cdef object ccs
     cdef object cqs
     cdef object qps
+    cdef object xrcds
 
 cdef class DeviceAttr(PyverbsObject):
     cdef v.ibv_device_attr dev_attr
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index cbba8837c283..f238d37ce3a9 100644
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -14,6 +14,7 @@ from .pyverbs_error import PyverbsUserError
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 cimport pyverbs.libibverbs as v
+from pyverbs.xrcd cimport XRCD
 from pyverbs.addr cimport GID
 from pyverbs.mr import DMMR
 from pyverbs.pd cimport PD
@@ -90,6 +91,7 @@ cdef class Context(PyverbsCM):
         self.ccs = weakref.WeakSet()
         self.cqs = weakref.WeakSet()
         self.qps = weakref.WeakSet()
+        self.xrcds = weakref.WeakSet()
 
         dev_name = kwargs.get('name')
 
@@ -126,7 +128,8 @@ cdef class Context(PyverbsCM):
 
     cpdef close(self):
         self.logger.debug('Closing Context')
-        self.close_weakrefs([self.qps, self.ccs, self.cqs, self.dms, self.pds])
+        self.close_weakrefs([self.qps, self.ccs, self.cqs, self.dms, self.pds,
+                             self.xrcds])
         if self.context != NULL:
             rc = v.ibv_close_device(self.context)
             if rc != 0:
@@ -198,6 +201,8 @@ cdef class Context(PyverbsCM):
             self.cqs.add(obj)
         elif isinstance(obj, QP):
             self.qps.add(obj)
+        elif isinstance(obj, XRCD):
+            self.xrcds.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
 
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
old mode 100644
new mode 100755
index 1aa5844b126e..8a5dd446d847
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -341,6 +341,11 @@ cdef extern from 'infiniband/verbs.h':
         ibv_qp_type     qp_type
         int             sq_sig_all
 
+    cdef struct ibv_xrcd_init_attr:
+        uint32_t comp_mask
+        int      fd
+        int      oflags
+
     cdef struct ibv_xrcd:
         pass
 
@@ -490,3 +495,6 @@ cdef extern from 'infiniband/verbs.h':
     int ibv_destroy_qp(ibv_qp *qp)
     int ibv_post_recv(ibv_qp *qp, ibv_recv_wr *wr, ibv_recv_wr **bad_wr)
     int ibv_post_send(ibv_qp *qp, ibv_send_wr *wr, ibv_send_wr **bad_wr)
+    ibv_xrcd *ibv_open_xrcd(ibv_context *context,
+                            ibv_xrcd_init_attr *xrcd_init_attr)
+    int ibv_close_xrcd(ibv_xrcd *xrcd)
diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index 1d437240a883..7d657b332324 100755
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -393,6 +393,11 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_RAW_PACKET_CAP_IP_CSUM          = 1 << 2
         IBV_RAW_PACKET_CAP_DELAY_DROP       = 1 << 3
 
+    cpdef enum ibv_xrcd_init_attr_mask:
+        IBV_XRCD_INIT_ATTR_FD       = 1 << 0
+        IBV_XRCD_INIT_ATTR_OFLAGS   = 1 << 1
+        IBV_XRCD_INIT_ATTR_RESERVED = 1 << 2
+
     cdef unsigned long long IBV_DEVICE_RAW_SCATTER_FCS
     cdef unsigned long long IBV_DEVICE_PCI_WRITE_END_PADDING
 
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
index 29b9ec4a0221..a5c92ea673e5 100644
--- a/pyverbs/qp.pxd
+++ b/pyverbs/qp.pxd
@@ -18,6 +18,7 @@ cdef class QPInitAttrEx(PyverbsObject):
     cdef v.ibv_qp_init_attr_ex attr
     cdef object scq
     cdef object rcq
+    cdef object xrcd
     cdef object pd
 
 cdef class QPAttr(PyverbsObject):
@@ -29,6 +30,7 @@ cdef class QP(PyverbsCM):
     cdef int state
     cdef object pd
     cdef object context
+    cdef object xrcd
     cpdef close(self)
     cdef update_cqs(self, init_attr)
     cdef object scq
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 732ef5094b6b..a36d5fe9d569 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -11,6 +11,7 @@ from pyverbs.addr cimport GlobalRoute
 from pyverbs.device cimport Context
 from pyverbs.cq cimport CQ, CQEX
 cimport pyverbs.libibverbs as v
+from pyverbs.xrcd cimport XRCD
 from pyverbs.pd cimport PD
 
 
@@ -193,7 +194,7 @@ cdef class QPInitAttrEx(PyverbsObject):
     def __cinit__(self, qp_type=e.IBV_QPT_UD, qp_context=None,
                   PyverbsObject scq=None, PyverbsObject rcq=None,
                   object srq=None, QPCap cap=None, sq_sig_all=0, comp_mask=0,
-                  PD pd=None, object xrcd=None, create_flags=0,
+                  PD pd=None, XRCD xrcd=None, create_flags=0,
                   max_tso_header=0, source_qpn=0, object hash_conf=None,
                   object ind_table=None):
         """
@@ -209,7 +210,7 @@ cdef class QPInitAttrEx(PyverbsObject):
         :param comp_mask: bit mask to determine which of the following fields
                           are valid
         :param pd: A PD object to be associated with this QP
-        :param xrcd: Not yet supported
+        :param xrcd: XRC domain to be used for XRC QPs
         :param create_flags: Creation flags for this QP
         :param max_tso_header: Maximum TSO header size
         :param source_qpn: Source QP number (requires IBV_QP_CREATE_SOURCE_QPN
@@ -240,14 +241,14 @@ cdef class QPInitAttrEx(PyverbsObject):
         self.rcq = rcq
 
         self.attr.srq = NULL  # Until SRQ support is added
-        self.attr.xrcd = NULL  # Until XRCD support is added
+        self.xrcd = xrcd
+        self.attr.xrcd = xrcd.xrcd if xrcd else NULL
         self.attr.rwq_ind_tbl = NULL  # Until RSS support is added
         self.attr.qp_type = qp_type
         self.attr.sq_sig_all = sq_sig_all
-        unsupp_flags = e.IBV_QP_INIT_ATTR_XRCD | e.IBV_QP_INIT_ATTR_IND_TABLE |\
-                       e.IBV_QP_INIT_ATTR_RX_HASH
+        unsupp_flags = e.IBV_QP_INIT_ATTR_IND_TABLE | e.IBV_QP_INIT_ATTR_RX_HASH
         if comp_mask & unsupp_flags:
-            raise PyverbsUserError('XRCD and RSS are not yet supported in pyverbs')
+            raise PyverbsUserError('RSS is not yet supported in pyverbs')
         self.attr.comp_mask = comp_mask
         if pd is not None:
             self.pd = pd
@@ -318,6 +319,14 @@ cdef class QPInitAttrEx(PyverbsObject):
         self.attr.pd = <v.ibv_pd*>val.pd
         self.pd = val
 
+    @property
+    def xrcd(self):
+        return self.xrcd
+    @xrcd.setter
+    def xrcd(self, XRCD val):
+        self.attr.xrcd = <v.ibv_xrcd*>val.xrcd
+        self.xrcd = val
+
     @property
     def create_flags(self):
         return self.attr.create_flags
@@ -794,6 +803,10 @@ cdef class QP(PyverbsCM):
                 pd = <PD>init_attr.pd
                 pd.add_ref(self)
                 self.pd = pd
+            if init_attr.xrcd is not None:
+                xrcd = <XRCD>init_attr.xrcd
+                xrcd.add_ref(self)
+                self.xrcd = xrcd
         else:
             self._create_qp(creator, init_attr)
             pd = <PD>creator
diff --git a/pyverbs/xrcd.pxd b/pyverbs/xrcd.pxd
new file mode 100755
index 000000000000..ab28dfafe1d1
--- /dev/null
+++ b/pyverbs/xrcd.pxd
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+from pyverbs.base cimport PyverbsCM, PyverbsObject
+from pyverbs.device cimport Context
+cimport pyverbs.libibverbs as v
+
+
+cdef class XRCDInitAttr(PyverbsObject):
+    cdef v.ibv_xrcd_init_attr attr
+
+
+cdef class XRCD(PyverbsCM):
+    cdef v.ibv_xrcd *xrcd
+    cdef Context ctx
+    cdef add_ref(self, obj)
+    cdef object qps
diff --git a/pyverbs/xrcd.pyx b/pyverbs/xrcd.pyx
new file mode 100755
index 000000000000..83d2a6b83e67
--- /dev/null
+++ b/pyverbs/xrcd.pyx
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+import weakref
+
+from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
+from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.device cimport Context
+from pyverbs.qp cimport QP
+
+cdef extern from 'errno.h':
+    int errno
+
+
+cdef class XRCDInitAttr(PyverbsObject):
+    def __cinit__(self, comp_mask, oflags, fd):
+        self.attr.fd = fd
+        self.attr.comp_mask = comp_mask
+        self.attr.oflags = oflags
+
+    @property
+    def fd(self):
+        return self.attr.fd
+    @fd.setter
+    def fd(self, val):
+        self.attr.fd = val
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask = val
+
+    @property
+    def oflags(self):
+        return self.attr.oflags
+    @oflags.setter
+    def oflags(self, val):
+        self.attr.oflags = val
+
+
+cdef class XRCD(PyverbsCM):
+    def __cinit__(self, Context context not None, XRCDInitAttr init_attr not None):
+        """
+        Initializes a XRCD object.
+        :param context: The Context object creating the XRCD
+        :return: The newly created XRCD on success
+        """
+        self.xrcd = v.ibv_open_xrcd(<v.ibv_context*> context.context,
+                                    &init_attr.attr)
+        if self.xrcd == NULL:
+            raise PyverbsRDMAErrno('Failed to allocate XRCD', errno)
+        self.ctx = context
+        context.add_ref(self)
+        self.logger.debug('XRCD: Allocated ibv_xrcd')
+        self.qps = weakref.WeakSet()
+
+    def __dealloc__(self):
+        """
+        Closes the inner XRCD.
+        :return: None
+        """
+        self.close()
+
+    cpdef close(self):
+        """
+        Closes the underlying C object of the XRCD.
+        :return: None
+        """
+        self.logger.debug('Closing XRCD')
+        self.close_weakrefs([self.qps])
+        # XRCD may be deleted directly or indirectly by closing its context,
+        # which leaves the Python XRCD object without the underlying C object,
+        # so during destruction, need to check whether or not the C object
+        # exists.
+        if self.xrcd != NULL:
+            rc = v.ibv_close_xrcd(self.xrcd)
+            if rc != 0:
+                raise PyverbsRDMAErrno('Failed to dealloc XRCD')
+            self.xrcd = NULL
+            self.ctx = None
+
+    cdef add_ref(self, obj):
+        if isinstance(obj, QP):
+            self.qps.add(obj)
+        else:
+            raise PyverbsError('Unrecognized object type')
-- 
2.21.0

