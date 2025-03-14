Return-Path: <linux-rdma+bounces-8693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF9A60B05
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 09:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF33617E1E1
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58519CC24;
	Fri, 14 Mar 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bFHXvYT6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AE433A8
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940161; cv=none; b=LjJPnKlup1CvpgD/ZfWvfrZjsQuVGprp5r+l6vH5+X+TkIxoeaTklavGWYNgT31foSBoRyaHr9sf+IjnnLo7IBYHNoGlF60y4yGse6JC/LyJsf/Ss0aXsUKpsnTOzJKahHgsLqrvS0e43Imb0XKkmY2u7AUpi4c+I3Xhw66D5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940161; c=relaxed/simple;
	bh=AUgtgIBUpCVxxBoayqW2swniz5T/aFUml7konwbt8d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uiUd7PZ4enwwQRblOfYFlKXQYeg+AA4wOXrJN9A7zCwX7WeOUOOUuysMIFEGuXvJgnOGekKWsC4RoLqWDYArtYQnyHqo7FqtZnCdkN8b/rU8iV2+f9uiElJ9k3M4leH5bfwZVXt0Ji4ziEnO+nHy17wPG1VOP5tWiYHb8jeo8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bFHXvYT6; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741940160; x=1773476160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUgtgIBUpCVxxBoayqW2swniz5T/aFUml7konwbt8d8=;
  b=bFHXvYT6XAJhonYRPL20uZSYAQfrpFyijidxelqB5WRyiXSK9wpe0rjF
   nQIpSgLDHLzg4yxvkSVY+Q00Hbla9BL1OOpf6wJ+HQMprMnYdSDjs0oeZ
   S5Jx176DTYZfg6pRZutKHVX3wB37WbTVonAYCg1rf6PlR1RCdaRGWKzj5
   eAoH8fD86CDSySTlXMi23+gvy64GpAZwtmg4aCuMRUTi5gkxnXfHwFDtj
   LtZ+n3W2TCDhdns5nFZZmj541jUrcecHm81+1FE/kaC9FNMO+5d8sKx0n
   XbsSXDzgkQ4DUUX5DSNcAg92ELo+c9kiSwP2FO0/gfj9BQCLyQgXBFxPW
   A==;
X-CSE-ConnectionGUID: TFkNcCF4RMGflPbZvx8AnA==
X-CSE-MsgGUID: IFgAfm16RruiuNBCfBKwIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="195800109"
X-IronPort-AV: E=Sophos;i="6.14,246,1736780400"; 
   d="scan'208";a="195800109"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 17:14:48 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DC647DBB87
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 17:14:45 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B2BB1D94C8
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 17:14:45 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 562282020FA0;
	Fri, 14 Mar 2025 17:14:45 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v1 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
Date: Fri, 14 Mar 2025 17:10:55 +0900
Message-Id: <20250314081056.3496708-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
References: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
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
 drivers/infiniband/sw/rxe/rxe_loc.h  |  7 +++
 drivers/infiniband/sw/rxe/rxe_odp.c  | 73 ++++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_resp.c | 13 ++---
 include/rdma/ib_verbs.h              |  1 +
 5 files changed, 85 insertions(+), 10 deletions(-)

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
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 94f7bbe14981..c1671e5efd70 100644
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
@@ -324,3 +335,57 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
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
+	/* mr must be valid even if length is zero */
+	if (WARN_ON(!mr))
+		return -EINVAL;
+
+	if (length == 0)
+		return 0;
+
+	err = mr_check_range(mr, iova, length);
+	if (err)
+		return err;
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
index 54ba9ee1acc5..dd65a8872111 100644
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
@@ -670,8 +666,13 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	}
 
 	if (res->flush.type & IB_FLUSH_PERSISTENT) {
-		if (rxe_flush_pmem_iova(mr, start, length))
-			return RESPST_ERR_RKEY_VIOLATION;
+		if (mr->umem->is_odp) {
+			if (rxe_odp_flush_pmem_iova(mr, start, length))
+				return RESPST_ERR_RKEY_VIOLATION;
+		} else {
+			if (rxe_flush_pmem_iova(mr, start, length))
+				return RESPST_ERR_RKEY_VIOLATION;
+		}
 		/* Make data persistent. */
 		wmb();
 	} else if (res->flush.type & IB_FLUSH_GLOBAL) {
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


