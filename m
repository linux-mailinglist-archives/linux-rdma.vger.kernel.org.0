Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C43458D9F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhKVLpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236718AbhKVLpC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 06:45:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E659E60D07;
        Mon, 22 Nov 2021 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637581316;
        bh=ZWlNC3TpeZfPv+nOlBCuTdG6NSroLQsdnEW6D3h8+wc=;
        h=From:To:Cc:Subject:Date:From;
        b=qcC2yLg1zaxQx2ExjolNIYmtINtiWs176zQ93DhxodeVS5kRXnU2DmAeeS1VA1249
         /PQlZ1z3nrXVvkhvcDWZdQ6wKCvNld9vpVGwSX9WvTl25elRe/j6fa17dHSDKVT3YE
         8ltBIde9z4RXdIvHEaIciXIPUfwUY9WdUQ0k4c8arcv2/M2DsZvcEV+tTpV9d4Uci3
         CBugbnXEW6zDpnm3l8MeGmNyB9YC75Z5YqJfLFHQY5ySkGwQ2NHvqaBciiuNPchW21
         3Nrggszw5Dj/zduVR4y2VB1j9WWL0uePL10m/6v7G61QAGm3HE+HEixqRWaDiRo5/j
         5kh8Xin/knCXQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alaa Hleihel <alaa@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc v1] RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow
Date:   Mon, 22 Nov 2021 13:41:51 +0200
Message-Id: <66bb1dd253c1fd7ceaa9fc411061eefa457b86fb.1637581144.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Alaa Hleihel <alaa@nvidia.com>

After the cited patch, and for the case of IB_MR_TYPE_DM that doesn't
have a umem (even though it is a user MR), function mlx5_free_priv_descs()
will think that it's a kernel MR, leading to wrongly accessing mr->descs
that will get wrong values in the union which leads to attempt to release
resources that were not allocated in the first place.

For example:
 DMA-API: mlx5_core 0000:08:00.1: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]
 WARNING: CPU: 8 PID: 1021 at kernel/dma/debug.c:961 check_unmap+0x54f/0x8b0
 RIP: 0010:check_unmap+0x54f/0x8b0
 Call Trace:
  debug_dma_unmap_page+0x57/0x60
  mlx5_free_priv_descs+0x57/0x70 [mlx5_ib]
  mlx5_ib_dereg_mr+0x1fb/0x3d0 [mlx5_ib]
  ib_dereg_mr_user+0x60/0x140 [ib_core]
  uverbs_destroy_uobject+0x59/0x210 [ib_uverbs]
  uobj_destroy+0x3f/0x80 [ib_uverbs]
  ib_uverbs_cmd_verbs+0x435/0xd10 [ib_uverbs]
  ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
  ? lock_acquire+0xc4/0x2e0
  ? lock_acquired+0x12/0x380
  ? lock_acquire+0xc4/0x2e0
  ? lock_acquire+0xc4/0x2e0
  ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
  ? lock_release+0x28a/0x400
  ib_uverbs_ioctl+0xc0/0x140 [ib_uverbs]
  ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
  __x64_sys_ioctl+0x7f/0xb0
  do_syscall_64+0x38/0x90

Fix it by reorganizing the dereg flow and mlx5_ib_mr structure:
 - Move the ib_umem field into the user MRs structure in the union as
   it's applicable on there.
 - Function mlx5_ib_dereg_mr() will now call mlx5_free_priv_descs() only
   in case there isn't udata (which indicates that this isn't a user MR.

Fixes: f18ec4223117 ("RDMA/mlx5: Use a union inside mlx5_ib_mr")
Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
v1: 
 * Different implementation
v0: https://lore.kernel.org/linux-rdma/e13b7014857ea296285ee5cfcdaaada9007f6978.1634638695.git.leonro@nvidia.com/
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
 drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++--------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e636e954f6bf..4a7a56ed740b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -664,7 +664,6 @@ struct mlx5_ib_mr {
 
 	/* User MR data */
 	struct mlx5_cache_ent *cache_ent;
-	struct ib_umem *umem;
 
 	/* This is zero'd when the MR is allocated */
 	union {
@@ -676,7 +675,7 @@ struct mlx5_ib_mr {
 			struct list_head list;
 		};
 
-		/* Used only by kernel MRs (umem == NULL) */
+		/* Used only by kernel MRs */
 		struct {
 			void *descs;
 			void *descs_alloc;
@@ -697,8 +696,9 @@ struct mlx5_ib_mr {
 			int data_length;
 		};
 
-		/* Used only by User MRs (umem != NULL) */
+		/* Used only by User MRs */
 		struct {
+			struct ib_umem *umem;
 			unsigned int page_shift;
 			/* Current access_flags */
 			int access_flags;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 157d862fb864..63e2129f1142 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1904,19 +1904,18 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 	return ret;
 }
 
-static void
-mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
+static void mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 {
-	if (!mr->umem && mr->descs) {
-		struct ib_device *device = mr->ibmr.device;
-		int size = mr->max_descs * mr->desc_size;
-		struct mlx5_ib_dev *dev = to_mdev(device);
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	int size = mr->max_descs * mr->desc_size;
 
-		dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
-				 DMA_TO_DEVICE);
-		kfree(mr->descs_alloc);
-		mr->descs = NULL;
-	}
+	if (!mr->descs)
+		return;
+
+	dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
+			 DMA_TO_DEVICE);
+	kfree(mr->descs_alloc);
+	mr->descs = NULL;
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
@@ -1992,7 +1991,8 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (mr->cache_ent) {
 		mlx5_mr_cache_free(dev, mr);
 	} else {
-		mlx5_free_priv_descs(mr);
+		if (!udata)
+			mlx5_free_priv_descs(mr);
 		kfree(mr);
 	}
 	return 0;
@@ -2079,7 +2079,6 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	if (err)
 		goto err_free_in;
 
-	mr->umem = NULL;
 	kfree(in);
 
 	return mr;
@@ -2206,7 +2205,6 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 	}
 
 	mr->ibmr.device = pd->device;
-	mr->umem = NULL;
 
 	switch (mr_type) {
 	case IB_MR_TYPE_MEM_REG:
-- 
2.33.1

