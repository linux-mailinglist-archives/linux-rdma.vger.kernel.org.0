Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FC1BA854
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgD0Pqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgD0Pqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:46:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2A72064C;
        Mon, 27 Apr 2020 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002413;
        bh=YoWOkrYvPnb6SyEX/IXkS/znKKHr8V3igyVNCzeNUwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMd6a1Fb1GkUhc8lWRZ6NB3K3rDQbdbqhizdupqZ4MLx2I3gTaNd3ebvQ7uvMWZjf
         CVe1TA0lCGsMi0LxMUDyL1HRW1+thWg/ka1y2vnRo1FlasDq47pu47qVwNbse48EGr
         h2/GoJEZiO1gv1qrhhl40ZlqQJvYgc7yP+ie5CMU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 04/36] RDMA/mlx5: Prepare QP allocation for future removal
Date:   Mon, 27 Apr 2020 18:46:04 +0300
Message-Id: <20200427154636.381474-5-leon@kernel.org>
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

Unify the QP memory allocation across different paths,
so it will be in one place.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 45 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 91d6151c349c..07df470e0d58 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2557,14 +2557,13 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		destroy_qp_user(dev, &get_pd(qp)->ibpd, qp, base, udata);
 }
 
-static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd,
+static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 					struct ib_qp_init_attr *attr,
 					struct mlx5_ib_create_qp *ucmd,
 					struct ib_udata *udata)
 {
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
-	struct mlx5_ib_qp *qp;
 	int err = 0;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	void *dctc;
@@ -2576,15 +2575,9 @@ static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd,
 	if (err)
 		return ERR_PTR(err);
 
-	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return ERR_PTR(-ENOMEM);
-
 	qp->dct.in = kzalloc(MLX5_ST_SZ_BYTES(create_dct_in), GFP_KERNEL);
-	if (!qp->dct.in) {
-		err = -ENOMEM;
-		goto err_free;
-	}
+	if (!qp->dct.in)
+		return ERR_PTR(-ENOMEM);
 
 	MLX5_SET(create_dct_in, qp->dct.in, uid, to_mpd(pd)->uid);
 	dctc = MLX5_ADDR_OF(create_dct_in, qp->dct.in, dct_context_entry);
@@ -2601,9 +2594,6 @@ static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd,
 	qp->state = IB_QPS_RESET;
 
 	return &qp->ibqp;
-err_free:
-	kfree(qp);
-	return ERR_PTR(err);
 }
 
 static int set_mlx_qp_type(struct mlx5_ib_dev *dev,
@@ -2752,6 +2742,13 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (err)
 		return ERR_PTR(err);
 
+	if (init_attr->qp_type == IB_QPT_GSI)
+		return mlx5_ib_gsi_create_qp(pd, init_attr);
+
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
+
 	if (init_attr->qp_type == IB_QPT_DRIVER) {
 		struct mlx5_ib_create_qp ucmd;
 
@@ -2759,22 +2756,21 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		memcpy(init_attr, verbs_init_attr, sizeof(*verbs_init_attr));
 		err = set_mlx_qp_type(dev, init_attr, &ucmd, udata);
 		if (err)
-			return ERR_PTR(err);
+			goto free_qp;
 
 		if (init_attr->qp_type == MLX5_IB_QPT_DCI) {
 			if (init_attr->cap.max_recv_wr ||
 			    init_attr->cap.max_recv_sge) {
 				mlx5_ib_dbg(dev, "DCI QP requires zero size receive queue\n");
-				return ERR_PTR(-EINVAL);
+				err = -EINVAL;
+				goto free_qp;
 			}
 		} else {
-			return mlx5_ib_create_dct(pd, init_attr, &ucmd, udata);
+			return mlx5_ib_create_dct(pd, qp, init_attr, &ucmd,
+						  udata);
 		}
 	}
 
-	if (init_attr->qp_type == IB_QPT_GSI)
-		return mlx5_ib_gsi_create_qp(pd, init_attr);
-
 	if (init_attr->qp_type == IB_QPT_XRC_TGT) {
 		init_attr->recv_cq = NULL;
 		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
@@ -2784,15 +2780,10 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (init_attr->qp_type == IB_QPT_XRC_INI)
 		init_attr->recv_cq = NULL;
 
-	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return ERR_PTR(-ENOMEM);
-
 	err = create_qp_common(dev, pd, init_attr, udata, qp);
 	if (err) {
 		mlx5_ib_dbg(dev, "create_qp_common failed\n");
-		kfree(qp);
-		return ERR_PTR(err);
+		goto free_qp;
 	}
 
 	if (is_qp0(init_attr->qp_type))
@@ -2808,6 +2799,10 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		qp->qp_sub_type = init_attr->qp_type;
 
 	return &qp->ibqp;
+
+free_qp:
+	kfree(qp);
+	return ERR_PTR(err);
 }
 
 static int mlx5_ib_destroy_dct(struct mlx5_ib_qp *mqp)
-- 
2.25.3

