Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68E5E6FB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfD2PzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 11:55:18 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47444 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728572AbfD2PzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 11:55:18 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 29 Apr 2019 18:55:15 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3TFtF7p025539;
        Mon, 29 Apr 2019 18:55:15 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 4/4] pyverbs: Add events support
Date:   Mon, 29 Apr 2019 18:55:13 +0300
Message-Id: <20190429155513.30543-5-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190429155513.30543-1-noaos@mellanox.com>
References: <20190429155513.30543-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add missing definitions to allow using a completion channel properly;
some functions declarations were missing as well as a reference
between a completion channel and its users.

Change-Id: Ia9259f34d8d1a76b09ed2fe1a897031bb04c8073
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/cq.pxd         |  3 +++
 pyverbs/cq.pyx         | 57 ++++++++++++++++++++++++++++++++++++++----
 pyverbs/libibverbs.pxd |  2 ++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/pyverbs/cq.pxd b/pyverbs/cq.pxd
index 181f7da668fe..44abf3bae010 100644
--- a/pyverbs/cq.pxd
+++ b/pyverbs/cq.pxd
@@ -7,6 +7,8 @@ cdef class CompChannel(PyverbsCM):
     cdef v.ibv_comp_channel *cc
     cpdef close(self)
     cdef object context
+    cdef add_ref(self, obj)
+    cdef object cqs
 
 cdef class CQ(PyverbsCM):
     cdef v.ibv_cq *cq
@@ -15,6 +17,7 @@ cdef class CQ(PyverbsCM):
 
 cdef class CqInitAttrEx(PyverbsObject):
     cdef v.ibv_cq_init_attr_ex attr
+    cdef object channel
 
 cdef class CQEX(PyverbsCM):
     cdef v.ibv_cq_ex *cq
diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index 748e30fe9bcb..dd7ab3cff8f0 100644
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB)
 # Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+import weakref
+
 from pyverbs.base import PyverbsRDMAErrno
 cimport pyverbs.libibverbs_enums as e
 from pyverbs.device cimport Context
@@ -22,6 +24,7 @@ cdef class CompChannel(PyverbsCM):
             raise PyverbsRDMAErrno('Failed to create a completion channel')
         self.context = context
         context.add_ref(self)
+        self.cqs = weakref.WeakSet()
         self.logger.debug('Created a Completion Channel')
 
     def __dealloc__(self):
@@ -29,6 +32,7 @@ cdef class CompChannel(PyverbsCM):
 
     cpdef close(self):
         self.logger.debug('Closing completion channel')
+        self.close_weakrefs([self.cqs])
         if self.cc != NULL:
             rc = v.ibv_destroy_comp_channel(self.cc)
             if rc != 0:
@@ -50,6 +54,14 @@ cdef class CompChannel(PyverbsCM):
         if cq != expected_cq.cq:
             raise PyverbsRDMAErrno('Received event on an unexpected CQ')
 
+    cdef add_ref(self, obj):
+        if isinstance(obj, CQ) or isinstance(obj, CQEX):
+            self.cqs.add(obj)
+
+    @property
+    def channel(self):
+        return <object>self.cc
+
 
 cdef class CQ(PyverbsCM):
     """
@@ -69,8 +81,14 @@ cdef class CQ(PyverbsCM):
                             context's num_comp_vectors
         :return: The newly created CQ
         """
-        self.cq = v.ibv_create_cq(context.context, cqe, <void*>cq_context,
-                                  NULL, comp_vector)
+        if channel is not None:
+            self.cq = v.ibv_create_cq(context.context, cqe, <void*>cq_context,
+                                      <v.ibv_comp_channel*>channel.channel,
+                                      comp_vector)
+            channel.add_ref(self)
+        else:
+            self.cq = v.ibv_create_cq(context.context, cqe, <void*>cq_context,
+                                      NULL, comp_vector)
         if self.cq == NULL:
             raise PyverbsRDMAErrno('Failed to create a CQ')
         self.context = context
@@ -115,6 +133,28 @@ cdef class CQ(PyverbsCM):
                           dlid_path_bits=wc.dlid_path_bits))
         return npolled, wcs
 
+    def req_notify(self, solicited_only = False):
+        """
+        Request completion notification on the completion queue.
+        :param solicited_only: If non-zero, notifications will be created only
+                               for incoming send / RDMA write WRs with
+                               immediate data that have the solicited bit set in
+                               their send flags.
+        :return: None
+        """
+        rc = v.ibv_req_notify_cq(self.cq, solicited_only)
+        if rc != 0:
+            raise PyverbsRDMAErrno('Request notify CQ returned {rc}'.
+                                   format(rc=rc))
+
+    def ack_events(self, num_events):
+        """
+        Get and acknowledge CQ events
+        :param num_events: Number of events to acknowledge
+        :return: None
+        """
+        v.ibv_ack_cq_events(self.cq, num_events)
+
     @property
     def _cq(self):
         return <object>self.cq
@@ -150,6 +190,7 @@ cdef class CqInitAttrEx(PyverbsObject):
         self.attr.wc_flags = wc_flags
         self.attr.comp_mask = comp_mask
         self.attr.flags = flags
+        self.channel = channel
 
     @property
     def cqe(self):
@@ -163,9 +204,13 @@ cdef class CqInitAttrEx(PyverbsObject):
         def __set__(self, val):
             self.attr.cq_context = <void*>val
 
-    property channel:
-        def __set__(self, val):
-            self.attr.channel = <v.ibv_comp_channel*>val
+    @property
+    def comp_channel(self):
+        return self.channel
+    @comp_channel.setter
+    def comp_channel(self, val):
+        self.channel = val
+        self.attr.channel = <v.ibv_comp_channel*>val
 
     @property
     def comp_vector(self):
@@ -215,6 +260,8 @@ cdef class CQEX(PyverbsCM):
         if init_attr is None:
             init_attr = CqInitAttrEx()
         self.cq = v.ibv_create_cq_ex(context.context, &init_attr.attr)
+        if init_attr.comp_channel:
+            init_attr.comp_channel.add_ref(self)
         if self.cq == NULL:
             raise PyverbsRDMAErrno('Failed to create extended CQ')
         self.ibv_cq = v.ibv_cq_ex_to_cq(self.cq)
diff --git a/pyverbs/libibverbs.pxd b/pyverbs/libibverbs.pxd
index 7facff5f8856..979022069887 100644
--- a/pyverbs/libibverbs.pxd
+++ b/pyverbs/libibverbs.pxd
@@ -259,6 +259,8 @@ cdef extern from 'infiniband/verbs.h':
     int ibv_destroy_comp_channel(ibv_comp_channel *channel)
     int ibv_get_cq_event(ibv_comp_channel *channel, ibv_cq **cq,
                          void **cq_context)
+    int ibv_req_notify_cq(ibv_cq *cq, int solicited_only)
+    void ibv_ack_cq_events(ibv_cq *cq, int nevents)
     ibv_cq *ibv_create_cq(ibv_context *context, int cqe, void *cq_context,
                           ibv_comp_channel *channel, int comp_vector)
     int ibv_destroy_cq(ibv_cq *cq)
-- 
2.17.2

