Return-Path: <linux-rdma+bounces-10622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B9AC2528
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774853A7228
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4D2472BA;
	Fri, 23 May 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYJ2cpm6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BA1CB518;
	Fri, 23 May 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010979; cv=none; b=lqbmzeqHPCVDB7OBZxitPMtyF7DHl9IWZOq7n0RO19dHN5y+50sqpEjec6bZ2GjaJ76zIzzcrBPMLykOIgYh3ZblkI2Sm246jIi/+OQR2TuY2f14SAAyKogMO/pSLNnautb7dvS8ygQ3ZTw3POWZ0+SZx4w27G7rZM+OruC1/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010979; c=relaxed/simple;
	bh=KWjfocBxHv0bliWXrGCrCB211qPT4vJ7witqppzAMPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZErwMIOoQ3170mZU/ZZJPeiWOCGsbVRssWFFp/MTaYN6BAW1aidC9rwFaO2liOXL9eUTl7xbKUC20gzmOhoKOCIICrmAfxWzqjzdvDoIRMOVoDS6f4fhdaCx7F89UF9JrHp5k5pV0wTu7+RaLjDJEEXhREOtniRFNI2Pv8ylkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYJ2cpm6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742caef5896so18654b3a.3;
        Fri, 23 May 2025 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010977; x=1748615777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZS6KKAxkfiJ47UQ2g7848YiBd6r9R46LhHeN/beZvg=;
        b=AYJ2cpm6o1kA7abJlLquYva7rN9mrdRi/8MfnzZXatZyFq2tNCYV1rr64pslXYur7V
         Gq2rLL37CMjFvRS9dTr8npl/vwQF2LhTlDtxSAdVTJQUhIsz9Rm7SxSjupa3s1HxVDKF
         OrcuK8BTMZBfKDcsDbyPkq3a/8ij9yMwICQAUD/pVmSD09szm5UY5MhrPUjWnvf03Qtx
         rsfTyuAsbJkVFJ+3CsZh+iBlcujt/p26iXY6OnArCk/exEYGIsM6qoQhjCRqWfnZNCaa
         SRtXBQ7C0gkHO8dI+yD1aARJ/HlS55aBuPauRNVs1/6AVKYo26bBWUXzThrptwZWyqW0
         +IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010977; x=1748615777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZS6KKAxkfiJ47UQ2g7848YiBd6r9R46LhHeN/beZvg=;
        b=MQNEMjWt0uQ3Cd4CqQhTZUJYOVF9qYfm+Jsr7UXu7Bo9vuaFMervPtVVEguCG8m0zZ
         6JH0dwqn2lVRi1pbPKvpMbn9lrwpStU2zxM+MouvjtRv7l2K980imp8uRyR5ggeCtMKp
         4xmnGQ1TLz9RU4V3QbD0kz1gVSpdjJFuIfz42jWF+3nes5U5ZUZKqt9hwH95h59uK1QJ
         CCOqx1Uhkq4vkOz25EMIsJ4pq97bedI39VwdEutMuQ0GTHetJxsJuNMcIC9aa+/gxi3a
         CfCccPalJwQE+Js4+1n+MWeVcxfFYUOhlwbDxxSoI43jZrjxBhhiL1HFIMMAgE9f5wdu
         XuSw==
X-Forwarded-Encrypted: i=1; AJvYcCUW1Vh1H9VJfHImNaqTbkdPYT7kc4rgCgO2o+Znb9/oB39ce7JH2aUh774agTmp0vWELUhqHh+j/Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfTH6U1362PzavIZJalbEVqN7rtQQQJyOvmlcaIHkTyceSzKj
	LH+78modQ4YFlslaY8dn0/wGy6pf0DGJ1P78XyIXvao6lkfn+JHVx5tUWpkfQmCB
X-Gm-Gg: ASbGncv/Tcq6gGkIXfu42apbtDhS3RGeF7+yTgxOc3C8QYPjQ4hTlEEzakx4B11I+iv
	kfXSC/l42vfIj4rzYU+INZ4NyZVNFwuGwjjXs5p1lJv6gwxDRPSan+V0V55Tl+14yD04TsvDBvk
	jM0yIkXsbG3MmzMsCDL7yL7U0nzd73WrZLi7nScnsRiGMu8mh1ApOtMgYnnwMZhtXPjBgk3dUi2
	vxYiLtCTPP0Tbj7N5jxPSUJZVOfABSJ8a/pp7iQNTyhw//PRtOo9N1GfuDK49IqAkAWzPCXF3ZQ
	1dDKRX72qQEW3ygas2LwizEKOYFJO9l763XXeN+yFX0qSX5RjI40z33x0NJ24Rh07KiOW4UDHav
	P92z+aQ==
X-Google-Smtp-Source: AGHT+IGBJ66/Pp0yFSs6RBfnlTgO0ld5hemSj0mUVbSrfLUVYezMJRqXOgHPvfEZXDDQere6Gt/CIQ==
X-Received: by 2002:a05:6a20:9d91:b0:1f5:619a:7f4c with SMTP id adf61e73a8af0-216219b250fmr45645240637.29.1748010977056;
        Fri, 23 May 2025 07:36:17 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf5a2cesm12884264a12.9.2025.05.23.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:36:16 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	akpm@linux-foundation.org,
	jglisse@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	zyjzyj2000@gmail.com,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH] mm/hmm: Allow hmm_dma_map_alloc() to tolerate NULL device
Date: Fri, 23 May 2025 14:35:37 +0000
Message-ID: <20250523143537.10362-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers (such as rxe) may legitimately call hmm_dma_map_alloc() with a
NULL device pointer, which leads to a NULL pointer dereference. This patch
adds NULL checks to safely bypass device-specific DMA features when no
device is provided.

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
 mm/hmm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a8bf097677f3..311141124e67 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -638,7 +638,7 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 		      size_t nr_entries, size_t dma_entry_size)
 {
 	bool dma_need_sync = false;
-	bool use_iova;
+	bool use_iova = false;
 
 	if (!(nr_entries * PAGE_SIZE / dma_entry_size))
 		return -EINVAL;
@@ -649,9 +649,9 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 	 * best approximation to ensure no swiotlb buffering happens.
 	 */
 #ifdef CONFIG_DMA_NEED_SYNC
-	dma_need_sync = !dev->dma_skip_sync;
+	dma_need_sync = dev ? !dev->dma_skip_sync : false;
 #endif /* CONFIG_DMA_NEED_SYNC */
-	if (dma_need_sync || dma_addressing_limited(dev))
+	if (dev && (dma_need_sync || dma_addressing_limited(dev)))
 		return -EOPNOTSUPP;
 
 	map->dma_entry_size = dma_entry_size;
@@ -660,9 +660,11 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 	if (!map->pfn_list)
 		return -ENOMEM;
 
-	use_iova = dma_iova_try_alloc(dev, &map->state, 0,
-			nr_entries * PAGE_SIZE);
-	if (!use_iova && dma_need_unmap(dev)) {
+	if (dev)
+		use_iova = dma_iova_try_alloc(dev, &map->state, 0,
+					      nr_entries * PAGE_SIZE);
+
+	if (!dev || (!use_iova && dma_need_unmap(dev))) {
 		map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
 					 GFP_KERNEL | __GFP_NOWARN);
 		if (!map->dma_list)
-- 
2.43.0


