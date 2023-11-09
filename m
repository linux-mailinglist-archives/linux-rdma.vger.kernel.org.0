Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226017E635A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Nov 2023 06:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjKIFpy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Nov 2023 00:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjKIFps (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Nov 2023 00:45:48 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937F26B9;
        Wed,  8 Nov 2023 21:45:44 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="118449468"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; 
   d="scan'208";a="118449468"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:45:41 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C1D48DC146;
        Thu,  9 Nov 2023 14:45:39 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id ED58CD9C64;
        Thu,  9 Nov 2023 14:45:38 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id A8AF72005323;
        Thu,  9 Nov 2023 14:45:38 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v7 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
Date:   Thu,  9 Nov 2023 14:44:51 +0900
Message-Id: <fcbbc3ba9414bfcdb775ad677ee63efbe7e74953.1699503619.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mr_copy() is used widely to copy data to/from a user MR. requester uses
it to load payloads of requesting packets; responder uses it to process
Send, Write, and Read operaetions; completer uses it to copy data from
response packets of Read and Atomic operations to a user MR.

Allow these operations to be used with ODP by adding a subordinate function
rxe_odp_mr_copy(). It is comprised of the following steps:
 1. Check page presence and R/W permission.
 2. If OK, just execute data copy to/from the pages and exit.
 3. Otherwise, trigger page fault to map the pages.
 4. Update the MR xarray using PFNs in umem_odp->pfn_list.
 5. Execute data copy to/from the pages.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c     | 10 ++++
 drivers/infiniband/sw/rxe/rxe_loc.h |  8 +++
 drivers/infiniband/sw/rxe/rxe_mr.c  |  9 +++-
 drivers/infiniband/sw/rxe/rxe_odp.c | 77 +++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index f2284d27229b..207a022156f0 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -79,6 +79,16 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 
 		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
 		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
+
+		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SEND;
+		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_RECV;
+		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
+
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SEND;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4bda154a0248..eeaeff8a1398 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -192,6 +192,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -199,6 +201,12 @@ rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+		int length, enum rxe_mr_copy_dir dir)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 384cb4ba1f2d..f0ce87c0fc7d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -247,7 +247,12 @@ int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
 	void *va;
 
 	while (length) {
-		page = xa_load(&mr->page_list, index);
+		if (mr->umem->is_odp)
+			page = xa_untag_pointer(xa_load(&mr->page_list,
+							index));
+		else
+			page = xa_load(&mr->page_list, index);
+
 		if (!page)
 			return -EFAULT;
 
@@ -319,7 +324,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	}
 
 	if (mr->umem->is_odp)
-		return -EOPNOTSUPP;
+		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
 	else
 		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index c5e24901c141..5aa09b9c1095 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -177,3 +177,80 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
 	return err;
 }
+
+/* Take xarray spinlock before entry */
+static inline bool rxe_odp_check_pages(struct rxe_mr *mr, u64 iova,
+				       int length, u32 flags)
+{
+	unsigned long upper = rxe_mr_iova_to_index(mr, iova + length - 1);
+	unsigned long lower = rxe_mr_iova_to_index(mr, iova);
+	bool need_fault = false;
+	void *page, *entry;
+	size_t perm = 0;
+
+
+	if (!(flags & RXE_PAGEFAULT_RDONLY))
+		perm = RXE_ODP_WRITABLE_BIT;
+
+	XA_STATE(xas, &mr->page_list, lower);
+
+	while (xas.xa_index <= upper) {
+		page = xas_load(&xas);
+
+		/* Check page presence and write permission */
+		if (!page || (perm && !(xa_pointer_tag(page) & perm))) {
+			need_fault = true;
+			break;
+		}
+		entry = xas_next(&xas);
+	}
+
+	return need_fault;
+}
+
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	u32 flags = 0;
+	int err;
+
+	if (unlikely(!mr->umem->is_odp))
+		return -EOPNOTSUPP;
+
+	switch (dir) {
+	case RXE_TO_MR_OBJ:
+		break;
+
+	case RXE_FROM_MR_OBJ:
+		flags = RXE_PAGEFAULT_RDONLY;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock(&mr->page_list.xa_lock);
+
+	if (rxe_odp_check_pages(mr, iova, length, flags)) {
+		spin_unlock(&mr->page_list.xa_lock);
+
+		/* umem_mutex is locked on success */
+		err = rxe_odp_do_pagefault_and_lock(mr, iova, length, flags);
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
+	err =  rxe_mr_copy_xarray(mr, iova, addr, length, dir);
+
+	spin_unlock(&mr->page_list.xa_lock);
+
+	return err;
+}
-- 
2.39.1

