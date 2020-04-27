Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC781BA850
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgD0Pqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgD0Pqu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:46:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539432064C;
        Mon, 27 Apr 2020 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002410;
        bh=5sJWyR3U4xDgCkZ/FNdZLPGyz9lprWhgEQL4ATiEjTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsYx6KLtFxKPFn8j6USoFKGOZ3BUqDi87xx4S+QmyHPSsW2UgZ1HHgJ3fnKmYJHJ/
         YxzGLiJ/SUVTSe09MnVp2BCDXsWsBO98QCGORJSTcMkDZN5kK76ltJLUG8LqrfOBrz
         C1Nko1zgV0N27xF0RApHJ+7KkNvkSlQIzjzQY96Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 03/36] RDMA/mlx5: Perform check if QP creation flow is valid
Date:   Mon, 27 Apr 2020 18:46:03 +0300
Message-Id: <20200427154636.381474-4-leon@kernel.org>
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

Fast check that kernel and user flows provides enough
data to create QP.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 128 +++++++++++++++-----------------
 1 file changed, 61 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index fdab5b6db1e5..91d6151c349c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1666,9 +1666,6 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	size_t required_cmd_sz;
 	u8 lb_flag = 0;
 
-	if (init_attr->qp_type != IB_QPT_RAW_PACKET)
-		return -EOPNOTSUPP;
-
 	if (init_attr->create_flags || init_attr->send_cq)
 		return -EINVAL;
 
@@ -2032,13 +2029,8 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (mlx5_st < 0)
 		return -EINVAL;
 
-	if (init_attr->rwq_ind_tbl) {
-		if (!udata)
-			return -ENOSYS;
-
-		err = create_rss_raw_qp_tir(dev, qp, pd, init_attr, udata);
-		return err;
-	}
+	if (init_attr->rwq_ind_tbl)
+		return create_rss_raw_qp_tir(dev, qp, pd, init_attr, udata);
 
 	if (init_attr->create_flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
 		if (!MLX5_CAP_GEN(mdev, block_lb_mc)) {
@@ -2565,39 +2557,6 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		destroy_qp_user(dev, &get_pd(qp)->ibpd, qp, base, udata);
 }
 
-static const char *ib_qp_type_str(enum ib_qp_type type)
-{
-	switch (type) {
-	case IB_QPT_SMI:
-		return "IB_QPT_SMI";
-	case IB_QPT_GSI:
-		return "IB_QPT_GSI";
-	case IB_QPT_RC:
-		return "IB_QPT_RC";
-	case IB_QPT_UC:
-		return "IB_QPT_UC";
-	case IB_QPT_UD:
-		return "IB_QPT_UD";
-	case IB_QPT_RAW_IPV6:
-		return "IB_QPT_RAW_IPV6";
-	case IB_QPT_RAW_ETHERTYPE:
-		return "IB_QPT_RAW_ETHERTYPE";
-	case IB_QPT_XRC_INI:
-		return "IB_QPT_XRC_INI";
-	case IB_QPT_XRC_TGT:
-		return "IB_QPT_XRC_TGT";
-	case IB_QPT_RAW_PACKET:
-		return "IB_QPT_RAW_PACKET";
-	case MLX5_IB_QPT_REG_UMR:
-		return "MLX5_IB_QPT_REG_UMR";
-	case IB_QPT_DRIVER:
-		return "IB_QPT_DRIVER";
-	case IB_QPT_MAX:
-	default:
-		return "Invalid QP type";
-	}
-}
-
 static struct ib_qp *mlx5_ib_create_dct(struct ib_pd *pd,
 					struct ib_qp_init_attr *attr,
 					struct mlx5_ib_create_qp *ucmd,
@@ -2655,9 +2614,6 @@ static int set_mlx_qp_type(struct mlx5_ib_dev *dev,
 	enum { MLX_QP_FLAGS = MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI };
 	int err;
 
-	if (!udata)
-		return -EINVAL;
-
 	if (udata->inlen < sizeof(*ucmd)) {
 		mlx5_ib_dbg(dev, "create_qp user command is smaller than expected\n");
 		return -EINVAL;
@@ -2715,6 +2671,62 @@ static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr)
 	return -EOPNOTSUPP;
 }
 
+static int check_valid_flow(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+			    struct ib_qp_init_attr *attr,
+			    struct ib_udata *udata)
+{
+	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
+		udata, struct mlx5_ib_ucontext, ibucontext);
+
+	if (!udata) {
+		/* Kernel create_qp callers */
+		if (attr->rwq_ind_tbl)
+			return -EOPNOTSUPP;
+
+		switch (attr->qp_type) {
+		case IB_QPT_RAW_PACKET:
+		case IB_QPT_DRIVER:
+			return -EOPNOTSUPP;
+		default:
+			return 0;
+		}
+	}
+
+	/* Userspace create_qp callers */
+	if (attr->qp_type == IB_QPT_RAW_PACKET && !ucontext->cqe_version) {
+		mlx5_ib_dbg(dev,
+			"Raw Packet QP is only supported for CQE version > 0\n");
+		return -EINVAL;
+	}
+
+	if (attr->qp_type != IB_QPT_RAW_PACKET && attr->rwq_ind_tbl) {
+		mlx5_ib_dbg(dev,
+			    "Wrong QP type %d for the RWQ indirect table\n",
+			    attr->qp_type);
+		return -EINVAL;
+	}
+
+	switch (attr->qp_type) {
+	case IB_QPT_SMI:
+	case MLX5_IB_QPT_HW_GSI:
+	case MLX5_IB_QPT_REG_UMR:
+	case IB_QPT_GSI:
+		mlx5_ib_dbg(dev, "Kernel doesn't support QP type %d\n",
+			    attr->qp_type);
+		return -EINVAL;
+	default:
+		break;
+	}
+
+	/*
+	 * We don't need to see this warning, it means that kernel code
+	 * missing ib_pd. Placed here to catch developer's mistakes.
+	 */
+	WARN_ONCE(!pd && attr->qp_type != IB_QPT_XRC_TGT,
+		  "There is a missing PD pointer assignment\n");
+	return 0;
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *verbs_init_attr,
 				struct ib_udata *udata)
@@ -2725,8 +2737,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	int err;
 	struct ib_qp_init_attr mlx_init_attr;
 	struct ib_qp_init_attr *init_attr = verbs_init_attr;
-	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
-		udata, struct mlx5_ib_ucontext, ibucontext);
 
 	dev = pd ? to_mdev(pd->device) :
 		   to_mdev(to_mxrcd(init_attr->xrcd)->ibxrcd.device);
@@ -2738,25 +2748,9 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		return ERR_PTR(err);
 	}
 
-	if (pd) {
-		if (init_attr->qp_type == IB_QPT_RAW_PACKET) {
-			if (!ucontext) {
-				mlx5_ib_dbg(dev, "Raw Packet QP is not supported for kernel consumers\n");
-				return ERR_PTR(-EINVAL);
-			} else if (!ucontext->cqe_version) {
-				mlx5_ib_dbg(dev, "Raw Packet QP is only supported for CQE version > 0\n");
-				return ERR_PTR(-EINVAL);
-			}
-		}
-	} else {
-		/* being cautious here */
-		if (init_attr->qp_type != IB_QPT_XRC_TGT &&
-		    init_attr->qp_type != MLX5_IB_QPT_REG_UMR) {
-			pr_warn("%s: no PD for transport %s\n", __func__,
-				ib_qp_type_str(init_attr->qp_type));
-			return ERR_PTR(-EINVAL);
-		}
-	}
+	err = check_valid_flow(dev, pd, init_attr, udata);
+	if (err)
+		return ERR_PTR(err);
 
 	if (init_attr->qp_type == IB_QPT_DRIVER) {
 		struct mlx5_ib_create_qp ucmd;
-- 
2.25.3

