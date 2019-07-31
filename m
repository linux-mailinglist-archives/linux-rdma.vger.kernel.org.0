Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C27BB66
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGaITf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 04:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfGaITe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 04:19:34 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E7A20693;
        Wed, 31 Jul 2019 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564561173;
        bh=EDAItAnXUXzpf343tx8YcqrLWjH+JxgWHiGM/wmWVe8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZjqU320AcLh4/XRk39Y2oYhvjyX6iwLbDgAT/Uq+EIl1j11XRSXvCtsZMyCUErUX3
         iftbmCL5/Ekz701kwIhns+zVGuxLYn5kczo8BrcntG3WBm+edc2Z3DHi1S7uZIzi+S
         az1e//Bol7Tg6VtBr+IHZw9a3bAtIoWeJdAc2pqM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Guy Levi <guyle@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] IB/mlx5: Fix MR registration flow to use UMR properly
Date:   Wed, 31 Jul 2019 11:19:29 +0300
Message-Id: <20190731081929.32559-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guy Levi <guyle@mellanox.com>

Driver shouldn't allow to use UMR to register a MR when
umr_modify_atomic_disabled is set. Otherwise it will always end up with a
failure in the post send flow which sets the UMR WQE to modify atomic access
right.

Fixes: c8d75a980fab ("IB/mlx5: Respect new UMR capabilities")
Signed-off-by: Guy Levi <guyle@mellanox.com>
Reviewed-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2c77456f359f..b74fad08412f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -51,22 +51,12 @@ static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static int mr_cache_max_order(struct mlx5_ib_dev *dev);
 static int unreg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
-static bool umr_can_modify_entity_size(struct mlx5_ib_dev *dev)
-{
-	return !MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled);
-}
 
 static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
 {
 	return !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled);
 }
 
-static bool use_umr(struct mlx5_ib_dev *dev, int order)
-{
-	return order <= mr_cache_max_order(dev) &&
-		umr_can_modify_entity_size(dev);
-}
-
 static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	int err = mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
@@ -1271,7 +1261,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr = NULL;
-	bool populate_mtts = false;
+	bool use_umr;
 	struct ib_umem *umem;
 	int page_shift;
 	int npages;
@@ -1303,29 +1293,30 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	if (use_umr(dev, order)) {
+	use_umr = !MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled) &&
+		  (!MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled) ||
+		   !MLX5_CAP_GEN(dev->mdev, atomic));
+
+	if (order <= mr_cache_max_order(dev) && use_umr) {
 		mr = alloc_mr_from_cache(pd, umem, virt_addr, length, ncont,
 					 page_shift, order, access_flags);
 		if (PTR_ERR(mr) == -EAGAIN) {
 			mlx5_ib_dbg(dev, "cache empty for order %d\n", order);
 			mr = NULL;
 		}
-		populate_mtts = false;
 	} else if (!MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset)) {
 		if (access_flags & IB_ACCESS_ON_DEMAND) {
 			err = -EINVAL;
 			pr_err("Got MR registration for ODP MR > 512MB, not supported for Connect-IB\n");
 			goto error;
 		}
-		populate_mtts = true;
+		use_umr = false;
 	}
 
 	if (!mr) {
-		if (!umr_can_modify_entity_size(dev))
-			populate_mtts = true;
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(NULL, pd, virt_addr, length, umem, ncont,
-				page_shift, access_flags, populate_mtts);
+				page_shift, access_flags, !use_umr);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 
@@ -1341,7 +1332,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	update_odp_mr(mr);
 
-	if (!populate_mtts) {
+	if (use_umr) {
 		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
 
 		if (access_flags & IB_ACCESS_ON_DEMAND)
-- 
2.20.1

