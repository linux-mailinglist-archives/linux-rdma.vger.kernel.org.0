Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03D1BA91E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgD0Ps7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbgD0Ps6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:58 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B965B2064C;
        Mon, 27 Apr 2020 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002538;
        bh=owfNJ43FNxReOdRSF8IiwSp6qSMWbvUi+HLHWQcLxes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMArdFBrzVIMSCiArFe38kOuYOQ07LV5QH0e2CkPa/iODqw2Hs5yR2+SFvtim2pIT
         c5xsON+hJu379hFKf4nHD0W/zU3WIjvNI4vRHESM+HPfzT5nc9JL/jYvfhaEcFDXp0
         lAipAkEbjX4FySKQEnDmb6yvxItEGMy+wNv50PQc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 35/36] RDMA/mlx5: Consolidate into special function all create QP calls
Date:   Mon, 27 Apr 2020 18:46:35 +0300
Message-Id: <20200427154636.381474-36-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Finish separation to blocks of mlx5_ib_create_qp() functions,
so all internal create QP implementation are located in one place.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 85 +++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d7983a951e8d..18c0a25da47a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1953,6 +1953,7 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	list_add_tail(&qp->qps_list, &dev->qp_list);
 	spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);
 
+	qp->trans_qp.xrcdn = to_mxrcd(attr->xrcd)->xrcdn;
 	return 0;
 }
 
@@ -2785,14 +2786,54 @@ static int process_udata_size(struct mlx5_ib_dev *dev,
 	return (params->inlen) ? 0 : -EINVAL;
 }
 
-static int create_raw_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
-			 struct mlx5_ib_qp *qp,
-			 struct mlx5_create_qp_params *params)
+static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+		     struct mlx5_ib_qp *qp,
+		     struct mlx5_create_qp_params *params)
 {
-	if (params->is_rss_raw)
-		return create_rss_raw_qp_tir(dev, pd, qp, params);
+	int err;
+
+	if (params->is_rss_raw) {
+		err = create_rss_raw_qp_tir(dev, pd, qp, params);
+		goto out;
+	}
+
+	if (qp->type == MLX5_IB_QPT_DCT) {
+		err = create_dct(pd, qp, params);
+		goto out;
+	}
+
+	if (qp->type == IB_QPT_XRC_TGT) {
+		err = create_xrc_tgt_qp(dev, qp, params);
+		goto out;
+	}
+
+	if (params->udata)
+		err = create_user_qp(dev, pd, qp, params);
+	else
+		err = create_kernel_qp(dev, pd, qp, params);
+
+out:
+	if (err) {
+		mlx5_ib_err(dev, "Create QP type %d failed\n", qp->type);
+		return err;
+	}
+
+	if (is_qp0(qp->type))
+		qp->ibqp.qp_num = 0;
+	else if (is_qp1(qp->type))
+		qp->ibqp.qp_num = 1;
+	else
+		qp->ibqp.qp_num = qp->trans_qp.base.mqp.qpn;
+
+	mlx5_ib_dbg(dev,
+		"QP type %d, ib qpn 0x%X, mlx qpn 0x%x, rcqn 0x%x, scqn 0x%x\n",
+		qp->type, qp->ibqp.qp_num, qp->trans_qp.base.mqp.qpn,
+		params->attr->recv_cq ? to_mcq(params->attr->recv_cq)->mcq.cqn :
+					-1,
+		params->attr->send_cq ? to_mcq(params->attr->send_cq)->mcq.cqn :
+					-1);
 
-	return create_user_qp(dev, pd, qp, params);
+	return 0;
 }
 
 static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
@@ -2862,7 +2903,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	struct mlx5_ib_dev *dev;
 	struct mlx5_ib_qp *qp;
 	enum ib_qp_type type;
-	u16 xrcdn = 0;
 	int err;
 
 	dev = pd ? to_mdev(pd->device) :
@@ -2922,40 +2962,13 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	if (err)
 		goto free_qp;
 
-	switch (qp->type) {
-	case IB_QPT_RAW_PACKET:
-		err = create_raw_qp(dev, pd, qp, &params);
-		break;
-	case MLX5_IB_QPT_DCT:
-		err = create_dct(pd, qp, &params);
-		break;
-	case IB_QPT_XRC_TGT:
-		xrcdn = to_mxrcd(attr->xrcd)->xrcdn;
-		err = create_xrc_tgt_qp(dev, qp, &params);
-		break;
-	default:
-		if (udata)
-			err = create_user_qp(dev, pd, qp, &params);
-		else
-			err = create_kernel_qp(dev, pd, qp, &params);
-	}
-	if (err) {
-		mlx5_ib_err(dev, "create_qp failed %d\n", err);
+	err = create_qp(dev, pd, qp, &params);
+	if (err)
 		goto free_qp;
-	}
 
 	kfree(params.ucmd);
 	params.ucmd = NULL;
 
-	if (is_qp0(attr->qp_type))
-		qp->ibqp.qp_num = 0;
-	else if (is_qp1(attr->qp_type))
-		qp->ibqp.qp_num = 1;
-	else
-		qp->ibqp.qp_num = qp->trans_qp.base.mqp.qpn;
-
-	qp->trans_qp.xrcdn = xrcdn;
-
 	if (udata)
 		/*
 		 * It is safe to copy response for all user create QP flows,
-- 
2.25.3

