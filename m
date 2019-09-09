Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9222AD54A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbfIIJHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48363 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389608AbfIIJHU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:20 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp3028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>,
        Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 05/12] pyverbs: Introducing SRQ class
Date:   Mon,  9 Sep 2019 12:07:05 +0300
Message-Id: <20190909090712.11029-6-noaos@mellanox.com>
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

SRQ class represents ibv_srq. SRQ is a shared receive queue which
can be used by multiple QPs.
Classes SrqInitAttrEx, SrqInitAttr and SrqAttr have been added too.
Note: SRQ XRC is suppored too. Messages arriving at receive ports of
XRC QPs will be channeled to SRQ only if the XRC Domain of the SRQ
matches the XRC Domain of the transport QP.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt |   1 +
 pyverbs/cq.pxd         |   2 +
 pyverbs/cq.pyx         |  13 ++-
 pyverbs/libibverbs.pxd |  35 ++++++++
 pyverbs/pd.pxd         |   1 +
 pyverbs/pd.pyx         |   6 +-
 pyverbs/qp.pxd         |   2 +
 pyverbs/qp.pyx         |  32 ++++++--
 pyverbs/srq.pxd        |  24 ++++++
 pyverbs/srq.pyx        | 176 +++++++++++++++++++++++++++++++++++++++++
 pyverbs/xrcd.pxd       |   1 +
 pyverbs/xrcd.pyx       |   6 +-
 12 files changed, 289 insertions(+), 10 deletions(-)
 create mode 100755 pyverbs/srq.pxd
 create mode 100755 pyverbs/srq.pyx

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 1addf10305c0..90293982b280 100755
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -12,6 +12,7 @@ rdma_cython_module(pyverbs
   qp.pyx
   wr.pyx
   xrcd.pyx
+  srq.pyx
   )
 
 rdma_python_module(pyverbs
diff --git a/pyverbs/cq.pxd b/pyverbs/cq.pxd
index 9b8df5dcae39..8eeb2e1fd0c2 100644
--- a/pyverbs/cq.pxd
+++ b/pyverbs/cq.pxd
@@ -19,6 +19,7 @@ cdef class CQ(PyverbsCM):
     cdef object context
     cdef add_ref(self, obj)
     cdef object qps
+    cdef object srqs
 
 cdef class CqInitAttrEx(PyverbsObject):
     cdef v.ibv_cq_init_attr_ex attr
@@ -31,6 +32,7 @@ cdef class CQEX(PyverbsCM):
     cdef object context
     cdef add_ref(self, obj)
     cdef object qps
+    cdef object srqs
 
 cdef class WC(PyverbsObject):
     cdef v.ibv_wc wc
diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index 32eee0a0f1fd..eadc1fdb3140 100755
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -2,9 +2,11 @@
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
 import weakref
 
+from pyverbs.pyverbs_error import PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.device cimport Context
+from pyverbs.srq cimport SRQ
 from pyverbs.qp cimport QP
 
 cdef class CompChannel(PyverbsCM):
@@ -90,18 +92,23 @@ cdef class CQ(PyverbsCM):
         self.context = context
         context.add_ref(self)
         self.qps = weakref.WeakSet()
+        self.srqs = weakref.WeakSet()
         self.logger.debug('Created a CQ')
 
     cdef add_ref(self, obj):
         if isinstance(obj, QP):
             self.qps.add(obj)
+        elif isinstance(obj, SRQ):
+            self.srqs.add(obj)
+        else:
+            raise PyverbsError('Unrecognized object type')
 
     def __dealloc__(self):
         self.close()
 
     cpdef close(self):
         self.logger.debug('Closing CQ')
-        self.close_weakrefs([self.qps])
+        self.close_weakrefs([self.qps, self.srqs])
         if self.cq != NULL:
             rc = v.ibv_destroy_cq(self.cq)
             if rc != 0:
@@ -270,6 +277,10 @@ cdef class CQEX(PyverbsCM):
     cdef add_ref(self, obj):
         if isinstance(obj, QP):
             self.qps.add(obj)
+        elif isinstance(obj, SRQ):
+            self.srqs.add(obj)
+        else:
+            raise PyverbsError('Unrecognized object type')
 
     def __dealloc__(self):
         self.close()
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 8a5dd446d847..a92286d42c67 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -349,6 +349,32 @@ cdef extern from 'infiniband/verbs.h':
     cdef struct ibv_xrcd:
         pass
 
+    cdef struct ibv_srq_attr:
+        unsigned int    max_wr
+        unsigned int    max_sge
+        unsigned int    srq_limit
+
+    cdef struct ibv_srq_init_attr:
+        void            *srq_context
+        ibv_srq_attr    attr
+
+    cdef struct ibv_srq_init_attr_ex:
+        void            *srq_context
+        ibv_srq_attr    attr
+        unsigned int    comp_mask
+        ibv_srq_type    srq_type
+        ibv_pd          *pd
+        ibv_xrcd        *xrcd
+        ibv_cq          *cq
+        ibv_tm_caps      tm_cap
+
+    cdef struct ibv_srq:
+        ibv_context     *context
+        void            *srq_context
+        ibv_pd          *pd
+        unsigned int    handle
+        unsigned int    events_completed
+
     cdef struct ibv_rwq_ind_table:
         pass
 
@@ -498,3 +524,12 @@ cdef extern from 'infiniband/verbs.h':
     ibv_xrcd *ibv_open_xrcd(ibv_context *context,
                             ibv_xrcd_init_attr *xrcd_init_attr)
     int ibv_close_xrcd(ibv_xrcd *xrcd)
+    ibv_srq *ibv_create_srq(ibv_pd *pd, ibv_srq_init_attr *srq_init_attr)
+    ibv_srq *ibv_create_srq_ex(ibv_context *context,
+                               ibv_srq_init_attr_ex *srq_init_attr)
+    int ibv_modify_srq(ibv_srq *srq, ibv_srq_attr *srq_attr, int srq_attr_mask)
+    int ibv_query_srq(ibv_srq *srq, ibv_srq_attr *srq_attr)
+    int ibv_get_srq_num(ibv_srq *srq, unsigned int *srq_num)
+    int ibv_destroy_srq(ibv_srq *srq)
+    int ibv_post_srq_recv(ibv_srq *srq, ibv_recv_wr *recv_wr,
+                          ibv_recv_wr **bad_recv_wr)
diff --git a/pyverbs/pd.pxd b/pyverbs/pd.pxd
index e0861b301b7c..6dd9c2959ed3 100644
--- a/pyverbs/pd.pxd
+++ b/pyverbs/pd.pxd
@@ -12,6 +12,7 @@ cdef class PD(PyverbsCM):
     cdef v.ibv_pd *pd
     cdef Context ctx
     cdef add_ref(self, obj)
+    cdef object srqs
     cdef object mrs
     cdef object mws
     cdef object ahs
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index 7cd0876682b2..46cbb36009ce 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -6,6 +6,7 @@ from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.device cimport Context, DM
 from .mr cimport MR, MW, DMMR
+from pyverbs.srq cimport SRQ
 from pyverbs.addr cimport AH
 from pyverbs.qp cimport QP
 
@@ -27,6 +28,7 @@ cdef class PD(PyverbsCM):
         self.ctx = context
         context.add_ref(self)
         self.logger.debug('PD: Allocated ibv_pd')
+        self.srqs = weakref.WeakSet()
         self.mrs = weakref.WeakSet()
         self.mws = weakref.WeakSet()
         self.ahs = weakref.WeakSet()
@@ -48,7 +50,7 @@ cdef class PD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing PD')
-        self.close_weakrefs([self.qps, self.ahs, self.mws, self.mrs])
+        self.close_weakrefs([self.qps, self.ahs, self.mws, self.mrs, self.srqs])
         if self.pd != NULL:
             rc = v.ibv_dealloc_pd(self.pd)
             if rc != 0:
@@ -65,5 +67,7 @@ cdef class PD(PyverbsCM):
             self.ahs.add(obj)
         elif isinstance(obj, QP):
             self.qps.add(obj)
+        elif isinstance(obj, SRQ):
+            self.srqs.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
index a5c92ea673e5..55503702cfe3 100644
--- a/pyverbs/qp.pxd
+++ b/pyverbs/qp.pxd
@@ -13,12 +13,14 @@ cdef class QPInitAttr(PyverbsObject):
     cdef v.ibv_qp_init_attr attr
     cdef object scq
     cdef object rcq
+    cdef object srq
 
 cdef class QPInitAttrEx(PyverbsObject):
     cdef v.ibv_qp_init_attr_ex attr
     cdef object scq
     cdef object rcq
     cdef object xrcd
+    cdef object srq
     cdef object pd
 
 cdef class QPAttr(PyverbsObject):
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index a36d5fe9d569..0417625e4b6c 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -12,6 +12,7 @@ from pyverbs.device cimport Context
 from pyverbs.cq cimport CQ, CQEX
 cimport pyverbs.libibverbs as v
 from pyverbs.xrcd cimport XRCD
+from pyverbs.srq cimport SRQ
 from pyverbs.pd cimport PD
 
 
@@ -86,7 +87,7 @@ cdef class QPCap(PyverbsObject):
 cdef class QPInitAttr(PyverbsObject):
     def __cinit__(self, qp_type=e.IBV_QPT_UD, qp_context=None,
                   PyverbsObject scq=None, PyverbsObject rcq=None,
-                  object srq=None, QPCap cap=None, sq_sig_all=1):
+                  SRQ srq=None, QPCap cap=None, sq_sig_all=1):
         """
         Initializes a QpInitAttr object representing ibv_qp_init_attr struct.
         Note that SRQ object is not yet supported in pyverbs so can't be passed
@@ -95,7 +96,7 @@ cdef class QPInitAttr(PyverbsObject):
         :param qp_context: Associated QP context
         :param scq: Send CQ to be used for this QP
         :param rcq: Receive CQ to be used for this QP
-        :param srq: Not yet supported
+        :param srq: Shared receive queue to be used as RQ in QP
         :param cap: A QPCap object
         :param sq_sig_all: If set, each send WR will generate a completion
                            entry
@@ -122,10 +123,10 @@ cdef class QPInitAttr(PyverbsObject):
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
                                        format(t=type(rcq)))
         self.rcq = rcq
-
-        self.attr.srq = NULL  # Until SRQ support is added
         self.attr.qp_type = qp_type
         self.attr.sq_sig_all = sq_sig_all
+        self.srq = srq
+        self.attr.srq = srq.srq if srq else NULL
 
     @property
     def send_cq(self):
@@ -138,6 +139,14 @@ cdef class QPInitAttr(PyverbsObject):
             self.attr.send_cq = (<CQEX>val).ibv_cq
         self.scq = val
 
+    @property
+    def srq(self):
+        return self.srq
+    @srq.setter
+    def srq(self, SRQ val):
+        self.attr.srq = <v.ibv_srq*>val.srq
+        self.srq = val
+
     @property
     def recv_cq(self):
         return self.rcq
@@ -193,7 +202,7 @@ cdef class QPInitAttr(PyverbsObject):
 cdef class QPInitAttrEx(PyverbsObject):
     def __cinit__(self, qp_type=e.IBV_QPT_UD, qp_context=None,
                   PyverbsObject scq=None, PyverbsObject rcq=None,
-                  object srq=None, QPCap cap=None, sq_sig_all=0, comp_mask=0,
+                  SRQ srq=None, QPCap cap=None, sq_sig_all=0, comp_mask=0,
                   PD pd=None, XRCD xrcd=None, create_flags=0,
                   max_tso_header=0, source_qpn=0, object hash_conf=None,
                   object ind_table=None):
@@ -203,7 +212,7 @@ cdef class QPInitAttrEx(PyverbsObject):
         :param qp_context: Associated user context
         :param scq: Send CQ to be used for this QP
         :param rcq: Recv CQ to be used for this QP
-        :param srq: Not yet supported
+        :param srq: Shared receive queue to be used as RQ in QP
         :param cap: A QPCap object
         :param sq_sig_all: If set, each send WR will generate a completion
                            entry
@@ -240,7 +249,8 @@ cdef class QPInitAttrEx(PyverbsObject):
                                        format(t=type(rcq)))
         self.rcq = rcq
 
-        self.attr.srq = NULL  # Until SRQ support is added
+        self.srq = srq
+        self.attr.srq = srq.srq if srq else NULL
         self.xrcd = xrcd
         self.attr.xrcd = xrcd.xrcd if xrcd else NULL
         self.attr.rwq_ind_tbl = NULL  # Until RSS support is added
@@ -327,6 +337,14 @@ cdef class QPInitAttrEx(PyverbsObject):
         self.attr.xrcd = <v.ibv_xrcd*>val.xrcd
         self.xrcd = val
 
+    @property
+    def srq(self):
+        return self.srq
+    @srq.setter
+    def srq(self, SRQ val):
+        self.attr.srq = <v.ibv_srq*>val.srq
+        self.srq = val
+
     @property
     def create_flags(self):
         return self.attr.create_flags
diff --git a/pyverbs/srq.pxd b/pyverbs/srq.pxd
new file mode 100755
index 000000000000..a7b7b34490e9
--- /dev/null
+++ b/pyverbs/srq.pxd
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.
+
+#cython: language_level=3
+
+from pyverbs.base cimport PyverbsObject, PyverbsCM
+from . cimport libibverbs as v
+
+cdef class SrqAttr(PyverbsObject):
+    cdef v.ibv_srq_attr attr
+
+cdef class SrqInitAttr(PyverbsObject):
+    cdef v.ibv_srq_init_attr    attr
+
+cdef class SrqInitAttrEx(PyverbsObject):
+    cdef v.ibv_srq_init_attr_ex attr
+    cdef object _cq
+    cdef object _pd
+    cdef object _xrcd
+
+cdef class SRQ(PyverbsCM):
+    cdef v.ibv_srq *srq
+    cdef object cq
+    cpdef close(self)
diff --git a/pyverbs/srq.pyx b/pyverbs/srq.pyx
new file mode 100755
index 000000000000..1d0d0dc4446b
--- /dev/null
+++ b/pyverbs/srq.pyx
@@ -0,0 +1,176 @@
+from pyverbs.pyverbs_error import PyverbsRDMAError
+from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.device cimport Context
+from pyverbs.cq cimport CQEX, CQ
+from pyverbs.xrcd cimport XRCD
+from pyverbs.wr cimport RecvWR
+from pyverbs.pd cimport PD
+
+
+cdef extern from 'errno.h':
+    int errno
+cdef extern from 'string.h':
+    void *memcpy(void *dest, const void *src, size_t n)
+
+
+cdef class SrqAttr(PyverbsObject):
+    def __cinit__(self, max_wr=100, max_sge=1, srq_limit=0):
+        self.attr.max_wr = max_wr
+        self.attr.max_sge = max_sge
+        self.attr.srq_limit = srq_limit
+
+    @property
+    def max_wr(self):
+        return self.attr.max_wr
+    @max_wr.setter
+    def max_wr(self, val):
+        self.attr.max_wr = val
+
+    @property
+    def max_sge(self):
+        return self.attr.max_sge
+    @max_sge.setter
+    def max_sge(self, val):
+        self.attr.max_sge = val
+
+    @property
+    def srq_limit(self):
+        return self.attr.srq_limit
+    def srq_limit(self, val):
+        self.attr.srq_limit = val
+
+
+cdef class SrqInitAttr(PyverbsObject):
+    def __cinit__(self, SrqAttr attr = None):
+         if attr is not None:
+            self.attr.attr.max_wr = attr.max_wr
+            self.attr.attr.max_sge = attr.max_sge
+            self.attr.attr.srq_limit = attr.srq_limit
+
+
+cdef class SrqInitAttrEx(PyverbsObject):
+    def __cinit__(self, max_wr=100, max_sge=1, srq_limit=0):
+        self.attr.attr.max_wr = max_wr
+        self.attr.attr.max_sge = max_sge
+        self.attr.attr.srq_limit = srq_limit
+        self._cq = None
+        self._pd = None
+        self._xrcd = None
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask = val
+
+    @property
+    def srq_type(self):
+        return self.attr.srq_type
+    @srq_type.setter
+    def srq_type(self, val):
+        self.attr.srq_type = val
+
+    @property
+    def pd(self):
+        return self._pd
+    @pd.setter
+    def pd(self, PD val):
+        self._pd = val
+        self.attr.pd = val.pd
+
+    @property
+    def xrcd(self):
+        return self._xrcd
+    @xrcd.setter
+    def xrcd(self, XRCD val):
+        self._xrcd = val
+        self.attr.xrcd = val.xrcd
+
+    @property
+    def cq(self):
+        return self._cq
+    @cq.setter
+    def cq(self, val):
+        if type(val) == CQ:
+            self.attr.cq = (<CQ>val).cq
+            self._cq = val
+        else:
+            self.attr.cq = (<CQEX>val).ibv_cq
+            self._cq = val
+
+
+cdef class SRQ(PyverbsCM):
+    def __cinit__(self, object creator not None, object attr not None):
+        self.srq = NULL
+        self.cq = None
+        if type(creator) == PD:
+            self._create_srq(creator, attr)
+        elif type(creator) == Context:
+            self._create_srq_ex(creator, attr)
+        else:
+            raise PyverbsRDMAError('Srq needs either Context or PD for creation')
+        if self.srq == NULL:
+            raise PyverbsRDMAErrno('Failed to create SRQ (errno is {err})'.
+                                   format(err=errno))
+        self.logger.debug('SRQ Created')
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        self.logger.debug('Closing SRQ')
+        if self.srq != NULL:
+            rc = v.ibv_destroy_srq(self.srq)
+            if rc != 0:
+                raise PyverbsRDMAErrno('Failed to destroy SRQ (errno is {err})'.
+                                        format(err=errno))
+            self.srq = NULL
+            self.cq =None
+
+    def _create_srq(self, PD pd, SrqInitAttr init_attr):
+        self.srq = v.ibv_create_srq(pd.pd, &init_attr.attr)
+
+    def _create_srq_ex(self, Context context, SrqInitAttrEx init_attr_ex):
+        self.srq = v.ibv_create_srq_ex(context.context, &init_attr_ex.attr)
+        if init_attr_ex.cq:
+            cq = <CQ>init_attr_ex.cq
+            cq.add_ref(self)
+            self.cq = cq
+        if init_attr_ex.xrcd:
+            xrcd = <XRCD>init_attr_ex.xrcd
+            xrcd.add_ref(self)
+        if init_attr_ex.pd:
+            pd = <PD>init_attr_ex.pd
+            pd.add_ref(self)
+
+    def get_srq_num(self):
+        cdef unsigned int srqn
+        rc = v.ibv_get_srq_num(self.srq, &srqn)
+        if rc != 0:
+           raise PyverbsRDMAErrno('Failed to retrieve SRQ number (returned {rc})'.
+                                   format(rc=rc))
+        return srqn
+
+    def modify(self, SrqAttr attr, comp_mask):
+        rc = v.ibv_modify_srq(self.srq, &attr.attr, comp_mask)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to modify SRQ ({err})'.
+                                   format(err=errno))
+
+    def query(self):
+        attr = SrqAttr()
+        rc = v.ibv_query_srq(self.srq, &attr.attr)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to query SRQ ({err})'.
+                                   format(err=errno))
+        return attr
+
+    def post_recv(self, RecvWR wr not None, RecvWR bad_wr=None):
+        cdef v.ibv_recv_wr *my_bad_wr
+        rc = v.ibv_post_srq_recv(self.srq, &wr.recv_wr, &my_bad_wr)
+        if rc != 0:
+            if bad_wr:
+                memcpy(&bad_wr.recv_wr, my_bad_wr, sizeof(bad_wr.recv_wr))
+                raise PyverbsRDMAErrno('Failed to post receive to SRQ ({err})'.
+                                  format(err=rc))
diff --git a/pyverbs/xrcd.pxd b/pyverbs/xrcd.pxd
index ab28dfafe1d1..4c1c6c042764 100755
--- a/pyverbs/xrcd.pxd
+++ b/pyverbs/xrcd.pxd
@@ -13,4 +13,5 @@ cdef class XRCD(PyverbsCM):
     cdef v.ibv_xrcd *xrcd
     cdef Context ctx
     cdef add_ref(self, obj)
+    cdef object srqs
     cdef object qps
diff --git a/pyverbs/xrcd.pyx b/pyverbs/xrcd.pyx
index 83d2a6b83e67..51a044ca7494 100755
--- a/pyverbs/xrcd.pyx
+++ b/pyverbs/xrcd.pyx
@@ -5,6 +5,7 @@ import weakref
 from pyverbs.pyverbs_error import PyverbsRDMAError, PyverbsError
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.device cimport Context
+from pyverbs.srq cimport SRQ
 from pyverbs.qp cimport QP
 
 cdef extern from 'errno.h':
@@ -53,6 +54,7 @@ cdef class XRCD(PyverbsCM):
         self.ctx = context
         context.add_ref(self)
         self.logger.debug('XRCD: Allocated ibv_xrcd')
+        self.srqs = weakref.WeakSet()
         self.qps = weakref.WeakSet()
 
     def __dealloc__(self):
@@ -68,7 +70,7 @@ cdef class XRCD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing XRCD')
-        self.close_weakrefs([self.qps])
+        self.close_weakrefs([self.qps, self.srqs])
         # XRCD may be deleted directly or indirectly by closing its context,
         # which leaves the Python XRCD object without the underlying C object,
         # so during destruction, need to check whether or not the C object
@@ -83,5 +85,7 @@ cdef class XRCD(PyverbsCM):
     cdef add_ref(self, obj):
         if isinstance(obj, QP):
             self.qps.add(obj)
+        elif isinstance(obj, SRQ):
+            self.srqs.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
-- 
2.21.0

