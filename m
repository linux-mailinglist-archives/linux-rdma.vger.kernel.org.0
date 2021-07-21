Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47743D08B4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhGUFfx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233088AbhGUFcr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:32:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6679B6113C;
        Wed, 21 Jul 2021 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626848002;
        bh=5J+jBturQ/bt30k9Ss/DG7LeflH8jrxgH/e5dbAPOps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PK7ouXDOo62W01D6sVbVnrS2pT16/qoA962+b1M3VzX84/biS5+F7632/Zs1h8iPh
         TrSSLTuAXBRCqWY00foAkH1pW9Sczs7UYhR3PotNgSITjp+Ey73o9vR5Nz7keDwWTy
         d/A0NVk5IWfC+0Pr5kLtP2aEyRl5RJtkqUEL1wOYsstXVwHgFh6GTQWtwwuH9Wdzkc
         hr9SSxtZ4+mSTcDxJuiiPI6s+qDqZ4Mk8PL7wTGQLXgHmTYHQXTRTeNM/HXVvXNBht
         KAOxHyah6kz1r1kRkeacEIm4/wRtzewSqfcj1okMYqCKOwyQCjCBdHDcXdECPJBnqA
         QVMS5pE/74DHg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 1/7] RDMA/mlx5: Delete not-available udata check
Date:   Wed, 21 Jul 2021 09:13:00 +0300
Message-Id: <1c60391dd1a45130343675bc2c15a8239c217f5b.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626846795.git.leonro@nvidia.com>
References: <cover.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

XRC_TGT QPs are created through kernel verbs and don't have udata at all.

Fixes: 6eefa839c4dd ("RDMA/mlx5: Protect from kernel crash if XRC_TGT doesn't have udata")
Fixes: e383085c2425 ("RDMA/mlx5: Set ECE options during QP create")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 18b018f1db83..81e3170a1ae6 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1908,7 +1908,6 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			     struct mlx5_create_qp_params *params)
 {
-	struct mlx5_ib_create_qp *ucmd = params->ucmd;
 	struct ib_qp_init_attr *attr = params->attr;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
@@ -1928,8 +1927,6 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (!in)
 		return -ENOMEM;
 
-	if (MLX5_CAP_GEN(mdev, ece_support) && ucmd)
-		MLX5_SET(create_qp_in, in, ece, ucmd->ece_options);
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
 	MLX5_SET(qpc, qpc, st, MLX5_QP_ST_XRC);
-- 
2.31.1

