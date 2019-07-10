Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C498B64867
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGJOb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 10:31:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47975 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbfGJOb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 10:31:57 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Jul 2019 17:31:51 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x6AEVpIm004077;
        Wed, 10 Jul 2019 17:31:51 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-core 4/4] pyverbs: Fix assignments of bad work requests
Date:   Wed, 10 Jul 2019 17:22:51 +0300
Message-Id: <20190710142251.9396-5-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710142251.9396-1-noaos@mellanox.com>
References: <20190710142251.9396-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The bad work request content wasn't properly copied from the C
object, fix copying to contain the bad work request data.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewd-by: Maor Gottlieb <maorg@mellanox.com>
---
 pyverbs/qp.pyx | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 47a2158a5acc..ad89c94c002e 100644
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -14,6 +14,9 @@ cimport pyverbs.libibverbs as v
 from pyverbs.pd cimport PD
 
 
+cdef extern from 'string.h':
+    void *memcpy(void *dest, const void *src, size_t n);
+
 cdef class QPCap(PyverbsObject):
     def __cinit__(self, max_send_wr=1, max_recv_wr=10, max_send_sge=1,
                       max_recv_sge=1, max_inline_data=0):
@@ -963,10 +966,12 @@ cdef class QP(PyverbsCM):
         :return: None
         """
         cdef v.ibv_recv_wr *my_bad_wr
+        # In order to provide a pointer to a pointer, use a temporary cdef'ed
+        # variable.
         rc = v.ibv_post_recv(self.qp, &wr.recv_wr, &my_bad_wr)
         if rc != 0:
-            if bad_wr is not None:
-                bad_wr.wr = <object>my_bad_wr
+            if (bad_wr):
+                memcpy(&bad_wr.recv_wr, my_bad_wr, sizeof(bad_wr.recv_wr))
             raise PyverbsRDMAErrno('Failed to post recv (returned {rc})'.
                                    format(rc=rc))
 
@@ -978,11 +983,13 @@ cdef class QP(PyverbsCM):
                        case of a failure
         :return: None
         """
+        # In order to provide a pointer to a pointer, use a temporary cdef'ed
+        # variable.
         cdef v.ibv_send_wr *my_bad_wr
         rc = v.ibv_post_send(self.qp, &wr.send_wr, &my_bad_wr)
         if rc != 0:
-            if bad_wr is not None:
-                bad_wr.wr = <object>my_bad_wr
+            if (bad_wr):
+                memcpy(&bad_wr.send_wr, my_bad_wr, sizeof(bad_wr.send_wr))
             raise PyverbsRDMAErrno('Failed to post send (returned {rc})'.
                                    format(rc=rc))
 
-- 
2.21.0

