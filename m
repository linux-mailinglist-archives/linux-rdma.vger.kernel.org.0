Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F611B642A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgDWTDb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 15:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDWTDb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 15:03:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6322120728;
        Thu, 23 Apr 2020 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668611;
        bh=BYQB7FuMaS1C3vPa/HvrC211zVV7/0q/tqZ4xR+Veec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8TXm4Fg2iBeeFfoPci0ESn38pU2v8F4OmddU8wHJpVV0syOW9/q908rbr6yC8S53
         HSqsMFO6Amzk3SUUXG1dP8XUVh/q/op5UQMGzrmIo2FuPAG5S4OnmG8cPn6p88Xc0i
         mIHz7YaFa4vCMHg6HDPidIJ4syHXVl4gnuAFyeiQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 06/18] RDMA/mlx5: Rely on existence of udata to separate kernel/user flows
Date:   Thu, 23 Apr 2020 22:02:51 +0300
Message-Id: <20200423190303.12856-7-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423190303.12856-1-leon@kernel.org>
References: <20200423190303.12856-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Instead of keeping special field to separate kernel/user create/destroy
flows, rely on existence of udata pointer. All allocation flows are
using kzalloc() and leave uninitialized pointers as NULL which makes
MLX5_QP_EMPTY and MLX5_QP_KERNEL flows to be the same.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 --------------
 drivers/infiniband/hw/mlx5/qp.c      | 23 ++++++++++-------------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 6b500f9b2346..25007e3aebf7 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -337,7 +337,6 @@ struct mlx5_ib_rwq {
 	struct ib_umem		*umem;
 	size_t			buf_size;
 	unsigned int		page_shift;
-	int			create_type;
 	struct mlx5_db		db;
 	u32			user_index;
 	u32			wqe_count;
@@ -346,17 +345,6 @@ struct mlx5_ib_rwq {
 	u32			create_flags; /* Use enum mlx5_ib_wq_flags */
 };
 
-enum {
-	MLX5_QP_USER,
-	MLX5_QP_KERNEL,
-	MLX5_QP_EMPTY
-};
-
-enum {
-	MLX5_WQ_USER,
-	MLX5_WQ_KERNEL
-};
-
 struct mlx5_ib_rwq_ind_table {
 	struct ib_rwq_ind_table ib_rwq_ind_tbl;
 	u32			rqtn;
@@ -457,8 +445,6 @@ struct mlx5_ib_qp {
 	 */
 	int			bfregn;
 
-	int			create_type;
-
 	struct list_head	qps_list;
 	struct list_head	cq_recv_list;
 	struct list_head	cq_send_list;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0f7a8f45764f..007163753f6f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -897,7 +897,6 @@ static int create_user_rq(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		goto err_umem;
 	}
 
-	rwq->create_type = MLX5_WQ_USER;
 	return 0;
 
 err_umem:
@@ -1022,7 +1021,6 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		mlx5_ib_dbg(dev, "copy failed\n");
 		goto err_unmap;
 	}
-	qp->create_type = MLX5_QP_USER;
 
 	return 0;
 
@@ -1187,7 +1185,6 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 		err = -ENOMEM;
 		goto err_wrid;
 	}
-	qp->create_type = MLX5_QP_KERNEL;
 
 	return 0;
 
@@ -1214,8 +1211,10 @@ static void destroy_qp_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp)
 	kvfree(qp->sq.wrid);
 	kvfree(qp->sq.wr_data);
 	kvfree(qp->rq.wrid);
-	mlx5_db_free(dev->mdev, &qp->db);
-	mlx5_frag_buf_free(dev->mdev, &qp->buf);
+	if (qp->db.db)
+		mlx5_db_free(dev->mdev, &qp->db);
+	if (qp->buf.frags)
+		mlx5_frag_buf_free(dev->mdev, &qp->buf);
 }
 
 static u32 get_rx_type(struct mlx5_ib_qp *qp, struct ib_qp_init_attr *attr)
@@ -2000,8 +1999,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		in = kvzalloc(inlen, GFP_KERNEL);
 		if (!in)
 			return -ENOMEM;
-
-		qp->create_type = MLX5_QP_EMPTY;
 	}
 
 	if (is_sqp(init_attr->qp_type))
@@ -2155,9 +2152,9 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 
 err_create:
-	if (qp->create_type == MLX5_QP_USER)
+	if (udata)
 		destroy_qp_user(dev, pd, qp, base, udata);
-	else if (qp->create_type == MLX5_QP_KERNEL)
+	else
 		destroy_qp_kernel(dev, qp);
 
 err:
@@ -2311,7 +2308,7 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (recv_cq)
 		list_del(&qp->cq_recv_list);
 
-	if (qp->create_type == MLX5_QP_KERNEL) {
+	if (!udata) {
 		__mlx5_ib_cq_clean(recv_cq, base->mqp.qpn,
 				   qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
 		if (send_cq != recv_cq)
@@ -2331,10 +2328,10 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				     base->mqp.qpn);
 	}
 
-	if (qp->create_type == MLX5_QP_KERNEL)
-		destroy_qp_kernel(dev, qp);
-	else if (qp->create_type == MLX5_QP_USER)
+	if (udata)
 		destroy_qp_user(dev, &get_pd(qp)->ibpd, qp, base, udata);
+	else
+		destroy_qp_kernel(dev, qp);
 }
 
 static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-- 
2.25.3

