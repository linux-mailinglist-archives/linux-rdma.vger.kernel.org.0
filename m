Return-Path: <linux-rdma+bounces-8694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E88A60B08
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 09:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6775B19C1623
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5231547E2;
	Fri, 14 Mar 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UvV4lyTz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5C32C85
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940165; cv=none; b=NG0VgeME62yGQooJ/AITDYhu9m8XxeYZZgTwHu+aHfzCIs/A5CZRcwQYQmzI4/mWH4UO3KUzpCgWtBbykl1lyBPJAz917gszLRud8cDnTCGhSKnA/B5iagfLy2kOsiqAG91NZqh2jNQaTACbLnHlMKMSiHSJyzjc5Fgp+eubHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940165; c=relaxed/simple;
	bh=33ATMU3g77pyUkZkdrr2yTn6MtaNh+8r8HIs1/9EShs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLd6ZJLfU9jhR/wg470RfbwfCpgxOnaVsPzFM3bjXxcmfdPzVKgCmObjEfvEd6neqd4Nqwe+v5/qmLfop48AfPlilmWP9G3LoYKj/UmwjwrDJNwSMcQNNFAulYSwTnndLElZ6bVjTy3t6w3ZBitppPyWwd+kuVsUTSoUpjYz9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UvV4lyTz; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741940162; x=1773476162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=33ATMU3g77pyUkZkdrr2yTn6MtaNh+8r8HIs1/9EShs=;
  b=UvV4lyTzERyXTHo3WUlJp3Qs34pprQkKXUGJ0Jo2ck/UUnilmyFopBoc
   uEO4mTl/xWEybDaWFmO/8XQBfxvbBSXk/SfL25BbbleuSLttgT87z27XH
   dz6/Z5ASFxYa7xIn6nOPBWtemflWXojaJSclDezoPtdloBx3+u3E3YDJN
   nz7hVY7fOfIwzKygxqLi8BPOQCOJ+JQNuzUcQ/kn6HLKpxYpV8U7SYgQV
   qvt+gnBnE7a0lhzbFxhHp4oFTZg2j18VJqNI2NjQUsvGvPVBVV94av+Xk
   ktDVSZJdLKXxLvFMWzNN8gzQSgrwV3piRiNmjEpEjt8P+syKLjlGzZcZx
   w==;
X-CSE-ConnectionGUID: lHaeil2JQ+Wi80jS5gEWfA==
X-CSE-MsgGUID: dHTNzN60Q2SyVyli4+1FDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="171981587"
X-IronPort-AV: E=Sophos;i="6.14,246,1736780400"; 
   d="scan'208";a="171981587"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 17:14:52 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A5246D480A
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 17:14:50 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CA24D560A
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 17:14:50 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id DEFCD204F43D;
	Fri, 14 Mar 2025 17:14:49 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v1 2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
Date: Fri, 14 Mar 2025 17:10:56 +0900
Message-Id: <20250314081056.3496708-3-matsuda-daisuke@fujitsu.com>
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

Add rxe_odp_do_atomic_write() so that ODP specific steps are applied to
ATOMIC WRITE requests.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  5 +++
 drivers/infiniband/sw/rxe/rxe_mr.c   |  4 --
 drivers/infiniband/sw/rxe/rxe_odp.c  | 59 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  5 ++-
 include/rdma/ib_verbs.h              |  1 +
 6 files changed, 70 insertions(+), 5 deletions(-)

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
index 868d2f0b74e9..3aecb5be26d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -535,10 +535,6 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	struct page *page;
 	u64 *va;
 
-	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
-		return RESPST_ERR_UNSUPPORTED_OPCODE;
-
 	/* See IBA oA19-28 */
 	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
 		rxe_dbg_mr(mr, "mr not in valid state\n");
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index c1671e5efd70..79ef5fe41f8e 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -389,3 +389,62 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 
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
+	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
+		rxe_dbg_mr(mr, "mr not in valid state\n");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
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
index dd65a8872111..1505d933c09b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -754,7 +754,10 @@ static enum resp_states atomic_write_reply(struct rxe_qp *qp,
 	value = *(u64 *)payload_addr(pkt);
 	iova = qp->resp.va + qp->resp.offset;
 
-	err = rxe_mr_do_atomic_write(mr, iova, value);
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


