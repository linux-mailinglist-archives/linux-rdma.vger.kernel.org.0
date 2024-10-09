Return-Path: <linux-rdma+bounces-5330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F30995D99
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 04:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA08B2432C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A67DA79;
	Wed,  9 Oct 2024 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HZn7LkAk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883B154433;
	Wed,  9 Oct 2024 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439254; cv=none; b=YcfPM2Kp9z1EfzJ5Hygtm6q6YXgAEugV9oH3QRgJu+L994dCxqDPbYL0Uam82h0vPYVmBBAzgVtuGv15Yru2+4AXR5UEHvDUFzOaJ4klKaPdZIPESubJLdxlDedMk8lBFstX7RFcivb8UBpY/4lYvaWAAJ+bFJZwcLJkV3II4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439254; c=relaxed/simple;
	bh=s0yJjF9Ii7DzkZTQa5QDzOmziKNFCBZLpxs+X3yjp18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDihJKGuw/wl2TkfM1m9vz7uruWGkINNJuYv5KJpIWnWoSbRaXryeTWnHXVYzav0Hg7XV6YDGEuSUTb8AhMR5hbjedkFesXR0RtLJijRv5infjyw7dE4fPhD/KYr7srT4gSCnf9jQ0O7eXTiTFWj0obbyqn04NoP/M4Ct+CoAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HZn7LkAk; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728439252; x=1759975252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0yJjF9Ii7DzkZTQa5QDzOmziKNFCBZLpxs+X3yjp18=;
  b=HZn7LkAk8n36hq8ESeynmXn+Rkjqp5yuOiD9KA+Ul+T7TryeCckITTIC
   RBj/5D6VasV8Ep33R1JrZeEaFWt8Qf8knosuC6rvbc6kae1OmWuonB27L
   dlXzycNoaUjGFNhxDV/1CW7ctEH9z/pndxQ38n56yjfFzVhnR7iNZqQv7
   M3Ab8HWYXNifsWorPmbe64gyDSyjHXO/5y39RFdr5NKMDuiz7z+/E2blJ
   8NAIJDcJUYOROSaFDwpGN72blO8zjEvlH5wTEOYAsScanbJBFcoOjLC2u
   Zfw1dKioBVYGyADkBvG5Cj/sFqf/4ZD2Yh4GtstzIDNdda/mFJm0I95a7
   Q==;
X-CSE-ConnectionGUID: QDPx8U43T0mQeXcQx0aUXg==
X-CSE-MsgGUID: LrU3QA+yQdSp6f/2SmvFtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="164199195"
X-IronPort-AV: E=Sophos;i="6.11,188,1725289200"; 
   d="scan'208";a="164199195"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 10:59:40 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5031CD4250;
	Wed,  9 Oct 2024 10:59:38 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4C75DD8CA7;
	Wed,  9 Oct 2024 10:59:35 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 0F5AB2005356;
	Wed,  9 Oct 2024 10:59:35 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v8 6/6] RDMA/rxe: Add support for the traditional Atomic operations with ODP
Date: Wed,  9 Oct 2024 10:59:03 +0900
Message-Id: <20241009015903.801987-7-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Enable 'fetch and add' and 'compare and swap' operations to be used with
ODP. This is comprised of the following steps:
 1. Verify that the page is present with write permission.
 2. If OK, execute the operation and exit.
 3. If not, then trigger page fault to map the page.
 4. Update the entry in the MR xarray.
 5. Execute the operation.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  1 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  9 +++++++++
 drivers/infiniband/sw/rxe/rxe_mr.c   |  7 ++++++-
 drivers/infiniband/sw/rxe/rxe_odp.c  | 30 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c |  5 ++++-
 5 files changed, 50 insertions(+), 2 deletions(-)

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
index 2483e90a5443..5ea6d423d527 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -195,6 +195,9 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir);
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val);
+
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -208,6 +211,12 @@ rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
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
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index eef3976309eb..273da7dfca97 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -498,7 +498,12 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 		}
 		page_offset = rxe_mr_iova_to_page_offset(mr, iova);
 		index = rxe_mr_iova_to_index(mr, iova);
-		page = xa_load(&mr->page_list, index);
+
+		if (mr->umem->is_odp)
+			page = xa_untag_pointer(xa_load(&mr->page_list, index));
+		else
+			page = xa_load(&mr->page_list, index);
+
 		if (!page)
 			return RESPST_ERR_RKEY_VIOLATION;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 979af279cf36..a6d9a840a38c 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -250,3 +250,33 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	return err;
 }
+
+int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
+			 u64 compare, u64 swap_add, u64 *orig_val)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	int err;
+
+	spin_lock(&mr->page_list.xa_lock);
+
+	/* Atomic operations manipulate a single char. */
+	if (rxe_odp_check_pages(mr, iova, sizeof(char), 0)) {
+		spin_unlock(&mr->page_list.xa_lock);
+
+		/* umem_mutex is locked on success */
+		err = rxe_odp_do_pagefault_and_lock(mr, iova, sizeof(char), 0);
+		if (err < 0)
+			return err;
+
+		/* spinlock to prevent page invalidation */
+		spin_lock(&mr->page_list.xa_lock);
+		mutex_unlock(&umem_odp->umem_mutex);
+	}
+
+	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
+				  swap_add, orig_val);
+
+	spin_unlock(&mr->page_list.xa_lock);
+
+	return err;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e703a3ab82d4..4c1e7337519a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -707,7 +707,10 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
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
2.43.0


