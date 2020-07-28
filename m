Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D11230983
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgG1MDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 08:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgG1MDC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 08:03:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CFE206D8;
        Tue, 28 Jul 2020 12:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595937781;
        bh=qIsFchhcG/XdESV0a8BeXSyjYDbqGWnaNtKK5a4ruMc=;
        h=From:To:Cc:Subject:Date:From;
        b=Cut9HncVU9PbzZWrCzCIAdk8da10gCZg/MSHL/f5zGin8984Sz7m03uTw54o1aus+
         RRbKf8XSycMH867yCjyOqBcRJwVp8ZPEwkKwZT7sEr1YefDx6iwU8hNGlIsZCt1pRf
         BJtcWb8SdYVB24w86VsKB5rTnIc4JGVnSwIa3XO0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Allow providing extra scatter CQE QP flag
Date:   Tue, 28 Jul 2020 15:02:55 +0300
Message-Id: <20200728120255.805733-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Scatter CQE feature relies on two flags MLX5_QP_FLAG_SCATTER_CQE and
MLX5_QP_FLAG_ALLOW_SCATTER_CQE, both of them can be provided without
relation to device capability.

Relax global validity check to allow MLX5_QP_FLAG_ALLOW_SCATTER_CQE QP
flag.

Fixes: 90ecb37a751b ("RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags")
Fixes: 37518fa49f76 ("RDMA/mlx5: Process all vendor flags in one place")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e050eade97a1..42620f88e393 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1766,15 +1766,14 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 }
 
 static void configure_requester_scat_cqe(struct mlx5_ib_dev *dev,
+					 struct mlx5_ib_qp *qp,
 					 struct ib_qp_init_attr *init_attr,
-					 struct mlx5_ib_create_qp *ucmd,
 					 void *qpc)
 {
 	int scqe_sz;
 	bool allow_scat_cqe = false;
 
-	if (ucmd)
-		allow_scat_cqe = ucmd->flags & MLX5_QP_FLAG_ALLOW_SCATTER_CQE;
+	allow_scat_cqe = qp->flags_en & MLX5_QP_FLAG_ALLOW_SCATTER_CQE;
 
 	if (!allow_scat_cqe && init_attr->sq_sig_type != IB_SIGNAL_ALL_WR)
 		return;
@@ -2012,7 +2011,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 	if ((qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) &&
 	    (qp->type == MLX5_IB_QPT_DCI || qp->type == IB_QPT_RC))
-		configure_requester_scat_cqe(dev, init_attr, ucmd, qpc);
+		configure_requester_scat_cqe(dev, qp, init_attr, qpc);
 
 	if (qp->rq.wqe_cnt) {
 		MLX5_SET(qpc, qpc, log_rq_stride, qp->rq.wqe_shift - 4);
@@ -2543,13 +2542,18 @@ static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 		return;
 	}
 
-	if (flag == MLX5_QP_FLAG_SCATTER_CQE) {
+	switch (flag) {
+	case MLX5_QP_FLAG_SCATTER_CQE:
+	case MLX5_QP_FLAG_ALLOW_SCATTER_CQE:
 		/*
-		 * We don't return error if this flag was provided,
-		 * and mlx5 doesn't have right capability.
-		 */
-		*flags &= ~MLX5_QP_FLAG_SCATTER_CQE;
+			 * We don't return error if these flags were provided,
+			 * and mlx5 doesn't have right capability.
+			 */
+		*flags &= ~(MLX5_QP_FLAG_SCATTER_CQE |
+			    MLX5_QP_FLAG_ALLOW_SCATTER_CQE);
 		return;
+	default:
+		break;
 	}
 	mlx5_ib_dbg(dev, "Vendor create QP flag 0x%X is not supported\n", flag);
 }
@@ -2589,6 +2593,8 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_SIGNATURE, true, qp);
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_SCATTER_CQE,
 			    MLX5_CAP_GEN(mdev, sctr_data_cqe), qp);
+	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_ALLOW_SCATTER_CQE,
+			    MLX5_CAP_GEN(mdev, sctr_data_cqe), qp);
 
 	if (qp->type == IB_QPT_RAW_PACKET) {
 		cond = MLX5_CAP_ETH(mdev, tunnel_stateless_vxlan) ||
-- 
2.26.2

