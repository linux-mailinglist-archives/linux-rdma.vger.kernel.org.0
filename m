Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A327B1B0FA6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgDTPLp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbgDTPLo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A33620775;
        Mon, 20 Apr 2020 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395503;
        bh=oox/cg09TFi6pXFyQ1jqXczDCjDtr9p37wBiuhkHSC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z747L2/GbbO8rrdzodztsrU122koNt32koifx+C/j7/DWEq1SfcU92dn5MW3OoxGP
         7JB4yiq8U6MKjRSe4//ElIZBZekWZ2iQYj4K9H8zQPVYKa+Ck44Oj/7R6CuPfEvTCH
         1NOGgNULjGyH4/fATr5kHU5iyDV49pqkUlJyG7ws=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 10/18] RDMA/mlx5: Move DRIVER QP flags check into separate function
Date:   Mon, 20 Apr 2020 18:10:57 +0300
Message-Id: <20200420151105.282848-11-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420151105.282848-1-leon@kernel.org>
References: <20200420151105.282848-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Perform validation of DRIVER QP in relevant function.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 91 ++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 4e6e72adb4c3..9ae8b43a77d4 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2570,36 +2570,6 @@ static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	return 0;
 }
 
-static int set_mlx_qp_type(struct mlx5_ib_dev *dev,
-			   struct ib_qp_init_attr *init_attr,
-			   struct mlx5_ib_create_qp *ucmd,
-			   struct ib_udata *udata)
-{
-	enum { MLX_QP_FLAGS = MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI };
-	int err;
-
-	if (udata->inlen < sizeof(*ucmd)) {
-		mlx5_ib_dbg(dev, "create_qp user command is smaller than expected\n");
-		return -EINVAL;
-	}
-	err = ib_copy_from_udata(ucmd, udata, sizeof(*ucmd));
-	if (err)
-		return err;
-
-	if ((ucmd->flags & MLX_QP_FLAGS) == MLX5_QP_FLAG_TYPE_DCI) {
-		init_attr->qp_type = MLX5_IB_QPT_DCI;
-	} else {
-		if ((ucmd->flags & MLX_QP_FLAGS) == MLX5_QP_FLAG_TYPE_DCT) {
-			init_attr->qp_type = MLX5_IB_QPT_DCT;
-		} else {
-			mlx5_ib_dbg(dev, "Invalid QP flags\n");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
 static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr)
 {
 	if (attr->qp_type == IB_QPT_DRIVER && !MLX5_CAP_GEN(dev->mdev, dct))
@@ -2691,6 +2661,24 @@ static int check_valid_flow(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 }
 
+static int process_vendor_flags(struct mlx5_ib_qp *qp,
+				struct ib_qp_init_attr *attr,
+				struct mlx5_ib_create_qp *ucmd)
+{
+	switch (ucmd->flags & (MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI)) {
+	case MLX5_QP_FLAG_TYPE_DCI:
+		qp->qp_sub_type = MLX5_IB_QPT_DCI;
+		break;
+	case MLX5_QP_FLAG_TYPE_DCT:
+		qp->qp_sub_type = MLX5_IB_QPT_DCT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 			    struct ib_qp_init_attr *attr,
 			    struct mlx5_ib_create_qp *ucmd,
@@ -2707,6 +2695,9 @@ static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 		ret = create_dct(pd, qp, attr, ucmd, udata);
 		break;
 	case MLX5_IB_QPT_DCI:
+		if (attr->cap.max_recv_wr || attr->cap.max_recv_sge)
+			goto out;
+
 		ret = create_qp_common(mdev, pd, attr, udata, qp);
 		break;
 	default:
@@ -2716,8 +2707,16 @@ static int create_driver_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 out:	return ret;
 }
 
+static size_t process_udata_size(struct ib_qp_init_attr *attr,
+				 struct ib_udata *udata)
+{
+	size_t ucmd = sizeof(struct mlx5_ib_create_qp);
+
+	return (udata->inlen < ucmd) ? 0 : ucmd;
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
-				struct ib_qp_init_attr *verbs_init_attr,
+				struct ib_qp_init_attr *init_attr,
 				struct ib_udata *udata)
 {
 	struct mlx5_ib_create_qp ucmd = {};
@@ -2725,8 +2724,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	struct mlx5_ib_qp *qp;
 	u16 xrcdn = 0;
 	int err;
-	struct ib_qp_init_attr mlx_init_attr;
-	struct ib_qp_init_attr *init_attr = verbs_init_attr;
 
 	dev = pd ? to_mdev(pd->device) :
 		   to_mdev(to_mxrcd(init_attr->xrcd)->ibxrcd.device);
@@ -2745,28 +2742,26 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (init_attr->qp_type == IB_QPT_GSI)
 		return mlx5_ib_gsi_create_qp(pd, init_attr);
 
+	if (udata && init_attr->qp_type == IB_QPT_DRIVER) {
+		size_t inlen =
+			process_udata_size(init_attr, udata);
+
+		if (!inlen)
+			return ERR_PTR(-EINVAL);
+
+		err = ib_copy_from_udata(&ucmd, udata, inlen);
+		if (err)
+			return ERR_PTR(err);
+	}
+
 	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
 	if (!qp)
 		return ERR_PTR(-ENOMEM);
 
 	if (init_attr->qp_type == IB_QPT_DRIVER) {
-		init_attr = &mlx_init_attr;
-		memcpy(init_attr, verbs_init_attr, sizeof(*verbs_init_attr));
-		err = set_mlx_qp_type(dev, init_attr, &ucmd, udata);
+		err = process_vendor_flags(qp, init_attr, &ucmd);
 		if (err)
 			goto free_qp;
-
-		if (init_attr->qp_type == MLX5_IB_QPT_DCI) {
-			if (init_attr->cap.max_recv_wr ||
-			    init_attr->cap.max_recv_sge) {
-				mlx5_ib_dbg(dev, "DCI QP requires zero size receive queue\n");
-				err = -EINVAL;
-				goto free_qp;
-			}
-			qp->qp_sub_type = MLX5_IB_QPT_DCI;
-		} else {
-			qp->qp_sub_type = MLX5_IB_QPT_DCT;
-		}
 	}
 
 	if (init_attr->qp_type == IB_QPT_XRC_TGT)
-- 
2.25.2

