Return-Path: <linux-rdma+bounces-5328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3D995D95
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 04:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB841F243FD
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5928213FD72;
	Wed,  9 Oct 2024 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KkAD2CQz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7251C4A;
	Wed,  9 Oct 2024 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439242; cv=none; b=eoBZSK5gPLv4APUzuGoIe5UzCH7sn9tl0kw7xktRh+qSyp0xK+GXHRl76S9TPc5UPxbepbW7dTlNeqcubDqf6BN+twS+9E6QHyga9wVazTzJc/ITbZ0R+WHx7+wTBfQrl/4VX1UpUXhUWgU9IruIxFZ9n6QFTva9dnfusapP4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439242; c=relaxed/simple;
	bh=MhaB+PjJmhfTum5OpD5ChJfo3q/GsY8t40p+fcY8qWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY+RTUgo3JiqM6Wg6EnpXW97cvvFWya9LXnEn8UMg+yfOcwGlDqiM8xRTkdn1xQ4LtSHqI+5epkO4MNAqag3uY0wLCcttdPykdQLiqlsnJ/0sioFGURQ6cEYekGpqC7TOkk/soVFtPV+9E+F0lQmCcaThuoW+oibu5C+aOMFr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KkAD2CQz; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728439241; x=1759975241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhaB+PjJmhfTum5OpD5ChJfo3q/GsY8t40p+fcY8qWI=;
  b=KkAD2CQzHxrD1G23JWLmqtqEvK2B4fn8TNm7iIZsD6XzxSVJq50yGtGZ
   oRootNhT2u5KLD4cqEJ/Fd5cmU3qPeN7xNPvFPMY0afqMSvYmb3TG/KAO
   DNzwwX5RwRBxFxY7yIIh15x91xY2J6+x17XZkskanTmOtYjCKJYMOOiW6
   aBNrzYnowflT1cJ0ngDZOTa7CufiTvH9p4xOH9GcfLQU2kbfT40Du4kRb
   YkrszLHLEPIjrp5w2GxiReKQTNa6BSqM298jJmGXYElHeakLTidpIhR+u
   pxdfSl12pn0OgkibcwhkeQKiHqcOwq7Pxv8nbOVbjjgoqOSohyV4zTh1x
   w==;
X-CSE-ConnectionGUID: Q1dA/vB8QiqCVAGakVhVPw==
X-CSE-MsgGUID: SXT6J5dgTOmxqAoun+iLGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="176266746"
X-IronPort-AV: E=Sophos;i="6.11,188,1725289200"; 
   d="scan'208";a="176266746"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 10:59:34 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B1572C68E2;
	Wed,  9 Oct 2024 10:59:31 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C870CFA5B;
	Wed,  9 Oct 2024 10:59:31 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id D62572005356;
	Wed,  9 Oct 2024 10:59:30 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v8 5/6] RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
Date: Wed,  9 Oct 2024 10:59:02 +0900
Message-Id: <20241009015903.801987-6-matsuda-daisuke@fujitsu.com>
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
 drivers/infiniband/sw/rxe/rxe_loc.h |  8 ++++
 drivers/infiniband/sw/rxe/rxe_mr.c  |  9 +++-
 drivers/infiniband/sw/rxe/rxe_odp.c | 73 +++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 3ca73f8d96cc..ea643ebf9667 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -81,6 +81,16 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 
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
index 51b77e8827aa..2483e90a5443 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -193,6 +193,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -200,6 +202,12 @@ rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
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
index 5589314a1e67..eef3976309eb 100644
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
index c5e24901c141..979af279cf36 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -177,3 +177,76 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
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
+		/* spinlock to prevent page invalidation */
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
2.43.0


