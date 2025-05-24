Return-Path: <linux-rdma+bounces-10663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E4AC2FD9
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91EA9E48AE
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC41E00B4;
	Sat, 24 May 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3Vl4JON"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7077261A;
	Sat, 24 May 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748092760; cv=none; b=QTyTc2uTIsUAo9gYOB+hjMxt0CfvDv3Z/waE+9vcgQSOfweQ3zzTgT+T8kB5ovHGc7toXF4dZv2iN4tZczexSPR4F1jon4eZsixcWEd63GnvIf/7wfKRXGCQVrM6kPJOPThOEgSjoExjzh9SAKgVfVBlxlkd4MyZeaP6ZJVkANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748092760; c=relaxed/simple;
	bh=yQxQhrTueZE5cBGrapYwYstif+ri9NaKOgfH7tEXk/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwMwHzKtCASFRAqNv6mK9jFyP/ljfLrBKqunR8Zx6UrsYgt/jE32ZeGiqXy7oZm3o/tMje4CqKmHSp/ig1DBDt9oGAlWE+FFkwq+ZZxhToa+iAeRSklM0KdUhq/pXLR8sRepdBfXgh5G3b4+w4Vnb//HGak1v8GdaWBs7dtl9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3Vl4JON; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376e311086so810753b3a.3;
        Sat, 24 May 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748092757; x=1748697557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9jbMxUqu8JnrssjQHuvWNBptgmTbZOQoKcrAOxZueo=;
        b=c3Vl4JONoN5xVIJH8qly+IX/LNZQBn5dUPQH+TMHNoJDgrqAnfkQ52awinqqxQ8e9J
         0AHehoTmdb+HH9B3McHqQacDSez5vcwk5yj+tHSjWl7++EE0svtXNG+S1IGkwtm3Y2XA
         tzo/ceKp78gfOadxIL3sVd3iHuSKVIxiV5gP/HNss4d3IzPCKj8FVUt2zvTK1YLhpZvh
         Kh1CggdPg94z3JhHNq8MOdBNoecAynfEBbxN4WXcci0sdWmqeIxsLAWUcVJxhV5DvsBm
         jUXguWR7ntiMbIhsrCNGKfHtTe3tYUpcSzjMYAb32qNo9l3WRU3vye3/j4MKBDDVu29F
         RNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748092757; x=1748697557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9jbMxUqu8JnrssjQHuvWNBptgmTbZOQoKcrAOxZueo=;
        b=nlNpeucz36Xd/zbln1ZUjiYdZ2efOaNFxyhiPvVvMTroFq4pKpM+xepoiSG/CDYF76
         JJLdJ2UZ95uoJDTxV8rfkOoxXORO0ECssUMgWGrJuKpsi/ve5Z/15XYqcgpVy118Z/PG
         xNSmc+yU32U9uVIc+Q8qyzT5iY0Lo9yeDO9YLPoiQc0qbFDAMg2bh/FUockpuFZwYB8x
         MONz8feZlRC9E0m5u6mHVvqCW4tAa41Pxj1SBIdGI+4kZJVAiUF0jRz2mK4oZPj4D4Bu
         OFQFPsM0qjJIJTaSfowXUPy2Ai9Aq7NEOrVlviuP/AGtndkBs5kZuaT5Ryl6gp4z3stT
         W4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWinp/J59ZM2kWUksxoWAiWOiWaVIV3GEqOBAoQfdeRB5W9l+TySKpxf4L1MLaThj//55StcfHC2xmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzEMAInvmQTxTyVpb9rSoJVQzE0hWJ5b2i0CTUk1LntW8lGrJ
	aaKL852NPJv3346k+Aec1wdYIfF3B5s8p+jLpnvnD3fzK+Cmd5lqHYkRJSkSKXs7
X-Gm-Gg: ASbGnctcCeeiSXI6R3nhM2IQcrm5g3ECxbviu+PJbltb+shmMPeUp/4jHbJBLPZydfm
	jMf6GSvk42jhFZ9HQM+XdIV5CcnmBCsgQIRUQqv4j4BI4EjumteBvQKXB96vwz97b2wPUa1a8nI
	jk7w6mPIBkeSe2dbS4JLg94Rt86qZXTQn4xS1H1xu2LqpO9sPaXjL6+EEfA0ClkNVriyPWTLF9a
	A+kdAxXUKMhUKSht7VnITAOPQ13Qdy6ENB7l+/M9SuyA8wqtYPm6AuhFfn7zosJLmcZLd0HBvRZ
	yS9zkSSnrKVHN4Co+BQbhUi/w8hGNNoAs/m1/RiUsrstwGqm+KlddweraeoYEmLuWdLzolC5Y8m
	700eC/g==
X-Google-Smtp-Source: AGHT+IFt2FSKxh3AmPvnHvWkrB1i+e41iLjlVOhAGUj3BTaYH7eBJNgAiFhmPXtDmMu7y5Yrv/jKrQ==
X-Received: by 2002:a05:6a00:22cd:b0:73e:970:731 with SMTP id d2e1a72fcca58-745fe035f23mr4207351b3a.16.1748092756825;
        Sat, 24 May 2025 06:19:16 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a31desm14755949b3a.171.2025.05.24.06.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 06:19:16 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: hch@infradead.org,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v2] RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
Date: Sat, 24 May 2025 13:19:02 +0000
Message-ID: <20250524131902.2255-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers such as rxe, which use virtual DMA, must not call into the DMA
mapping core since they lack physical DMA capabilities. Otherwise, a NULL
pointer dereference is observed as shown below. This patch ensures the RDMA
core handles virtual and physical DMA paths appropriately.

This fixes the following kernel oops:

 BUG: kernel NULL pointer dereference, address: 00000000000002fc
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        W           6.15.0-rc1+ #11 PREEMPT(voluntary)
 Tainted: [W]=WARN
 Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
 RIP: 0010:hmm_dma_map_alloc+0x25/0x100
 Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
 RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
 RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
 RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
 RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
 FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
  ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
  rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
  rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
  ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
  ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
  ? mmap_region+0x63/0xd0
  ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
  ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
  __x64_sys_ioctl+0xa4/0xe0
  x64_sys_call+0x1178/0x2660
  do_syscall_64+0x7e/0x170
  ? syscall_exit_to_user_mode+0x4e/0x250
  ? do_syscall_64+0x8a/0x170
  ? do_syscall_64+0x8a/0x170
  ? syscall_exit_to_user_mode+0x4e/0x250
  ? do_syscall_64+0x8a/0x170
  ? syscall_exit_to_user_mode+0x4e/0x250
  ? do_syscall_64+0x8a/0x170
  ? do_user_addr_fault+0x1d2/0x8d0
  ? irqentry_exit_to_user_mode+0x43/0x250
  ? irqentry_exit+0x43/0x50
  ? exc_page_fault+0x93/0x1d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7262a6124ded
 Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
 RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
 RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
 RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
 R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
 R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
  </TASK>

Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/core/device.c   | 24 ++++++++++++++++++++++++
 drivers/infiniband/core/umem_odp.c |  6 +++---
 include/rdma/ib_verbs.h            | 11 +++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b4e3e4beb7f4..5a580eb5cc24 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2864,6 +2864,30 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
 	return nents;
 }
 EXPORT_SYMBOL(ib_dma_virt_map_sg);
+int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
+			  size_t dma_entry_size)
+{
+	if (!(nr_entries * PAGE_SIZE / dma_entry_size))
+		return -EINVAL;
+
+	map->dma_entry_size = dma_entry_size;
+	map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
+				 GFP_KERNEL | __GFP_NOWARN);
+	if (!map->pfn_list)
+		return -ENOMEM;
+
+	map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
+				 GFP_KERNEL | __GFP_NOWARN);
+	if (!map->dma_list)
+		goto err_dma;
+
+	return 0;
+
+err_dma:
+	kvfree(map->pfn_list);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(ib_dma_virt_map_alloc);
 #endif /* CONFIG_INFINIBAND_VIRT_DMA */
 
 static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 51d518989914..aa03f3fc84d0 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -75,9 +75,9 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 	if (unlikely(end < page_size))
 		return -EOVERFLOW;
 
-	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
-				(end - start) >> PAGE_SHIFT,
-				1 << umem_odp->page_shift);
+	ret = ib_dma_map_alloc(dev, &umem_odp->map,
+			       (end - start) >> PAGE_SHIFT,
+			       1 << umem_odp->page_shift);
 	if (ret)
 		return ret;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b06a0ed81bdd..7e861eac731f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -36,6 +36,7 @@
 #include <linux/irqflags.h>
 #include <linux/preempt.h>
 #include <linux/dim.h>
+#include <linux/hmm-dma.h>
 #include <uapi/rdma/ib_user_verbs.h>
 #include <rdma/rdma_counter.h>
 #include <rdma/restrack.h>
@@ -4221,6 +4222,16 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
+			  size_t dma_entry_size);
+static inline int ib_dma_map_alloc(struct ib_device *dev, struct hmm_dma_map *map,
+				   size_t nr_entries, size_t dma_entry_size)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_alloc(map, nr_entries, dma_entry_size);
+	return hmm_dma_map_alloc(dev->dma_device, map, nr_entries, dma_entry_size);
+}
+
 /**
  * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.43.0


