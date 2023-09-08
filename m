Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541EC79825E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 08:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbjIHG1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 02:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbjIHG1Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 02:27:16 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039C11FC4;
        Thu,  7 Sep 2023 23:27:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="131102632"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="131102632"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:27:10 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D061CD7E3;
        Fri,  8 Sep 2023 15:27:07 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 85377D621A;
        Fri,  8 Sep 2023 15:27:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 4202F20059A3;
        Fri,  8 Sep 2023 15:27:06 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v6 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
Date:   Fri,  8 Sep 2023 15:26:47 +0900
Message-Id: <f15b06b934aa0ace8b28dc046022e5507458eb99.1694153251.git.matsuda-daisuke@fujitsu.com>
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

umem_mutex is used to ensure that mapped pages are not invalidated before
data copy completes. It also protects the lists in umem_odp and the MR
xarray.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c     | 10 ++++
 drivers/infiniband/sw/rxe/rxe_loc.h |  8 +++
 drivers/infiniband/sw/rxe/rxe_mr.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_odp.c | 84 +++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 1 deletion(-)

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
index 384cb4ba1f2d..1641bf1a42a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -319,7 +319,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	}
 
 	if (mr->umem->is_odp)
-		return -EOPNOTSUPP;
+		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
 	else
 		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 713bef9161e3..da1c0753db93 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -184,3 +184,87 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
 	return err;
 }
+
+static inline bool rxe_odp_check_pages(struct rxe_mr *mr, u64 iova,
+				       int length, u32 flags)
+{
+	unsigned long lower, upper, idx;
+	unsigned long hmm_flags = HMM_PFN_VALID;
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	struct page *page;
+	bool need_fault = false;
+
+	lower = rxe_mr_iova_to_index(mr, iova);
+	upper = rxe_mr_iova_to_index(mr, iova + length - 1);
+
+	if (!(flags & RXE_PAGEFAULT_RDONLY))
+		hmm_flags |= HMM_PFN_WRITE;
+
+	/* xarray is protected by umem_mutex */
+	for (idx = lower; idx <= upper; idx++) {
+		page = xa_load(&mr->page_list, idx);
+
+		if (!page || !(umem_odp->pfn_list[idx] & hmm_flags)) {
+			need_fault = true;
+			break;
+		}
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
+	int retry = 0;
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
+	mutex_lock(&umem_odp->umem_mutex);
+
+	if (rxe_odp_check_pages(mr, iova, length, flags))
+		goto need_fault;
+
+	err =  rxe_mr_copy_xarray(mr, iova, addr, length, dir);
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
+		err = rxe_odp_do_pagefault_and_lock(mr, iova, length, flags);
+		if (err < 0)
+			return err;
+		retry++;
+	} while (rxe_odp_check_pages(mr, iova, length, flags));
+
+	err =  rxe_mr_copy_xarray(mr, iova, addr, length, dir);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+}
-- 
2.39.1

