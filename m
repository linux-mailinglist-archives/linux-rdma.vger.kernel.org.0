Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9901C1B0DF1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDTOHk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 10:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgDTOHj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 10:07:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A89220722;
        Mon, 20 Apr 2020 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587391658;
        bh=83qtSHazwCIrl4vrD+8ed/b2heIjxn61VO1XS+w8hXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3LuQLzDuRcb5VQwo2/8C/zddKpV/5c0k4ofLEqgiC2g0N1iCR+o2KUKJTdUOJq97
         qWHuU9jXUjE51M8IR1c01zOEGX1gk+qoO25aO1rLQn4mRwrruDeUdd2VCmx5uxn4M9
         DyGVzKZwf3BvHD4aRkZqogwEQbsj7NxWaQAZB/tc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ido Kalir <idok@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 11/12] pyverbs: Add support for ECE
Date:   Mon, 20 Apr 2020 17:06:47 +0300
Message-Id: <20200420140648.275554-12-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420140648.275554-1-leon@kernel.org>
References: <20200420140648.275554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ido Kalir <idok@mellanox.com>

ECE (enhanced connection establishment) is a mechanism that gives an
option to different libibverbs providers to advertise and use various
provider-specific QP configuration options.
Add those verbs:
ibv_query_ece - get QPs ece.
ibv_set_ece - set the QPs ece.
rdma_set_local_ece - set the local CMs ece.
rdma_get_remote_ece - get the remote CM ece from the connection request.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
Signed-off-by: Ido Kalir <idok@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 pyverbs/cmid.pyx       | 23 ++++++++++++++++++++-
 pyverbs/libibverbs.pxd |  7 +++++++
 pyverbs/librdmacm.pxd  |  2 ++
 pyverbs/qp.pxd         |  3 +++
 pyverbs/qp.pyx         | 45 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/pyverbs/cmid.pyx b/pyverbs/cmid.pyx
index 66d73268..2505ec70 100755
--- a/pyverbs/cmid.pyx
+++ b/pyverbs/cmid.pyx
@@ -1,7 +1,7 @@
 from libc.string cimport memset

 from pyverbs.pyverbs_error import PyverbsUserError
-from pyverbs.qp cimport QPInitAttr, QPAttr
+from pyverbs.qp cimport QPInitAttr, QPAttr, ECE
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 cimport pyverbs.librdmacm_enums as ce
@@ -424,6 +424,27 @@ cdef class CMID(PyverbsCM):
         if ret != 0:
             raise PyverbsRDMAErrno('Failed to Complete an active connection request')

+    def set_local_ece(self, ECE ece):
+        """
+        Set local ECE paraemters to be used for REQ/REP communication.
+        :param ece: ECE object with the requested configuration
+        :return: None
+        """
+        rc = cm.rdma_set_local_ece(self.id, &ece.ece)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to set local ECE')
+
+    def get_remote_ece(self):
+        """
+        Get ECE parameters as were received from the communication peer.
+        :return: ECE object with the ece configuration
+        """
+        ece = ECE()
+        rc = cm.rdma_get_remote_ece(self.id, &ece.ece)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Failed to get remote ECE')
+        return ece
+
     def create_qp(self, QPInitAttr qp_init not None):
         """
         Create a QP, which is associated with CMID.
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 6ffa303c..52f51f07 100755
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -475,6 +475,11 @@ cdef extern from 'infiniband/verbs.h':
         uint64_t        wr_id
         unsigned int    wr_flags

+    cdef struct ibv_ece:
+        uint32_t vendor_id
+        uint32_t options
+        uint32_t comp_mask
+
     ibv_device **ibv_get_device_list(int *n)
     void ibv_free_device_list(ibv_device **list)
     ibv_context *ibv_open_device(ibv_device *device)
@@ -599,3 +604,5 @@ cdef extern from 'infiniband/verbs.h':
 cdef extern from 'infiniband/driver.h':
     int ibv_query_gid_type(ibv_context *context, uint8_t port_num,
                            unsigned int index, ibv_gid_type *type)
+    int ibv_set_ece(ibv_qp *qp, ibv_ece *ece)
+    int ibv_query_ece(ibv_qp *qp, ibv_ece *ece)
diff --git a/pyverbs/librdmacm.pxd b/pyverbs/librdmacm.pxd
index 03c0cddc..ff579205 100755
--- a/pyverbs/librdmacm.pxd
+++ b/pyverbs/librdmacm.pxd
@@ -97,6 +97,8 @@ cdef extern from '<rdma/rdma_cma.h>':
     int rdma_create_id(rdma_event_channel *channel, rdma_cm_id **id,
                        void *context, rdma_port_space ps)
     int rdma_destroy_id(rdma_cm_id *id)
+    int rdma_get_remote_ece(rdma_cm_id *id, ibv_ece *ece)
+    int rdma_set_local_ece(rdma_cm_id *id, ibv_ece *ece)
     int rdma_get_request(rdma_cm_id *listen, rdma_cm_id **id)
     int rdma_bind_addr(rdma_cm_id *id, sockaddr *addr)
     int rdma_resolve_addr(rdma_cm_id *id, sockaddr *src_addr,
diff --git a/pyverbs/qp.pxd b/pyverbs/qp.pxd
index 209a2438..1294560a 100644
--- a/pyverbs/qp.pxd
+++ b/pyverbs/qp.pxd
@@ -43,3 +43,6 @@ cdef class DataBuffer(PyverbsCM):

 cdef class QPEx(QP):
     cdef v.ibv_qp_ex *qp_ex
+
+cdef class ECE(PyverbsCM):
+    cdef v.ibv_ece ece
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 95ef554c..fd851443 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -4,9 +4,8 @@
 from libc.stdlib cimport malloc, free
 from libc.string cimport memcpy

+from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError, PyverbsRDMAError
 from pyverbs.utils import gid_str, qp_type_to_str, qp_state_to_str, mtu_to_str
-from pyverbs.pyverbs_error import PyverbsUserError, PyverbsError, \
-    PyverbsRDMAError
 from pyverbs.utils import access_flags_to_str, mig_state_to_str
 from pyverbs.base import PyverbsRDMAErrno
 from pyverbs.wr cimport RecvWR, SendWR, SGE
@@ -871,6 +870,27 @@ cdef class QPAttr(PyverbsObject):
                print_format.format('Rate limit', self.attr.rate_limit)


+cdef class ECE(PyverbsCM):
+    def __init__(self, vendor_id=0, options=0, comp_mask=0):
+        """
+        :param vendor_id: Unique identifier of the provider vendor.
+        :param options: Provider specific attributes which are supported or
+                        needed to be enabled by ECE users.
+        :param comp_mask: A bitmask specifying which ECE options should be
+                          valid.
+        """
+        super().__init__()
+        self.ece.vendor_id = vendor_id
+        self.ece.options = options
+        self.ece.comp_mask = comp_mask
+
+    def __str__(self):
+        print_format = '{:22}: {:<20}\n'
+        print_format.format('Vendor ID', self.ece.vendor_id) +\
+        print_format.format('Options', self.ece.options) +\
+        print_format.format('Comp Mask', self.ece.comp_mask)
+
+
 cdef class QP(PyverbsCM):
     def __init__(self, object creator not None, object init_attr not None,
                  QPAttr qp_attr=None):
@@ -1133,6 +1153,27 @@ cdef class QP(PyverbsCM):
                 memcpy(&bad_wr.send_wr, my_bad_wr, sizeof(bad_wr.send_wr))
             raise PyverbsRDMAError('Failed to post send', rc)

+    def set_ece(self, ECE ece):
+        """
+        Set ECE options and use them for QP configuration stage
+        :param ece: The requested ECE values.
+        :return: None
+        """
+        rc = v.ibv_set_ece(self.qp, &ece.ece)
+        if rc != 0:
+            raise PyverbsRDMAError('Failed to set ECE', rc)
+
+    def query_ece(self):
+        """
+        Query QPs ECE options
+        :return: ECE object with this QP ece configuration.
+        """
+        ece = ECE()
+        rc = v.ibv_query_ece(self.qp, &ece.ece)
+        if rc != 0:
+            raise PyverbsRDMAError('Failed to query ECE', rc)
+        return ece
+
     @property
     def qp_type(self):
         return self.qp.qp_type
--
2.25.2

