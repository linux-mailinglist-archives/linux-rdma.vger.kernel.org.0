Return-Path: <linux-rdma+bounces-10674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476BBAC32AB
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 09:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5903B71D3
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D71714C6;
	Sun, 25 May 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdG7i79R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDF4414;
	Sun, 25 May 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748156892; cv=none; b=XQEdcyBlgUfjOyXocZjj7tQr/5eXv/Wu+JeEBQs6tjaAPGwnJOosjCptQAN5UJY6tjP5T/ryXne8Xo5iHPsJrCiDdlGMFYwKhy5mM3up4lttzbdlR4ZKx4nA6lxOBILgN4JZ4uEEt9j8/iBn5TsK8dItT110WwnScVq71F7LZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748156892; c=relaxed/simple;
	bh=AqhiJQHZlFcoZN7lnTCI3OEqT4tv5v0J1EU0ETJL5s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8lD/hephypKchVygex3WUDYd//8N10E8uxH76KClvRiq9RChOOOlUfSfy4R9NKp7jhhJPgwFcjAd7ZOUMl/6i55OB2XSJhKUFET2s8R/gHEEA8XFJf44ESlvBLNWVSvx1eZ67Ck9HV+yCL7x4e8NIi3myNPCBzcbBEO09H090A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdG7i79R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56AFC4CEEA;
	Sun, 25 May 2025 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748156891;
	bh=AqhiJQHZlFcoZN7lnTCI3OEqT4tv5v0J1EU0ETJL5s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdG7i79RVvByimkhDkZr+6Oh15NygEQBfOZ52yV3ZjWVoNVRRIN7xMPBjAik2i66X
	 d4KFYDLvRxRb0JH0qxbyRx9vZ8MKTMffdeKVT7+XcWW4pQj10qZy0F3v5snBFOpiRe
	 a8t3MbQlt/2/ff3koTFIoE+6wmFQUGz+vUW/JEt7PLfZ0sugxtynKdlwBywaXaprAi
	 gHK98RwJfWqWkPWKxKDw9UR2xjiHGc8yjrRewksYru6hCZd/qz3Wp8Z15c5H3UQp9j
	 81JIhBug617yMRuzrX9ZZicI5n3/H/iPH8dr055PIkmhFpT5kMF3cmHgbv2H0DgMvO
	 hh0Q3wG0tRzww==
Date: Sun, 25 May 2025 10:08:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, hch@infradead.org
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250525070806.GW7435@unreal>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524144328.4361-1-dskmtsd@gmail.com>

On Sat, May 24, 2025 at 02:43:28PM +0000, Daisuke Matsuda wrote:
> Drivers such as rxe, which use virtual DMA, must not call into the DMA
> mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> pointer dereference is observed as shown below. This patch ensures the RDMA
> core handles virtual and physical DMA paths appropriately.
> 
> This fixes the following kernel oops:
> 
>  BUG: kernel NULL pointer dereference, address: 00000000000002fc
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        W           6.15.0-rc1+ #11 PREEMPT(voluntary)
>  Tainted: [W]=WARN
>  Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>  RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>  Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>  RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>  RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>  RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>  RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>  R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>  FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
>   ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
>   rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
>   rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
>   ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
>   ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
>   ? mmap_region+0x63/0xd0
>   ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
>   ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
>   __x64_sys_ioctl+0xa4/0xe0
>   x64_sys_call+0x1178/0x2660
>   do_syscall_64+0x7e/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? do_syscall_64+0x8a/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? do_user_addr_fault+0x1d2/0x8d0
>   ? irqentry_exit_to_user_mode+0x43/0x250
>   ? irqentry_exit+0x43/0x50
>   ? exc_page_fault+0x93/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7262a6124ded
>  Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>  RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>  RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>  RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>  R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>  R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>   </TASK>
> 
> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>  drivers/infiniband/core/device.c   | 17 +++++++++++++++++
>  drivers/infiniband/core/umem_odp.c | 11 ++++++++---
>  include/rdma/ib_verbs.h            |  4 ++++
>  3 files changed, 29 insertions(+), 3 deletions(-)

Please include changelogs when you submit vX patches next time.

I ended with the following patch:

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 51d518989914e..cf16549919e02 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -60,9 +60,11 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 {
 	struct ib_device *dev = umem_odp->umem.ibdev;
 	size_t page_size = 1UL << umem_odp->page_shift;
+	struct hmm_dma_map *map;
 	unsigned long start;
 	unsigned long end;
-	int ret;
+	size_t nr_entries;
+	int ret = 0;
 
 	umem_odp->umem.is_odp = 1;
 	mutex_init(&umem_odp->umem_mutex);
@@ -75,9 +77,20 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 	if (unlikely(end < page_size))
 		return -EOVERFLOW;
 
-	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
-				(end - start) >> PAGE_SHIFT,
-				1 << umem_odp->page_shift);
+	nr_entries = (end - start) >> PAGE_SHIFT;
+	if (!(nr_entries * PAGE_SIZE / page_size))
+		return -EINVAL;
+
+	nap = &umem_odp->map;
+	if (ib_uses_virt_dma(dev)) {
+		map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
+					 GFP_KERNEL | __GFP_NOWARN);
+		if (!map->pfn_list)
+			ret = -ENOMEM;
+	} else
+		ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
+					(end - start) >> PAGE_SHIFT,
+					1 << umem_odp->page_shift);
 	if (ret)
 		return ret;
 
@@ -90,7 +103,10 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 	return 0;
 
 out_free_map:
-	hmm_dma_map_free(dev->dma_device, &umem_odp->map);
+	if (ib_uses_virt_dma(dev))
+		kfree(map->pfn_list);
+	else
+		hmm_dma_map_free(dev->dma_device, &umem_odp->map);
 	return ret;
 }
 
@@ -259,7 +275,10 @@ static void ib_umem_odp_free(struct ib_umem_odp *umem_odp)
 				    ib_umem_end(umem_odp));
 	mutex_unlock(&umem_odp->umem_mutex);
 	mmu_interval_notifier_remove(&umem_odp->notifier);
-	hmm_dma_map_free(dev->dma_device, &umem_odp->map);
+	if (ib_uses_virt_dma(dev))
+		kfree(umem_odp->map->pfn_list);
+	else
+		hmm_dma_map_free(dev->dma_device, &umem_odp->map);
 }
 
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
diff --git a/mm/hmm.c b/mm/hmm.c
index a8bf097677f39..feac86196a65f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -640,8 +640,7 @@ int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
 	bool dma_need_sync = false;
 	bool use_iova;
 
-	if (!(nr_entries * PAGE_SIZE / dma_entry_size))
-		return -EINVAL;
+	WARN_ON_ONCE(!(nr_entries * PAGE_SIZE / dma_entry_size));
 
 	/*
 	 * The HMM API violates our normal DMA buffer ownership rules and can't
-- 
2.49.0




