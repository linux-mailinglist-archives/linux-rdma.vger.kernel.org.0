Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386A914F1A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfEFPHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:49 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50114 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727522AbfEFPHs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edc019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 06/11] pyverbs: Introducing QP class
Date:   Mon,  6 May 2019 18:07:33 +0300
Message-Id: <20190506150738.19477-7-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow creation, modification, querying and post recv and send
operations on QPs of types RC, UC, UD and Raw Packet.

Creation process allows user to get the QP in a more advanced state
than INIT; by providing a QPAttr object (in addition to the mandatory
QPInitAttr object), the user tells pyverbs to use the provided values
and transition the QP as far as possible towards RTS. For connected
QPs it means to INIT state, for UD / Raw Packet QPs it means to RTS.
By default, the QPAttr's value will be None and the QP will be
returned in RESET state.

The QP class offers to_init/rtr/rts methods for quick and easy state
transitions - they only require the user to provide a QPAttr object
and the comp masks are being set according to the bits required for
each QP type / transition.

Similarly to querying a device, querying the QP doesn't require
providing the QPAttr / QPInitAttr objects; they are created by
pyverbs and are returned to the user as a tuple.

This patch also adds weakref support to CQ/CQEX to keep pyverbs'
reference scheme.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/cq.pxd         |   4 +
 pyverbs/cq.pyx         |  13 +++
 pyverbs/device.pxd     |   1 +
 pyverbs/device.pyx     |   6 +-
 pyverbs/libibverbs.pxd |  22 ++++
 pyverbs/pd.pxd         |   1 +
 pyverbs/pd.pyx         |   6 +-
 pyverbs/qp.pxd         |  11 ++
 pyverbs/qp.pyx         | 256 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 318 insertions(+), 2 deletions(-)

diff --git a/pyverbs/cq.pxd b/pyverbs/cq.pxd
index 44abf3bae010..0e3bcdfffb7e 100644
--- a/pyverbs/cq.pxd
+++ b/pyverbs/cq.pxd
@@ -14,6 +14,8 @@ cdef class CQ(PyverbsCM):
     cdef v.ibv_cq *cq
     cpdef close(self)
     cdef object context
+    cdef add_ref(self, obj)
+    cdef object qps
 
 cdef class CqInitAttrEx(PyverbsObject):
     cdef v.ibv_cq_init_attr_ex attr
@@ -24,6 +26,8 @@ cdef class CQEX(PyverbsCM):
     cdef v.ibv_cq *ibv_cq
     cpdef close(self)
     cdef object context
+    cdef add_ref(self, obj)
+    cdef object qps
 
 cdef class WC(PyverbsObject):
     cdef v.ibv_wc wc
diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index dd7ab3cff8f0..dd475759337c 100644
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -5,6 +5,7 @@ import weakref
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.device cimport Context
+from pyverbs.qp cimport QP
 
 cdef class CompChannel(PyverbsCM):
     """
@@ -93,13 +94,19 @@ cdef class CQ(PyverbsCM):
             raise PyverbsRDMAErrno('Failed to create a CQ')
         self.context = context
         context.add_ref(self)
+        self.qps = weakref.WeakSet()
         self.logger.debug('Created a CQ')
 
+    cdef add_ref(self, obj):
+        if isinstance(obj, QP):
+            self.qps.add(obj)
+
     def __dealloc__(self):
         self.close()
 
     cpdef close(self):
         self.logger.debug('Closing CQ')
+        self.close_weakrefs([self.qps])
         if self.cq != NULL:
             rc = v.ibv_destroy_cq(self.cq)
             if rc != 0:
@@ -267,12 +274,18 @@ cdef class CQEX(PyverbsCM):
         self.ibv_cq = v.ibv_cq_ex_to_cq(self.cq)
         self.context = context
         context.add_ref(self)
+        self.qps = weakref.WeakSet()
+
+    cdef add_ref(self, obj):
+        if isinstance(obj, QP):
+            self.qps.add(obj)
 
     def __dealloc__(self):
         self.close()
 
     cpdef close(self):
         self.logger.debug('Closing CQEx')
+        self.close_weakrefs([self.qps])
         if self.cq != NULL:
             rc = v.ibv_destroy_cq(<v.ibv_cq*>self.cq)
             if rc != 0:
diff --git a/pyverbs/device.pxd b/pyverbs/device.pxd
index aecdc0c1d254..3cb52bde4603 100644
--- a/pyverbs/device.pxd
+++ b/pyverbs/device.pxd
@@ -13,6 +13,7 @@ cdef class Context(PyverbsCM):
     cdef object dms
     cdef object ccs
     cdef object cqs
+    cdef object qps
 
 cdef class DeviceAttr(PyverbsObject):
     cdef v.ibv_device_attr dev_attr
diff --git a/pyverbs/device.pyx b/pyverbs/device.pyx
index 72acc4d2829f..fb1986f0ba8f 100644
--- a/pyverbs/device.pyx
+++ b/pyverbs/device.pyx
@@ -17,6 +17,7 @@ cimport pyverbs.libibverbs as v
 from pyverbs.addr cimport GID
 from pyverbs.mr import DMMR
 from pyverbs.pd cimport PD
+from pyverbs.qp cimport QP
 
 cdef extern from 'errno.h':
     int errno
@@ -88,6 +89,7 @@ cdef class Context(PyverbsCM):
         self.dms = weakref.WeakSet()
         self.ccs = weakref.WeakSet()
         self.cqs = weakref.WeakSet()
+        self.qps = weakref.WeakSet()
 
         dev_name = kwargs.get('name')
 
@@ -124,7 +126,7 @@ cdef class Context(PyverbsCM):
 
     cpdef close(self):
         self.logger.debug('Closing Context')
-        self.close_weakrefs([self.ccs, self.cqs, self.dms, self.pds])
+        self.close_weakrefs([self.qps, self.ccs, self.cqs, self.dms, self.pds])
         if self.context != NULL:
             rc = v.ibv_close_device(self.context)
             if rc != 0:
@@ -194,6 +196,8 @@ cdef class Context(PyverbsCM):
             self.ccs.add(obj)
         elif isinstance(obj, CQ) or isinstance(obj, CQEX):
             self.cqs.add(obj)
+        elif isinstance(obj, QP):
+            self.qps.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
 
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 039a6952a433..1aa5844b126e 100644
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -403,6 +403,19 @@ cdef extern from 'infiniband/verbs.h':
         unsigned int    handle
         unsigned int    events_completed
 
+    cdef struct ibv_qp:
+        ibv_context     *context;
+        void            *qp_context;
+        ibv_pd          *pd;
+        ibv_cq          *send_cq;
+        ibv_cq          *recv_cq;
+        ibv_srq         *srq;
+        unsigned int    handle;
+        unsigned int    qp_num;
+        ibv_qp_state    state;
+        ibv_qp_type     qp_type;
+        unsigned int    events_completed;
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
@@ -468,3 +481,12 @@ cdef extern from 'infiniband/verbs.h':
     ibv_ah *ibv_create_ah_from_wc(ibv_pd *pd, ibv_wc *wc, ibv_grh *grh,
                                   uint8_t port_num)
     int ibv_destroy_ah(ibv_ah *ah)
+    ibv_qp *ibv_create_qp(ibv_pd *pd, ibv_qp_init_attr *qp_init_attr)
+    ibv_qp *ibv_create_qp_ex(ibv_context *context,
+                             ibv_qp_init_attr_ex *qp_init_attr_ex)
+    int ibv_modify_qp(ibv_qp *qp, ibv_qp_attr *qp_attr, int comp_mask)
+    int ibv_query_qp(ibv_qp *qp, ibv_qp_attr *attr, int attr_mask,
+                     ibv_qp_init_attr *init_attr)
+    int ibv_destroy_qp(ibv_qp *qp)
+    int ibv_post_recv(ibv_qp *qp, ibv_recv_wr *wr, ibv_recv_wr **bad_wr)
+    int ibv_post_send(ibv_qp *qp, ibv_send_wr *wr, ibv_send_wr **bad_wr)
diff --git a/pyverbs/pd.pxd b/pyverbs/pd.pxd
index 0b8fb10e6c67..07c9158b27eb 100644
--- a/pyverbs/pd.pxd
+++ b/pyverbs/pd.pxd
@@ -12,3 +12,4 @@ cdef class PD(PyverbsCM):
     cdef object mrs
     cdef object mws
     cdef object ahs
+    cdef object qps
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index b09e3bf1a555..4b5dc139c59f 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -7,6 +7,7 @@ from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.device cimport Context, DM
 from .mr cimport MR, MW, DMMR
 from pyverbs.addr cimport AH
+from pyverbs.qp cimport QP
 
 cdef extern from 'errno.h':
     int errno
@@ -29,6 +30,7 @@ cdef class PD(PyverbsCM):
         self.mrs = weakref.WeakSet()
         self.mws = weakref.WeakSet()
         self.ahs = weakref.WeakSet()
+        self.qps = weakref.WeakSet()
 
     def __dealloc__(self):
         """
@@ -46,7 +48,7 @@ cdef class PD(PyverbsCM):
         :return: None
         """
         self.logger.debug('Closing PD')
-        self.close_weakrefs([self.ahs, self.mws, self.mrs])
+        self.close_weakrefs([self.qps, self.ahs, self.mws, self.mrs])
         if self.pd != NULL:
             rc = v.ibv_dealloc_pd(self.pd)
             if rc != 0:
@@ -61,6 +63,8 @@ cdef class PD(PyverbsCM):
             self.mws.add(obj)
         elif isinstance(obj, AH):
             self.ahs.add(obj)
+        elif isinstance(obj, QP):
+            self.qps.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
 
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
index 787fda3cb789..d85bc28992ad 100644
--- a/pyverbs/qp.pxd
+++ b/pyverbs/qp.pxd
@@ -19,3 +19,14 @@ cdef class QPInitAttrEx(PyverbsObject):
 
 cdef class QPAttr(PyverbsObject):
     cdef v.ibv_qp_attr attr
+
+cdef class QP(PyverbsCM):
+    cdef v.ibv_qp *qp
+    cdef int type
+    cdef int state
+    cdef object pd
+    cdef object context
+    cpdef close(self)
+    cdef update_cqs(self, init_attr)
+    cdef object scq
+    cdef object rcq
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 80aee40eae02..b33993a106e9 100644
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -3,9 +3,12 @@
 from pyverbs.utils import gid_str, qp_type_to_str, qp_state_to_str, mtu_to_str
 from pyverbs.utils import access_flags_to_str, mig_state_to_str
 from pyverbs.pyverbs_error import PyverbsUserError
+from pyverbs.base import PyverbsRDMAErrno
+from pyverbs.wr cimport RecvWR, SendWR
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.addr cimport AHAttr, GID
 from pyverbs.addr cimport GlobalRoute
+from pyverbs.device cimport Context
 from pyverbs.cq cimport CQ, CQEX
 cimport pyverbs.libibverbs as v
 from pyverbs.pd cimport PD
@@ -750,6 +753,259 @@ cdef class QPAttr(PyverbsObject):
                print_format.format('Rate limit', self.attr.rate_limit)
 
 
+cdef class QP(PyverbsCM):
+    def __cinit__(self, object creator not None, object init_attr not None,
+                  QPAttr qp_attr=None):
+        """
+        Initializes a QP object and performs state transitions according to
+        user request.
+        A C ibv_qp object will be created using the provided init_attr.
+        If a qp_attr object is provided, pyverbs will consider this a hint to
+        transit the QP's state as far as possible towards RTS:
+        - In case of UD and Raw Packet QP types, if a qp_attr is provided the
+          QP will be returned in RTS state.
+        - In case of connected QPs (RC, UC), remote QPN is needed for INIT2RTR
+          transition, so if a qp_attr is provided, the QP will be returned in
+          INIT state.
+        :param creator: The object creating the QP. Can be of type PD so
+                        ibv_create_qp will be used or of type Context, so
+                        ibv_create_qp_ex will be used.
+        :param init_attr: QP initial attributes of type QPInitAttr (when
+                          created using PD) or QPInitAttrEx (when created
+                          using Context).
+        :param qp_attr: Optional QPAttr object. Will be used for QP state
+                        transitions after creation.
+        :return: An initialized QP object
+        """
+        cdef PD pd
+        cdef Context ctx
+        self.update_cqs(init_attr)
+        # In order to use cdef'd methods, a proper casting must be done, let's
+        # infer the type.
+        if type(creator) == Context:
+            self._create_qp_ex(creator, init_attr)
+            ctx = <Context>creator
+            self.context = ctx
+            ctx.add_ref(self)
+            if init_attr.pd is not None:
+                pd = <PD>init_attr.pd
+                pd.add_ref(self)
+                self.pd = pd
+        else:
+            self._create_qp(creator, init_attr)
+            pd = <PD>creator
+            self.pd = pd
+            pd.add_ref(self)
+            self.context = None
+        if self.qp == NULL:
+            raise PyverbsRDMAErrno('Failed to create QP')
+        if qp_attr is not None:
+            funcs = {e.IBV_QPT_RC: self.to_init, e.IBV_QPT_UC: self.to_init,
+                     e.IBV_QPT_UD: self.to_rts,
+                     e.IBV_QPT_RAW_PACKET: self.to_rts}
+            funcs[self.qp.qp_type](qp_attr)
+
+    cdef update_cqs(self, init_attr):
+        cdef CQ cq
+        cdef CQEX cqex
+        if init_attr.send_cq is not None:
+            if type(init_attr.send_cq) == CQ:
+                cq = <CQ>init_attr.send_cq
+                cq.add_ref(self)
+            else:
+                cqex = <CQEX>init_attr.send_cq
+                cqex.add_ref(self)
+            self.scq = cq
+        if init_attr.send_cq != init_attr.recv_cq and init_attr.recv_cq is not None:
+            if type(init_attr.recv_cq) == CQ:
+                cq = <CQ>init_attr.recv_cq
+                cq.add_ref(self)
+            else:
+                cqex = <CQEX>init_attr.recv_cq
+                cqex.add_ref(self)
+            self.rcq = cq
+
+    def _create_qp(self, PD pd, QPInitAttr attr):
+        self.qp = v.ibv_create_qp(pd.pd, &attr.attr)
+
+    def _create_qp_ex(self, Context ctx, QPInitAttrEx attr):
+        self.qp = v.ibv_create_qp_ex(ctx.context, &attr.attr)
+
+    def __dealloc__(self):
+        self.close()
+
+    cpdef close(self):
+        self.logger.debug('Closing QP')
+        if self.qp != NULL:
+            if v.ibv_destroy_qp(self.qp):
+                raise PyverbsRDMAErrno('Failed to destroy QP')
+            self.qp = NULL
+            self.pd = None
+            self.context = None
+            self.scq = None
+            self.rcq = None
+
+    def _get_comp_mask(self, dst):
+        masks = {e.IBV_QPT_RC: {'INIT': e.IBV_QP_PKEY_INDEX | e.IBV_QP_PORT |\
+                                e.IBV_QP_ACCESS_FLAGS, 'RTR': e.IBV_QP_AV |\
+                                e.IBV_QP_PATH_MTU | e.IBV_QP_DEST_QPN |\
+                                e.IBV_QP_RQ_PSN |\
+                                e.IBV_QP_MAX_DEST_RD_ATOMIC |\
+                                e.IBV_QP_MIN_RNR_TIMER,
+                                'RTS': e.IBV_QP_TIMEOUT |\
+                                e.IBV_QP_RETRY_CNT | e.IBV_QP_RNR_RETRY |\
+                                e.IBV_QP_SQ_PSN | e.IBV_QP_MAX_QP_RD_ATOMIC},
+                e.IBV_QPT_UC: {'INIT': e.IBV_QP_PKEY_INDEX | e.IBV_QP_PORT |\
+                               e.IBV_QP_ACCESS_FLAGS, 'RTR': e.IBV_QP_AV |\
+                               e.IBV_QP_PATH_MTU | e.IBV_QP_DEST_QPN |\
+                               e.IBV_QP_RQ_PSN, 'RTS': e.IBV_QP_SQ_PSN},
+                e.IBV_QPT_UD: {'INIT': e.IBV_QP_PKEY_INDEX | e.IBV_QP_PORT |\
+                               e.IBV_QP_QKEY, 'RTR': 0,
+                               'RTS': e.IBV_QP_SQ_PSN},
+                e.IBV_QPT_RAW_PACKET: {'INIT': e.IBV_QP_PORT, 'RTR': 0,
+                                       'RTS': 0}}
+        return masks[self.qp.qp_type][dst] | e.IBV_QP_STATE
+
+    def to_init(self, QPAttr qp_attr):
+        """
+        Modify the current QP's state to INIT. If the current state doesn't
+        support transition to INIT, an exception will be raised.
+        The comp mask provided to the kernel includes the needed bits for 2INIT
+        transition for this QP type.
+        :param qp_attr: QPAttr object containing the needed attributes for
+                        2INIT transition
+        :return: None
+        """
+        mask = self._get_comp_mask('INIT')
+        qp_attr.qp_state = e.IBV_QPS_INIT
+        rc =  v.ibv_modify_qp(self.qp, &qp_attr.attr, mask)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to modify QP state to init (returned {rc})'.
+                                   format(rc=rc))
+
+    def to_rtr(self, QPAttr qp_attr):
+        """
+        Modify the current QP's state to RTR. It assumes that its current
+        state is INIT or RESET, in which case it will attempt a transition to
+        INIT prior to transition to RTR. As a result, if current state doesn't
+        support transition to INIT, an exception will be raised.
+        The comp mask provided to the kernel includes the needed bits for 2RTR
+        transition for this QP type.
+        :param qp_attr: QPAttr object containing the needed attributes for
+                        2RTR transition.
+        :return: None
+        """
+        if self.qp_state != e.IBV_QPS_INIT: #assume reset
+            self.to_init(qp_attr)
+        mask = self._get_comp_mask('RTR')
+        qp_attr.qp_state = e.IBV_QPS_RTR
+        rc = v.ibv_modify_qp(self.qp, &qp_attr.attr, mask)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to modify QP state to RTR (returned {rc})'.
+                                   format(rc=rc))
+
+    def to_rts(self, QPAttr qp_attr):
+        """
+        Modify the current QP's state to RTS. It assumes that its current
+        state is either RTR, INIT or RESET. If current state is not RTR, to_rtr()
+        will be called.
+        The comp mask provided to the kernel includes the needed bits for 2RTS
+        transition for this QP type.
+        :param qp_attr: QPAttr object containing the needed attributes for
+                        2RTS transition.
+        :return: None
+        """
+        if self.qp_state != e.IBV_QPS_RTR: #assume reset/init
+            self.to_rtr(qp_attr)
+        mask = self._get_comp_mask('RTS')
+        qp_attr.qp_state = e.IBV_QPS_RTS
+        rc = v.ibv_modify_qp(self.qp, &qp_attr.attr, mask)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to modify QP state to RTS (returned {rc})'.
+                                   format(rc=rc))
+
+    def query(self, attr_mask):
+        """
+        Query the QP
+        :param attr_mask: The minimum list of attributes to retrieve. Some
+                          devices may return additional attributes as well
+                          (see enum ibv_qp_attr_mask)
+        :return: (QPAttr, QPInitAttr) tuple containing the QP requested
+                 attributes
+        """
+        attr = QPAttr()
+        init_attr = QPInitAttr()
+        rc = v.ibv_query_qp(self.qp, &attr.attr, attr_mask, &init_attr.attr)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to query QP (returned {rc})'.
+                                   format(rc=rc))
+        return attr, init_attr
+
+    def modify(self, QPAttr qp_attr not None, comp_mask):
+        """
+        Modify the QP
+        :param qp_attr: A QPAttr object with updated values to be applied to
+                        the QP
+        :param comp_mask: A bitmask specifying which QP attributes should be
+                          modified (see enum ibv_qp_attr_mask)
+        :return: None
+        """
+        rc = v.ibv_modify_qp(self.qp, &qp_attr.attr, comp_mask)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to modify QP (returned {rc})'.
+                                   format(rc=rc))
+
+    def post_recv(self, RecvWR wr not None, RecvWR bad_wr=None):
+        """
+        Post a receive WR on the QP.
+        :param wr: The work request to post
+        :param bad_wr: A RecvWR object to hold the bad WR if it is available in
+                       case of a failure
+        :return: None
+        """
+        cdef v.ibv_recv_wr *my_bad_wr
+        rc = v.ibv_post_recv(self.qp, &wr.recv_wr, &my_bad_wr)
+        if rc != 0:
+            if bad_wr is not None:
+                bad_wr.wr = <object>my_bad_wr
+            raise PyverbsRDMAErrno('Failed to post recv (returned {rc})'.
+                                   format(rc=rc))
+
+    def post_send(self, SendWR wr not None, SendWR bad_wr=None):
+        """
+        Post a send WR on the QP.
+        :param wr: The work request to post
+        :param bad_wr: A SendWR object to hold the bad WR if it is available in
+                       case of a failure
+        :return: None
+        """
+        cdef v.ibv_send_wr *my_bad_wr
+        rc = v.ibv_post_send(self.qp, &wr.send_wr, &my_bad_wr)
+        if rc != 0:
+            if bad_wr is not None:
+                bad_wr.wr = <object>my_bad_wr
+            raise PyverbsRDMAErrno('Failed to post send (returned {rc})'.
+                                   format(rc=rc))
+
+    @property
+    def qp_type(self):
+        return self.qp.qp_type
+
+    @property
+    def qp_state(self):
+        return self.qp.state
+
+    @property
+    def qp_num(self):
+        return self.qp.qp_num
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        return print_format.format('QP type', qp_type_to_str(self.qp_type)) +\
+               print_format.format('  number', self.qp_num) +\
+               print_format.format('  state', qp_state_to_str(self.qp_state))
+
+
 def _copy_caps(QPCap src, dst):
     """
     Copy the QPCaps values of src into the inner ibv_qp_cap struct of dst.
-- 
2.17.2

