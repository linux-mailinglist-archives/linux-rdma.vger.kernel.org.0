Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376032647DA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgIJOSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 10:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731117AbgIJOKb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C2720C09;
        Thu, 10 Sep 2020 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746458;
        bh=lk/HloU4Ev4itPgFWdL72eINQ2+qkB6BCGBOMVy4yi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ljJT/7NIBU0J2IGXAKWw00OGrTgZHA4/VuPYqESALfN5RzPTCNONy4Uu1g2hQVk2
         Ay3A8taelY1zyIRPuMJX5I0O8KXdcVC/GIP/QHVkc0vo7p8j7BgVTL81QISkV95Y3c
         8UE4Z1D6Fm9RbI1l+4+ytOMuJPX79xPxkoKCLoK8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 02/10] RDMA/mlx5: Reuse existing fields in parent QP storage object
Date:   Thu, 10 Sep 2020 17:00:38 +0300
Message-Id: <20200910140046.1306341-3-leon@kernel.org>
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

Remove duplication of mlx5_ib_qp and mlx5_ib_gsi_qp fields.
This change returns the memory footprint of mlx5_ib QP to be
as it was before embedding GSI QP.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/gsi.c     | 66 +++++++++++++---------------
 drivers/infiniband/hw/mlx5/main.c    |  6 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 --
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index 0b18558ba7b0..53c2b8a8c0fb 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -39,20 +39,16 @@ struct mlx5_ib_gsi_wr {
 	bool completed:1;
 };
 
-static struct mlx5_ib_gsi_qp *gsi_qp(struct ib_qp *qp)
-{
-	return container_of(qp, struct mlx5_ib_gsi_qp, ibqp);
-}
-
 static bool mlx5_ib_deth_sqpn_cap(struct mlx5_ib_dev *dev)
 {
 	return MLX5_CAP_GEN(dev->mdev, set_deth_sqpn);
 }
 
 /* Call with gsi->lock locked */
-static void generate_completions(struct mlx5_ib_gsi_qp *gsi)
+static void generate_completions(struct mlx5_ib_qp *mqp)
 {
-	struct ib_cq *gsi_cq = gsi->ibqp.send_cq;
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
+	struct ib_cq *gsi_cq = mqp->ibqp.send_cq;
 	struct mlx5_ib_gsi_wr *wr;
 	u32 index;
 
@@ -78,6 +74,7 @@ static void handle_single_completion(struct ib_cq *cq, struct ib_wc *wc)
 	struct mlx5_ib_gsi_qp *gsi = cq->cq_context;
 	struct mlx5_ib_gsi_wr *wr =
 		container_of(wc->wr_cqe, struct mlx5_ib_gsi_wr, cqe);
+	struct mlx5_ib_qp *mqp = container_of(gsi, struct mlx5_ib_qp, gsi);
 	u64 wr_id;
 	unsigned long flags;
 
@@ -86,9 +83,9 @@ static void handle_single_completion(struct ib_cq *cq, struct ib_wc *wc)
 	wr_id = wr->wc.wr_id;
 	wr->wc = *wc;
 	wr->wc.wr_id = wr_id;
-	wr->wc.qp = &gsi->ibqp;
+	wr->wc.qp = &mqp->ibqp;
 
-	generate_completions(gsi);
+	generate_completions(mqp);
 	spin_unlock_irqrestore(&gsi->lock, flags);
 }
 
@@ -130,7 +127,7 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 		goto err_free_tx;
 	}
 
-	mutex_init(&gsi->mutex);
+	mutex_init(&mqp->mutex);
 
 	mutex_lock(&dev->devr.mutex);
 
@@ -145,7 +142,7 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 
 	gsi->cap = init_attr->cap;
 	gsi->sq_sig_type = init_attr->sq_sig_type;
-	gsi->ibqp.qp_num = 1;
+	mqp->ibqp.qp_num = 1;
 	gsi->port_num = port_num;
 
 	gsi->cq = ib_alloc_cq(pd->device, gsi, init_attr->cap.max_send_wr, 0,
@@ -188,7 +185,7 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 
 	mutex_unlock(&dev->devr.mutex);
 
-	return &gsi->ibqp;
+	return &mqp->ibqp;
 
 err_destroy_cq:
 	ib_free_cq(gsi->cq);
@@ -362,56 +359,54 @@ static void setup_qp(struct mlx5_ib_gsi_qp *gsi, u16 qp_index)
 
 static void setup_qps(struct mlx5_ib_gsi_qp *gsi)
 {
+	struct mlx5_ib_dev *dev = to_mdev(gsi->rx_qp->device);
 	u16 qp_index;
 
+	mutex_lock(&dev->devr.mutex);
 	for (qp_index = 0; qp_index < gsi->num_qps; ++qp_index)
 		setup_qp(gsi, qp_index);
+	mutex_unlock(&dev->devr.mutex);
 }
 
 int mlx5_ib_gsi_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
 			  int attr_mask)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
-	struct mlx5_ib_gsi_qp *gsi = gsi_qp(qp);
+	struct mlx5_ib_qp *mqp = to_mqp(qp);
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
 	int ret;
 
 	mlx5_ib_dbg(dev, "modifying GSI QP to state %d\n", attr->qp_state);
 
-	mutex_lock(&gsi->mutex);
 	ret = ib_modify_qp(gsi->rx_qp, attr, attr_mask);
 	if (ret) {
 		mlx5_ib_warn(dev, "unable to modify GSI rx QP: %d\n", ret);
-		goto unlock;
+		return ret;
 	}
 
 	if (to_mqp(gsi->rx_qp)->state == IB_QPS_RTS)
 		setup_qps(gsi);
-
-unlock:
-	mutex_unlock(&gsi->mutex);
-
-	return ret;
+	return 0;
 }
 
 int mlx5_ib_gsi_query_qp(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			 int qp_attr_mask,
 			 struct ib_qp_init_attr *qp_init_attr)
 {
-	struct mlx5_ib_gsi_qp *gsi = gsi_qp(qp);
+	struct mlx5_ib_qp *mqp = to_mqp(qp);
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
 	int ret;
 
-	mutex_lock(&gsi->mutex);
 	ret = ib_query_qp(gsi->rx_qp, qp_attr, qp_attr_mask, qp_init_attr);
 	qp_init_attr->cap = gsi->cap;
-	mutex_unlock(&gsi->mutex);
-
 	return ret;
 }
 
 /* Call with gsi->lock locked */
-static int mlx5_ib_add_outstanding_wr(struct mlx5_ib_gsi_qp *gsi,
+static int mlx5_ib_add_outstanding_wr(struct mlx5_ib_qp *mqp,
 				      struct ib_ud_wr *wr, struct ib_wc *wc)
 {
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
 	struct mlx5_ib_dev *dev = to_mdev(gsi->rx_qp->device);
 	struct mlx5_ib_gsi_wr *gsi_wr;
 
@@ -440,22 +435,21 @@ static int mlx5_ib_add_outstanding_wr(struct mlx5_ib_gsi_qp *gsi,
 }
 
 /* Call with gsi->lock locked */
-static int mlx5_ib_gsi_silent_drop(struct mlx5_ib_gsi_qp *gsi,
-				    struct ib_ud_wr *wr)
+static int mlx5_ib_gsi_silent_drop(struct mlx5_ib_qp *mqp, struct ib_ud_wr *wr)
 {
 	struct ib_wc wc = {
 		{ .wr_id = wr->wr.wr_id },
 		.status = IB_WC_SUCCESS,
 		.opcode = IB_WC_SEND,
-		.qp = &gsi->ibqp,
+		.qp = &mqp->ibqp,
 	};
 	int ret;
 
-	ret = mlx5_ib_add_outstanding_wr(gsi, wr, &wc);
+	ret = mlx5_ib_add_outstanding_wr(mqp, wr, &wc);
 	if (ret)
 		return ret;
 
-	generate_completions(gsi);
+	generate_completions(mqp);
 
 	return 0;
 }
@@ -482,7 +476,8 @@ static struct ib_qp *get_tx_qp(struct mlx5_ib_gsi_qp *gsi, struct ib_ud_wr *wr)
 int mlx5_ib_gsi_post_send(struct ib_qp *qp, const struct ib_send_wr *wr,
 			  const struct ib_send_wr **bad_wr)
 {
-	struct mlx5_ib_gsi_qp *gsi = gsi_qp(qp);
+	struct mlx5_ib_qp *mqp = to_mqp(qp);
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
 	struct ib_qp *tx_qp;
 	unsigned long flags;
 	int ret;
@@ -495,14 +490,14 @@ int mlx5_ib_gsi_post_send(struct ib_qp *qp, const struct ib_send_wr *wr,
 		spin_lock_irqsave(&gsi->lock, flags);
 		tx_qp = get_tx_qp(gsi, &cur_wr);
 		if (!tx_qp) {
-			ret = mlx5_ib_gsi_silent_drop(gsi, &cur_wr);
+			ret = mlx5_ib_gsi_silent_drop(mqp, &cur_wr);
 			if (ret)
 				goto err;
 			spin_unlock_irqrestore(&gsi->lock, flags);
 			continue;
 		}
 
-		ret = mlx5_ib_add_outstanding_wr(gsi, &cur_wr, NULL);
+		ret = mlx5_ib_add_outstanding_wr(mqp, &cur_wr, NULL);
 		if (ret)
 			goto err;
 
@@ -526,7 +521,8 @@ int mlx5_ib_gsi_post_send(struct ib_qp *qp, const struct ib_send_wr *wr,
 int mlx5_ib_gsi_post_recv(struct ib_qp *qp, const struct ib_recv_wr *wr,
 			  const struct ib_recv_wr **bad_wr)
 {
-	struct mlx5_ib_gsi_qp *gsi = gsi_qp(qp);
+	struct mlx5_ib_qp *mqp = to_mqp(qp);
+	struct mlx5_ib_gsi_qp *gsi = &mqp->gsi;
 
 	return ib_post_recv(gsi->rx_qp, wr, bad_wr);
 }
@@ -536,7 +532,5 @@ void mlx5_ib_gsi_pkey_change(struct mlx5_ib_gsi_qp *gsi)
 	if (!gsi)
 		return;
 
-	mutex_lock(&gsi->mutex);
 	setup_qps(gsi);
-	mutex_unlock(&gsi->mutex);
 }
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f3bece081ad0..8696ad50d8fb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2714,9 +2714,7 @@ static void pkey_change_handler(struct work_struct *work)
 		container_of(work, struct mlx5_ib_port_resources,
 			     pkey_change_work);
 
-	mutex_lock(&ports->devr->mutex);
 	mlx5_ib_gsi_pkey_change(ports->gsi);
-	mutex_unlock(&ports->devr->mutex);
 }
 
 static void mlx5_ib_handle_internal_error(struct mlx5_ib_dev *ibdev)
@@ -3142,11 +3140,9 @@ static int mlx5_ib_dev_res_init(struct mlx5_ib_dev *dev)
 	atomic_inc(&devr->p0->usecnt);
 	atomic_set(&devr->s1->usecnt, 0);
 
-	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port) {
+	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
 		INIT_WORK(&devr->ports[port].pkey_change_work,
 			  pkey_change_handler);
-		devr->ports[port].devr = devr;
-	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7e0eb815724b..0ad4824716a9 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -385,13 +385,10 @@ struct mlx5_ib_dct {
 };
 
 struct mlx5_ib_gsi_qp {
-	struct ib_qp ibqp;
 	struct ib_qp *rx_qp;
 	u8 port_num;
 	struct ib_qp_cap cap;
 	enum ib_sig_type sq_sig_type;
-	/* Serialize qp state modifications */
-	struct mutex mutex;
 	struct ib_cq *cq;
 	struct mlx5_ib_gsi_wr *outstanding_wrs;
 	u32 outstanding_pi, outstanding_ci;
@@ -715,7 +712,6 @@ struct mlx5_mr_cache {
 };
 
 struct mlx5_ib_port_resources {
-	struct mlx5_ib_resources *devr;
 	struct mlx5_ib_gsi_qp *gsi;
 	struct work_struct pkey_change_work;
 };
-- 
2.26.2

