Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D66486A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGJOb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 10:31:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47977 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfGJOb7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 10:31:59 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Jul 2019 17:31:51 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x6AEVpIl004077;
        Wed, 10 Jul 2019 17:31:51 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-core 3/4] pyverbs: Avoid casting pointers to object type
Date:   Wed, 10 Jul 2019 17:22:50 +0300
Message-Id: <20190710142251.9396-4-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710142251.9396-1-noaos@mellanox.com>
References: <20190710142251.9396-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

When casting a C pointer into <object> type python assumes that the
head of the struct is the reference count. The reference count is
incremented every time another variable points to this object.
The result is that the first member of the C struct, which is wrapped
by python object, is incremented. E.g. PD holds ibv_pd pointer, so the
first field of ibv_pd which is ibv_context address is incremented by
1, meaning ibv_context pointer holds invalid address.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
Reviewd-by: Maor Gottlieb <maorg@mellanox.com>
---
 pyverbs/cq.pyx | 23 +++--------------------
 pyverbs/pd.pyx |  4 ----
 pyverbs/qp.pyx | 39 +++++++++++++++++++--------------------
 pyverbs/wr.pyx | 17 +++++------------
 4 files changed, 27 insertions(+), 56 deletions(-)

diff --git a/pyverbs/cq.pyx b/pyverbs/cq.pyx
index dd475759337c..dc09924e88a9 100644
--- a/pyverbs/cq.pyx
+++ b/pyverbs/cq.pyx
@@ -59,10 +59,6 @@ cdef class CompChannel(PyverbsCM):
         if isinstance(obj, CQ) or isinstance(obj, CQEX):
             self.cqs.add(obj)
 
-    @property
-    def channel(self):
-        return <object>self.cc
-
 
 cdef class CQ(PyverbsCM):
     """
@@ -84,8 +80,7 @@ cdef class CQ(PyverbsCM):
         """
         if channel is not None:
             self.cq = v.ibv_create_cq(context.context, cqe, <void*>cq_context,
-                                      <v.ibv_comp_channel*>channel.channel,
-                                      comp_vector)
+                                      channel.cc, comp_vector)
             channel.add_ref(self)
         else:
             self.cq = v.ibv_create_cq(context.context, cqe, <void*>cq_context,
@@ -162,10 +157,6 @@ cdef class CQ(PyverbsCM):
         """
         v.ibv_ack_cq_events(self.cq, num_events)
 
-    @property
-    def _cq(self):
-        return <object>self.cq
-
     def __str__(self):
         print_format = '{:22}: {:<20}\n'
         return 'CQ\n' +\
@@ -215,9 +206,9 @@ cdef class CqInitAttrEx(PyverbsObject):
     def comp_channel(self):
         return self.channel
     @comp_channel.setter
-    def comp_channel(self, val):
+    def comp_channel(self, CompChannel val):
         self.channel = val
-        self.attr.channel = <v.ibv_comp_channel*>val
+        self.attr.channel = val.cc
 
     @property
     def comp_vector(self):
@@ -364,14 +355,6 @@ cdef class CQEX(PyverbsCM):
     def wr_id(self, val):
         self.cq.wr_id = val
 
-    @property
-    def _cq(self):
-        return <object>self.cq
-
-    @property
-    def _ibv_cq(self):
-        return <object>self.ibv_cq
-
     def __str__(self):
         print_format = '{:<22}: {:<20}\n'
         return 'Extended CQ:\n' +\
diff --git a/pyverbs/pd.pyx b/pyverbs/pd.pyx
index 4b5dc139c59f..7cd0876682b2 100644
--- a/pyverbs/pd.pyx
+++ b/pyverbs/pd.pyx
@@ -67,7 +67,3 @@ cdef class PD(PyverbsCM):
             self.qps.add(obj)
         else:
             raise PyverbsError('Unrecognized object type')
-
-    @property
-    def _pd(self):
-        return <object>self.pd
diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index b33993a106e9..47a2158a5acc 100644
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -101,9 +101,9 @@ cdef class QPInitAttr(PyverbsObject):
         self.attr.qp_context = <void*>qp_context
         if scq is not None:
             if type(scq) is CQ:
-                self.attr.send_cq = <v.ibv_cq*>scq._cq
+                self.attr.send_cq = (<CQ>rcq).cq
             elif type(scq) is CQEX:
-                self.attr.send_cq = <v.ibv_cq*>scq._ibv_cq
+                self.attr.send_cq = (<CQEX>rcq).ibv_cq
             else:
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
                                        format(t=type(scq)))
@@ -111,9 +111,9 @@ cdef class QPInitAttr(PyverbsObject):
 
         if rcq is not None:
             if type(rcq) is CQ:
-                self.attr.recv_cq = <v.ibv_cq*>rcq._cq
+                self.attr.recv_cq = (<CQ>rcq).cq
             elif type(rcq) is CQEX:
-                self.attr.recv_cq = <v.ibv_cq*>rcq._ibv_cq
+                self.attr.recv_cq = (<CQEX>rcq).ibv_cq
             else:
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
                                        format(t=type(rcq)))
@@ -129,9 +129,9 @@ cdef class QPInitAttr(PyverbsObject):
     @send_cq.setter
     def send_cq(self, val):
         if type(val) is CQ:
-            self.attr.send_cq = <v.ibv_cq*>val._cq
+            self.attr.send_cq = (<CQ>val).cq
         elif type(val) is CQEX:
-            self.attr.send_cq = <v.ibv_cq*>val._ibv_cq
+            self.attr.send_cq = (<CQEX>val).ibv_cq
         self.scq = val
 
     @property
@@ -140,9 +140,9 @@ cdef class QPInitAttr(PyverbsObject):
     @recv_cq.setter
     def recv_cq(self, val):
         if type(val) is CQ:
-            self.attr.recv_cq = <v.ibv_cq*>val._cq
+            self.attr.recv_cq = (<CQ>val).cq
         elif type(val) is CQEX:
-            self.attr.recv_cq = <v.ibv_cq*>val._ibv_cq
+            self.attr.recv_cq = (<CQEX>val).ibv_cq
         self.rcq = val
 
     @property
@@ -218,9 +218,9 @@ cdef class QPInitAttrEx(PyverbsObject):
         _copy_caps(cap, self)
         if scq is not None:
             if type(scq) is CQ:
-                self.attr.send_cq = <v.ibv_cq*>scq._cq
+                self.attr.send_cq = (<CQ>rcq).cq
             elif type(scq) is CQEX:
-                self.attr.send_cq = <v.ibv_cq*>scq._ibv_cq
+                self.attr.send_cq = (<CQEX>rcq).ibv_cq
             else:
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
                                        format(t=type(scq)))
@@ -228,12 +228,12 @@ cdef class QPInitAttrEx(PyverbsObject):
 
         if rcq is not None:
             if type(rcq) is CQ:
-                self.attr.recv_cq = <v.ibv_cq*>rcq._cq
+                self.attr.recv_cq = (<CQ>rcq).cq
             elif type(rcq) is CQEX:
-                self.attr.recv_cq = <v.ibv_cq*>rcq._ibv_cq
+                self.attr.recv_cq = (<CQEX>rcq).ibv_cq
             else:
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
-                                       format(type(rcq)))
+                                       format(t=type(rcq)))
         self.rcq = rcq
 
         self.attr.srq = NULL  # Until SRQ support is added
@@ -247,7 +247,6 @@ cdef class QPInitAttrEx(PyverbsObject):
             raise PyverbsUserError('XRCD and RSS are not yet supported in pyverbs')
         self.attr.comp_mask = comp_mask
         if pd is not None:
-            self.attr.pd = <v.ibv_pd*>pd._pd
             self.pd = pd
         self.attr.create_flags = create_flags
         self.attr.max_tso_header = max_tso_header
@@ -259,9 +258,9 @@ cdef class QPInitAttrEx(PyverbsObject):
     @send_cq.setter
     def send_cq(self, val):
         if type(val) is CQ:
-            self.attr.send_cq = <v.ibv_cq*>val._cq
+            self.attr.send_cq = (<CQ>val).cq
         elif type(val) is CQEX:
-            self.attr.send_cq = <v.ibv_cq*>val._ibv_cq
+            self.attr.send_cq = (<CQEX>val).ibv_cq
         self.scq = val
 
     @property
@@ -270,9 +269,9 @@ cdef class QPInitAttrEx(PyverbsObject):
     @recv_cq.setter
     def recv_cq(self, val):
         if type(val) is CQ:
-            self.attr.recv_cq = <v.ibv_cq*>val._cq
+            self.attr.recv_cq = (<CQ>val).cq
         elif type(val) is CQEX:
-            self.attr.recv_cq = <v.ibv_cq*>val._ibv_cq
+            self.attr.recv_cq = (<CQEX>val).ibv_cq
         self.rcq = val
 
     @property
@@ -311,8 +310,8 @@ cdef class QPInitAttrEx(PyverbsObject):
     def pd(self):
         return self.pd
     @pd.setter
-    def pd(self, val):
-        self.attr.pd = <v.ibv_pd*>val._pd
+    def pd(self, PD val):
+        self.attr.pd = <v.ibv_pd*>val.pd
         self.pd = val
 
     @property
diff --git a/pyverbs/wr.pyx b/pyverbs/wr.pyx
index 2dc766282db3..3003224a8f32 100644
--- a/pyverbs/wr.pyx
+++ b/pyverbs/wr.pyx
@@ -53,10 +53,7 @@ cdef class SGE(PyverbsCM):
         cdef char *sg_data
         cdef int off = offset
         sg_data = <char*>(self.sge.addr + off)
-        return <object>sg_data[:length]
-
-    def _get_sge(self):
-        return <object>self.sge
+        return sg_data[:length]
 
     def __str__(self):
         print_format = '{:22}: {:<20}\n'
@@ -104,7 +101,7 @@ cdef class RecvWR(PyverbsCM):
         if self.recv_wr.sg_list == NULL:
             raise PyverbsRDMAErrno('Failed to malloc SG buffer')
         dst = self.recv_wr.sg_list
-        copy_sg_array(<object>dst, sg, num_sge)
+        copy_sg_array(dst, sg, num_sge)
         self.recv_wr.num_sge = num_sge
         self.recv_wr.wr_id = wr_id
         if next_wr is not None:
@@ -166,7 +163,7 @@ cdef class SendWR(PyverbsCM):
         if self.send_wr.sg_list == NULL:
             raise PyverbsRDMAErrno('Failed to malloc SG buffer')
         dst = self.send_wr.sg_list
-        copy_sg_array(<object>dst, sg, num_sge)
+        copy_sg_array(dst, sg, num_sge)
         self.send_wr.num_sge = num_sge
         self.send_wr.wr_id = wr_id
         if next_wr is not None:
@@ -298,13 +295,9 @@ def send_flags_to_str(flags):
     return flags_str
 
 
-cdef copy_sg_array(dst_obj, sg, num_sge):
-    cdef v.ibv_sge *dst = <v.ibv_sge*>dst_obj
+cdef copy_sg_array(v.ibv_sge *dst, sg, num_sge):
     cdef v.ibv_sge *src
     for i in range(num_sge):
-        # Avoid 'storing unsafe C derivative of temporary Python' errors
-        # that will occur if we merge the two following lines.
-        tmp = sg[i]._get_sge()
-        src = <v.ibv_sge*>tmp
+        src = (<SGE>sg[i]).sge
         memcpy(dst, src, sizeof(v.ibv_sge))
         dst += 1
-- 
2.21.0

