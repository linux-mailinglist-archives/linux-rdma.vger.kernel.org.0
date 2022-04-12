Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8374FDB0A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbiDLJ5T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359462AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDF12AE2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48639615B4
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D35FC385A6;
        Tue, 12 Apr 2022 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748277;
        bh=CxGgkv+CN8qmVT9z/k/Q06lGgwTEIg+2ZPL7IEkoPpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gy6vGHUwXO7aeeNbbOxmgbPUsaRfrTuXgYqZqr33AbWeEB8FRH8shwgpkua3si497
         XG27mrQJQxFt0iNJesZAt0Y3glguSQ8i7C8sy+Ty+p/cIjnvXbjfmusqjvuySPgELC
         JSpdFE0pxa/Bn364ZS8kKNftA3s3marLRER/rbELEctA77G+A76dBL/cOK9yQIK0HT
         o2M+e2eWC3PJnPloj27aC3ACNESxgdzoQASteD6knOWNQzE2y/Ab4/LbLMduNt9J4w
         ZMemhFnX3TzygtIYwNctYRwVqstx0vYXptZBWxUkysHTlWPYCohXXdaBQwWyaGJc6h
         UdLUq1PWgFIQg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 07/12] RDMA/mlx5: Use mlx5_umr_post_send_wait() to revoke MRs
Date:   Tue, 12 Apr 2022 10:24:02 +0300
Message-Id: <63717dfdaf6007f81b3e6dbf598f5bf3875ce86f.1649747695.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Move the revoke_mr logic to umr.c, and using mlx5_umr_post_send_wait()
instead of mlx5_ib_post_send_wait().

In the new implementation, do not zero out the access flags. Before
reusing the MR, we will update it to the required access.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c  | 31 +++----------------------------
 drivers/infiniband/hw/mlx5/umr.c | 29 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h |  2 ++
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6d87a93e03db..32ad93e69a89 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1629,31 +1629,6 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 	return ERR_PTR(err);
 }
 
-/**
- * revoke_mr - Fence all DMA on the MR
- * @mr: The MR to fence
- *
- * Upon return the NIC will not be doing any DMA to the pages under the MR,
- * and any DMA in progress will be completed. Failure of this function
- * indicates the HW has failed catastrophically.
- */
-static int revoke_mr(struct mlx5_ib_mr *mr)
-{
-	struct mlx5_umr_wr umrwr = {};
-
-	if (mr_to_mdev(mr)->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
-		return 0;
-
-	umrwr.wr.send_flags = MLX5_IB_SEND_UMR_DISABLE_MR |
-			      MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS;
-	umrwr.wr.opcode = MLX5_IB_WR_UMR;
-	umrwr.pd = mr_to_mdev(mr)->umrc.pd;
-	umrwr.mkey = mr->mmkey.key;
-	umrwr.ignore_free_state = 1;
-
-	return mlx5_ib_post_send_wait(mr_to_mdev(mr), &umrwr);
-}
-
 /*
  * True if the change in access flags can be done via UMR, only some access
  * flags can be updated.
@@ -1730,7 +1705,7 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	 * with it. This ensure the change is atomic relative to any use of the
 	 * MR.
 	 */
-	err = revoke_mr(mr);
+	err = mlx5r_umr_revoke_mr(mr);
 	if (err)
 		return err;
 
@@ -1808,7 +1783,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		 * Only one active MR can refer to a umem at one time, revoke
 		 * the old MR before assigning the umem to the new one.
 		 */
-		err = revoke_mr(mr);
+		err = mlx5r_umr_revoke_mr(mr);
 		if (err)
 			return ERR_PTR(err);
 		umem = mr->umem;
@@ -1953,7 +1928,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	/* Stop DMA */
 	if (mr->cache_ent) {
-		if (revoke_mr(mr)) {
+		if (mlx5r_umr_revoke_mr(mr)) {
 			spin_lock_irq(&mr->cache_ent->lock);
 			mr->cache_ent->total_mrs--;
 			spin_unlock_irq(&mr->cache_ent->lock);
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index f17f64cb1925..2f14f6ccf9da 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -320,3 +320,32 @@ static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
 	up(&umrc->sem);
 	return err;
 }
+
+/**
+ * mlx5r_umr_revoke_mr - Fence all DMA on the MR
+ * @mr: The MR to fence
+ *
+ * Upon return the NIC will not be doing any DMA to the pages under the MR,
+ * and any DMA in progress will be completed. Failure of this function
+ * indicates the HW has failed catastrophically.
+ */
+int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr)
+{
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	struct mlx5r_umr_wqe wqe = {};
+
+	if (dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return 0;
+
+	wqe.ctrl_seg.mkey_mask |= get_umr_update_pd_mask();
+	wqe.ctrl_seg.mkey_mask |= get_umr_disable_mr_mask();
+	wqe.ctrl_seg.flags |= MLX5_UMR_INLINE;
+
+	MLX5_SET(mkc, &wqe.mkey_seg, free, 1);
+	MLX5_SET(mkc, &wqe.mkey_seg, pd, to_mpd(dev->umrc.pd)->pdn);
+	MLX5_SET(mkc, &wqe.mkey_seg, qpn, 0xffffff);
+	MLX5_SET(mkc, &wqe.mkey_seg, mkey_7_0,
+		 mlx5_mkey_variant(mr->mmkey.key));
+
+	return mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, false);
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index d984213caf60..c14072b06ffb 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -91,4 +91,6 @@ struct mlx5r_umr_wqe {
 	struct mlx5_wqe_data_seg data_seg;
 };
 
+int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr);
+
 #endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

