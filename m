Return-Path: <linux-rdma+bounces-8913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924ABA6D597
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 08:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4253ADF03
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0E825C6FE;
	Mon, 24 Mar 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="m0qGJjKu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45225A2D6
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803103; cv=none; b=DhWTdOwK2Xm34DS10jAHzw72KCAE5Hc5dBKruRJoV7YD8hKwjdEvHpd67Oh4eUHMGWObLg+GlWR0E8+eb/r2nSPa0rSYOYEgT5pY7w/iW4xbg4/TFgWH5rn2jYIpiAUVGP5xw2k8fJ4aDJS+F9M6KuYsgDKwHq9XSW9eA6urhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803103; c=relaxed/simple;
	bh=vTOPgPi5QiVlXYe8IJhRmMrweNEqMpDIdA8gy87oi8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkgkWI/TnjsYHOvRFVo6+qgWEktY4PMu0tQVDe4O7YiVfrPge59Zg0J08zLKEtzkqxLFuCon8nbMUEC5sy6YLtb9vzMRTAfGnz/v+MGO70olb52EW4Ip6MSeoI61LCHOTDYuwZV03/fJrep56u7oGDgs8uaIKnugTMQKQiPq2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=m0qGJjKu; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742803102; x=1774339102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTOPgPi5QiVlXYe8IJhRmMrweNEqMpDIdA8gy87oi8o=;
  b=m0qGJjKuR8XCwFfC59+2FAUDsu5s+f45z4rkibSH6vSTX3emiti/QJrQ
   jJTXLESLWg8G0gY5uKWZzBO5oxEKgKP6QjFGEnE3h0/AW3xa+NqX3PEl5
   OX+n6D5uRl+ws+5qfPm8biwrPTypX3ZTVFU7eN048ic0/lqTPHjq8NEF9
   /R3EYS6R2CzGdMH67qE7iQAHGgL936LrIGteMvuiSb8W+lOcdAkeXJheE
   +ZfnNmm6wNo3baxpouwOnIliRMjSIFGoj0UmKApyGduOfBKxj1PCVC7Qv
   hcbxh44MJBaXt8CEyhLzo7k7NXugPL+N1HerggftRcusyf7BogBeKMh1s
   A==;
X-CSE-ConnectionGUID: xNKxnwdWTSSuHNuD5tLhWw==
X-CSE-MsgGUID: UyEQOQMkQGWlkwNX+FfGFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="194005672"
X-IronPort-AV: E=Sophos;i="6.14,271,1736780400"; 
   d="scan'208";a="194005672"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 16:57:11 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0FF88C2264
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 16:57:08 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D4593BF4AD
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 16:57:07 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 830522005347;
	Mon, 24 Mar 2025 16:57:07 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v3 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
Date: Mon, 24 Mar 2025 16:56:48 +0900
Message-Id: <20250324075649.3313968-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
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
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
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
index d42eae69d9a8..41bf98ccb275 100644
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


