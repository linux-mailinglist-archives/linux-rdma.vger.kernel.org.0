Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F254FD43F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351883AbiDLJ5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359460AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF4101CD
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C51614FA
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4BC385A8;
        Tue, 12 Apr 2022 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748270;
        bh=Muqpk4Fcp0WQRAnx75LoJTRA+xN2K9Ew1aGqdx4UkT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9XpOrblqVhEwvM8caHSUsYXjDmHZTKOHsIjAY596rWkOy9fo716PabspbN96+dGQ
         T/PGtAyrebIrkm0jw7XZGttZtf0Q5GEBRxphkhSi2p3ajrB6GyqKpwXgzEBLcXkkTq
         rN6Kn2WElXzwXZ4NbGqWDLwpHQDAZISDzbEK/uOBD+asvxq+Q7+HdHa9ufyO0WlF/M
         Q/+qk+jfZcP4i1Fvj0fYH265MYjOT3BiB5XA2chbBFBqdV4ITJjk2un0fqMtV68KLB
         jt29wxPU+E9Yv9QRFL3k+1wlAce4VyRF4NAs2KeWbseYnZv3g+clygVt5AyerJ4Pr5
         jbJuLBq85PDdQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 04/12] RDMA/mlx5: Simplify get_umr_update_access_mask()
Date:   Tue, 12 Apr 2022 10:23:59 +0300
Message-Id: <f22b8a84ef32e29ada26691f06b57e2ed5943b76.1649747695.git.leonro@nvidia.com>
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

Instead of getting the update access capabilities each call to
get_umr_update_access_mask(), pass struct mlx5_ib_dev and get the
capabilities inside the function.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index d3626a9dc8ab..8131501dc052 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -34,9 +34,7 @@ static __be64 get_umr_update_translation_mask(void)
 	return cpu_to_be64(result);
 }
 
-static __be64 get_umr_update_access_mask(int atomic,
-					 int relaxed_ordering_write,
-					 int relaxed_ordering_read)
+static __be64 get_umr_update_access_mask(struct mlx5_ib_dev *dev)
 {
 	u64 result;
 
@@ -45,13 +43,13 @@ static __be64 get_umr_update_access_mask(int atomic,
 		 MLX5_MKEY_MASK_RR |
 		 MLX5_MKEY_MASK_RW;
 
-	if (atomic)
+	if (MLX5_CAP_GEN(dev->mdev, atomic))
 		result |= MLX5_MKEY_MASK_A;
 
-	if (relaxed_ordering_write)
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
 		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_WRITE;
 
-	if (relaxed_ordering_read)
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
 		result |= MLX5_MKEY_MASK_RELAXED_ORDERING_READ;
 
 	return cpu_to_be64(result);
@@ -116,10 +114,7 @@ int mlx5r_umr_set_umr_ctrl_seg(struct mlx5_ib_dev *dev,
 	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_TRANSLATION)
 		umr->mkey_mask |= get_umr_update_translation_mask();
 	if (wr->send_flags & MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS) {
-		umr->mkey_mask |= get_umr_update_access_mask(
-			!!MLX5_CAP_GEN(dev->mdev, atomic),
-			!!MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr),
-			!!MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr));
+		umr->mkey_mask |= get_umr_update_access_mask(dev);
 		umr->mkey_mask |= get_umr_update_pd_mask();
 	}
 	if (wr->send_flags & MLX5_IB_SEND_UMR_ENABLE_MR)
-- 
2.35.1

