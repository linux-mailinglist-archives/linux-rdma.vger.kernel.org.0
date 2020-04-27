Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92871BA8E7
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgD0Psa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgD0Ps3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E30720728;
        Mon, 27 Apr 2020 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002508;
        bh=kcohJrMyZqziBXZFmURq+qP7vw3Oan5O8UyKozKaevQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blZ0ZLxq8Xy66ZlQdaT1/TU+7ZeunJVy4CoyDnB6KIm8dbMJFxyPBrNQXOwCfatxD
         Hzk+A9ZW6n8V9P7/N0iht4PHifU+XHc5jJnHYjw3GLxQJvxocG7bos4bmL34c4S/2g
         2KFv1lwos8c03WWRvVUZvhik65vFF3RlkgKoX4QU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 29/36] RDMA/mlx5: Reduce amount of duplication in QP destroy
Date:   Mon, 27 Apr 2020 18:46:29 +0300
Message-Id: <20200427154636.381474-30-leon@kernel.org>
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

Delete both PD argument and checks if udata was provided, in favour
of unified destroy QP functions.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 70 +++++++++++++++------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d5061001217e..6b390b0e43af 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1038,25 +1038,36 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return err;
 }
 
-static void destroy_qp_user(struct mlx5_ib_dev *dev, struct ib_pd *pd,
-			    struct mlx5_ib_qp *qp, struct mlx5_ib_qp_base *base,
-			    struct ib_udata *udata)
+static void destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+		       struct mlx5_ib_qp_base *base, struct ib_udata *udata)
 {
-	struct mlx5_ib_ucontext *context =
-		rdma_udata_to_drv_context(
-			udata,
-			struct mlx5_ib_ucontext,
-			ibucontext);
+	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
+		udata, struct mlx5_ib_ucontext, ibucontext);
 
-	mlx5_ib_db_unmap_user(context, &qp->db);
-	ib_umem_release(base->ubuffer.umem);
+	if (udata) {
+		/* User QP */
+		mlx5_ib_db_unmap_user(context, &qp->db);
+		ib_umem_release(base->ubuffer.umem);
 
-	/*
-	 * Free only the BFREGs which are handled by the kernel.
-	 * BFREGs of UARs allocated dynamically are handled by user.
-	 */
-	if (qp->bfregn != MLX5_IB_INVALID_BFREG)
-		mlx5_ib_free_bfreg(dev, &context->bfregi, qp->bfregn);
+		/*
+		 * Free only the BFREGs which are handled by the kernel.
+		 * BFREGs of UARs allocated dynamically are handled by user.
+		 */
+		if (qp->bfregn != MLX5_IB_INVALID_BFREG)
+			mlx5_ib_free_bfreg(dev, &context->bfregi, qp->bfregn);
+		return;
+	}
+
+	/* Kernel QP */
+	kvfree(qp->sq.wqe_head);
+	kvfree(qp->sq.w_list);
+	kvfree(qp->sq.wrid);
+	kvfree(qp->sq.wr_data);
+	kvfree(qp->rq.wrid);
+	if (qp->db.db)
+		mlx5_db_free(dev->mdev, &qp->db);
+	if (qp->buf.frags)
+		mlx5_frag_buf_free(dev->mdev, &qp->buf);
 }
 
 /* get_sq_edge - Get the next nearby edge.
@@ -1202,19 +1213,6 @@ static int _create_kernel_qp(struct mlx5_ib_dev *dev,
 	return err;
 }
 
-static void destroy_qp_kernel(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp)
-{
-	kvfree(qp->sq.wqe_head);
-	kvfree(qp->sq.w_list);
-	kvfree(qp->sq.wrid);
-	kvfree(qp->sq.wr_data);
-	kvfree(qp->rq.wrid);
-	if (qp->db.db)
-		mlx5_db_free(dev->mdev, &qp->db);
-	if (qp->buf.frags)
-		mlx5_frag_buf_free(dev->mdev, &qp->buf);
-}
-
 static u32 get_rx_type(struct mlx5_ib_qp *qp, struct ib_qp_init_attr *attr)
 {
 	if (attr->srq || (qp->type == IB_QPT_XRC_TGT) ||
@@ -1972,7 +1970,7 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev,
 	err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
 	kvfree(in);
 	if (err) {
-		destroy_qp_user(dev, NULL, qp, base, udata);
+		destroy_qp(dev, qp, base, udata);
 		return err;
 	}
 
@@ -2170,10 +2168,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 
 err_create:
-	if (udata)
-		destroy_qp_user(dev, pd, qp, base, udata);
-	else
-		destroy_qp_kernel(dev, qp);
+	destroy_qp(dev, qp, base, udata);
 	return err;
 }
 
@@ -2300,7 +2295,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 
 err_create:
-	destroy_qp_kernel(dev, qp);
+	destroy_qp(dev, qp, base, NULL);
 	return err;
 }
 
@@ -2470,10 +2465,7 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 				     base->mqp.qpn);
 	}
 
-	if (udata)
-		destroy_qp_user(dev, &get_pd(qp)->ibpd, qp, base, udata);
-	else
-		destroy_qp_kernel(dev, qp);
+	destroy_qp(dev, qp, base, udata);
 }
 
 static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-- 
2.25.3

