Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6A92206
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfHSLR7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfHSLR7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:59 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568F22087B;
        Mon, 19 Aug 2019 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213479;
        bh=kfH6SGTaSxNfI2d4IeDbLimhCVud6dopTWhxTGTvFkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LENo9HGoTDVSpo+NgMc7AKUO/fe+5MgOu+lC/nfcLwQgiJ3WMjmz0Q1R0G/T3VHEV
         p9ZGvmBRVGmA+rQZyX6DViJqBhdEjqTS/p33JSKoh0OLgD6FD3PY5cHTfDWmUe2oiz
         x/XpAPRo0vqrSbaDuZXl+GoqeMS/7t6oto47tvnY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 10/12] RDMA/core: Make invalidate_range a device operation
Date:   Mon, 19 Aug 2019 14:17:08 +0300
Message-Id: <20190819111710.18440-11-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

The callback function 'invalidate_range' is implemented in a driver so the
place for it is in the ib_device_ops structure and not in ib_ucontext.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Guy Levi <guyle@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c     |  1 +
 drivers/infiniband/core/umem_odp.c   | 10 +++++-----
 drivers/infiniband/core/uverbs_cmd.c |  2 --
 drivers/infiniband/hw/mlx5/main.c    |  4 ----
 drivers/infiniband/hw/mlx5/odp.c     |  1 +
 include/rdma/ib_verbs.h              |  4 ++--
 6 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8892862fb759..6e284963741e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2582,6 +2582,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, get_vf_config);
 	SET_DEVICE_OP(dev_ops, get_vf_stats);
 	SET_DEVICE_OP(dev_ops, init_port);
+	SET_DEVICE_OP(dev_ops, invalidate_range);
 	SET_DEVICE_OP(dev_ops, iw_accept);
 	SET_DEVICE_OP(dev_ops, iw_add_ref);
 	SET_DEVICE_OP(dev_ops, iw_connect);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index f1b298575b4c..09c0c585b2e7 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -103,7 +103,7 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
 		 */
 		smp_wmb();
 		complete_all(&umem_odp->notifier_completion);
-		umem_odp->umem.context->invalidate_range(
+		umem_odp->umem.context->device->ops.invalidate_range(
 			umem_odp, ib_umem_start(umem_odp),
 			ib_umem_end(umem_odp));
 	}
@@ -116,7 +116,7 @@ static int invalidate_range_start_trampoline(struct ib_umem_odp *item,
 					     u64 start, u64 end, void *cookie)
 {
 	ib_umem_notifier_start_account(item);
-	item->umem.context->invalidate_range(item, start, end);
+	item->umem.context->device->ops.invalidate_range(item, start, end);
 	return 0;
 }
 
@@ -392,7 +392,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 
 	if (!context)
 		return ERR_PTR(-EIO);
-	if (WARN_ON_ONCE(!context->invalidate_range))
+	if (WARN_ON_ONCE(!context->device->ops.invalidate_range))
 		return ERR_PTR(-EINVAL);
 
 	umem_odp = kzalloc(sizeof(*umem_odp), GFP_KERNEL);
@@ -486,7 +486,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 		return ERR_PTR(-EIO);
 
 	if (WARN_ON_ONCE(!(access & IB_ACCESS_ON_DEMAND)) ||
-	    WARN_ON_ONCE(!context->invalidate_range))
+	    WARN_ON_ONCE(!context->device->ops.invalidate_range))
 		return ERR_PTR(-EINVAL);
 
 	umem_odp = kzalloc(sizeof(struct ib_umem_odp), GFP_KERNEL);
@@ -614,7 +614,7 @@ static int ib_umem_odp_map_dma_single_page(
 
 	if (remove_existing_mapping) {
 		ib_umem_notifier_start_account(umem_odp);
-		context->invalidate_range(
+		dev->ops.invalidate_range(
 			umem_odp,
 			ib_umem_start(umem_odp) +
 				(page_index << umem_odp->page_shift),
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 7ddd0e5bc6b3..8f4fd4fac159 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -275,8 +275,6 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 	ret = ib_dev->ops.alloc_ucontext(ucontext, &attrs->driver_udata);
 	if (ret)
 		goto err_file;
-	if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING))
-		ucontext->invalidate_range = NULL;
 
 	rdma_restrack_uadd(&ucontext->res);
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 98e566acb746..08020affdc17 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1867,10 +1867,6 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	if (err)
 		goto out_sys_pages;
 
-	if (ibdev->attrs.device_cap_flags & IB_DEVICE_ON_DEMAND_PAGING)
-		context->ibucontext.invalidate_range =
-			&mlx5_ib_invalidate_range;
-
 	if (req.flags & MLX5_IB_ALLOC_UCTX_DEVX) {
 		err = mlx5_ib_devx_create(dev, true);
 		if (err < 0)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index ad5d5f2c8509..c755c76729bc 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1594,6 +1594,7 @@ void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent)
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
 	.advise_mr = mlx5_ib_advise_mr,
+	.invalidate_range = mlx5_ib_invalidate_range,
 };
 
 int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 391499008a22..18a34888bbca 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1469,8 +1469,6 @@ struct ib_ucontext {
 
 	bool cleanup_retryable;
 
-	void (*invalidate_range)(struct ib_umem_odp *umem_odp,
-				 unsigned long start, unsigned long end);
 	struct mutex per_mm_list_lock;
 	struct list_head per_mm_list;
 
@@ -2430,6 +2428,8 @@ struct ib_device_ops {
 			    u64 iova);
 	int (*unmap_fmr)(struct list_head *fmr_list);
 	int (*dealloc_fmr)(struct ib_fmr *fmr);
+	void (*invalidate_range)(struct ib_umem_odp *umem_odp,
+				 unsigned long start, unsigned long end);
 	int (*attach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	int (*detach_mcast)(struct ib_qp *qp, union ib_gid *gid, u16 lid);
 	struct ib_xrcd *(*alloc_xrcd)(struct ib_device *device,
-- 
2.20.1

