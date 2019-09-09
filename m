Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA16BAD54F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbfIIJHY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:24 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48369 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389617AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp0028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 02/12] pyverbs: Fix CQ and PD assignment in QPAttr
Date:   Mon,  9 Sep 2019 12:07:02 +0300
Message-Id: <20190909090712.11029-3-noaos@mellanox.com>
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

Fixed CQs assignment in QPInitAttr, QPInitAttrEx and QP objects:
Receive cq parameter was assigned to send_cq attribute in InitAttr
objects, and in QP rcq and scq attributes was not initialized properly.
Fixed PD assignment in QPInitAttrEx object:
In QPInitAttrEx pd pointer was not initialized with PD.pd pointer.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 pyverbs/qp.pyx | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 pyverbs/qp.pyx

diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
old mode 100644
new mode 100755
index ad89c94c002e..732ef5094b6b
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -104,9 +104,9 @@ cdef class QPInitAttr(PyverbsObject):
         self.attr.qp_context = <void*>qp_context
         if scq is not None:
             if type(scq) is CQ:
-                self.attr.send_cq = (<CQ>rcq).cq
+                self.attr.send_cq = (<CQ>scq).cq
             elif type(scq) is CQEX:
-                self.attr.send_cq = (<CQEX>rcq).ibv_cq
+                self.attr.send_cq = (<CQEX>scq).ibv_cq
             else:
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
                                        format(t=type(scq)))
@@ -221,9 +221,9 @@ cdef class QPInitAttrEx(PyverbsObject):
         _copy_caps(cap, self)
         if scq is not None:
             if type(scq) is CQ:
-                self.attr.send_cq = (<CQ>rcq).cq
+                self.attr.send_cq = (<CQ>scq).cq
             elif type(scq) is CQEX:
-                self.attr.send_cq = (<CQEX>rcq).ibv_cq
+                self.attr.send_cq = (<CQEX>scq).ibv_cq
             else:
                 raise PyverbsUserError('Expected CQ/CQEX, got {t}'.\
                                        format(t=type(scq)))
@@ -251,6 +251,7 @@ cdef class QPInitAttrEx(PyverbsObject):
         self.attr.comp_mask = comp_mask
         if pd is not None:
             self.pd = pd
+            self.attr.pd = pd.pd
         self.attr.create_flags = create_flags
         self.attr.max_tso_header = max_tso_header
         self.attr.source_qpn = source_qpn
@@ -814,18 +815,20 @@ cdef class QP(PyverbsCM):
             if type(init_attr.send_cq) == CQ:
                 cq = <CQ>init_attr.send_cq
                 cq.add_ref(self)
+                self.scq = cq
             else:
                 cqex = <CQEX>init_attr.send_cq
                 cqex.add_ref(self)
-            self.scq = cq
+                self.scq = cqex
         if init_attr.send_cq != init_attr.recv_cq and init_attr.recv_cq is not None:
             if type(init_attr.recv_cq) == CQ:
                 cq = <CQ>init_attr.recv_cq
                 cq.add_ref(self)
+                self.rcq = cq
             else:
                 cqex = <CQEX>init_attr.recv_cq
                 cqex.add_ref(self)
-            self.rcq = cq
+                self.rcq = cqex
 
     def _create_qp(self, PD pd, QPInitAttr attr):
         self.qp = v.ibv_create_qp(pd.pd, &attr.attr)
-- 
2.21.0

