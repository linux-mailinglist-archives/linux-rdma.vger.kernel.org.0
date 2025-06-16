Return-Path: <linux-rdma+bounces-11328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D1ADAA6A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CB67A55CA
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE620E01F;
	Mon, 16 Jun 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW//tl60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A431BF58
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061656; cv=none; b=k4KvRVYawen3sOQL70CKxWcbaZi9B5CfPWj48dHk+xlw+IJTzazhpSB1K1J7FtUr3DISXjQO46BYyaE1OgW+Oyc8duv8tIZ66x0iBaUMzrapAclnUazcS5Neh5OIqhgHxLGjuaAm04zq0MU7yTHePcKlNMRsDcrNFcXRWkPDVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061656; c=relaxed/simple;
	bh=SqHIQn6NkVwSs0lQ0Q2y2RZhIMRtny+hihp13Apq6xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toG1WIt+prgDCr32YjbD5eissP3lKiexJv6MIUGA+ibvLUvb5Dfl3hQf4LlYlHXsACMpERzBO0PDja0fnsfSp3U+PC2hAWFizHEL+Z3uJQMXbHjLsX1SfTvg9N4WGqvr52Dv1XTHz99mrtwZhfGfNCsxBDSqrUHU/EyVhbHB+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW//tl60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C479C4CEEA;
	Mon, 16 Jun 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750061655;
	bh=SqHIQn6NkVwSs0lQ0Q2y2RZhIMRtny+hihp13Apq6xc=;
	h=From:To:Cc:Subject:Date:From;
	b=GW//tl60wIuqDg5UblsD+0xs8b0SKyhRdmLpZBkYLehnKrJuY2IEmxyjgRsbiKfhP
	 zy2MYlpihMorNRrjK3HfDXCD1sc9QYB4DDgkZUn3P/DQrY/ijYs1lvQkgyJ1qxLEyq
	 iOtV6HfdHZCOSPxwrHdi8Ai2qezxaOw/2r3cUr2gZCIdZtxUyyCpIpbDLqaR4BTgSs
	 WOMtQQLyiPi1YCazOssU64AzblX0XL0/9XuxjI33+bG0y6GAv6qyd6ypBEuOrER05I
	 QqaV59vmTRjkyf7uIhmrcoIEwhmzbek0GAzAGWr7tf4r2skQfe5LEscdXoBi8hBFEz
	 tk33OmlMk3bAw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc] IB/mlx5: Fix potential deadlock in MR deregistration
Date: Mon, 16 Jun 2025 11:14:09 +0300
Message-ID: <3c8f225a8a9fade647d19b014df1172544643e4a.1750061612.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

The issue arises when kzalloc() is invoked while holding umem_mutex or
any other lock acquired under umem_mutex. This is problematic because
kzalloc() can trigger fs_reclaim_aqcuire(), which may, in turn, invoke
mmu_notifier_invalidate_range_start(). This function can lead to
mlx5_ib_invalidate_range(), which attempts to acquire umem_mutex again,
resulting in a deadlock.

The problematic flow:
             CPU0                      |              CPU1
---------------------------------------|------------------------------------------------
mlx5_ib_dereg_mr()                     |
 → revoke_mr()                         |
   → mutex_lock(&umem_odp->umem_mutex) |
                                       | mlx5_mkey_cache_init()
                                       |  → mutex_lock(&dev->cache.rb_lock)
                                       |  → mlx5r_cache_create_ent_locked()
                                       |    → kzalloc(GFP_KERNEL)
                                       |      → fs_reclaim()
                                       |        → mmu_notifier_invalidate_range_start()
                                       |          → mlx5_ib_invalidate_range()
                                       |            → mutex_lock(&umem_odp->umem_mutex)
   → cache_ent_find_and_store()        |
     → mutex_lock(&dev->cache.rb_lock) |

Additionally, when kzalloc() is called from within
cache_ent_find_and_store(), we encounter the same deadlock due to
re-acquisition of umem_mutex.

Solve by releasing umem_mutex in dereg_mr() after umr_revoke_mr()
and before acquiring rb_lock. This ensures that we don't hold
umem_mutex while performing memory allocations that could trigger
the reclaim path.

This change prevents the deadlock by ensuring proper lock ordering and
avoiding holding locks during memory allocation operations that could
trigger the reclaim path.

The following lockdep warning demonstrates the deadlock:

 python3/20557 is trying to acquire lock:
 ffff888387542128 (&umem_odp->umem_mutex){+.+.}-{4:4}, at:
 mlx5_ib_invalidate_range+0x5b/0x550 [mlx5_ib]

 but task is already holding lock:
 ffffffff82f6b840 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at:
 unmap_vmas+0x7b/0x1a0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #3 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
       fs_reclaim_acquire+0x60/0xd0
       mem_cgroup_css_alloc+0x6f/0x9b0
       cgroup_init_subsys+0xa4/0x240
       cgroup_init+0x1c8/0x510
       start_kernel+0x747/0x760
       x86_64_start_reservations+0x25/0x30
       x86_64_start_kernel+0x73/0x80
       common_startup_64+0x129/0x138

 -> #2 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x91/0xd0
       __kmalloc_cache_noprof+0x4d/0x4c0
       mlx5r_cache_create_ent_locked+0x75/0x620 [mlx5_ib]
       mlx5_mkey_cache_init+0x186/0x360 [mlx5_ib]
       mlx5_ib_stage_post_ib_reg_umr_init+0x3c/0x60 [mlx5_ib]
       __mlx5_ib_add+0x4b/0x190 [mlx5_ib]
       mlx5r_probe+0xd9/0x320 [mlx5_ib]
       auxiliary_bus_probe+0x42/0x70
       really_probe+0xdb/0x360
       __driver_probe_device+0x8f/0x130
       driver_probe_device+0x1f/0xb0
       __driver_attach+0xd4/0x1f0
       bus_for_each_dev+0x79/0xd0
       bus_add_driver+0xf0/0x200
       driver_register+0x6e/0xc0
       __auxiliary_driver_register+0x6a/0xc0
       do_one_initcall+0x5e/0x390
       do_init_module+0x88/0x240
       init_module_from_file+0x85/0xc0
       idempotent_init_module+0x104/0x300
       __x64_sys_finit_module+0x68/0xc0
       do_syscall_64+0x6d/0x140
       entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #1 (&dev->cache.rb_lock){+.+.}-{4:4}:
       __mutex_lock+0x98/0xf10
       __mlx5_ib_dereg_mr+0x6f2/0x890 [mlx5_ib]
       mlx5_ib_dereg_mr+0x21/0x110 [mlx5_ib]
       ib_dereg_mr_user+0x85/0x1f0 [ib_core]
       uverbs_free_mr+0x19/0x30 [ib_uverbs]
       destroy_hw_idr_uobject+0x21/0x80 [ib_uverbs]
       uverbs_destroy_uobject+0x60/0x3d0 [ib_uverbs]
       uobj_destroy+0x57/0xa0 [ib_uverbs]
       ib_uverbs_cmd_verbs+0x4d5/0x1210 [ib_uverbs]
       ib_uverbs_ioctl+0x129/0x230 [ib_uverbs]
       __x64_sys_ioctl+0x596/0xaa0
       do_syscall_64+0x6d/0x140
       entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #0 (&umem_odp->umem_mutex){+.+.}-{4:4}:
       __lock_acquire+0x1826/0x2f00
       lock_acquire+0xd3/0x2e0
       __mutex_lock+0x98/0xf10
       mlx5_ib_invalidate_range+0x5b/0x550 [mlx5_ib]
       __mmu_notifier_invalidate_range_start+0x18e/0x1f0
       unmap_vmas+0x182/0x1a0
       exit_mmap+0xf3/0x4a0
       mmput+0x3a/0x100
       do_exit+0x2b9/0xa90
       do_group_exit+0x32/0xa0
       get_signal+0xc32/0xcb0
       arch_do_signal_or_restart+0x29/0x1d0
       syscall_exit_to_user_mode+0x105/0x1d0
       do_syscall_64+0x79/0x140
       entry_SYSCALL_64_after_hwframe+0x4b/0x53

 Chain exists of:
 &dev->cache.rb_lock --> mmu_notifier_invalidate_range_start -->
 &umem_odp->umem_mutex

 Possible unsafe locking scenario:

       CPU0                        CPU1
       ----                        ----
   lock(&umem_odp->umem_mutex);
                                lock(mmu_notifier_invalidate_range_start);
                                lock(&umem_odp->umem_mutex);
   lock(&dev->cache.rb_lock);

 *** DEADLOCK ***

Fixes: abb604a1a9c8 ("RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with error")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 61 +++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5142ff4b6b2d..41e897a7e652 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2063,23 +2063,50 @@ void mlx5_ib_revoke_data_direct_mrs(struct mlx5_ib_dev *dev)
 	}
 }
 
-static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
+static int mlx5_umr_revoke_mr_with_lock(struct mlx5_ib_mr *mr)
 {
-	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
-	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
-	bool is_odp = is_odp_mr(mr);
 	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
-			!to_ib_umem_dmabuf(mr->umem)->pinned;
-	bool from_cache = !!ent;
-	int ret = 0;
+			      !to_ib_umem_dmabuf(mr->umem)->pinned;
+	bool is_odp = is_odp_mr(mr);
+	int ret;
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
 	if (is_odp_dma_buf)
-		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv, NULL);
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv,
+			      NULL);
+
+	ret = mlx5r_umr_revoke_mr(mr);
+
+	if (is_odp) {
+		if (!ret)
+			to_ib_umem_odp(mr->umem)->private = NULL;
+		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+	}
+
+	if (is_odp_dma_buf) {
+		if (!ret)
+			to_ib_umem_dmabuf(mr->umem)->private = NULL;
+		dma_resv_unlock(
+			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+	}
 
-	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
+	return ret;
+}
+
+static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
+{
+	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
+			      !to_ib_umem_dmabuf(mr->umem)->pinned;
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+	bool is_odp = is_odp_mr(mr);
+	bool from_cache = !!ent;
+	int ret;
+
+	if (mr->mmkey.cacheable && !mlx5_umr_revoke_mr_with_lock(mr) &&
+	    !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
 		/* upon storing to a clean temp entry - schedule its cleanup */
 		spin_lock_irq(&ent->mkeys_queue.lock);
@@ -2091,7 +2118,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-		goto out;
+		return 0;
 	}
 
 	if (ent) {
@@ -2100,8 +2127,14 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mr->mmkey.cache_ent = NULL;
 		spin_unlock_irq(&ent->mkeys_queue.lock);
 	}
+
+	if (is_odp)
+		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+
+	if (is_odp_dma_buf)
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv,
+			      NULL);
 	ret = destroy_mkey(dev, mr);
-out:
 	if (is_odp) {
 		if (!ret)
 			to_ib_umem_odp(mr->umem)->private = NULL;
@@ -2111,9 +2144,9 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	if (is_odp_dma_buf) {
 		if (!ret)
 			to_ib_umem_dmabuf(mr->umem)->private = NULL;
-		dma_resv_unlock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+		dma_resv_unlock(
+			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
-
 	return ret;
 }
 
@@ -2162,7 +2195,7 @@ static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 	}
 
 	/* Stop DMA */
-	rc = mlx5_revoke_mr(mr);
+	rc = mlx5r_handle_mkey_cleanup(mr);
 	if (rc)
 		return rc;
 
-- 
2.49.0


