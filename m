Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF72798260
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 08:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbjIHG1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 02:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242009AbjIHG1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 02:27:20 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36C1BD8;
        Thu,  7 Sep 2023 23:27:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="119319382"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="119319382"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:27:10 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A26FFD29E1;
        Fri,  8 Sep 2023 15:27:08 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DFAEBD9A75;
        Fri,  8 Sep 2023 15:27:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 9B53E200537C;
        Fri,  8 Sep 2023 15:27:07 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v6 7/7] RDMA/rxe: Add support for the traditional Atomic operations with ODP
Date:   Fri,  8 Sep 2023 15:26:48 +0900
Message-Id: <908514dfa6bbeae72d36481d893674b254ee416d.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

umem_mutex is used to ensure that the target page is not invalidated before
data access completes. It also protects the lists in umem_odp and the MR
xarray.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  9 ++++++
 drivers/infiniband/sw/rxe/rxe_odp.c  | 43 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  5 +++-
 4 files changed, 57 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index da1c0753db93..289c60cbda12 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -268,3 +268,46 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	return err;
 }
+
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val)
+{
+	int err;
+	int retry = 0;
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	mutex_lock(&umem_odp->umem_mutex);
+
+	/* Atomic operations manipulate a single char. */
+	if (rxe_odp_check_pages(mr, iova, sizeof(char), 0))
+		goto need_fault;
+
+	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
+				  swap_add, orig_val);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+
+need_fault:
+	/* allow max 3 tries for pagefault */
+	do {
+		mutex_unlock(&umem_odp->umem_mutex);
+
+		if (retry > 2)
+			return -EFAULT;
+
+		/* umem_mutex is locked on success */
+		err = rxe_odp_do_pagefault_and_lock(mr, iova, sizeof(char), 0);
+		if (err < 0)
+			return err;
+		retry++;
+	} while (rxe_odp_check_pages(mr, iova, sizeof(char), 0));
+
+	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
+				  swap_add, orig_val);
+
+	mutex_unlock(&umem_odp->umem_mutex);
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

