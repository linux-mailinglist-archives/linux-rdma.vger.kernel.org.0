Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB365F8E1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 15:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGDNJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 09:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfGDNJt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 09:09:49 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D77218AD;
        Thu,  4 Jul 2019 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245788;
        bh=KLstyS+k9a3JpKzGb3+ENEcuJ4PH5H+DbqKBS6bZdg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdNjnCMU+XL4bxYKwD0+eIMKmMG9qWIEpTGZkx2hd4NLjSPSJ2jPbiO6HwwIjZ4fd
         0c2fZ6EIc0zyFhw4s3nqdTbe4ekMDibd3Dd02+ZBdM6E7Cntnz/ep46+8+0P9OW/NY
         MAEKXeTxpEDXQBd+63EyghJqryOFuSCYA6UhJoc0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 1/2] RDMA/mlx4: Separate creation of RWQ and QP
Date:   Thu,  4 Jul 2019 16:09:35 +0300
Message-Id: <20190704130936.8705-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704130936.8705-1-leon@kernel.org>
References: <20190704130936.8705-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The mlx4 WQ is implemented with HW QP without special HW object.
Current implementation which tried to reuse the code did it with
common QP creation flows. Such decision caused to the absence of
mlx4_ib_wq struct, which is needed to ensure proper allocation
of ib_wq inside of IB/core.

Separate create_qp_common() to pure QP flow and to create_rq() for RWQ.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 236 +++++++++++++++++++++-----------
 1 file changed, 154 insertions(+), 82 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 82aff2f2fdc2..e409adac4e2e 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -855,12 +855,143 @@ static void mlx4_ib_release_wqn(struct mlx4_ib_ucontext *context,
 	mutex_unlock(&context->wqn_ranges_mutex);
 }
 
-static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
-			    enum mlx4_ib_source_type src,
-			    struct ib_qp_init_attr *init_attr,
+static int create_rq(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
+		     struct ib_udata *udata, struct mlx4_ib_qp *qp)
+{
+	struct mlx4_ib_dev *dev = to_mdev(pd->device);
+	int qpn;
+	int err;
+	struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
+		udata, struct mlx4_ib_ucontext, ibucontext);
+	struct mlx4_ib_cq *mcq;
+	unsigned long flags;
+	int range_size;
+	struct mlx4_ib_create_wq wq;
+	size_t copy_len;
+	int shift;
+	int n;
+
+	qp->mlx4_ib_qp_type = MLX4_IB_QPT_RAW_PACKET;
+
+	mutex_init(&qp->mutex);
+	spin_lock_init(&qp->sq.lock);
+	spin_lock_init(&qp->rq.lock);
+	INIT_LIST_HEAD(&qp->gid_list);
+	INIT_LIST_HEAD(&qp->steering_rules);
+
+	qp->state = IB_QPS_RESET;
+
+	copy_len = min(sizeof(struct mlx4_ib_create_wq), udata->inlen);
+
+	if (ib_copy_from_udata(&wq, udata, copy_len)) {
+		err = -EFAULT;
+		goto err;
+	}
+
+	if (wq.comp_mask || wq.reserved[0] || wq.reserved[1] ||
+	    wq.reserved[2]) {
+		pr_debug("user command isn't supported\n");
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+
+	if (wq.log_range_size > ilog2(dev->dev->caps.max_rss_tbl_sz)) {
+		pr_debug("WQN range size must be equal or smaller than %d\n",
+			 dev->dev->caps.max_rss_tbl_sz);
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+	range_size = 1 << wq.log_range_size;
+
+	if (init_attr->create_flags & IB_QP_CREATE_SCATTER_FCS)
+		qp->flags |= MLX4_IB_QP_SCATTER_FCS;
+
+	err = set_rq_size(dev, &init_attr->cap, true, 1, qp, qp->inl_recv_sz);
+	if (err)
+		goto err;
+
+	qp->sq_no_prefetch = 1;
+	qp->sq.wqe_cnt = 1;
+	qp->sq.wqe_shift = MLX4_IB_MIN_SQ_STRIDE;
+	qp->buf_size = (qp->rq.wqe_cnt << qp->rq.wqe_shift) +
+		       (qp->sq.wqe_cnt << qp->sq.wqe_shift);
+
+	qp->umem = ib_umem_get(udata, wq.buf_addr, qp->buf_size, 0, 0);
+	if (IS_ERR(qp->umem)) {
+		err = PTR_ERR(qp->umem);
+		goto err;
+	}
+
+	n = ib_umem_page_count(qp->umem);
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0, &n);
+	err = mlx4_mtt_init(dev->dev, n, shift, &qp->mtt);
+
+	if (err)
+		goto err_buf;
+
+	err = mlx4_ib_umem_write_mtt(dev, &qp->mtt, qp->umem);
+	if (err)
+		goto err_mtt;
+
+	err = mlx4_ib_db_map_user(udata, wq.db_addr, &qp->db);
+	if (err)
+		goto err_mtt;
+	qp->mqp.usage = MLX4_RES_USAGE_USER_VERBS;
+
+	err = mlx4_ib_alloc_wqn(context, qp, range_size, &qpn);
+	if (err)
+		goto err_wrid;
+
+	err = mlx4_qp_alloc(dev->dev, qpn, &qp->mqp);
+	if (err)
+		goto err_qpn;
+
+	/*
+	 * Hardware wants QPN written in big-endian order (after
+	 * shifting) for send doorbell.  Precompute this value to save
+	 * a little bit when posting sends.
+	 */
+	qp->doorbell_qpn = swab32(qp->mqp.qpn << 8);
+
+	qp->mqp.event = mlx4_ib_wq_event;
+
+	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
+	mlx4_ib_lock_cqs(to_mcq(init_attr->send_cq),
+			 to_mcq(init_attr->recv_cq));
+	/* Maintain device to QPs access, needed for further handling
+	 * via reset flow
+	 */
+	list_add_tail(&qp->qps_list, &dev->qp_list);
+	/* Maintain CQ to QPs access, needed for further handling
+	 * via reset flow
+	 */
+	mcq = to_mcq(init_attr->send_cq);
+	list_add_tail(&qp->cq_send_list, &mcq->send_qp_list);
+	mcq = to_mcq(init_attr->recv_cq);
+	list_add_tail(&qp->cq_recv_list, &mcq->recv_qp_list);
+	mlx4_ib_unlock_cqs(to_mcq(init_attr->send_cq),
+			   to_mcq(init_attr->recv_cq));
+	spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);
+	return 0;
+
+err_qpn:
+	mlx4_ib_release_wqn(context, qp, 0);
+err_wrid:
+	mlx4_ib_db_unmap_user(context, &qp->db);
+
+err_mtt:
+	mlx4_mtt_cleanup(dev->dev, &qp->mtt);
+err_buf:
+	ib_umem_release(qp->umem);
+err:
+	return err;
+}
+
+static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 			    struct ib_udata *udata, int sqpn,
 			    struct mlx4_ib_qp **caller_qp)
 {
+	struct mlx4_ib_dev *dev = to_mdev(pd->device);
 	int qpn;
 	int err;
 	struct mlx4_ib_sqp *sqp = NULL;
@@ -870,7 +1001,6 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 	enum mlx4_ib_qp_type qp_type = (enum mlx4_ib_qp_type) init_attr->qp_type;
 	struct mlx4_ib_cq *mcq;
 	unsigned long flags;
-	int range_size = 0;
 
 	/* When tunneling special qps, we use a plain UD qp */
 	if (sqpn) {
@@ -921,15 +1051,13 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 			if (!sqp)
 				return -ENOMEM;
 			qp = &sqp->qp;
-			qp->pri.vid = 0xFFFF;
-			qp->alt.vid = 0xFFFF;
 		} else {
 			qp = kzalloc(sizeof(struct mlx4_ib_qp), GFP_KERNEL);
 			if (!qp)
 				return -ENOMEM;
-			qp->pri.vid = 0xFFFF;
-			qp->alt.vid = 0xFFFF;
 		}
+		qp->pri.vid = 0xFFFF;
+		qp->alt.vid = 0xFFFF;
 	} else
 		qp = *caller_qp;
 
@@ -941,48 +1069,24 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 	INIT_LIST_HEAD(&qp->gid_list);
 	INIT_LIST_HEAD(&qp->steering_rules);
 
-	qp->state	 = IB_QPS_RESET;
+	qp->state = IB_QPS_RESET;
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
 		qp->sq_signal_bits = cpu_to_be32(MLX4_WQE_CTRL_CQ_UPDATE);
 
-
 	if (udata) {
-		union {
-			struct mlx4_ib_create_qp qp;
-			struct mlx4_ib_create_wq wq;
-		} ucmd;
+		struct mlx4_ib_create_qp ucmd;
 		size_t copy_len;
 		int shift;
 		int n;
 
-		copy_len = (src == MLX4_IB_QP_SRC) ?
-			   sizeof(struct mlx4_ib_create_qp) :
-			   min(sizeof(struct mlx4_ib_create_wq), udata->inlen);
+		copy_len = sizeof(struct mlx4_ib_create_qp);
 
 		if (ib_copy_from_udata(&ucmd, udata, copy_len)) {
 			err = -EFAULT;
 			goto err;
 		}
 
-		if (src == MLX4_IB_RWQ_SRC) {
-			if (ucmd.wq.comp_mask || ucmd.wq.reserved[0] ||
-			    ucmd.wq.reserved[1] || ucmd.wq.reserved[2]) {
-				pr_debug("user command isn't supported\n");
-				err = -EOPNOTSUPP;
-				goto err;
-			}
-
-			if (ucmd.wq.log_range_size >
-			    ilog2(dev->dev->caps.max_rss_tbl_sz)) {
-				pr_debug("WQN range size must be equal or smaller than %d\n",
-					 dev->dev->caps.max_rss_tbl_sz);
-				err = -EOPNOTSUPP;
-				goto err;
-			}
-			range_size = 1 << ucmd.wq.log_range_size;
-		} else {
-			qp->inl_recv_sz = ucmd.qp.inl_recv_sz;
-		}
+		qp->inl_recv_sz = ucmd.inl_recv_sz;
 
 		if (init_attr->create_flags & IB_QP_CREATE_SCATTER_FCS) {
 			if (!(dev->dev->caps.flags &
@@ -1000,30 +1104,14 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 		if (err)
 			goto err;
 
-		if (src == MLX4_IB_QP_SRC) {
-			qp->sq_no_prefetch = ucmd.qp.sq_no_prefetch;
+		qp->sq_no_prefetch = ucmd.sq_no_prefetch;
 
-			err = set_user_sq_size(dev, qp,
-					       (struct mlx4_ib_create_qp *)
-					       &ucmd);
-			if (err)
-				goto err;
-		} else {
-			qp->sq_no_prefetch = 1;
-			qp->sq.wqe_cnt = 1;
-			qp->sq.wqe_shift = MLX4_IB_MIN_SQ_STRIDE;
-			/* Allocated buffer expects to have at least that SQ
-			 * size.
-			 */
-			qp->buf_size = (qp->rq.wqe_cnt << qp->rq.wqe_shift) +
-				(qp->sq.wqe_cnt << qp->sq.wqe_shift);
-		}
+		err = set_user_sq_size(dev, qp, &ucmd);
+		if (err)
+			goto err;
 
 		qp->umem =
-			ib_umem_get(udata,
-				    (src == MLX4_IB_QP_SRC) ? ucmd.qp.buf_addr :
-							      ucmd.wq.buf_addr,
-				    qp->buf_size, 0, 0);
+			ib_umem_get(udata, ucmd.buf_addr, qp->buf_size, 0, 0);
 		if (IS_ERR(qp->umem)) {
 			err = PTR_ERR(qp->umem);
 			goto err;
@@ -1041,11 +1129,7 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 			goto err_mtt;
 
 		if (qp_has_rq(init_attr)) {
-			err = mlx4_ib_db_map_user(udata,
-						  (src == MLX4_IB_QP_SRC) ?
-							  ucmd.qp.db_addr :
-							  ucmd.wq.db_addr,
-						  &qp->db);
+			err = mlx4_ib_db_map_user(udata, ucmd.db_addr, &qp->db);
 			if (err)
 				goto err_mtt;
 		}
@@ -1115,10 +1199,6 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 				goto err_wrid;
 			}
 		}
-	} else if (src == MLX4_IB_RWQ_SRC) {
-		err = mlx4_ib_alloc_wqn(context, qp, range_size, &qpn);
-		if (err)
-			goto err_wrid;
 	} else {
 		/* Raw packet QPNs may not have bits 6,7 set in their qp_num;
 		 * otherwise, the WQE BlueFlame setup flow wrongly causes
@@ -1157,8 +1237,7 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 	 */
 	qp->doorbell_qpn = swab32(qp->mqp.qpn << 8);
 
-	qp->mqp.event = (src == MLX4_IB_QP_SRC) ? mlx4_ib_qp_event :
-						  mlx4_ib_wq_event;
+	qp->mqp.event = mlx4_ib_qp_event;
 
 	if (!*caller_qp)
 		*caller_qp = qp;
@@ -1186,8 +1265,6 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 	if (!sqpn) {
 		if (qp->flags & MLX4_IB_QP_NETIF)
 			mlx4_ib_steer_qp_free(dev, qpn, 1);
-		else if (src == MLX4_IB_RWQ_SRC)
-			mlx4_ib_release_wqn(context, qp, 0);
 		else
 			mlx4_qp_release_range(dev->dev, qpn, 1);
 	}
@@ -1518,8 +1595,7 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 		/* fall through */
 	case IB_QPT_UD:
 	{
-		err = create_qp_common(to_mdev(pd->device), pd,	MLX4_IB_QP_SRC,
-				       init_attr, udata, 0, &qp);
+		err = create_qp_common(pd, init_attr, udata, 0, &qp);
 		if (err) {
 			kfree(qp);
 			return ERR_PTR(err);
@@ -1549,8 +1625,7 @@ static struct ib_qp *_mlx4_ib_create_qp(struct ib_pd *pd,
 			sqpn = get_sqp_num(to_mdev(pd->device), init_attr);
 		}
 
-		err = create_qp_common(to_mdev(pd->device), pd, MLX4_IB_QP_SRC,
-				       init_attr, udata, sqpn, &qp);
+		err = create_qp_common(pd, init_attr, udata, sqpn, &qp);
 		if (err)
 			return ERR_PTR(err);
 
@@ -4047,8 +4122,8 @@ struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 				struct ib_wq_init_attr *init_attr,
 				struct ib_udata *udata)
 {
-	struct mlx4_ib_dev *dev;
-	struct ib_qp_init_attr ib_qp_init_attr;
+	struct mlx4_dev *dev = to_mdev(pd->device)->dev;
+	struct ib_qp_init_attr ib_qp_init_attr = {};
 	struct mlx4_ib_qp *qp;
 	struct mlx4_ib_create_wq ucmd;
 	int err, required_cmd_sz;
@@ -4073,14 +4148,13 @@ struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 	if (udata->outlen)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	dev = to_mdev(pd->device);
-
 	if (init_attr->wq_type != IB_WQT_RQ) {
 		pr_debug("unsupported wq type %d\n", init_attr->wq_type);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	if (init_attr->create_flags & ~IB_WQ_FLAGS_SCATTER_FCS) {
+	if (init_attr->create_flags & ~IB_WQ_FLAGS_SCATTER_FCS ||
+	    !(dev->caps.flags & MLX4_DEV_CAP_FLAG_FCS_KEEP)) {
 		pr_debug("unsupported create_flags %u\n",
 			 init_attr->create_flags);
 		return ERR_PTR(-EOPNOTSUPP);
@@ -4093,7 +4167,6 @@ struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 	qp->pri.vid = 0xFFFF;
 	qp->alt.vid = 0xFFFF;
 
-	memset(&ib_qp_init_attr, 0, sizeof(ib_qp_init_attr));
 	ib_qp_init_attr.qp_context = init_attr->wq_context;
 	ib_qp_init_attr.qp_type = IB_QPT_RAW_PACKET;
 	ib_qp_init_attr.cap.max_recv_wr = init_attr->max_wr;
@@ -4104,8 +4177,7 @@ struct ib_wq *mlx4_ib_create_wq(struct ib_pd *pd,
 	if (init_attr->create_flags & IB_WQ_FLAGS_SCATTER_FCS)
 		ib_qp_init_attr.create_flags |= IB_QP_CREATE_SCATTER_FCS;
 
-	err = create_qp_common(dev, pd, MLX4_IB_RWQ_SRC, &ib_qp_init_attr,
-			       udata, 0, &qp);
+	err = create_rq(pd, &ib_qp_init_attr, udata, qp);
 	if (err) {
 		kfree(qp);
 		return ERR_PTR(err);
-- 
2.20.1

