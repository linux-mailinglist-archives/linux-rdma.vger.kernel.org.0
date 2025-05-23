Return-Path: <linux-rdma+bounces-10656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71789AC29EA
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 20:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F4EA26D69
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F92989A7;
	Fri, 23 May 2025 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbZFj7fc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828F20FAB9;
	Fri, 23 May 2025 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026042; cv=none; b=nTrKrhZOfa0BilvpGVsV/xkM5vulncPSh12DTbNtVI7GLeaohg5TH3TL93wbIatpNpH+XGmkFrI0ABL37h47l0aLuS4ICEBiOCg23wWk93X96fbSatcQIblFx4O+J/G3qdCMC79GLOSVuT8MNKBIuzkGXjhafrIQ/j7odmDcgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026042; c=relaxed/simple;
	bh=t5BFb4WRIJnfVfZdiG0nlQqjCuE11J00mDw6LYyvTDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQvZnUnzoKh3hhaHWIyFRsyD+GgwxDTHAsw3zRfk7BClwweEwjgO5e/arotQKlZgb4pX6LMNVg7OtVKibOMVI01rf3YWCAK6CGS+sUsYJi0+Ek2tcAoomiWb8wLYDHuNB4oA0VHhACu4do0XxKrwIYW6rTor3GKU4Dz+6m8l884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbZFj7fc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af5085f7861so93334a12.3;
        Fri, 23 May 2025 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748026038; x=1748630838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMINtzx5xOC79CwJSKh5YsZHyP2qAGiFcqWeREBv/nU=;
        b=LbZFj7fc717/9Fy4Ho/bq8x+2WGb2xwBITjZ9SOUF5N2OcN4sotRjd19w6HXHVYb22
         LcBRiGb7p41BFxcAvxtlj+rEv8JB82HtQynlSBNeFlQ8hjTwZRMu9NUWWi/9rupB59+g
         5WrTqyjRN6lRgRkHBYB3iRKSKhuKfdkXRyQHRfAJ+XyBvB9A1h2q51ZgJ9uR+bZtIv9e
         7ARgMb8Qy2FCNwzXPpELb9oD0u7MSiYk5vok924FLEZyUL8lNWdSJu60SCqyJ2KMGwn0
         SvMiMXKVllr4FpwiOGdo7gEnoPKLsTuYkXFiUcd0Pa7HsMMPutRbE0XLXHnkFGnpk2P/
         C4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748026038; x=1748630838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMINtzx5xOC79CwJSKh5YsZHyP2qAGiFcqWeREBv/nU=;
        b=YfrkDl3IjhO9FuSlIP5p5IS2J+0pvVPX3oaH/YlnLNOdVD8k1T5w9gNJMWEyl16fcy
         mCL4/ZI8bi8SAZOMJGPj9nToH9AHtAxtvCiGO3AJ5rmE3QFiY/E3MlJcgcOe5p9gSrRH
         jbf0GB7SFD+Oo4DdVvqOhxQ8slIE+uISNeuDHuwM4+1on+/AMppvNQm0xNZrqJWWsCUR
         LDPSed6zYFvSPTXq1HpX65Y33G8tg/FsHzHwCJy5Cr5YDAGP31/zhIAovKDad4MaFr32
         q5AQhxDvJgdA9kw+f2q/NVn9EA5aD2jV8Q2BXJCjQlKOTKX6AUCTwLzJDAPOTYpjKWAL
         ezvA==
X-Forwarded-Encrypted: i=1; AJvYcCVonqpIod+EFCIOx5FJMEmuoZi/GyQE02+89Qbg0m+wg/p6rk0wGrKx4ALzrREONoSVkvQh9HRjsyXN@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFRWAhGpmeVxUMIE1luqqEUlUoKfa0kVoA8oYs9h+tjuYuuoW
	rfs6f02WMnNSeEA4IATBnKgZsbYze5aXwY7dkxSVL5VugCEiOTsUgMoQxPcRTKnF
X-Gm-Gg: ASbGncvM0Q2QAj5Yn9Np4WwHVHs/1kxgIBE8CboS+8jDRuM8aaVmJ/b+QVL1nvNeYIB
	e9ymTnH78viNlg+WMFoRk+qElWgGNo5ZuunJBpeotwQHG0U0/6YZ/0wfj1jFv2fAVhpa0c/YJyj
	7ydUIy+TUGMeXLLgZ7sZDNeV4O1HwTbCTtM2+hGnj0BYF/848MNrIGLy2dmhpKmEh+uYCnXkHip
	yXcPOS6dL104WoG3WYgwsEav0Saer4gZyMyt7+3ETFwIi5xyPxMhGdJ4pRj50Gq67/jswfP8fUh
	dr4NwCeiAmfhf1baGfeglNf9CfjfjCsMTtV/ixtCvVBghcenM8ki0iVEq4E1YnDUUiIwR9EeVOV
	2DGHIaA==
X-Google-Smtp-Source: AGHT+IF7B7mJMAugvw4fwtXrMgg9UCZb9nMSCJHiZRZwJc9x14TpigEIGRvbLeLmAQri4x14gpQitQ==
X-Received: by 2002:a17:903:19f0:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-23414fc98a6mr5483995ad.50.1748026037794;
        Fri, 23 May 2025 11:47:17 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340ec5c5fcsm3417685ad.217.2025.05.23.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:47:17 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: hch@infradead.org,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v1] RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
Date: Fri, 23 May 2025 18:47:01 +0000
Message-ID: <20250523184701.11004-1-dskmtsd@gmail.com>
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
 include/rdma/ib_verbs.h            | 12 ++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b4e3e4beb7f4..8be4797c66ec 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2864,6 +2864,30 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
 	return nents;
 }
 EXPORT_SYMBOL(ib_dma_virt_map_sg);
+int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
+			  size_t nr_entries, size_t dma_entry_size)
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
index b06a0ed81bdd..10813f348b99 100644
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
@@ -4221,6 +4222,17 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
+			  size_t nr_entries, size_t dma_entry_size);
+static inline int ib_dma_map_alloc(struct ib_device *dev, struct hmm_dma_map *map,
+				   size_t nr_entries, size_t dma_entry_size)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_alloc(dev->dma_device, map, nr_entries,
+					     dma_entry_size);
+	return hmm_dma_map_alloc(dev->dma_device, map, nr_entries, dma_entry_size);
+}
+
 /**
  * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.43.0


