Return-Path: <linux-rdma+bounces-8914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E4A6D591
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD2E188D435
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD925C70B;
	Mon, 24 Mar 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PFsfT0ph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921A136988
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803107; cv=none; b=VNfO56vMgMKbkaFGjur4Dgug4v5j81fpId1d18NOWTapJjNBvzHBkUA+IGN5bhF953YZr5ZtpW7s4AVpND/yYTVm1q+EEix0cFK4wIR28FLILWwool8DqBYq7t/cdArxOvwr8UuvABrsUx9eFqrfqAZ+xig3GuzQGNR8Bd+RAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803107; c=relaxed/simple;
	bh=4BocUZLX+WXivWiosdzLh0kYKKS7r0Kcs+6eK498Eog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdWQItlSWdMPfK25H0/8yDDuX4tLIfOsu39SPR6tS3+gE0P4440M4MyFlS9djATO8ojX/ACU9TW2aM0CgRM+SnwLq+7DbN2Zw3H5SbAuyuY8DoKcxTpX/lyQ1i8tb2bRosaqmnlJNzdiE68jDgWpkJfz7IkmypkyeQFhWdSbvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PFsfT0ph; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742803105; x=1774339105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4BocUZLX+WXivWiosdzLh0kYKKS7r0Kcs+6eK498Eog=;
  b=PFsfT0phcmQL6iBiaHOzt/e9e39tQFQxea50pCb/XjmKUHYJz3MkywJI
   YIv/+zIctrKuS6Ko4cLzrjPJ/JXR9Cn9b3VCM+5hRhEUKFZyfohvDPbJ/
   wC2a64c10SSCf0h4UR7dLuhgPueKF+pWY8Nw7vLOvrLESU/0zA1mQgK6w
   c2EaaRT1eScswiTBj3BH+3xqHsOJloCw1IVwp/xxRPFHAFsqa5Ghs6zxP
   Eg5lz0buRRdOIy54ApaGt7Qxa00rB0RSJANguKK5OuuN3N9TufXjzhf27
   CsTxUdZU+6GDkHZvJO8Nj9zYDJKjyVmYuCvUcF3VGyTNJaMwkG5MuUN+b
   g==;
X-CSE-ConnectionGUID: /dpbowijR8esAEj7XUYlvw==
X-CSE-MsgGUID: BaHI+YqNTyej4/9TiBjA6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="182412858"
X-IronPort-AV: E=Sophos;i="6.14,271,1736780400"; 
   d="scan'208";a="182412858"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 16:57:13 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 77AF9D6EAD
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 16:57:11 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E978F76B
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 16:57:11 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 0FBDE2005347;
	Mon, 24 Mar 2025 16:57:11 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v3 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
Date: Mon, 24 Mar 2025 16:56:49 +0900
Message-Id: <20250324075649.3313968-3-matsuda-daisuke@fujitsu.com>
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

Add rxe_odp_do_atomic_write() so that ODP specific steps are applied to
ATOMIC WRITE requests.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  | 11 ++++++-
 drivers/infiniband/sw/rxe/rxe_mr.c   | 12 --------
 drivers/infiniband/sw/rxe/rxe_odp.c  | 46 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++-
 include/rdma/ib_verbs.h              |  1 +
 6 files changed, 68 insertions(+), 14 deletions(-)

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
index 0012bebe96ef..d27bd05ed21f 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -187,7 +187,7 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 /* rxe_odp.c */
 extern const struct mmu_interval_notifier_ops rxe_mn_ops;
 
-#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
+#if defined CONFIG_INFINIBAND_ON_DEMAND_PAGING
 int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
@@ -221,4 +221,13 @@ static inline int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 }
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
+#if defined CONFIG_INFINIBAND_ON_DEMAND_PAGING && defined CONFIG_64BIT
+enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
+#else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING && CONFIG_64BIT */
+static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
+#endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING && CONFIG_64BIT */
+
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
index 9a9aae967486..4bd7284e066a 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -378,3 +378,49 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 
 	return 0;
 }
+
+/* CONFIG_64BIT=y */
+enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
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
+	return RESPST_NONE;
+}
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
index 41bf98ccb275..0a7ccd08b365 100644
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


