Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74966576B5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Dec 2022 13:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiL1M41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Dec 2022 07:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiL1M40 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Dec 2022 07:56:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372E269
        for <linux-rdma@vger.kernel.org>; Wed, 28 Dec 2022 04:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC03A61338
        for <linux-rdma@vger.kernel.org>; Wed, 28 Dec 2022 12:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BAAC433D2;
        Wed, 28 Dec 2022 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672232184;
        bh=wDn8EhNIwORWzFs0i7uTZO6hM8H/dY6NTwlrZAfVtM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNNXT98YPeFKaDL5vARMfSiE4WZIOoZZs0wTZvwkl6Krfq7Zy6qDCcZRieC1HoMu+
         +xSQtuQt44wCpKppTTtwoShzXhXDXMKPxPE9b3CSWM6L/iXrb5WRmwCXCrJTiAKNPC
         dNOy5MUDk7fCgrO8cRG0xzBtGHw54nLQBJoosAS4nxuH0M1Ium/CiebwSLlMO0WHaT
         Kio4hY4qxTesQkO3GzZv6r6FhwEwa6uJNMV1G8WS4vPWEwqsChSRVB6D9iGEAgTt1v
         3jA/J9l18cYCLgx7qEwuEDAveaTzilrRGqWREGzlhmkBRegDFdFBai8FxiNfF2qU0A
         vqOYo7Z4rag5Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        Patrisious Haddad <phaddad@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH RESEND rdma-next 2/2] RDMA/mlx5: Fix validation of max_rd_atomic caps for DC
Date:   Wed, 28 Dec 2022 14:56:10 +0200
Message-Id: <0c5aee72cea188c3bb770f4207cce7abc9b6fc74.1672231736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672231736.git.leonro@nvidia.com>
References: <cover.1672231736.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Currently, when modifying DC, we validate max_rd_atomic
user attribute against the RC cap, fix it to validate against DC.

Fixes: c32a4f296e1d ("IB/mlx5: Add support for DC Initiator QP")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Link: https://lore.kernel.org/r/193aa04bce4609df7d86250da3e2886f26f266cf.1670749789.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 49 +++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 40d9410ec303..cf953d23d18d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4502,6 +4502,40 @@ static bool mlx5_ib_modify_qp_allowed(struct mlx5_ib_dev *dev,
 	return false;
 }
 
+static int validate_rd_atomic(struct mlx5_ib_dev *dev, struct ib_qp_attr *attr,
+			      int attr_mask, enum ib_qp_type qp_type)
+{
+	int log_max_ra_res;
+	int log_max_ra_req;
+
+	if (qp_type == MLX5_IB_QPT_DCI) {
+		log_max_ra_res = 1 << MLX5_CAP_GEN(dev->mdev,
+						   log_max_ra_res_dc);
+		log_max_ra_req = 1 << MLX5_CAP_GEN(dev->mdev,
+						   log_max_ra_req_dc);
+	} else {
+		log_max_ra_res = 1 << MLX5_CAP_GEN(dev->mdev,
+						   log_max_ra_res_qp);
+		log_max_ra_req = 1 << MLX5_CAP_GEN(dev->mdev,
+						   log_max_ra_req_qp);
+	}
+
+	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
+	    attr->max_rd_atomic > log_max_ra_res) {
+		mlx5_ib_dbg(dev, "invalid max_rd_atomic value %d\n",
+			    attr->max_rd_atomic);
+		return false;
+	}
+
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
+	    attr->max_dest_rd_atomic > log_max_ra_req) {
+		mlx5_ib_dbg(dev, "invalid max_dest_rd_atomic value %d\n",
+			    attr->max_dest_rd_atomic);
+		return false;
+	}
+	return true;
+}
+
 int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		      int attr_mask, struct ib_udata *udata)
 {
@@ -4589,21 +4623,8 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		goto out;
 	}
 
-	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
-	    attr->max_rd_atomic >
-	    (1 << MLX5_CAP_GEN(dev->mdev, log_max_ra_res_qp))) {
-		mlx5_ib_dbg(dev, "invalid max_rd_atomic value %d\n",
-			    attr->max_rd_atomic);
-		goto out;
-	}
-
-	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
-	    attr->max_dest_rd_atomic >
-	    (1 << MLX5_CAP_GEN(dev->mdev, log_max_ra_req_qp))) {
-		mlx5_ib_dbg(dev, "invalid max_dest_rd_atomic value %d\n",
-			    attr->max_dest_rd_atomic);
+	if (!validate_rd_atomic(dev, attr, attr_mask, qp_type))
 		goto out;
-	}
 
 	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
 		err = 0;
-- 
2.38.1

