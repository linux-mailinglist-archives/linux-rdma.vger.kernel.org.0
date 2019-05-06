Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED4014F3C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEFPIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:08:02 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50112 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727508AbfEFPHv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:51 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edb019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 05/11] pyverbs: Add QP related classes
Date:   Mon,  6 May 2019 18:07:32 +0300
Message-Id: <20190506150738.19477-6-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds the following classes needed to create a QP: QPCap,
PInitAttr, QPInitAttrEx and QPAttr.

These classes provide a user-friendly print format.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/CMakeLists.txt |   1 +
 pyverbs/libibverbs.pxd |  78 ++++
 pyverbs/pd.pyx         |   4 +
 pyverbs/qp.pxd         |  21 ++
 pyverbs/qp.pyx         | 790 +++++++++++++++++++++++++++++++++++++++++
 pyverbs/utils.py       |  46 +++
 6 files changed, 940 insertions(+)
 create mode 100644 pyverbs/qp.pxd
 create mode 100644 pyverbs/qp.pyx

diff --git a/pyverbs/CMakeLists.txt b/pyverbs/CMakeLists.txt
index 9545e5052628..3b3838ddb8b5 100644
--- a/pyverbs/CMakeLists.txt
+++ b/pyverbs/CMakeLists.txt
@@ -9,6 +9,7 @@ rdma_cython_module(pyverbs
   enums.pyx
   mr.pyx
   pd.pyx
+  qp.pyx
   wr.pyx
   )
 
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 33c655f42491..039a6952a433 100644
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -325,6 +325,84 @@ cdef extern from 'infiniband/verbs.h':
         qp_type         qp_type
         unnamed         unnamed
 
+    cdef struct ibv_qp_cap:
+        unsigned int    max_send_wr
+        unsigned int    max_recv_wr
+        unsigned int    max_send_sge
+        unsigned int    max_recv_sge
+        unsigned int    max_inline_data
+
+    cdef struct ibv_qp_init_attr:
+        void            *qp_context
+        ibv_cq          *send_cq
+        ibv_cq          *recv_cq
+        ibv_srq         *srq
+        ibv_qp_cap      cap
+        ibv_qp_type     qp_type
+        int             sq_sig_all
+
+    cdef struct ibv_xrcd:
+        pass
+
+    cdef struct ibv_rwq_ind_table:
+        pass
+
+    cdef struct ibv_rx_hash_conf:
+        pass
+
+    cdef struct ibv_qp_init_attr_ex:
+        void                *qp_context
+        ibv_cq              *send_cq
+        ibv_cq              *recv_cq
+        ibv_srq             *srq
+        ibv_qp_cap          cap
+        ibv_qp_type         qp_type
+        int                 sq_sig_all
+        unsigned int        comp_mask
+        ibv_pd              *pd
+        ibv_xrcd            *xrcd
+        unsigned int        create_flags
+        unsigned short      max_tso_header
+        ibv_rwq_ind_table   *rwq_ind_tbl
+        ibv_rx_hash_conf    rx_hash_conf
+        unsigned int        source_qpn
+        unsigned long       send_ops_flags
+
+    cdef struct ibv_qp_attr:
+        ibv_qp_state    qp_state
+        ibv_qp_state    cur_qp_state
+        ibv_mtu         path_mtu
+        ibv_mig_state   path_mig_state
+        unsigned int    qkey
+        unsigned int    rq_psn
+        unsigned int    sq_psn
+        unsigned int    dest_qp_num
+        unsigned int    qp_access_flags
+        ibv_qp_cap      cap
+        ibv_ah_attr     ah_attr
+        ibv_ah_attr     alt_ah_attr
+        unsigned short  pkey_index
+        unsigned short  alt_pkey_index
+        unsigned char   en_sqd_async_notify
+        unsigned char   sq_draining
+        unsigned char   max_rd_atomic
+        unsigned char   max_dest_rd_atomic
+        unsigned char   min_rnr_timer
+        unsigned char   port_num
+        unsigned char   timeout
+        unsigned char   retry_cnt
+        unsigned char   rnr_retry
+        unsigned char   alt_port_num
+        unsigned char   alt_timeout
+        unsigned int    rate_limit
+
+    cdef struct ibv_srq:
+        ibv_context     *context
+        void            *srq_context
+        ibv_pd          *pd
+        unsigned int    handle
+        unsigned int    events_completed
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index c2164f8381bd..b09e3bf1a555 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -63,3 +63,7 @@ cdef class PD(PyverbsCM):
             self.ahs.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
+
+    @property
+    def _pd(self):
+        return <object>self.pd
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
new file mode 100644
index 000000000000..787fda3cb789
--- /dev/null
+++ b/pyverbs/qp.pxd
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.
+from pyverbs.base cimport PyverbsObject, PyverbsCM
+cimport pyverbs.libibverbs as v
+
+cdef class QPCap(PyverbsObject):
+    cdef v.ibv_qp_cap cap
+
+cdef class QPInitAttr(PyverbsObject):
+    cdef v.ibv_qp_init_attr attr
+    cdef object scq
+    cdef object rcq
+
+cdef class QPInitAttrEx(PyverbsObject):
+    cdef v.ibv_qp_init_attr_ex attr
+    cdef object scq
+    cdef object rcq
+    cdef object pd
+
+cdef class QPAttr(PyverbsObject):
+    cdef v.ibv_qp_attr attr
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
new file mode 100644
index 000000000000..80aee40eae02
--- /dev/null
+++ b/pyverbs/qp.pyx
@@ -0,0 +1,790 @@
+# SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
+# Copyright (c) 2019 Mellanox Technologies, Inc. All rights reserved.
+from pyverbs.utils import gid_str, qp_type_to_str, qp_state_to_str, mtu_to_str
+from pyverbs.utils import access_flags_to_str, mig_state_to_str
+from pyverbs.pyverbs_error import PyverbsUserError
+cimport pyverbs.libibverbs_enums as e
+from pyverbs.addr cimport AHAttr, GID
+from pyverbs.addr cimport GlobalRoute
+from pyverbs.cq cimport CQ, CQEX
+cimport pyverbs.libibverbs as v
+from pyverbs.pd cimport PD
+
+
+cdef class QPCap(PyverbsObject):
+    def __cinit__(self, max_send_wr=1, max_recv_wr=10, max_send_sge=1,
+                      max_recv_sge=1, max_inline_data=0):
+        """
+        Initializes a QPCap object with user-provided or default values.
+        :param max_send_wr: max number of outstanding WRs in the SQ
+        :param max_recv_wr: max number of outstanding WRs in the RQ
+        :param max_send_sge: Requested max number of scatter-gather elements in
+                             a WR in the SQ
+        :param max_recv_sge: Requested max number of scatter-gather elements in
+                             a WR in the RQ
+        :param max_inline_data: max number of data (bytes) that can be posted
+                                inline to the SQ, otherwise 0
+        :return:
+        """
+        self.cap.max_send_wr = max_send_wr
+        self.cap.max_recv_wr = max_recv_wr
+        self.cap.max_send_sge = max_send_sge
+        self.cap.max_recv_sge = max_recv_sge
+        self.cap.max_inline_data = max_inline_data
+
+    @property
+    def max_send_wr(self):
+        return self.cap.max_send_wr
+    @max_send_wr.setter
+    def max_send_wr(self, val):
+        self.cap.max_send_wr = val
+
+    @property
+    def max_recv_wr(self):
+        return self.cap.max_recv_wr
+    @max_recv_wr.setter
+    def max_recv_wr(self, val):
+        self.cap.max_recv_wr = val
+
+    @property
+    def max_send_sge(self):
+        return self.cap.max_send_sge
+    @max_send_sge.setter
+    def max_send_sge(self, val):
+        self.cap.max_send_sge = val
+
+    @property
+    def max_recv_sge(self):
+        return self.cap.max_recv_sge
+    @max_recv_sge.setter
+    def max_recv_sge(self, val):
+        self.cap.max_recv_sge = val
+
+    @property
+    def max_inline_data(self):
+        return self.cap.max_inline_data
+    @max_inline_data.setter
+    def max_inline_data(self, val):
+        self.cap.max_inline_data = val
+
+    def __str__(self):
+        print_format = '{:20}: {:<20}\n'
+        return print_format.format('max send wrs', self.cap.max_send_wr) +\
+               print_format.format('max recv wrs', self.cap.max_recv_wr) +\
+               print_format.format('max send sges', self.cap.max_send_sge) +\
+               print_format.format('max recv sges', self.cap.max_recv_sge) +\
+               print_format.format('max inline data', self.cap.max_inline_data)
+
+
+cdef class QPInitAttr(PyverbsObject):
+    def __cinit__(self, qp_type=e.IBV_QPT_UD, qp_context=None,
+                  PyverbsObject scq=None, PyverbsObject rcq=None,
+                  object srq=None, QPCap cap=None, sq_sig_all=1):
+        """
+        Initializes a QpInitAttr object representing ibv_qp_init_attr struct.
+        Note that SRQ object is not yet supported in pyverbs so can't be passed
+        as a parameter. None should be used until such support is added.
+        :param qp_type: The desired QP type (see enum ibv_qp_type)
+        :param qp_context: Associated QP context
+        :param scq: Send CQ to be used for this QP
+        :param rcq: Receive CQ to be used for this QP
+        :param srq: Not yet supported
+        :param cap: A QPCap object
+        :param sq_sig_all: If set, each send WR will generate a completion
+                           entry
+        :return: A QpInitAttr object
+        """
+        _copy_caps(cap, self)
+        self.attr.qp_context = <void*>qp_context
+        if scq is not None:
+            if type(scq) is CQ:
+                self.attr.send_cq = <v.ibv_cq*>scq._cq
+            elif type(scq) is CQEX:
+                self.attr.send_cq = <v.ibv_cq*>scq._ibv_cq
+            else:
+                raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
+                                       format(t=type(scq)))
+        self.scq = scq
+
+        if rcq is not None:
+            if type(rcq) is CQ:
+                self.attr.recv_cq = <v.ibv_cq*>rcq._cq
+            elif type(rcq) is CQEX:
+                self.attr.recv_cq = <v.ibv_cq*>rcq._ibv_cq
+            else:
+                raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
+                                       format(t=type(rcq)))
+        self.rcq = rcq
+
+        self.attr.srq = NULL  # Until SRQ support is added
+        self.attr.qp_type = qp_type
+        self.attr.sq_sig_all = sq_sig_all
+
+    @property
+    def send_cq(self):
+        return self.scq
+    @send_cq.setter
+    def send_cq(self, val):
+        if type(val) is CQ:
+            self.attr.send_cq = <v.ibv_cq*>val._cq
+        elif type(val) is CQEX:
+            self.attr.send_cq = <v.ibv_cq*>val._ibv_cq
+        self.scq = val
+
+    @property
+    def recv_cq(self):
+        return self.rcq
+    @recv_cq.setter
+    def recv_cq(self, val):
+        if type(val) is CQ:
+            self.attr.recv_cq = <v.ibv_cq*>val._cq
+        elif type(val) is CQEX:
+            self.attr.recv_cq = <v.ibv_cq*>val._ibv_cq
+        self.rcq = val
+
+    @property
+    def cap(self):
+        return QPCap(max_send_wr=self.attr.cap.max_send_wr,
+                     max_recv_wr=self.attr.cap.max_recv_wr,
+                     max_send_sge=self.attr.cap.max_send_sge,
+                     max_recv_sge=self.attr.cap.max_recv_sge,
+                     max_inline_data=self.attr.cap.max_inline_data)
+    @cap.setter
+    def cap(self, val):
+        _copy_caps(val, self)
+
+    @property
+    def qp_type(self):
+        return self.attr.qp_type
+    @qp_type.setter
+    def qp_type(self, val):
+        self.attr.qp_type = val
+
+    @property
+    def sq_sig_all(self):
+        return self.attr.sq_sig_all
+    @sq_sig_all.setter
+    def sq_sig_all(self, val):
+        self.attr.sq_sig_all = val
+
+    def __str__(self):
+        print_format = '{:20}: {:<20}\n'
+        ident_format = '    {:20}: {:<20}\n'
+        return print_format.format('QP type', qp_type_to_str(self.qp_type)) +\
+               print_format.format('SQ sig. all', self.sq_sig_all) +\
+               'QP caps:\n' +\
+               ident_format.format('max send WR', self.attr.cap.max_send_wr) +\
+               ident_format.format('max recv WR', self.attr.cap.max_recv_wr) +\
+               ident_format.format('max send SGE',
+                                   self.attr.cap.max_send_sge) +\
+               ident_format.format('max recv SGE',
+                                   self.attr.cap.max_recv_sge) +\
+               ident_format.format('max inline data',
+                                   self.attr.cap.max_inline_data)
+
+
+cdef class QPInitAttrEx(PyverbsObject):
+    def __cinit__(self, qp_type=e.IBV_QPT_UD, qp_context=None,
+                  PyverbsObject scq=None, PyverbsObject rcq=None,
+                  object srq=None, QPCap cap=None, sq_sig_all=0, comp_mask=0,
+                  PD pd=None, object xrcd=None, create_flags=0,
+                  max_tso_header=0, source_qpn=0, object hash_conf=None,
+                  object ind_table=None):
+        """
+        Initialize a QPInitAttrEx object with user-defined or default values.
+        :param qp_type: QP type to be created
+        :param qp_context: Associated user context
+        :param scq: Send CQ to be used for this QP
+        :param rcq: Recv CQ to be used for this QP
+        :param srq: Not yet supported
+        :param cap: A QPCap object
+        :param sq_sig_all: If set, each send WR will generate a completion
+                           entry
+        :param comp_mask: bit mask to determine which of the following fields
+                          are valid
+        :param pd: A PD object to be associated with this QP
+        :param xrcd: Not yet supported
+        :param create_flags: Creation flags for this QP
+        :param max_tso_header: Maximum TSO header size
+        :param source_qpn: Source QP number (requires IBV_QP_CREATE_SOURCE_QPN
+                           set in create_flags)
+        :param hash_conf: Not yet supported
+        :param ind_table: Not yet supported
+        :return: An initialized QPInitAttrEx object
+        """
+        _copy_caps(cap, self)
+        if scq is not None:
+            if type(scq) is CQ:
+                self.attr.send_cq = <v.ibv_cq*>scq._cq
+            elif type(scq) is CQEX:
+                self.attr.send_cq = <v.ibv_cq*>scq._ibv_cq
+            else:
+                raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
+                                       format(t=type(scq)))
+        self.scq = scq
+
+        if rcq is not None:
+            if type(rcq) is CQ:
+                self.attr.recv_cq = <v.ibv_cq*>rcq._cq
+            elif type(rcq) is CQEX:
+                self.attr.recv_cq = <v.ibv_cq*>rcq._ibv_cq
+            else:
+                raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
+                                       format(type(rcq)))
+        self.rcq = rcq
+
+        self.attr.srq = NULL  # Until SRQ support is added
+        self.attr.xrcd = NULL  # Until XRCD support is added
+        self.attr.rwq_ind_tbl = NULL  # Until RSS support is added
+        self.attr.qp_type = qp_type
+        self.attr.sq_sig_all = sq_sig_all
+        unsupp_flags = e.IBV_QP_INIT_ATTR_XRCD | e.IBV_QP_INIT_ATTR_IND_TABLE |\
+                       e.IBV_QP_INIT_ATTR_RX_HASH
+        if comp_mask & unsupp_flags:
+            raise PyverbsUserError('XRCD and RSS are not yet supported in pyverbs')
+        self.attr.comp_mask = comp_mask
+        if pd is not None:
+            self.attr.pd = <v.ibv_pd*>pd._pd
+            self.pd = pd
+        self.attr.create_flags = create_flags
+        self.attr.max_tso_header = max_tso_header
+        self.attr.source_qpn = source_qpn
+
+    @property
+    def send_cq(self):
+        return self.scq
+    @send_cq.setter
+    def send_cq(self, val):
+        if type(val) is CQ:
+            self.attr.send_cq = <v.ibv_cq*>val._cq
+        elif type(val) is CQEX:
+            self.attr.send_cq = <v.ibv_cq*>val._ibv_cq
+        self.scq = val
+
+    @property
+    def recv_cq(self):
+        return self.rcq
+    @recv_cq.setter
+    def recv_cq(self, val):
+        if type(val) is CQ:
+            self.attr.recv_cq = <v.ibv_cq*>val._cq
+        elif type(val) is CQEX:
+            self.attr.recv_cq = <v.ibv_cq*>val._ibv_cq
+        self.rcq = val
+
+    @property
+    def cap(self):
+        return QPCap(max_send_wr=self.attr.cap.max_send_wr,
+                     max_recv_wr=self.attr.cap.max_recv_wr,
+                     max_send_sge=self.attr.cap.max_send_sge,
+                     max_recv_sge=self.attr.cap.max_recv_sge,
+                     max_inline_data=self.attr.cap.max_inline_data)
+    @cap.setter
+    def cap(self, val):
+        _copy_caps(val, self)
+
+    @property
+    def qp_type(self):
+        return self.attr.qp_type
+    @qp_type.setter
+    def qp_type(self, val):
+        self.attr.qp_type = val
+
+    @property
+    def sq_sig_all(self):
+        return self.attr.sq_sig_all
+    @sq_sig_all.setter
+    def sq_sig_all(self, val):
+        self.attr.sq_sig_all = val
+
+    @property
+    def comp_mask(self):
+        return self.attr.comp_mask
+    @comp_mask.setter
+    def comp_mask(self, val):
+        self.attr.comp_mask = val
+
+    @property
+    def pd(self):
+        return self.pd
+    @pd.setter
+    def pd(self, val):
+        self.attr.pd = <v.ibv_pd*>val._pd
+        self.pd = val
+
+    @property
+    def create_flags(self):
+        return self.attr.create_flags
+    @create_flags.setter
+    def create_flags(self, val):
+        self.attr.create_flags = val
+
+    @property
+    def max_tso_header(self):
+        return self.attr.max_tso_header
+    @max_tso_header.setter
+    def max_tso_header(self, val):
+        self.attr.max_tso_header = val
+
+    @property
+    def source_qpn(self):
+        return self.attr.source_qpn
+    @source_qpn.setter
+    def source_qpn(self, val):
+        self.attr.source_qpn = val
+
+    def mask_to_str(self, mask):
+        comp_masks = {1: 'PD', 2: 'XRCD', 4: 'Create Flags',
+                      8: 'Max TSO header', 16: 'Indirection Table',
+                      32: 'RX hash'}
+        mask_str = ''
+        for f in comp_masks:
+            if mask & f:
+                mask_str += comp_masks[f]
+                mask_str += ' '
+        return mask_str
+
+    def flags_to_str(self, flags):
+        create_flags = {1: 'Block self mcast loopback', 2: 'Scatter FCS',
+                        4: 'CVLAN stripping', 8: 'Source QPN',
+                        16: 'PCI write end padding'}
+        create_str = ''
+        for f in create_flags:
+            if flags & f:
+                create_str += create_flags[f]
+                create_str += ' '
+        return create_str
+
+    def __str__(self):
+        print_format = '{:20}: {:<20}\n'
+        return print_format.format('QP type', qp_type_to_str(self.qp_type)) +\
+               print_format.format('SQ sig. all', self.sq_sig_all) +\
+               'QP caps:\n' +\
+               print_format.format('  max send WR',
+                                   self.attr.cap.max_send_wr) +\
+               print_format.format('  max recv WR',
+                                   self.attr.cap.max_recv_wr) +\
+               print_format.format('  max send SGE',
+                                   self.attr.cap.max_send_sge) +\
+               print_format.format('  max recv SGE',
+                                   self.attr.cap.max_recv_sge) +\
+               print_format.format('  max inline data',
+                                   self.attr.cap.max_inline_data) +\
+               print_format.format('comp mask',
+                                   self.mask_to_str(self.attr.comp_mask)) +\
+               print_format.format('create flags',
+                                   self.flags_to_str(self.attr.create_flags)) +\
+               print_format.format('max TSO header',
+                                   self.attr.max_tso_header) +\
+               print_format.format('Source QPN', self.attr.source_qpn)
+
+
+cdef class QPAttr(PyverbsObject):
+    def __cinit__(self, qp_state=e.IBV_QPS_INIT, cur_qp_state=e.IBV_QPS_RESET,
+                  port_num=1, path_mtu=e.IBV_MTU_1024):
+        """
+        Initializes a QPQttr object which represents ibv_qp_attr structs. It
+        can be used to modify a QP.
+        This function initializes default values for reset-to-init transition.
+        :param qp_state: Desired QP state
+        :param cur_qp_state: Current QP state
+        :return: An initialized QpAttr object
+        """
+        self.attr.qp_state = qp_state
+        self.attr.cur_qp_state = cur_qp_state
+        self.attr.port_num = port_num
+        self.attr.path_mtu = path_mtu
+
+    @property
+    def qp_state(self):
+        return self.attr.qp_state
+    @qp_state.setter
+    def qp_state(self, val):
+        self.attr.qp_state = val
+
+    @property
+    def cur_qp_state(self):
+        return self.attr.cur_qp_state
+    @cur_qp_state.setter
+    def cur_qp_state(self, val):
+        self.attr.cur_qp_state = val
+
+    @property
+    def path_mtu(self):
+        return self.attr.path_mtu
+    @path_mtu.setter
+    def path_mtu(self, val):
+        self.attr.path_mtu = val
+
+    @property
+    def path_mig_state(self):
+        return self.attr.path_mig_state
+    @path_mig_state.setter
+    def path_mig_state(self, val):
+        self.attr.path_mig_state = val
+
+    @property
+    def qkey(self):
+        return self.attr.qkey
+    @qkey.setter
+    def qkey(self, val):
+        self.attr.qkey = val
+
+    @property
+    def rq_psn(self):
+        return self.attr.rq_psn
+    @rq_psn.setter
+    def rq_psn(self, val):
+        self.attr.rq_psn = val
+
+    @property
+    def sq_psn(self):
+        return self.attr.sq_psn
+    @sq_psn.setter
+    def sq_psn(self, val):
+        self.attr.sq_psn = val
+
+    @property
+    def dest_qp_num(self):
+        return self.attr.dest_qp_num
+    @dest_qp_num.setter
+    def dest_qp_num(self, val):
+        self.attr.dest_qp_num = val
+
+    @property
+    def qp_access_flags(self):
+        return self.attr.qp_access_flags
+    @qp_access_flags.setter
+    def qp_access_flags(self, val):
+        self.attr.qp_access_flags = val
+
+    @property
+    def cap(self):
+        return QPCap(max_send_wr=self.attr.cap.max_send_wr,
+                     max_recv_wr=self.attr.cap.max_recv_wr,
+                     max_send_sge=self.attr.cap.max_send_sge,
+                     max_recv_sge=self.attr.cap.max_recv_sge,
+                     max_inline_data=self.attr.cap.max_inline_data)
+    @cap.setter
+    def cap(self, val):
+        _copy_caps(val, self)
+
+    @property
+    def ah_attr(self):
+        if self.attr.ah_attr.is_global:
+            gid = gid_str(self.attr.ah_attr.grh.dgid._global.subnet_prefix,
+                          self.attr.ah_attr.grh.dgid._global.interface_id)
+            g = GID(gid)
+            gr = GlobalRoute(flow_label=self.attr.ah_attr.grh.flow_label,
+                             sgid_index=self.attr.ah_attr.grh.sgid_index,
+                             hop_limit=self.attr.ah_attr.grh.hop_limit, dgid=g,
+                             traffic_class=self.attr.ah_attr.grh.traffic_class)
+        else:
+            gr = None
+        ah = AHAttr(dlid=self.attr.ah_attr.dlid, sl=self.attr.ah_attr.sl,
+                    src_path_bits=self.attr.ah_attr.src_path_bits,
+                    static_rate=self.attr.ah_attr.static_rate,
+                    is_global=self.attr.ah_attr.is_global, gr=gr)
+        return ah
+
+    @ah_attr.setter
+    def ah_attr(self, val):
+        self._copy_ah(val)
+
+    @property
+    def alt_ah_attr(self):
+        if self.attr.alt_ah_attr.is_global:
+            gid = gid_str(self.attr.alt_ah_attr.grh.dgid._global.subnet_prefix,
+                          self.attr.alt_ah_attr.grh.dgid._global.interface_id)
+            g = GID(gid)
+            gr = GlobalRoute(flow_label=self.attr.alt_ah_attr.grh.flow_label,
+                             sgid_index=self.attr.alt_ah_attr.grh.sgid_index,
+                             hop_limit=self.attr.alt_ah_attr.grh.hop_limit,
+                             dgid=g,
+                             traffic_class=self.attr.alt_ah_attr.grh.traffic_class)
+        else:
+            gr = None
+        ah = AHAttr(dlid=self.attr.alt_ah_attr.dlid,
+                    sl=self.attr.alt_ah_attr.sl,
+                    src_path_bits=self.attr.alt_ah_attr.src_path_bits,
+                    static_rate=self.attr.alt_ah_attr.static_rate,
+                    is_global=self.attr.alt_ah_attr.is_global, gr=gr)
+        return ah
+
+    @alt_ah_attr.setter
+    def alt_ah_attr(self, val):
+        self._copy_ah(val, True)
+
+    def _copy_ah(self, AHAttr ah_attr, is_alt=False):
+        if ah_attr is None:
+            return
+        if not is_alt:
+            for i in range(16):
+                self.attr.ah_attr.grh.dgid.raw[i] = \
+                    ah_attr.ah_attr.grh.dgid.raw[i]
+            self.attr.ah_attr.grh.flow_label = ah_attr.ah_attr.grh.flow_label
+            self.attr.ah_attr.grh.sgid_index = ah_attr.ah_attr.grh.sgid_index
+            self.attr.ah_attr.grh.hop_limit = ah_attr.ah_attr.grh.hop_limit
+            self.attr.ah_attr.grh.traffic_class = \
+                ah_attr.ah_attr.grh.traffic_class
+            self.attr.ah_attr.dlid = ah_attr.ah_attr.dlid
+            self.attr.ah_attr.sl = ah_attr.ah_attr.sl
+            self.attr.ah_attr.src_path_bits = ah_attr.ah_attr.src_path_bits
+            self.attr.ah_attr.static_rate = ah_attr.ah_attr.static_rate
+            self.attr.ah_attr.is_global = ah_attr.ah_attr.is_global
+            self.attr.ah_attr.port_num = ah_attr.ah_attr.port_num
+        else:
+            for i in range(16):
+                self.attr.alt_ah_attr.grh.dgid.raw[i] = \
+                    ah_attr.ah_attr.grh.dgid.raw[i]
+            self.attr.alt_ah_attr.grh.flow_label = \
+                ah_attr.ah_attr.grh.flow_label
+            self.attr.alt_ah_attr.grh.sgid_index = \
+                ah_attr.ah_attr.grh.sgid_index
+            self.attr.alt_ah_attr.grh.hop_limit = ah_attr.ah_attr.grh.hop_limit
+            self.attr.alt_ah_attr.grh.traffic_class = \
+                ah_attr.ah_attr.grh.traffic_class
+            self.attr.alt_ah_attr.dlid = ah_attr.ah_attr.dlid
+            self.attr.alt_ah_attr.sl = ah_attr.ah_attr.sl
+            self.attr.alt_ah_attr.src_path_bits = ah_attr.ah_attr.src_path_bits
+            self.attr.alt_ah_attr.static_rate = ah_attr.ah_attr.static_rate
+            self.attr.alt_ah_attr.is_global = ah_attr.ah_attr.is_global
+            self.attr.alt_ah_attr.port_num = ah_attr.ah_attr.port_num
+
+    @property
+    def pkey_index(self):
+        return self.attr.pkey_index
+    @pkey_index.setter
+    def pkey_index(self, val):
+        self.attr.pkey_index = val
+
+    @property
+    def alt_pkey_index(self):
+        return self.attr.alt_pkey_index
+    @alt_pkey_index.setter
+    def alt_pkey_index(self, val):
+        self.attr.alt_pkey_index = val
+
+    @property
+    def en_sqd_async_notify(self):
+        return self.attr.en_sqd_async_notify
+    @en_sqd_async_notify.setter
+    def en_sqd_async_notify(self, val):
+        self.attr.en_sqd_async_notify = val
+
+    @property
+    def sq_draining(self):
+        return self.attr.sq_draining
+    @sq_draining.setter
+    def sq_draining(self, val):
+        self.attr.sq_draining = val
+
+    @property
+    def max_rd_atomic(self):
+        return self.attr.max_rd_atomic
+    @max_rd_atomic.setter
+    def max_rd_atomic(self, val):
+        self.attr.max_rd_atomic = val
+
+    @property
+    def max_dest_rd_atomic(self):
+        return self.attr.max_dest_rd_atomic
+    @max_dest_rd_atomic.setter
+    def max_dest_rd_atomic(self, val):
+        self.attr.max_dest_rd_atomic = val
+
+    @property
+    def min_rnr_timer(self):
+        return self.attr.min_rnr_timer
+    @min_rnr_timer.setter
+    def min_rnr_timer(self, val):
+        self.attr.min_rnr_timer = val
+
+    @property
+    def port_num(self):
+        return self.attr.port_num
+    @port_num.setter
+    def port_num(self, val):
+        self.attr.port_num = val
+
+    @property
+    def timeout(self):
+        return self.attr.timeout
+    @timeout.setter
+    def timeout(self, val):
+        self.attr.timeout = val
+
+    @property
+    def retry_cnt(self):
+        return self.attr.retry_cnt
+    @retry_cnt.setter
+    def retry_cnt(self, val):
+        self.attr.retry_cnt = val
+
+    @property
+    def rnr_retry(self):
+        return self.attr.rnr_retry
+    @rnr_retry.setter
+    def rnr_retry(self, val):
+        self.attr.rnr_retry = val
+
+    @property
+    def alt_port_num(self):
+        return self.attr.alt_port_num
+    @alt_port_num.setter
+    def alt_port_num(self, val):
+        self.attr.alt_port_num = val
+
+    @property
+    def alt_timeout(self):
+        return self.attr.alt_timeout
+    @alt_timeout.setter
+    def alt_timeout(self, val):
+        self.attr.alt_timeout = val
+
+    @property
+    def rate_limit(self):
+        return self.attr.rate_limit
+    @rate_limit.setter
+    def rate_limit(self, val):
+        self.attr.rate_limit = val
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        ah_format = '    {:22}: {:<20}\n'
+        ident_format = '  {:22}: {:<20}\n'
+        if self.attr.ah_attr.is_global:
+            global_ah = ah_format.format('dgid',
+                                         gid_str(self.attr.ah_attr.grh.dgid._global.subnet_prefix,
+                                                 self.attr.ah_attr.grh.dgid._global.interface_id)) +\
+                        ah_format.format('flow label',
+                                         self.attr.ah_attr.grh.flow_label) +\
+                        ah_format.format('sgid index',
+                                         self.attr.ah_attr.grh.sgid_index) +\
+                        ah_format.format('hop limit',
+                                         self.attr.ah_attr.grh.hop_limit) +\
+                        ah_format.format('traffic_class',
+                                         self.attr.ah_attr.grh.traffic_class)
+        else:
+            global_ah = ''
+        if self.attr.alt_ah_attr.is_global:
+            alt_global_ah = ah_format.format('dgid',
+                                             gid_str(self.attr.alt_ah_attr.grh.dgid._global.subnet_prefix,
+                                                     self.attr.alt_ah_attr.grh.dgid._global.interface_id)) +\
+                            ah_format.format('flow label',
+                                             self.attr.alt_ah_attr.grh.flow_label) +\
+                            ah_format.format('sgid index',
+                                             self.attr.alt_ah_attr.grh.sgid_index) +\
+                            ah_format.format('hop limit',
+                                             self.attr.alt_ah_attr.grh.hop_limit) +\
+                            ah_format.format('traffic_class',
+                                             self.attr.alt_ah_attr.grh.traffic_class)
+        else:
+            alt_global_ah = ''
+        return print_format.format('QP state',
+                                   qp_state_to_str(self.attr.qp_state)) +\
+               print_format.format('QP current state',
+                            qp_state_to_str(self.attr.cur_qp_state)) +\
+               print_format.format('Path MTU',
+                                   mtu_to_str(self.attr.path_mtu)) +\
+               print_format.format('Path mig. state',
+                            mig_state_to_str(self.attr.path_mig_state)) +\
+               print_format.format('QKey', self.attr.qkey) +\
+               print_format.format('RQ PSN', self.attr.rq_psn) +\
+               print_format.format('SQ PSN', self.attr.sq_psn) +\
+               print_format.format('Dest QP number', self.attr.dest_qp_num) +\
+               print_format.format('QP access flags',
+                                   access_flags_to_str(self.attr.qp_access_flags)) +\
+               'QP caps:\n' +\
+               ident_format.format('max send WR',
+                                   self.attr.cap.max_send_wr) +\
+               ident_format.format('max recv WR',
+                                   self.attr.cap.max_recv_wr) +\
+               ident_format.format('max send SGE',
+                                   self.attr.cap.max_send_sge) +\
+               ident_format.format('max recv SGE',
+                                   self.attr.cap.max_recv_sge) +\
+               ident_format.format('max inline data',
+                                   self.attr.cap.max_inline_data) +\
+               'AH Attr:\n' +\
+               ident_format.format('port num', self.attr.ah_attr.port_num) +\
+               ident_format.format('sl', self.attr.ah_attr.sl) +\
+               ident_format.format('source path bits',
+                                   self.attr.ah_attr.src_path_bits) +\
+               ident_format.format('dlid', self.attr.ah_attr.dlid) +\
+               ident_format.format('port num', self.attr.ah_attr.port_num) +\
+               ident_format.format('static rate',
+                                   self.attr.ah_attr.static_rate) +\
+               ident_format.format('is global',
+                                   self.attr.ah_attr.is_global) +\
+               global_ah +\
+               'Alt. AH Attr:\n' +\
+               ident_format.format('port num', self.attr.alt_ah_attr.port_num) +\
+               ident_format.format('sl', self.attr.alt_ah_attr.sl) +\
+               ident_format.format('source path bits',
+                                   self.attr.alt_ah_attr.src_path_bits) +\
+               ident_format.format('dlid', self.attr.alt_ah_attr.dlid) +\
+               ident_format.format('port num', self.attr.alt_ah_attr.port_num) +\
+               ident_format.format('static rate',
+                                   self.attr.alt_ah_attr.static_rate) +\
+               ident_format.format('is global',
+                                   self.attr.alt_ah_attr.is_global) +\
+               alt_global_ah +\
+               print_format.format('PKey index', self.attr.pkey_index) +\
+               print_format.format('Alt. PKey index',
+                                   self.attr.alt_pkey_index) +\
+               print_format.format('En. SQD async notify',
+                                   self.attr.en_sqd_async_notify) +\
+               print_format.format('SQ draining', self.attr.sq_draining) +\
+               print_format.format('Max RD atomic', self.attr.max_rd_atomic) +\
+               print_format.format('Max dest. RD atomic',
+                                   self.attr.max_dest_rd_atomic) +\
+               print_format.format('Min RNR timer', self.attr.min_rnr_timer) +\
+               print_format.format('Port number', self.attr.port_num) +\
+               print_format.format('Timeout', self.attr.timeout) +\
+               print_format.format('Retry counter', self.attr.retry_cnt) +\
+               print_format.format('RNR retry', self.attr.rnr_retry) +\
+               print_format.format('Alt. port number',
+                                   self.attr.alt_port_num) +\
+               print_format.format('Alt. timeout', self.attr.alt_timeout) +\
+               print_format.format('Rate limit', self.attr.rate_limit)
+
+
+def _copy_caps(QPCap src, dst):
+    """
+    Copy the QPCaps values of src into the inner ibv_qp_cap struct of dst.
+    Since both ibv_qp_init_attr and ibv_qp_attr have an inner ibv_qp_cap inner
+    struct, they can both be used.
+    :param src: A QPCap object
+    :param dst: A QPInitAttr / QPInitAttrEx / QPAttr object
+    :return: None
+    """
+    # we're assigning to C structs here, we must have type-specific objects in
+    # order to do that. Instead of having this function smaller but in 3
+    # classes, it appears here once.
+    cdef QPInitAttr qia
+    cdef QPInitAttrEx qiae
+    cdef QPAttr qa
+    if src is None:
+        return
+    if type(dst) == QPInitAttr:
+        qia = <QPInitAttr>dst
+        qia.attr.cap.max_send_wr = src.cap.max_send_wr
+        qia.attr.cap.max_recv_wr = src.cap.max_recv_wr
+        qia.attr.cap.max_send_sge = src.cap.max_send_sge
+        qia.attr.cap.max_recv_sge = src.cap.max_recv_sge
+        qia.attr.cap.max_inline_data = src.cap.max_inline_data
+    elif type(dst) == QPInitAttrEx:
+        qiae = <QPInitAttrEx>dst
+        qiae.attr.cap.max_send_wr = src.cap.max_send_wr
+        qiae.attr.cap.max_recv_wr = src.cap.max_recv_wr
+        qiae.attr.cap.max_send_sge = src.cap.max_send_sge
+        qiae.attr.cap.max_recv_sge = src.cap.max_recv_sge
+        qiae.attr.cap.max_inline_data = src.cap.max_inline_data
+    else:
+        qa = <QPAttr>dst
+        qa.attr.cap.max_send_wr = src.cap.max_send_wr
+        qa.attr.cap.max_recv_wr = src.cap.max_recv_wr
+        qa.attr.cap.max_send_sge = src.cap.max_send_sge
+        qa.attr.cap.max_recv_sge = src.cap.max_recv_sge
+        qa.attr.cap.max_inline_data = src.cap.max_inline_data
diff --git a/pyverbs/utils.py b/pyverbs/utils.py
index 01adceab568c..a59d6275fefc 100644
--- a/pyverbs/utils.py
+++ b/pyverbs/utils.py
@@ -33,3 +33,49 @@ def gid_str_to_array(val):
         vals.append(val[i][0:2])
         vals.append(val[i][2:4])
     return vals
+
+
+def qp_type_to_str(qp_type):
+    types = {2: 'RC', 3: 'UC', 4: 'UD', 8: 'Raw Packet', 9: 'XRCD_SEND',
+             10: 'XRCD_RECV', 0xff:'Driver QP'}
+    try:
+        return types[qp_type]
+    except KeyError:
+        return 'Unknown ({qpt})'.format(qpt=qp_type)
+
+
+def qp_state_to_str(qp_state):
+    states = {0: 'Reset', 1: 'Init', 2: 'RTR', 3: 'RTS', 4: 'SQD',
+              5: 'SQE', 6: 'Error', 7: 'Unknown'}
+    try:
+        return states[qp_state]
+    except KeyError:
+        return 'Unknown ({qps})'.format(qps=qp_state_to_str)
+
+
+def mtu_to_str(mtu):
+    mtus = {1: 256, 2: 512, 3: 1024, 4: 2048, 5: 4096}
+    try:
+        return mtus[mtu]
+    except KeyError:
+        return 0
+
+
+def access_flags_to_str(flags):
+    access_flags = {1: 'Local write', 2: 'Remote write', 4: 'Remote read',
+                    8: 'Remote atomic', 16: 'MW bind', 32: 'Zero based',
+                    64: 'On demand'}
+    access_str = ''
+    for f in access_flags:
+        if flags & f:
+            access_str += access_flags[f]
+            access_str += ' '
+    return access_str
+
+
+def mig_state_to_str(mig):
+    mig_states = {0: 'Migrated', 1: 'Re-arm', 2: 'Armed'}
+    try:
+        return mig_states[mig]
+    except KeyError:
+        return 'Unknown ({m})'.format(m=mig)
-- 
2.17.2

