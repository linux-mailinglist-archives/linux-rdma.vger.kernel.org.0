Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5E1B0F64
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDTPLP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgDTPLP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA74320775;
        Mon, 20 Apr 2020 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395474;
        bh=Tt/+FVbsaOFrcPgkrCxhwkcBtilZKd0LoyodBn6B9/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTyIEuAfwbo3ZrBkiBC9b8/saz0stn+/nhL5srBW9n50CT+WXZ6YKNRTtbIrDHleT
         THsqlfgdhhQ5qSZXGhEgdZ+WXKB2bhqrYS2ELDOojvuIdgNkv6qGxDERzYHKc/q4PO
         bZ9gnzuCbH5IJeDfv3ysOOrxaLQ9WEDJkw5JjQlI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 01/18] RDMA/mlx5: Organize QP types checks in one place
Date:   Mon, 20 Apr 2020 18:10:48 +0300
Message-Id: <20200420151105.282848-2-leon@kernel.org>
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

Perform check if QP type is supported in one place at the beginning of
the create_qp function instead of current implementation with checks
buried inside of the code.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 129 +++++++++++++++++---------------
 1 file changed, 68 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0f986ce22a96..df63ad38509b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2677,12 +2677,42 @@ static int set_mlx_qp_type(struct mlx5_ib_dev *dev,
 		}
 	}
 
-	if (!MLX5_CAP_GEN(dev->mdev, dct)) {
-		mlx5_ib_dbg(dev, "DC transport is not supported\n");
-		return -EOPNOTSUPP;
+	return 0;
+}
+
+static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr)
+{
+	if (attr->qp_type == IB_QPT_DRIVER && !MLX5_CAP_GEN(dev->mdev, dct))
+		goto out;
+
+	switch (attr->qp_type) {
+	case IB_QPT_XRC_TGT:
+	case IB_QPT_XRC_INI:
+		if (!MLX5_CAP_GEN(dev->mdev, xrc))
+			goto out;
+		fallthrough;
+	case IB_QPT_RAW_PACKET:
+	case IB_QPT_RC:
+	case IB_QPT_UC:
+	case IB_QPT_UD:
+	case IB_QPT_SMI:
+	case MLX5_IB_QPT_HW_GSI:
+	case MLX5_IB_QPT_REG_UMR:
+	case IB_QPT_DRIVER:
+	case IB_QPT_GSI:
+		return 0;
+	case IB_QPT_RAW_IPV6:
+	case IB_QPT_RAW_ETHERTYPE:
+	case IB_QPT_MAX:
+	default:
+		goto out;
 	}
 
 	return 0;
+
+out:
+	mlx5_ib_dbg(dev, "Unsupported QP type %d\n", attr->qp_type);
+	return -EOPNOTSUPP;
 }
 
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
@@ -2698,9 +2728,17 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
-	if (pd) {
-		dev = to_mdev(pd->device);
+	dev = pd ? to_mdev(pd->device) :
+		   to_mdev(to_mxrcd(init_attr->xrcd)->ibxrcd.device);
 
+	err = check_qp_type(dev, init_attr);
+	if (err) {
+		mlx5_ib_dbg(dev, "Unsupported QP type %d\n",
+			    init_attr->qp_type);
+		return ERR_PTR(err);
+	}
+
+	if (pd) {
 		if (init_attr->qp_type == IB_QPT_RAW_PACKET) {
 			if (!ucontext) {
 				mlx5_ib_dbg(dev, "Raw Packet QP is not supported for kernel consumers\n");
@@ -2718,7 +2756,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				ib_qp_type_str(init_attr->qp_type));
 			return ERR_PTR(-EINVAL);
 		}
-		dev = to_mdev(to_mxrcd(init_attr->xrcd)->ibxrcd.device);
 	}
 
 	if (init_attr->qp_type == IB_QPT_DRIVER) {
@@ -2741,67 +2778,37 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		}
 	}
 
-	switch (init_attr->qp_type) {
-	case IB_QPT_XRC_TGT:
-	case IB_QPT_XRC_INI:
-		if (!MLX5_CAP_GEN(dev->mdev, xrc)) {
-			mlx5_ib_dbg(dev, "XRC not supported\n");
-			return ERR_PTR(-ENOSYS);
-		}
-		init_attr->recv_cq = NULL;
-		if (init_attr->qp_type == IB_QPT_XRC_TGT) {
-			xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
-			init_attr->send_cq = NULL;
-		}
-
-		/* fall through */
-	case IB_QPT_RAW_PACKET:
-	case IB_QPT_RC:
-	case IB_QPT_UC:
-	case IB_QPT_UD:
-	case IB_QPT_SMI:
-	case MLX5_IB_QPT_HW_GSI:
-	case MLX5_IB_QPT_REG_UMR:
-	case MLX5_IB_QPT_DCI:
-		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-		if (!qp)
-			return ERR_PTR(-ENOMEM);
-
-		err = create_qp_common(dev, pd, init_attr, udata, qp);
-		if (err) {
-			mlx5_ib_dbg(dev, "create_qp_common failed\n");
-			kfree(qp);
-			return ERR_PTR(err);
-		}
+	if (init_attr->qp_type == IB_QPT_GSI)
+		return mlx5_ib_gsi_create_qp(pd, init_attr);
 
-		if (is_qp0(init_attr->qp_type))
-			qp->ibqp.qp_num = 0;
-		else if (is_qp1(init_attr->qp_type))
-			qp->ibqp.qp_num = 1;
-		else
-			qp->ibqp.qp_num = qp->trans_qp.base.mqp.qpn;
+	if (init_attr->qp_type == IB_QPT_XRC_TGT) {
+		init_attr->recv_cq = NULL;
+		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
+		init_attr->send_cq = NULL;
+	}
 
-		mlx5_ib_dbg(dev, "ib qpnum 0x%x, mlx qpn 0x%x, rcqn 0x%x, scqn 0x%x\n",
-			    qp->ibqp.qp_num, qp->trans_qp.base.mqp.qpn,
-			    init_attr->recv_cq ? to_mcq(init_attr->recv_cq)->mcq.cqn : -1,
-			    init_attr->send_cq ? to_mcq(init_attr->send_cq)->mcq.cqn : -1);
+	if (init_attr->qp_type == IB_QPT_XRC_INI)
+		init_attr->recv_cq = NULL;
 
-		qp->trans_qp.xrcdn = xrcdn;
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
 
-		break;
+	err = create_qp_common(dev, pd, init_attr, udata, qp);
+	if (err) {
+		mlx5_ib_dbg(dev, "create_qp_common failed\n");
+		kfree(qp);
+		return ERR_PTR(err);
+	}
 
-	case IB_QPT_GSI:
-		return mlx5_ib_gsi_create_qp(pd, init_attr);
+	if (is_qp0(init_attr->qp_type))
+		qp->ibqp.qp_num = 0;
+	else if (is_qp1(init_attr->qp_type))
+		qp->ibqp.qp_num = 1;
+	else
+		qp->ibqp.qp_num = qp->trans_qp.base.mqp.qpn;
 
-	case IB_QPT_RAW_IPV6:
-	case IB_QPT_RAW_ETHERTYPE:
-	case IB_QPT_MAX:
-	default:
-		mlx5_ib_dbg(dev, "unsupported qp type %d\n",
-			    init_attr->qp_type);
-		/* Don't support raw QPs */
-		return ERR_PTR(-EOPNOTSUPP);
-	}
+	qp->trans_qp.xrcdn = xrcdn;
 
 	if (verbs_init_attr->qp_type == IB_QPT_DRIVER)
 		qp->qp_sub_type = init_attr->qp_type;
-- 
2.25.2

