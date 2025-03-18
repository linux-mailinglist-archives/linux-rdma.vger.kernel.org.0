Return-Path: <linux-rdma+bounces-8769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F72A67043
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9264817625D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AEE1EF362;
	Tue, 18 Mar 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kZXWGUl1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921241EB5F5
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291407; cv=none; b=KwJ/nrsk0qg+FKs4grE6cwh+dDTrKYQxWcVk6hjIAxo8XnZdgMqHRqo4UKDu5lZbpvC6en2QmMzHF06C4fi+u6sHXPoEJYa/3g0cbMCbhetZ5nGYnXVt013AYbv7QLwu9u5ViB/HKtctuTds9TRSrcL2eOb0U2Oyu/ZhLTxxFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291407; c=relaxed/simple;
	bh=V5wRv7l7GNB3R2L/+Gbh2PvYhO+n2zFTooa09Db0t74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vC7ofCN/5lYMMdE/a1yfqg20d8ZQgFh4DRu2QDSEso959aPpRKjxDoV5IGF/dD4K4KZvHOt7+9NorgFNuHmxBCFFkXMxNYaumRffIxRGkuxH96LONqEpsxQhQ+ursIAUwRd11EcnSpugI0SMukKEdK6y9jOXB09JKHIYvgBsEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kZXWGUl1; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742291403; x=1773827403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5wRv7l7GNB3R2L/+Gbh2PvYhO+n2zFTooa09Db0t74=;
  b=kZXWGUl1du3K9Vhm/bl4BmfBX2UYT4n7aP9qOQLb/Gnr/hAVY+PwhzAb
   /ys5TxJl5ru/EcDj1mPNq58YTCLHETwvnx+CfWDU2gRRUJy61NjMfGT1o
   TgrKB2Wh36V8wJuvNMKUFFIUj3OTtto1sh2HDYXO30SUeywj8PJoROa8Q
   KYrJbeiPL93aFQw2PX59CaZL7Z5HAJUiDhVAwdd9n5VwBRP6KStLRCerU
   1h03bGNdog4PEqlcrFTjoT/mbjnA5M04xHmm/5uH9b/DJDkOrKL3ZH4qV
   LtYWj1sV7Bd9k7oLUpyU7Y6u5RZyHcl/fuaBolh+qgTJ1YBDC4GDH+w5c
   w==;
X-CSE-ConnectionGUID: PHvLsXPGSmqJYl2XU9zFPA==
X-CSE-MsgGUID: hcgVN+StTBywd9IBDXL9rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="180825956"
X-IronPort-AV: E=Sophos;i="6.14,256,1736780400"; 
   d="scan'208";a="180825956"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:49:55 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F704E9EE5
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 18:49:53 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 63B5ED8ADF
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 18:49:53 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 1375220053A7;
	Tue, 18 Mar 2025 18:49:53 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v2 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
Date: Tue, 18 Mar 2025 18:49:32 +0900
Message-Id: <20250318094932.2643614-3-matsuda-daisuke@fujitsu.com>
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

Add rxe_odp_do_atomic_write() so that ODP specific steps are applied to
ATOMIC WRITE requests.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  5 +++
 drivers/infiniband/sw/rxe/rxe_mr.c   | 12 -------
 drivers/infiniband/sw/rxe/rxe_odp.c  | 53 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 11 +++++-
 include/rdma/ib_verbs.h              |  1 +
 6 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index df66f8f9efa1..21ce2d876b42 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -110,6 +110,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0012bebe96ef..8b1517c0894c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -196,6 +196,7 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			 u64 compare, u64 swap_add, u64 *orig_val);
 int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 			    unsigned int length);
+int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -219,6 +220,10 @@ static inline int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 {
 	return -EOPNOTSUPP;
 }
+static inline int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 93e4b5acd3ac..d40fbe10633f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -547,16 +547,6 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	struct page *page;
 	u64 *va;
 
-	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
-		return RESPST_ERR_UNSUPPORTED_OPCODE;
-
-	/* See IBA oA19-28 */
-	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
-		rxe_dbg_mr(mr, "mr not in valid state\n");
-		return RESPST_ERR_RKEY_VIOLATION;
-	}
-
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		page_offset = iova & (PAGE_SIZE - 1);
 		page = ib_virt_dma_to_page(iova);
@@ -584,10 +574,8 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	}
 
 	va = kmap_local_page(page);
-
 	/* Do atomic write after all prior operations have completed */
 	smp_store_release(&va[page_offset >> 3], value);
-
 	kunmap_local(va);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 9a9aae967486..f3443c604a7f 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -378,3 +378,56 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 
 	return 0;
 }
+
+#if defined CONFIG_64BIT
+/* only implemented or called for 64 bit architectures */
+int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	unsigned int page_offset;
+	unsigned long index;
+	struct page *page;
+	int err;
+	u64 *va;
+
+	/* See IBA oA19-28 */
+	err = mr_check_range(mr, iova, sizeof(value));
+	if (unlikely(err)) {
+		rxe_dbg_mr(mr, "iova out of range\n");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(value),
+					 RXE_PAGEFAULT_DEFAULT);
+	if (err)
+		return RESPST_ERR_RKEY_VIOLATION;
+
+	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
+	index = rxe_odp_iova_to_index(umem_odp, iova);
+	page = hmm_pfn_to_page(umem_odp->pfn_list[index]);
+	if (!page) {
+		mutex_unlock(&umem_odp->umem_mutex);
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+	/* See IBA A19.4.2 */
+	if (unlikely(page_offset & 0x7)) {
+		mutex_unlock(&umem_odp->umem_mutex);
+		rxe_dbg_mr(mr, "misaligned address\n");
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+	}
+
+	va = kmap_local_page(page);
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(&va[page_offset >> 3], value);
+	kunmap_local(va);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return 0;
+}
+#else
+int rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
+#endif
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 304e3de740ad..fd7bac5bce18 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -749,7 +749,16 @@ static enum resp_states atomic_write_reply(struct rxe_qp *qp,
 	value = *(u64 *)payload_addr(pkt);
 	iova = qp->resp.va + qp->resp.offset;
 
-	err = rxe_mr_do_atomic_write(mr, iova, value);
+	/* See IBA oA19-28 */
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not in valid state\n");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	if (mr->umem->is_odp)
+		err = rxe_odp_do_atomic_write(mr, iova, value);
+	else
+		err = rxe_mr_do_atomic_write(mr, iova, value);
 	if (err)
 		return err;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index da07d3e2db1d..bfa1bff3c720 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -326,6 +326,7 @@ enum ib_odp_transport_cap_bits {
 	IB_ODP_SUPPORT_ATOMIC	= 1 << 4,
 	IB_ODP_SUPPORT_SRQ_RECV	= 1 << 5,
 	IB_ODP_SUPPORT_FLUSH	= 1 << 6,
+	IB_ODP_SUPPORT_ATOMIC_WRITE	= 1 << 7,
 };
 
 struct ib_odp_caps {
-- 
2.43.0


