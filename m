Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52979265324
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIJV3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgIJOCp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:02:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC95C21D90;
        Thu, 10 Sep 2020 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746468;
        bh=3VY7kEH/+5AyY0jvPW+AsTtFv+18bjXGg7LYLPI2Sew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxL4+wsHYyQube6+89AHyCivRt3I/Kp8Uew5dZvRDVI/Gi7drllDNyFiqjQqxceXg
         qLjb1n5UwYiDMo6aqYWih56H6rTC9QcvZgThma44ziaslioauL0WK8iC9AhEb8gmbW
         fKNnQ6mPHJHHyo7qImkBWelpDNZTQLOPbRkdO8B4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 06/10] RDMA/mlx4: Prepare QP allocation to remove from the driver
Date:   Thu, 10 Sep 2020 17:00:42 +0300
Message-Id: <20200910140046.1306341-7-leon@kernel.org>
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

Since all mlx4 QP have same storage type, move the QP allocation to be
in one place. This change is preparation to removal of such allocation
from the driver.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 142 +++++++++++++-------------------
 1 file changed, 56 insertions(+), 86 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index f30acb563993..39c52c311dad 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -630,8 +630,6 @@ static int create_qp_rss(struct mlx4_ib_dev *dev,
 	if (err)
 		goto err_qpn;
 
-	mutex_init(&qp->mutex);
-
 	INIT_LIST_HEAD(&qp->gid_list);
 	INIT_LIST_HEAD(&qp->steering_rules);
 
@@ -670,80 +668,72 @@ static int create_qp_rss(struct mlx4_ib_dev *dev,
 	return err;
 }
 
-static struct ib_qp *_mlx4_ib_create_qp_rss(struct ib_pd *pd,
-					    struct ib_qp_init_attr *init_attr,
-					    struct ib_udata *udata)
+static int _mlx4_ib_create_qp_rss(struct ib_pd *pd, struct mlx4_ib_qp *qp,
+				  struct ib_qp_init_attr *init_attr,
+				  struct ib_udata *udata)
 {
-	struct mlx4_ib_qp *qp;
 	struct mlx4_ib_create_qp_rss ucmd = {};
 	size_t required_cmd_sz;
 	int err;
 
 	if (!udata) {
 		pr_debug("RSS QP with NULL udata\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	if (udata->outlen)
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	required_cmd_sz = offsetof(typeof(ucmd), reserved1) +
 					sizeof(ucmd.reserved1);
 	if (udata->inlen < required_cmd_sz) {
 		pr_debug("invalid inlen\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	if (ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen))) {
 		pr_debug("copy failed\n");
-		return ERR_PTR(-EFAULT);
+		return -EFAULT;
 	}
 
 	if (memchr_inv(ucmd.reserved, 0, sizeof(ucmd.reserved)))
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	if (ucmd.comp_mask || ucmd.reserved1)
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	if (udata->inlen > sizeof(ucmd) &&
 	    !ib_is_udata_cleared(udata, sizeof(ucmd),
 				 udata->inlen - sizeof(ucmd))) {
 		pr_debug("inlen is not supported\n");
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 	}
 
 	if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
 		pr_debug("RSS QP with unsupported QP type %d\n",
 			 init_attr->qp_type);
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 	}
 
 	if (init_attr->create_flags) {
 		pr_debug("RSS QP doesn't support create flags\n");
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 	}
 
 	if (init_attr->send_cq || init_attr->cap.max_send_wr) {
 		pr_debug("RSS QP with unsupported send attributes\n");
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 	}
 
-	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return ERR_PTR(-ENOMEM);
-
 	qp->pri.vid = 0xFFFF;
 	qp->alt.vid = 0xFFFF;
 
 	err = create_qp_rss(to_mdev(pd->device), init_attr, &ucmd, qp);
-	if (err) {
-		kfree(qp);
-		return ERR_PTR(err);
-	}
+	if (err)
+		return err;
 
 	qp->ibqp.qp_num = qp->mqp.qpn;
-
-	return &qp->ibqp;
+	return 0;
 }
 
 /*
@@ -847,7 +837,6 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 
 	qp->mlx4_ib_qp_type = MLX4_IB_QPT_RAW_PACKET;
 
-	mutex_init(&qp->mutex);
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 	INIT_LIST_HEAD(&qp->gid_list);
@@ -962,12 +951,11 @@ static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 
 static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 			    struct ib_udata *udata, int sqpn,
-			    struct mlx4_ib_qp **caller_qp)
+			    struct mlx4_ib_qp *qp, bool is_sqp)
 {
 	struct mlx4_ib_dev *dev = to_mdev(pd->device);
 	int qpn;
 	int err;
-	struct mlx4_ib_qp *qp;
 	struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx4_ib_ucontext, ibucontext);
 	enum mlx4_ib_qp_type qp_type = (enum mlx4_ib_qp_type) init_attr->qp_type;
@@ -1015,28 +1003,20 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 		sqpn = qpn;
 	}
 
-	if (!*caller_qp) {
-		qp = kzalloc(sizeof(struct mlx4_ib_qp), GFP_KERNEL);
-		if (!qp)
-			return -ENOMEM;
-
+	if (is_sqp) {
 		if (qp_type == MLX4_IB_QPT_SMI || qp_type == MLX4_IB_QPT_GSI ||
 		    (qp_type & (MLX4_IB_QPT_PROXY_SMI | MLX4_IB_QPT_PROXY_SMI_OWNER |
 				MLX4_IB_QPT_PROXY_GSI | MLX4_IB_QPT_TUN_SMI_OWNER))) {
 			qp->sqp = kzalloc(sizeof(struct mlx4_ib_sqp), GFP_KERNEL);
-			if (!qp->sqp) {
-				kfree(qp);
+			if (!qp->sqp)
 				return -ENOMEM;
-			}
 		}
 		qp->pri.vid = 0xFFFF;
 		qp->alt.vid = 0xFFFF;
-	} else
-		qp = *caller_qp;
+	}
 
 	qp->mlx4_ib_qp_type = qp_type;
 
-	mutex_init(&qp->mutex);
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 	INIT_LIST_HEAD(&qp->gid_list);
@@ -1211,9 +1191,6 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 
 	qp->mqp.event = mlx4_ib_qp_event;
 
-	if (!*caller_qp)
-		*caller_qp = qp;
-
 	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
 	mlx4_ib_lock_cqs(to_mcq(init_attr->send_cq),
 			 to_mcq(init_attr->recv_cq));
@@ -1265,11 +1242,7 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 		mlx4_db_free(dev->dev, &qp->db);
 
 err:
-	if (!*caller_qp) {
-		kfree(qp->sqp);
-		kfree(qp);
-	}
-
+	kfree(qp->sqp);
 	return err;
 }
 
@@ -1502,17 +1475,16 @@ static u32 get_sqp_num(struct mlx4_ib_dev *dev, struct ib_qp_init_attr *attr)
 		return dev->dev->caps.spec_qps[attr->port_num - 1].qp1_proxy;
 }
 
-static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
-					struct ib_qp_init_attr *init_attr,
-					struct ib_udata *udata)
+static int _mlx4_ib_create_qp(struct ib_pd *pd, struct mlx4_ib_qp *qp,
+			      struct ib_qp_init_attr *init_attr,
+			      struct ib_udata *udata)
 {
-	struct mlx4_ib_qp *qp = NULL;
 	int err;
 	int sup_u_create_flags = MLX4_IB_QP_BLOCK_MULTICAST_LOOPBACK;
 	u16 xrcdn = 0;
 
 	if (init_attr->rwq_ind_tbl)
-		return _mlx4_ib_create_qp_rss(pd, init_attr, udata);
+		return _mlx4_ib_create_qp_rss(pd, qp, init_attr, udata);
 
 	/*
 	 * We only support LSO, vendor flag1, and multicast loopback blocking,
@@ -1524,16 +1496,16 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 					MLX4_IB_SRIOV_SQP |
 					MLX4_IB_QP_NETIF |
 					MLX4_IB_QP_CREATE_ROCE_V2_GSI))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (init_attr->create_flags & IB_QP_CREATE_NETIF_QP) {
 		if (init_attr->qp_type != IB_QPT_UD)
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 	}
 
 	if (init_attr->create_flags) {
 		if (udata && init_attr->create_flags & ~(sup_u_create_flags))
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 
 		if ((init_attr->create_flags & ~(MLX4_IB_SRIOV_SQP |
 						 MLX4_IB_QP_CREATE_ROCE_V2_GSI  |
@@ -1543,7 +1515,7 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 		     init_attr->qp_type > IB_QPT_GSI) ||
 		    (init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI &&
 		     init_attr->qp_type != IB_QPT_GSI))
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 	}
 
 	switch (init_attr->qp_type) {
@@ -1554,31 +1526,22 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 		fallthrough;
 	case IB_QPT_XRC_INI:
 		if (!(to_mdev(pd->device)->dev->caps.flags & MLX4_DEV_CAP_FLAG_XRC))
-			return ERR_PTR(-ENOSYS);
+			return -ENOSYS;
 		init_attr->recv_cq = init_attr->send_cq;
 		fallthrough;
 	case IB_QPT_RC:
 	case IB_QPT_UC:
 	case IB_QPT_RAW_PACKET:
-		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-		if (!qp)
-			return ERR_PTR(-ENOMEM);
+	case IB_QPT_UD:
 		qp->pri.vid = 0xFFFF;
 		qp->alt.vid = 0xFFFF;
-		fallthrough;
-	case IB_QPT_UD:
-	{
-		err = create_qp_common(pd, init_attr, udata, 0, &qp);
-		if (err) {
-			kfree(qp);
-			return ERR_PTR(err);
-		}
+		err = create_qp_common(pd, init_attr, udata, 0, qp, false);
+		if (err)
+			return err;
 
 		qp->ibqp.qp_num = qp->mqp.qpn;
 		qp->xrcdn = xrcdn;
-
 		break;
-	}
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	{
@@ -1586,21 +1549,21 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 
 		/* Userspace is not allowed to create special QPs: */
 		if (udata)
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		if (init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI) {
 			int res = mlx4_qp_reserve_range(to_mdev(pd->device)->dev,
 							1, 1, &sqpn, 0,
 							MLX4_RES_USAGE_DRIVER);
 
 			if (res)
-				return ERR_PTR(res);
+				return res;
 		} else {
 			sqpn = get_sqp_num(to_mdev(pd->device), init_attr);
 		}
 
-		err = create_qp_common(pd, init_attr, udata, sqpn, &qp);
+		err = create_qp_common(pd, init_attr, udata, sqpn, qp, true);
 		if (err)
-			return ERR_PTR(err);
+			return err;
 
 		qp->port	= init_attr->port_num;
 		qp->ibqp.qp_num = init_attr->qp_type == IB_QPT_SMI ? 0 :
@@ -1609,25 +1572,32 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 	}
 	default:
 		/* Don't support raw QPs */
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 	}
-
-	return &qp->ibqp;
+	return 0;
 }
 
 struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct ib_udata *udata) {
 	struct ib_device *device = pd ? pd->device : init_attr->xrcd->device;
-	struct ib_qp *ibqp;
 	struct mlx4_ib_dev *dev = to_mdev(device);
+	struct mlx4_ib_qp *qp;
+	int ret;
 
-	ibqp = _mlx4_ib_create_qp(pd, init_attr, udata);
+	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&qp->mutex);
+	ret = _mlx4_ib_create_qp(pd, qp, init_attr, udata);
+	if (ret) {
+		kfree(qp);
+		return ERR_PTR(ret);
+	}
 
-	if (!IS_ERR(ibqp) &&
-	    (init_attr->qp_type == IB_QPT_GSI) &&
+	if (init_attr->qp_type == IB_QPT_GSI &&
 	    !(init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI)) {
-		struct mlx4_ib_qp *qp = to_mqp(ibqp);
 		struct mlx4_ib_sqp *sqp = qp->sqp;
 		int is_eth = rdma_cap_eth_ah(&dev->ib_dev, init_attr->port_num);
 
@@ -1647,7 +1617,7 @@ struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
 			init_attr->create_flags &= ~MLX4_IB_QP_CREATE_ROCE_V2_GSI;
 		}
 	}
-	return ibqp;
+	return &qp->ibqp;
 }
 
 static int _mlx4_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
@@ -1674,8 +1644,7 @@ static int _mlx4_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 		destroy_qp_common(dev, mqp, MLX4_IB_QP_SRC, udata);
 	}
 
-	if (is_sqp(dev, mqp))
-		kfree(mqp->sqp);
+	kfree(mqp->sqp);
 	kfree(mqp);
 
 	return 0;
@@ -4156,6 +4125,7 @@ struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 	if (!qp)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&qp->mutex);
 	qp->pri.vid = 0xFFFF;
 	qp->alt.vid = 0xFFFF;
 
-- 
2.26.2

