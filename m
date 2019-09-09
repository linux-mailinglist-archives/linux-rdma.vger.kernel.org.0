Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E22AD546
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbfIIJHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48366 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389596AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp4028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 06/12] pyverbs: Support XRC QPs when modifying QP states
Date:   Mon,  9 Sep 2019 12:07:06 +0300
Message-Id: <20190909090712.11029-7-noaos@mellanox.com>
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

Add the needed support to allow usage of to_<state> methods for
XRC QP types.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 pyverbs/qp.pyx | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/pyverbs/qp.pyx b/pyverbs/qp.pyx
index 0417625e4b6c..d9770608663c 100755
--- a/pyverbs/qp.pyx
+++ b/pyverbs/qp.pyx
@@ -836,6 +836,8 @@ cdef class QP(PyverbsCM):
         if qp_attr is not None:
             funcs = {e.IBV_QPT_RC: self.to_init, e.IBV_QPT_UC: self.to_init,
                      e.IBV_QPT_UD: self.to_rts,
+                     e.IBV_QPT_XRC_RECV: self.to_init,
+                     e.IBV_QPT_XRC_SEND: self.to_init,
                      e.IBV_QPT_RAW_PACKET: self.to_rts}
             funcs[self.qp.qp_type](qp_attr)
 
@@ -899,7 +901,22 @@ cdef class QP(PyverbsCM):
                                e.IBV_QP_QKEY, 'RTR': 0,
                                'RTS': e.IBV_QP_SQ_PSN},
                 e.IBV_QPT_RAW_PACKET: {'INIT': e.IBV_QP_PORT, 'RTR': 0,
-                                       'RTS': 0}}
+                                       'RTS': 0},
+                e.IBV_QPT_XRC_RECV: {'INIT': e.IBV_QP_PKEY_INDEX |\
+                                e.IBV_QP_PORT | e.IBV_QP_ACCESS_FLAGS,
+                                'RTR': e.IBV_QP_AV | e.IBV_QP_PATH_MTU |\
+                                e.IBV_QP_DEST_QPN | e.IBV_QP_RQ_PSN |   \
+                                e.IBV_QP_MAX_DEST_RD_ATOMIC |\
+                                e.IBV_QP_MIN_RNR_TIMER,
+                                'RTS': e.IBV_QP_TIMEOUT | e.IBV_QP_SQ_PSN },
+                e.IBV_QPT_XRC_SEND: {'INIT': e.IBV_QP_PKEY_INDEX |\
+                                e.IBV_QP_PORT | e.IBV_QP_ACCESS_FLAGS,
+                                'RTR': e.IBV_QP_AV | e.IBV_QP_PATH_MTU |\
+                                e.IBV_QP_DEST_QPN | e.IBV_QP_RQ_PSN,
+                                'RTS': e.IBV_QP_TIMEOUT |\
+                                e.IBV_QP_RETRY_CNT | e.IBV_QP_RNR_RETRY |\
+                                e.IBV_QP_SQ_PSN | e.IBV_QP_MAX_QP_RD_ATOMIC}}
+
         return masks[self.qp.qp_type][dst] | e.IBV_QP_STATE
 
     def to_init(self, QPAttr qp_attr):
-- 
2.21.0

