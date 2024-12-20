Return-Path: <linux-rdma+bounces-6679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379E29F8FE7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 11:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B3016A1D2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B31BEF97;
	Fri, 20 Dec 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Pg7ebfdk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CC1AAA3D;
	Fri, 20 Dec 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689418; cv=none; b=fMTh8EsMza9guNjmS9ktTO9qmvNIjdOQ+2xsM0zB/pWkTATDoPKEzD4FK9mcFBNQiU3wymlPCcaihOhTARTc90oEc75xUs3/TMqdiUhrt6aWVb5KIiRrOt2uPle+27es9NiQobfMyNdxmEFM7PcvO3P807G0enXrUyyArZbIqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689418; c=relaxed/simple;
	bh=tjI3RBe/5HcoD/GJymJmGnHSsX9G9yUAfmPYNSXHMjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5mvuAYUwjv6MUpOFKKG4kfqXzbcNqdn0cUUjobkeYupSUmCgwCH/GVTKXAx+rWN0PMZNH3pJCa7eN1EWAORLC8K4/tmViuoinQ1x5/r4ghcR5Hjvvt0IvAqzsFAKqJAHz01aBgBdCJshGpzEOBqmej1iavudcicOd3EMdODL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Pg7ebfdk; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734689416; x=1766225416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tjI3RBe/5HcoD/GJymJmGnHSsX9G9yUAfmPYNSXHMjA=;
  b=Pg7ebfdkzxCGyo2moYdSI+eYbOcRhbHcD0VlQY8O7gT099x0oEC67khE
   yc/3rGgARf3DeKs+8NLWBr+bF/OUYLultRMpfBI76IeXonjlIXGfZ3LX8
   oVtnqFNxp25zB5UGYHkekJ65bo+43djqiq5MpliUgGuLBbWjdBGbCACsm
   X6X0RdPiqzAza9pTz0yYTnqykQLEoJsVFQpmyKxiuu981jrXk++smBqr/
   l2O2ZwKu0wGVWzeuWKRpb0b4E6WfRXSUinNgQG9Y75D7TBwCU/cbNRMDp
   U61hfVAxd3J3j404qa0ai9l9TM/sHwVFXJuzKnwW3156G/rqg1hJY82Jt
   A==;
X-CSE-ConnectionGUID: kwz5rEXTQ7Wx6WalgAgoLQ==
X-CSE-MsgGUID: fRdJSJPgSp6InPatSlvKVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="184642845"
X-IronPort-AV: E=Sophos;i="6.12,250,1728918000"; 
   d="scan'208";a="184642845"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 19:10:15 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F1F47D4807;
	Fri, 20 Dec 2024 19:10:12 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C4A4ED94A6;
	Fri, 20 Dec 2024 19:10:12 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 85035200597B;
	Fri, 20 Dec 2024 19:10:12 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v9 5/5] RDMA/rxe: Add support for the traditional Atomic operations with ODP
Date: Fri, 20 Dec 2024 19:09:36 +0900
Message-Id: <20241220100936.2193541-6-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable 'fetch and add' and 'compare and swap' operations to be used with
ODP. This is comprised of the following steps:
 1. Check the driver page table(umem_odp->dma_list) to see if the target
    page is both readable and writable.
 2. If not, then trigger page fault to map the page.
 3. Convert its user space address to a kernel logical address using PFNs
    in the driver page table(umem_odp->pfn_list).
 4. Execute the operation.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  | 11 +++++
 drivers/infiniband/sw/rxe/rxe_mr.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_odp.c  | 69 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  5 +-
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index ea643ebf9667..08c69c637663 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -90,6 +90,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_RECV;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_WRITE;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_READ;
+		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC;
 		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 7a735108d475..a45ff6236613 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -81,6 +81,9 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 void rxe_mr_cleanup(struct rxe_pool_elem *elem);
 
+/* defined in rxe_mr.c; used in rxe_mr.c and rxe_odp.c */
+extern spinlock_t atomic_ops_lock;
+
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
@@ -190,6 +193,8 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
+int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -202,6 +207,12 @@ static inline int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+		     u64 compare, u64 swap_add, u64 *orig_val)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6cd668a8dfb2..868d2f0b74e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -469,7 +469,7 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 }
 
 /* Guarantee atomicity of atomic operations at the machine level. */
-static DEFINE_SPINLOCK(atomic_ops_lock);
+DEFINE_SPINLOCK(atomic_ops_lock);
 
 int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 			u64 compare, u64 swap_add, u64 *orig_val)
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index d3c67d18c173..a82e5011360c 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -253,3 +253,72 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	return err;
 }
+
+static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+				u64 compare, u64 swap_add, u64 *orig_val)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	unsigned int page_offset;
+	struct page *page;
+	unsigned int idx;
+	u64 value;
+	u64 *va;
+	int err;
+
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not in valid state\n");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	err = mr_check_range(mr, iova, sizeof(value));
+	if (err) {
+		rxe_dbg_mr(mr, "iova out of range\n");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
+	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+	page_offset = iova & (BIT(umem_odp->page_shift) - 1);
+	page = hmm_pfn_to_page(umem_odp->pfn_list[idx]);
+	if (!page)
+		return RESPST_ERR_RKEY_VIOLATION;
+
+	if (unlikely(page_offset & 0x7)) {
+		rxe_dbg_mr(mr, "iova not aligned\n");
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+	}
+
+	va = kmap_local_page(page);
+
+	spin_lock_bh(&atomic_ops_lock);
+	value = *orig_val = va[page_offset >> 3];
+
+	if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+		if (value == compare)
+			va[page_offset >> 3] = swap_add;
+	} else {
+		value += swap_add;
+		va[page_offset >> 3] = value;
+	}
+	spin_unlock_bh(&atomic_ops_lock);
+
+	kunmap_local(va);
+
+	return 0;
+}
+
+int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	int err;
+
+	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char), 0);
+	if (err < 0)
+		return err;
+
+	err = rxe_odp_do_atomic_op(mr, iova, opcode, compare, swap_add,
+				   orig_val);
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e703a3ab82d4..54ba9ee1acc5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -707,7 +707,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		u64 iova = qp->resp.va + qp->resp.offset;
 
 		if (mr->umem->is_odp)
-			err = RESPST_ERR_UNSUPPORTED_OPCODE;
+			err = rxe_odp_atomic_op(mr, iova, pkt->opcode,
+						atmeth_comp(pkt),
+						atmeth_swap_add(pkt),
+						&res->atomic.orig_val);
 		else
 			err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
 						  atmeth_comp(pkt),
-- 
2.43.0


