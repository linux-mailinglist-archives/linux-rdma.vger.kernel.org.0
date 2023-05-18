Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43AF707BE5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjERIWx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 04:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjERIWs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 04:22:48 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C13D10D9;
        Thu, 18 May 2023 01:22:38 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="105317055"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; 
   d="scan'208";a="105317055"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:22:35 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CD9CD772E;
        Thu, 18 May 2023 17:22:33 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C0ADBD5006;
        Thu, 18 May 2023 17:22:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 8CF04200A4E1;
        Thu, 18 May 2023 17:22:32 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v5 7/7] RDMA/rxe: Add support for the traditional Atomic operations with ODP
Date:   Thu, 18 May 2023 17:21:52 +0900
Message-Id: <2841b1a86987564f14f15ec5b59f6a8bead86b30.1684397037.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enable 'fetch and add' and 'compare and swap' operations to manipulate
data in an ODP-enabled MR. This is comprised of the following steps:
 1. Check the driver page table(umem_odp->dma_list) to see if the target
    page is both readable and writable.
 2. If not, then trigger page fault to map the page.
 3. Update the entry in the MR xarray.
 4. Execute the operation.

umem_mutex is used to ensure that dma_list (an array of addresses of an MR)
is not changed while it is being checked and that the target page is not
invalidated before data access completes.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  9 +++++++++
 drivers/infiniband/sw/rxe/rxe_odp.c  | 26 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  5 ++++-
 4 files changed, 40 insertions(+), 1 deletion(-)

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
index 4b95c8c46bdc..b9d2985774ee 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -208,6 +208,9 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val);
+
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -221,6 +224,12 @@ rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
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
 
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index cbe5d0c3fcc4..194b1fab98b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -283,3 +283,29 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	return err;
 }
+
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val)
+{
+	int err;
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	/* If pagefault is not required, umem mutex will be held until the
+	 * atomic operation completes. Otherwise, it is released and locked
+	 * again in rxe_odp_map_range() to let invalidation handler do its
+	 * work meanwhile.
+	 */
+	mutex_lock(&umem_odp->umem_mutex);
+
+	/* Atomic operations manipulate a single char. */
+	err = rxe_odp_map_range(mr, iova, sizeof(char), 0);
+	if (err)
+		return err;
+
+	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
+				  swap_add, orig_val);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 90c31c4f2944..0a918145dc07 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -684,7 +684,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		u64 iova = qp->resp.va + qp->resp.offset;
 
 		if (mr->odp_enabled)
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

