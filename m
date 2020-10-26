Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E892C298DB8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbgJZNWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776791AbgJZNTu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:19:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F2022263;
        Mon, 26 Oct 2020 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718389;
        bh=skuxtExF0xcEEcMrbTkcb9u3rzu/nUPrLyLn8uEpTsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHxeUCx60ou6HhoSQpFAeQ+/edAWQTh/ajFj9O/TxV3+CO9xLP8Bo2Zy7C3Z2+C7J
         y/rNbnv4rv+zncSOGwczGVSclOv0xjPG6nl8ANXaRzcZsTAsw6+VbktNr4Kr27cKLQ
         PeTlQ/jDAdM3OoJ6tw9+pxHhOrahkw+U7WUb2cIQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/7] RDMA/mlx5: Remove mlx5_ib_mr->npages
Date:   Mon, 26 Oct 2020 15:19:32 +0200
Message-Id: <20201026131936.1335664-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
References: <20201026131936.1335664-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is the same value as ib_umem_num_pages(mr->umem), use that instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 93310dda01b6..0eaf992a4e15 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -602,7 +602,6 @@ struct mlx5_ib_mr {
 	struct mlx5_shared_mr_info	*smr_info;
 	struct list_head	list;
 	struct mlx5_cache_ent  *cache_ent;
-	int			npages;
 	struct mlx5_ib_dev     *dev;
 	u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
 	struct mlx5_core_sig_ctx    *sig;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 769c5ae4894a..c76134219bf2 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1418,8 +1418,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
 
 	mr->umem = umem;
-	mr->npages = npages;
-	atomic_add(mr->npages, &dev->mdev->priv.reg_pages);
+	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
 	set_mr_fields(dev, mr, length, access_flags);
 
 	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
@@ -1552,8 +1551,8 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		 * used.
 		 */
 		flags |= IB_MR_REREG_TRANS;
-		atomic_sub(mr->npages, &dev->mdev->priv.reg_pages);
-		mr->npages = 0;
+		atomic_sub(ib_umem_num_pages(mr->umem),
+			   &dev->mdev->priv.reg_pages);
 		ib_umem_release(mr->umem);
 		mr->umem = NULL;
 
@@ -1561,8 +1560,8 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 				  &npages, &page_shift, &ncont, &order);
 		if (err)
 			goto err;
-		mr->npages = ncont;
-		atomic_add(mr->npages, &dev->mdev->priv.reg_pages);
+		atomic_add(ib_umem_num_pages(mr->umem),
+			   &dev->mdev->priv.reg_pages);
 	}
 
 	if (!mlx5_ib_can_reconfig_with_umr(dev, mr->access_flags,
@@ -1695,23 +1694,26 @@ static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	int npages = mr->npages;
 	struct ib_umem *umem = mr->umem;
+	bool is_odp = is_odp_mr(mr);
 
 	/* Stop all DMA */
-	if (is_odp_mr(mr))
+	if (is_odp)
 		mlx5_ib_fence_odp_mr(mr);
 	else
 		clean_mr(dev, mr);
 
+	if (umem) {
+		if (!is_odp)
+			atomic_sub(ib_umem_num_pages(umem),
+				   &dev->mdev->priv.reg_pages);
+		ib_umem_release(umem);
+	}
+
 	if (mr->cache_ent)
 		mlx5_mr_cache_free(dev, mr);
 	else
 		kfree(mr);
-
-	ib_umem_release(umem);
-	atomic_sub(npages, &dev->mdev->priv.reg_pages);
-
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-- 
2.26.2

