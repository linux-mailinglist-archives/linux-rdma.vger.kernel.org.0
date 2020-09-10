Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2126531F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgIJV2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbgIJODj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:03:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299A3221E5;
        Thu, 10 Sep 2020 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746475;
        bh=k5fO+zGKRH6jYEEH3rMPYhLlk2cBek2z5u5BqlL4MEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gx3KXLx0wHNAmEtrUE5GDDW/syedd1qfM+muLr7I6MB2S/t+uJgfL8y9XB3v7PBCv
         4XGGic91Iul8Y9Reg6KRe6ez2/dUl0NgWDv5xxIC87NsRYXC4Ar25zfs8kWjZ3eMnL
         P0W+XdTN3ddvOVwvJAKxcLEu3ihL9lJPzV2D4RP0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 03/10] RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
Date:   Thu, 10 Sep 2020 17:00:39 +0300
Message-Id: <20200910140046.1306341-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910140046.1306341-1-leon@kernel.org>
References: <20200910140046.1306341-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no reason to have separate create flow for the GSI QP,
while general create_qp routine has all needed checks and ability to
allocate and free the proper struct mlx5_ib_qp.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/gsi.c     | 42 ++++++++++------------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 ++--
 drivers/infiniband/hw/mlx5/qp.c      | 36 +++++++++++++-----------
 3 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index 53c2b8a8c0fb..f5aa1167cb9c 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -89,14 +89,13 @@ static void handle_single_completion(struct ib_cq *cq, struct ib_wc *wc)
 	spin_unlock_irqrestore(&gsi->lock, flags);
 }
 
-struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
-				    struct ib_qp_init_attr *init_attr)
+int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
+		       struct ib_qp_init_attr *attr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_ib_qp *mqp;
 	struct mlx5_ib_gsi_qp *gsi;
-	struct ib_qp_init_attr hw_init_attr = *init_attr;
-	const u8 port_num = init_attr->port_num;
+	struct ib_qp_init_attr hw_init_attr = *attr;
+	const u8 port_num = attr->port_num;
 	int num_qps = 0;
 	int ret;
 
@@ -108,27 +107,19 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 			num_qps = MLX5_MAX_PORTS;
 	}
 
-	mqp = kzalloc(sizeof(struct mlx5_ib_qp), GFP_KERNEL);
-	if (!mqp)
-		return ERR_PTR(-ENOMEM);
-
 	gsi = &mqp->gsi;
 	gsi->tx_qps = kcalloc(num_qps, sizeof(*gsi->tx_qps), GFP_KERNEL);
-	if (!gsi->tx_qps) {
-		ret = -ENOMEM;
-		goto err_free;
-	}
+	if (!gsi->tx_qps)
+		return -ENOMEM;
 
-	gsi->outstanding_wrs = kcalloc(init_attr->cap.max_send_wr,
-				       sizeof(*gsi->outstanding_wrs),
-				       GFP_KERNEL);
+	gsi->outstanding_wrs =
+		kcalloc(attr->cap.max_send_wr, sizeof(*gsi->outstanding_wrs),
+			GFP_KERNEL);
 	if (!gsi->outstanding_wrs) {
 		ret = -ENOMEM;
 		goto err_free_tx;
 	}
 
-	mutex_init(&mqp->mutex);
-
 	mutex_lock(&dev->devr.mutex);
 
 	if (dev->devr.ports[port_num - 1].gsi) {
@@ -140,12 +131,11 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 	gsi->num_qps = num_qps;
 	spin_lock_init(&gsi->lock);
 
-	gsi->cap = init_attr->cap;
-	gsi->sq_sig_type = init_attr->sq_sig_type;
-	mqp->ibqp.qp_num = 1;
+	gsi->cap = attr->cap;
+	gsi->sq_sig_type = attr->sq_sig_type;
 	gsi->port_num = port_num;
 
-	gsi->cq = ib_alloc_cq(pd->device, gsi, init_attr->cap.max_send_wr, 0,
+	gsi->cq = ib_alloc_cq(pd->device, gsi, attr->cap.max_send_wr, 0,
 			      IB_POLL_SOFTIRQ);
 	if (IS_ERR(gsi->cq)) {
 		mlx5_ib_warn(dev, "unable to create send CQ for GSI QP. error %ld\n",
@@ -181,11 +171,11 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 	INIT_LIST_HEAD(&gsi->rx_qp->rdma_mrs);
 	INIT_LIST_HEAD(&gsi->rx_qp->sig_mrs);
 
-	dev->devr.ports[init_attr->port_num - 1].gsi = gsi;
+	dev->devr.ports[attr->port_num - 1].gsi = gsi;
 
 	mutex_unlock(&dev->devr.mutex);
 
-	return &mqp->ibqp;
+	return 0;
 
 err_destroy_cq:
 	ib_free_cq(gsi->cq);
@@ -194,9 +184,7 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 	kfree(gsi->outstanding_wrs);
 err_free_tx:
 	kfree(gsi->tx_qps);
-err_free:
-	kfree(mqp);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0ad4824716a9..1cea4940991f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1335,8 +1335,8 @@ void mlx5_ib_cleanup_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
 void mlx5_ib_init_cong_debugfs(struct mlx5_ib_dev *dev, u8 port_num);
 
 /* GSI QP helper functions */
-struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
-				    struct ib_qp_init_attr *init_attr);
+int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
+		       struct ib_qp_init_attr *attr);
 int mlx5_ib_destroy_gsi(struct mlx5_ib_qp *mqp);
 int mlx5_ib_gsi_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 			  int attr_mask);
@@ -1375,7 +1375,7 @@ static inline void init_query_mad(struct ib_smp *mad)
 
 static inline int is_qp1(enum ib_qp_type qp_type)
 {
-	return qp_type == MLX5_IB_QPT_HW_GSI;
+	return qp_type == MLX5_IB_QPT_HW_GSI || qp_type == IB_QPT_GSI;
 }
 
 #define MLX5_MAX_UMR_SHIFT 16
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 92dda0e50f5d..7e9bf75c33e4 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2785,21 +2785,23 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		goto out;
 	}
 
-	if (qp->type == MLX5_IB_QPT_DCT) {
+	switch (qp->type) {
+	case MLX5_IB_QPT_DCT:
 		err = create_dct(dev, pd, qp, params);
-		goto out;
-	}
-
-	if (qp->type == IB_QPT_XRC_TGT) {
+		break;
+	case IB_QPT_XRC_TGT:
 		err = create_xrc_tgt_qp(dev, qp, params);
-		goto out;
+		break;
+	case IB_QPT_GSI:
+		err = mlx5_ib_create_gsi(pd, qp, params->attr);
+		break;
+	default:
+		if (params->udata)
+			err = create_user_qp(dev, pd, qp, params);
+		else
+			err = create_kernel_qp(dev, pd, qp, params);
 	}
 
-	if (params->udata)
-		err = create_user_qp(dev, pd, qp, params);
-	else
-		err = create_kernel_qp(dev, pd, qp, params);
-
 out:
 	if (err) {
 		mlx5_ib_err(dev, "Create QP type %d failed\n", qp->type);
@@ -2939,9 +2941,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	if (err)
 		return ERR_PTR(err);
 
-	if (attr->qp_type == IB_QPT_GSI)
-		return mlx5_ib_gsi_create_qp(pd, attr);
-
 	params.udata = udata;
 	params.uidx = MLX5_IB_DEFAULT_UIDX;
 	params.attr = attr;
@@ -3010,9 +3009,14 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	return &qp->ibqp;
 
 destroy_qp:
-	if (qp->type == MLX5_IB_QPT_DCT) {
+	switch (qp->type) {
+	case MLX5_IB_QPT_DCT:
 		mlx5_ib_destroy_dct(qp);
-	} else {
+		break;
+	case IB_QPT_GSI:
+		mlx5_ib_destroy_gsi(qp);
+		break;
+	default:
 		/*
 		 * These lines below are temp solution till QP allocation
 		 * will be moved to be under IB/core responsiblity.
-- 
2.26.2

