Return-Path: <linux-rdma+bounces-8771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A681A67049
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F8F3B29B6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31F1E832D;
	Tue, 18 Mar 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pAxV7kMX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC720296A
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291467; cv=none; b=V96+GNuCYl0j4LRX+gOwCEFQ3z1JU05M95boME05cIlsf6f+hRsAHcD1gCuU/xyIigr/gc6JMJsMNOkGjwLpLtHGipN/VbbS9Ob9+eU7avKL8MyUhj/lxpEX1gNlw0QUlT4AJgApspcp1ge0pBsjsAuQPpzYzWfrBETpqZ6nSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291467; c=relaxed/simple;
	bh=GLlhwMO28u3ZIOXFTZJj6j8lAG79oRtqQm0j+trtDIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXHA8E+pWPQ3m3D27eLl+o7R7FNBngxVA9LKCydQ/3JDZ7WpU3xVBlSZWc6vx5J2Ndorv7icwKtl5xELh5iSo8hK0PQRtHRjhPoXll5sUh1D7HqrxPPr0hNn7wDsBffROuVqtgcq2dEQwONFb0pRKOr+I/InvEboykAfd2+o4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pAxV7kMX; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742291465; x=1773827465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GLlhwMO28u3ZIOXFTZJj6j8lAG79oRtqQm0j+trtDIQ=;
  b=pAxV7kMX4i8di2qPf3ns0HfH7Md92CqfSOsDUjX+6rjd3p5pfQ1p8FHL
   lRWbcwTJQSucx4C4gOK2Z+wRT1CRvn5gTWsQUQypGwV656QJRk5efw9ZG
   2IcXa9542YIGuDeVFkRTuQyzCqNtkjSzRuJF/J4LwtuvHdznPd2pwB1sc
   mkpeFC/bB1YD5sr0YmAKwxakxP/DZNMx5aGrAZw2eypo4m+NeI4KAAmbw
   5ZqVjUDDspa7Q3Y3UCoB1kIFWTJqIYZvpg0mWgJDb7bRON6eMW31DmzaA
   W0eiiosg7m4zQNSYbyTewdxFVeDelu1f1ryDHJWFoVldspHgx/bUUQVaG
   Q==;
X-CSE-ConnectionGUID: y0RwH/2mSsKLKZV76oEk+w==
X-CSE-MsgGUID: zTnD752WQ/+0b6PKe5ME8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="193766738"
X-IronPort-AV: E=Sophos;i="6.14,256,1736780400"; 
   d="scan'208";a="193766738"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:49:53 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E1DCD480A
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 18:49:51 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F3FFD4BEB
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 18:49:51 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 1F03920053A7;
	Tue, 18 Mar 2025 18:49:51 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v2 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
Date: Tue, 18 Mar 2025 18:49:31 +0900
Message-Id: <20250318094932.2643614-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
References: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For persistent memories, add rxe_odp_flush_pmem_iova() so that ODP specific
steps are executed. Otherwise, no additional consideration is required.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  7 ++++
 drivers/infiniband/sw/rxe/rxe_mr.c   | 36 ++++++++++------
 drivers/infiniband/sw/rxe/rxe_odp.c  | 62 ++++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_resp.c |  4 --
 include/rdma/ib_verbs.h              |  1 +
 6 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 4e56a371deb5..df66f8f9efa1 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -109,6 +109,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index feb386d98d1d..0012bebe96ef 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -194,6 +194,8 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
 int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			 u64 compare, u64 swap_add, u64 *orig_val);
+int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
+			    unsigned int length);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -212,6 +214,11 @@ rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 {
 	return RESPST_ERR_UNSUPPORTED_OPCODE;
 }
+static inline int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
+					  unsigned int length)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 868d2f0b74e9..93e4b5acd3ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -424,7 +424,7 @@ int copy_data(
 	return err;
 }
 
-int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
+static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 {
 	unsigned int page_offset;
 	unsigned long index;
@@ -433,16 +433,6 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 	int err;
 	u8 *va;
 
-	/* mr must be valid even if length is zero */
-	if (WARN_ON(!mr))
-		return -EINVAL;
-
-	if (length == 0)
-		return 0;
-
-	if (mr->ibmr.type == IB_MR_TYPE_DMA)
-		return -EFAULT;
-
 	err = mr_check_range(mr, iova, length);
 	if (err)
 		return err;
@@ -454,7 +444,7 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 		if (!page)
 			return -EFAULT;
 		bytes = min_t(unsigned int, length,
-				mr_page_size(mr) - page_offset);
+			      mr_page_size(mr) - page_offset);
 
 		va = kmap_local_page(page);
 		arch_wb_cache_pmem(va + page_offset, bytes);
@@ -468,6 +458,28 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 	return 0;
 }
 
+int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 start, unsigned int length)
+{
+	int err;
+
+	/* mr must be valid even if length is zero */
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->ibmr.type == IB_MR_TYPE_DMA)
+		return -EFAULT;
+
+	if (mr->umem->is_odp)
+		err = rxe_odp_flush_pmem_iova(mr, start, length);
+	else
+		err = rxe_mr_flush_pmem_iova(mr, start, length);
+
+	return err;
+}
+
 /* Guarantee atomicity of atomic operations at the machine level. */
 DEFINE_SPINLOCK(atomic_ops_lock);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 9f6e2bb2a269..9a9aae967486 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/hmm.h>
+#include <linux/libnvdimm.h>
 
 #include <rdma/ib_umem_odp.h>
 
@@ -147,6 +148,16 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
 	return need_fault;
 }
 
+static unsigned long rxe_odp_iova_to_index(struct ib_umem_odp *umem_odp, u64 iova)
+{
+	return (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+}
+
+static unsigned long rxe_odp_iova_to_page_offset(struct ib_umem_odp *umem_odp, u64 iova)
+{
+	return iova & (BIT(umem_odp->page_shift) - 1);
+}
+
 static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u32 flags)
 {
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
@@ -190,8 +201,8 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	size_t offset;
 	u8 *user_va;
 
-	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
-	offset = iova & (BIT(umem_odp->page_shift) - 1);
+	idx = rxe_odp_iova_to_index(umem_odp, iova);
+	offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 
 	while (length > 0) {
 		u8 *src, *dest;
@@ -277,8 +288,8 @@ static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 		return RESPST_ERR_RKEY_VIOLATION;
 	}
 
-	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
-	page_offset = iova & (BIT(umem_odp->page_shift) - 1);
+	idx = rxe_odp_iova_to_index(umem_odp, iova);
+	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 	page = hmm_pfn_to_page(umem_odp->pfn_list[idx]);
 	if (!page)
 		return RESPST_ERR_RKEY_VIOLATION;
@@ -324,3 +335,46 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
 	return err;
 }
+
+int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
+			    unsigned int length)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	unsigned int page_offset;
+	unsigned long index;
+	struct page *page;
+	unsigned int bytes;
+	int err;
+	u8 *va;
+
+	err = rxe_odp_map_range_and_lock(mr, iova, length,
+					 RXE_PAGEFAULT_DEFAULT);
+	if (err)
+		return err;
+
+	while (length > 0) {
+		index = rxe_odp_iova_to_index(umem_odp, iova);
+		page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
+
+		page = hmm_pfn_to_page(umem_odp->pfn_list[index]);
+		if (!page) {
+			mutex_unlock(&umem_odp->umem_mutex);
+			return -EFAULT;
+		}
+
+		bytes = min_t(unsigned int, length,
+			      mr_page_size(mr) - page_offset);
+
+		va = kmap_local_page(page);
+		arch_wb_cache_pmem(va + page_offset, bytes);
+		kunmap_local(va);
+
+		length -= bytes;
+		iova += bytes;
+		page_offset = 0;
+	}
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return 0;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 54ba9ee1acc5..304e3de740ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -649,10 +649,6 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	struct rxe_mr *mr = qp->resp.mr;
 	struct resp_res *res = qp->resp.res;
 
-	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
-		return RESPST_ERR_UNSUPPORTED_OPCODE;
-
 	/* oA19-14, oA19-15 */
 	if (res && res->replay)
 		return RESPST_ACKNOWLEDGE;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9941f4185c79..da07d3e2db1d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -325,6 +325,7 @@ enum ib_odp_transport_cap_bits {
 	IB_ODP_SUPPORT_READ	= 1 << 3,
 	IB_ODP_SUPPORT_ATOMIC	= 1 << 4,
 	IB_ODP_SUPPORT_SRQ_RECV	= 1 << 5,
+	IB_ODP_SUPPORT_FLUSH	= 1 << 6,
 };
 
 struct ib_odp_caps {
-- 
2.43.0


