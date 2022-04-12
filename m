Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96EB4FDA8C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbiDLJ53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359467AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8A5F4A
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F97A614FA
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB00C385A5;
        Tue, 12 Apr 2022 07:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748293;
        bh=LhDttNcXH6lsMRSKakIGSYBL2KLGatG7vB79OYwzqv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbQRMyA2gczj4+I1gnuW8+vFNMKZlNUzBmIQ67nHMLDXLCr89rU8/drZc68XzKY83
         BzynHG6Ua+UdyKCJRbH0ODJEOYbvd4WuNefDvu7g2CgKuC6jaqZy2mJEf6KeIYZna/
         tlCtZPY4HywRmame4IxyxetNypXd56mwzRYYh1qavZlaba9l0tZI+z98/Ky8qwCKAB
         VsqcDdKrn2D3UpMCIPJge4Pi9G90UeYYEOFSzd8g7gbgwbTkkV5TGRpXdHbVWrm59L
         CcoftT5vdtug+CwExBrwgRV642ncK81el2GcCwu6fmQfRqy1cJ6L/JSbInKNnr/whC
         7Dy0R8IW8f4YA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 08/12] RDMA/mlx5: Use mlx5_umr_post_send_wait() to rereg pd access
Date:   Tue, 12 Apr 2022 10:24:03 +0300
Message-Id: <18da4f47edbc2561f652b7ee4e7a5269e866af77.1649747695.git.leonro@nvidia.com>
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

Move rereg_pd_access logic to umr.c, and use mlx5_umr_post_send_wait()
instead of mlx5_ib_post_send_wait().

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c  | 27 ++-------------------
 drivers/infiniband/hw/mlx5/umr.c | 41 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h |  2 ++
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 32ad93e69a89..50b4ccd38fe2 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1646,30 +1646,6 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 				      target_access_flags);
 }
 
-static int umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
-			       int access_flags)
-{
-	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
-	struct mlx5_umr_wr umrwr = {
-		.wr = {
-			.send_flags = MLX5_IB_SEND_UMR_FAIL_IF_FREE |
-				      MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS,
-			.opcode = MLX5_IB_WR_UMR,
-		},
-		.mkey = mr->mmkey.key,
-		.pd = pd,
-		.access_flags = access_flags,
-	};
-	int err;
-
-	err = mlx5_ib_post_send_wait(dev, &umrwr);
-	if (err)
-		return err;
-
-	mr->access_flags = access_flags;
-	return 0;
-}
-
 static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 				  struct ib_umem *new_umem,
 				  int new_access_flags, u64 iova,
@@ -1770,7 +1746,8 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		/* Fast path for PD/access change */
 		if (can_use_umr_rereg_access(dev, mr->access_flags,
 					     new_access_flags)) {
-			err = umr_rereg_pd_access(mr, new_pd, new_access_flags);
+			err = mlx5r_umr_rereg_pd_access(mr, new_pd,
+							new_access_flags);
 			if (err)
 				return ERR_PTR(err);
 			return NULL;
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 2f14f6ccf9da..716c35258e33 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -349,3 +349,44 @@ int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr)
 
 	return mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, false);
 }
+
+static void mlx5r_umr_set_access_flags(struct mlx5_ib_dev *dev,
+				       struct mlx5_mkey_seg *seg,
+				       unsigned int access_flags)
+{
+	MLX5_SET(mkc, seg, a, !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
+	MLX5_SET(mkc, seg, rw, !!(access_flags & IB_ACCESS_REMOTE_WRITE));
+	MLX5_SET(mkc, seg, rr, !!(access_flags & IB_ACCESS_REMOTE_READ));
+	MLX5_SET(mkc, seg, lw, !!(access_flags & IB_ACCESS_LOCAL_WRITE));
+	MLX5_SET(mkc, seg, lr, 1);
+	MLX5_SET(mkc, seg, relaxed_ordering_write,
+		 !!(access_flags & IB_ACCESS_RELAXED_ORDERING));
+	MLX5_SET(mkc, seg, relaxed_ordering_read,
+		 !!(access_flags & IB_ACCESS_RELAXED_ORDERING));
+}
+
+int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
+			      int access_flags)
+{
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	struct mlx5r_umr_wqe wqe = {};
+	int err;
+
+	wqe.ctrl_seg.mkey_mask = get_umr_update_access_mask(dev);
+	wqe.ctrl_seg.mkey_mask |= get_umr_update_pd_mask();
+	wqe.ctrl_seg.flags = MLX5_UMR_CHECK_FREE;
+	wqe.ctrl_seg.flags |= MLX5_UMR_INLINE;
+
+	mlx5r_umr_set_access_flags(dev, &wqe.mkey_seg, access_flags);
+	MLX5_SET(mkc, &wqe.mkey_seg, pd, to_mpd(pd)->pdn);
+	MLX5_SET(mkc, &wqe.mkey_seg, qpn, 0xffffff);
+	MLX5_SET(mkc, &wqe.mkey_seg, mkey_7_0,
+		 mlx5_mkey_variant(mr->mmkey.key));
+
+	err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, false);
+	if (err)
+		return err;
+
+	mr->access_flags = access_flags;
+	return 0;
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index c14072b06ffb..53816316cb1f 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -92,5 +92,7 @@ struct mlx5r_umr_wqe {
 };
 
 int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr);
+int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
+			      int access_flags);
 
 #endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

