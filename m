Return-Path: <linux-rdma+bounces-6681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1AF9F8FEB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 11:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B267316DE87
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B7A1BD027;
	Fri, 20 Dec 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FvGnxkD9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34291C0DED;
	Fri, 20 Dec 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689423; cv=none; b=IVROOrkDnooycai6H/Sde/YZA/z8+YV+nnOgxXSeP9AVbMrceFybgx3eJKKxwuw4blJahGAknmSfwpx4fyEIrUMRdW15rQegcFDwJHTYQCUk6RVgWEnGqt/xlCOyajq8cNKNN87owiCofdgD7RU/W4DkOWqNvqhpsNBKwTf4L64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689423; c=relaxed/simple;
	bh=n2sP4DecmZDxZfHzEQPg0qcVq+Jlny28ynFu1Gyhdyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bM53FZcGGRoTFMp1L/ci+DtqLNC/5Zj6bHB21wSuPALf31u30++oeG3uqcGE/Z73v045HHId0LkPC8ucH/qup7amO1LCgqtrNDdYh6gI0XjT0dJ2lrRI7SdVEOTEpcbEyylPzJgWVAOkDaOQOIoeR1+VuLTSos48mzWSrJAhIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FvGnxkD9; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734689420; x=1766225420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n2sP4DecmZDxZfHzEQPg0qcVq+Jlny28ynFu1Gyhdyc=;
  b=FvGnxkD9W/8CcPm5V6R/aWj42uVXLn2lfySh1lONr10g4k0PJ65yiFeN
   xrtF6xGjfkcq+VghwFOrayv7+LTi3GJ36/Y/9bS9HgToDbpvGrFucyF17
   49K1c1J5Fk36G34IOiETuGludjjKZ/Bd5hHzbEVRjqtCyu3Ut6cEv4s0T
   NdgyV+N44MirYOsgOdfYvdiPyQAHZWt5oYIjgo3yBuIWuTK2mnsNEkPg1
   qWtkLWCGciimF2rqmKTXbjsToYMOuDTR1Bd0jPeLfgrdRqifUuC36I5VL
   1E7djR6UhQeYyRU8KPPDUGMK1TOTaoH722pLLFof9KuOR5CNbnFdThBsH
   w==;
X-CSE-ConnectionGUID: Lu/uDwhKQA2tCLfImW5+qQ==
X-CSE-MsgGUID: Ty60ePE3S/2PlOTXa6ZirQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="163321228"
X-IronPort-AV: E=Sophos;i="6.12,250,1728918000"; 
   d="scan'208";a="163321228"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 19:10:12 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 904F4D500C;
	Fri, 20 Dec 2024 19:10:10 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6076FCFBC3;
	Fri, 20 Dec 2024 19:10:10 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 3329C200597B;
	Fri, 20 Dec 2024 19:10:10 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v9 4/5] RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
Date: Fri, 20 Dec 2024 19:09:35 +0900
Message-Id: <20241220100936.2193541-5-matsuda-daisuke@fujitsu.com>
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

rxe_mr_copy() is used widely to copy data to/from a user MR. requester uses
it to load payloads of requesting packets; responder uses it to process
Send, Write, and Read operaetions; completer uses it to copy data from
response packets of Read and Atomic operations to a user MR.

Allow these operations to be used with ODP by adding a subordinate function
rxe_odp_mr_copy(). It is comprised of the following steps:
 1. Check the driver page table(umem_odp->dma_list) to see if pages being
    accessed are present with appropriate permission.
 2. If necessary, trigger page fault to map the pages.
 3. Convert their user space addresses to kernel logical addresses using
    PFNs in the driver page table(umem_odp->pfn_list).
 4. Execute data copy to/from the pages.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c     |  10 +++
 drivers/infiniband/sw/rxe/rxe_loc.h |   7 ++
 drivers/infiniband/sw/rxe/rxe_mr.c  |   2 +-
 drivers/infiniband/sw/rxe/rxe_odp.c | 131 ++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)

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
index 1043240daa97..7a735108d475 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -188,6 +188,8 @@ extern const struct mmu_interval_notifier_ops rxe_mn_ops;
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr);
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int
 rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -195,6 +197,11 @@ rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 {
 	return -EOPNOTSUPP;
 }
+static inline int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+				  int length, enum rxe_mr_copy_dir dir)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 190225a34139..6cd668a8dfb2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -324,7 +324,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 	}
 
 	if (mr->umem->is_odp)
-		return -EOPNOTSUPP;
+		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
 	else
 		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 141290078754..d3c67d18c173 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -122,3 +122,134 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 
 	return err;
 }
+
+static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
+				       u64 iova, int length, u32 perm)
+{
+	bool need_fault = false;
+	u64 addr;
+	int idx;
+
+	addr = iova & (~(BIT(umem_odp->page_shift) - 1));
+
+	/* Skim through all pages that are to be accessed. */
+	while (addr < iova + length) {
+		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+
+		if (!(umem_odp->dma_list[idx] & perm)) {
+			need_fault = true;
+			break;
+		}
+
+		addr += BIT(umem_odp->page_shift);
+	}
+	return need_fault;
+}
+
+static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u32 flags)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	bool need_fault;
+	u64 perm;
+	int err;
+
+	if (unlikely(length < 1))
+		return -EINVAL;
+
+	perm = ODP_READ_ALLOWED_BIT;
+	if (!(flags & RXE_PAGEFAULT_RDONLY))
+		perm |= ODP_WRITE_ALLOWED_BIT;
+
+	mutex_lock(&umem_odp->umem_mutex);
+
+	need_fault = rxe_check_pagefault(umem_odp, iova, length, perm);
+	if (need_fault) {
+		mutex_unlock(&umem_odp->umem_mutex);
+
+		/* umem_mutex is locked on success. */
+		err = rxe_odp_do_pagefault_and_lock(mr, iova, length,
+						    flags);
+		if (err < 0)
+			return err;
+
+		need_fault = rxe_check_pagefault(umem_odp, iova, length, perm);
+		if (need_fault)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
+			     int length, enum rxe_mr_copy_dir dir)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	struct page *page;
+	int idx, bytes;
+	size_t offset;
+	u8 *user_va;
+
+	idx = (iova - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
+	offset = iova & (BIT(umem_odp->page_shift) - 1);
+
+	while (length > 0) {
+		u8 *src, *dest;
+
+		page = hmm_pfn_to_page(umem_odp->pfn_list[idx]);
+		user_va = kmap_local_page(page);
+		if (!user_va)
+			return -EFAULT;
+
+		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
+		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
+
+		bytes = BIT(umem_odp->page_shift) - offset;
+		if (bytes > length)
+			bytes = length;
+
+		memcpy(dest, src, bytes);
+		kunmap_local(user_va);
+
+		length  -= bytes;
+		idx++;
+		offset = 0;
+	}
+
+	return 0;
+}
+
+int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
+		    enum rxe_mr_copy_dir dir)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	u32 flags = 0;
+	int err;
+
+	if (length == 0)
+		return 0;
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
+	err = rxe_odp_map_range_and_lock(mr, iova, length, flags);
+	if (err)
+		return err;
+
+	err =  __rxe_odp_mr_copy(mr, iova, addr, length, dir);
+
+	mutex_unlock(&umem_odp->umem_mutex);
+
+	return err;
+}
-- 
2.43.0


