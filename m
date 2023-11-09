Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107E7E6364
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 06:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjKIFrR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 00:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjKIFq7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 00:46:59 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 21:46:50 PST
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60002709;
        Wed,  8 Nov 2023 21:46:50 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="138532744"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="138532744"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:45:44 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 11D7CDC146;
        Thu,  9 Nov 2023 14:45:41 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4537FD9C60;
        Thu,  9 Nov 2023 14:45:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 006152005323;
        Thu,  9 Nov 2023 14:45:39 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v7 7/7] RDMA/rxe: Add support for the traditional Atomic operations with ODP
Date:   Thu,  9 Nov 2023 14:44:52 +0900
Message-Id: <c7e0ca1c26a9225638bc9fd8f8b463c6595ebdfa.1699503619.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enable 'fetch and add' and 'compare and swap' operations to be used with
ODP. This is comprised of the following steps:
 1. Verify that the page is present with write permission.
 2. If OK, execute the operation and exit.
 3. If not, then trigger page fault to map the page.
 4. Update the entry in the MR xarray.
 5. Execute the operation.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  9 ++++++++
 drivers/infiniband/sw/rxe/rxe_mr.c   |  7 +++++-
 drivers/infiniband/sw/rxe/rxe_odp.c  | 33 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  5 ++++-
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 207a022156f0..abd3267c2873 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -88,6 +88,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index eeaeff8a1398..0bae9044f362 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -194,6 +194,9 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val);
+
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -207,6 +210,12 @@ rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+		     u64 compare, u64 swap_add, u64 *orig_val)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
 
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f0ce87c0fc7d..0dc452ab772b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -498,7 +498,12 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 		}
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 		index = rxe_mr_iova_to_index(mr, iova);
-		page = xa_load(&mr->page_list, index);
+
+		if (mr->umem->is_odp)
+			page = xa_untag_pointer(xa_load(&mr->page_list, index));
+		else
+			page = xa_load(&mr->page_list, index);
+
 		if (!page)
 			return RESPST_ERR_RKEY_VIOLATION;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 5aa09b9c1095..45b54ba15210 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -254,3 +254,36 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	return err;
 }
+
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	int err;
+
+	spin_lock(&mr->page_list.xa_lock);
+
+	/* Atomic operations manipulate a single char. */
+	if (rxe_odp_check_pages(mr, iova, sizeof(char), 0)) {
+		spin_unlock(&mr->page_list.xa_lock);
+
+		/* umem_mutex is locked on success */
+		err = rxe_odp_do_pagefault_and_lock(mr, iova, sizeof(char), 0);
+		if (err < 0)
+			return err;
+
+		/*
+		 * The spinlock is always locked under mutex_lock except
+		 * for MR initialization. No worry about deadlock.
+		 */
+		spin_lock(&mr->page_list.xa_lock);
+		mutex_unlock(&umem_odp->umem_mutex);
+	}
+
+	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
+				  swap_add, orig_val);
+
+	spin_unlock(&mr->page_list.xa_lock);
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9159f1bdfc6f..af3e669679a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -693,7 +693,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		u64 iova = qp->resp.va + qp->resp.offset;
 
 		if (mr->umem->is_odp)
-			err = RESPST_ERR_UNSUPPORTED_OPCODE;
+			err = rxe_odp_mr_atomic_op(mr, iova, pkt->opcode,
+						   atmeth_comp(pkt),
+						   atmeth_swap_add(pkt),
+						   &res->atomic.orig_val);
 		else
 			err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
 						  atmeth_comp(pkt),
-- 
2.39.1

