Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8139C1BA857
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgD0PrF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgD0PrF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:47:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E5B62064C;
        Mon, 27 Apr 2020 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002425;
        bh=63B/zj1M9MUKg1WRxa8UnTyCepCBIYpjRri/8wc3U8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mwTfmZr6xGrrMoGw95mZMcIboJ0ag9bNnjDiVgsEGOaidHUQciIHvSi3kc7Ga7PcC
         cD491ph+nP748VWT25WZHyLLfik5mwtkP83QyNW2ilrdT97KislGjF+YcES2GgqiAR
         eblTZDjcc5BuzX0ylEgKJdF4tkIfoOgb95xm1NBw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 07/36] RDMA/mlx5: Separate create QP flows to be based on type
Date:   Mon, 27 Apr 2020 18:46:07 +0300
Message-Id: <20200427154636.381474-8-leon@kernel.org>
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

Move driver QP creation flow to separate functions to simplify
the create_qp() and allow future separation of create_qp_common()
to subtypes.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 54 ++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d991c33c4d9b..ae336c1eed74 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2557,10 +2557,9 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		destroy_qp_user(dev, &get_pd(qp)->ibpd, qp, base, udata);
 }
 
-static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-					struct ib_qp_init_attr *attr,
-					struct mlx5_ib_create_qp *ucmd,
-					struct ib_udata *udata)
+static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
+		      struct ib_qp_init_attr *attr,
+		      struct mlx5_ib_create_qp *ucmd, struct ib_udata *udata)
 {
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
@@ -2568,16 +2567,13 @@ static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	void *dctc;
 
-	if (!attr->srq || !attr->recv_cq)
-		return ERR_PTR(-EINVAL);
-
 	err = get_qp_user_index(ucontext, ucmd, sizeof(*ucmd), &uidx);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	qp->dct.in = kzalloc(MLX5_ST_SZ_BYTES(create_dct_in), GFP_KERNEL);
 	if (!qp->dct.in)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	MLX5_SET(create_dct_in, qp->dct.in, uid, to_mpd(pd)->uid);
 	dctc = MLX5_ADDR_OF(create_dct_in, qp->dct.in, dct_context_entry);
@@ -2592,7 +2588,7 @@ static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 
 	qp->state = IB_QPS_RESET;
 
-	return &qp->ibqp;
+	return 0;
 }
 
 static int set_mlx_qp_type(struct mlx5_ib_dev *dev,
@@ -2716,10 +2712,36 @@ static int check_valid_flow(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 }
 
+static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
+			    struct ib_qp_init_attr *attr,
+			    struct mlx5_ib_create_qp *ucmd,
+			    struct ib_udata *udata)
+{
+	struct mlx5_ib_dev *mdev = to_mdev(pd->device);
+	int ret = -EINVAL;
+
+	switch (qp->qp_sub_type) {
+	case MLX5_IB_QPT_DCT:
+		if (!attr->srq || !attr->recv_cq)
+			goto out;
+
+		ret = create_dct(pd, qp, attr, ucmd, udata);
+		break;
+	case MLX5_IB_QPT_DCI:
+		ret = create_qp_common(mdev, pd, attr, udata, qp);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+out:	return ret;
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *verbs_init_attr,
 				struct ib_udata *udata)
 {
+	struct mlx5_ib_create_qp ucmd = {};
 	struct mlx5_ib_dev *dev;
 	struct mlx5_ib_qp *qp;
 	u16 xrcdn = 0;
@@ -2749,8 +2771,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		return ERR_PTR(-ENOMEM);
 
 	if (init_attr->qp_type == IB_QPT_DRIVER) {
-		struct mlx5_ib_create_qp ucmd;
-
 		init_attr = &mlx_init_attr;
 		memcpy(init_attr, verbs_init_attr, sizeof(*verbs_init_attr));
 		err = set_mlx_qp_type(dev, init_attr, &ucmd, udata);
@@ -2767,15 +2787,19 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 			qp->qp_sub_type = MLX5_IB_QPT_DCI;
 		} else {
 			qp->qp_sub_type = MLX5_IB_QPT_DCT;
-			return mlx5_ib_create_dct(pd, qp, init_attr, &ucmd,
-						  udata);
 		}
 	}
 
 	if (init_attr->qp_type == IB_QPT_XRC_TGT)
 		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
 
-	err = create_qp_common(dev, pd, init_attr, udata, qp);
+	switch (init_attr->qp_type) {
+	case IB_QPT_DRIVER:
+		err = create_driver_qp(pd, qp, init_attr, &ucmd, udata);
+		break;
+	default:
+		err = create_qp_common(dev, pd, init_attr, udata, qp);
+	}
 	if (err) {
 		mlx5_ib_dbg(dev, "create_qp_common failed\n");
 		goto free_qp;
-- 
2.25.3

