Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3978026531B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIJV2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731033AbgIJODk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:03:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255AE221E7;
        Thu, 10 Sep 2020 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746478;
        bh=lAZPpPYEAUt6ts0wYXEcptrS+isoaE/Jyx/p5Gt0nqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tPABSlI/N2Aw1egCv10myMco43lHeVfAwX0rpOD5NdXukIXh/OxTwovgPmq+ErP8
         twRHIAkZLGNJvTItjRvoska9J5s1K8mn/9rauKD9mAw/Ry17evhkp+PZN8VQnbVeID
         IE4nin7rJPZjWYwvwwPcM5HoYQhJU1GNXETZNHLQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 09/10] RDMA/mthca: Combine special QP struct with mthca QP
Date:   Thu, 10 Sep 2020 17:00:45 +0300
Message-Id: <20200910140046.1306341-10-leon@kernel.org>
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

As preparation for the removal of QP allocation logic, we need to ensure
that ib_core allocates the right amount of memory before a call to the
driver create_qp(). It requires from driver to have the same structs for
all types of QPs.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mthca/mthca_dev.h      |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c | 13 +++-
 drivers/infiniband/hw/mthca/mthca_provider.h | 27 +++----
 drivers/infiniband/hw/mthca/mthca_qp.c       | 75 ++++++++++----------
 4 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 7550e9d03dec..9dbbf4d16796 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -548,7 +548,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 		    struct ib_qp_cap *cap,
 		    int qpn,
 		    int port,
-		    struct mthca_sqp *sqp,
+		    struct mthca_qp *qp,
 		    struct ib_udata *udata);
 void mthca_free_qp(struct mthca_dev *dev, struct mthca_qp *qp);
 int mthca_create_ah(struct mthca_dev *dev,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 5dbddf8faf99..31b558ff8218 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -535,9 +535,14 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	{
-		qp = kzalloc(sizeof(struct mthca_sqp), GFP_KERNEL);
+		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
 		if (!qp)
 			return ERR_PTR(-ENOMEM);
+		qp->sqp = kzalloc(sizeof(struct mthca_sqp), GFP_KERNEL);
+		if (!qp->sqp) {
+			kfree(qp);
+			return ERR_PTR(-ENOMEM);
+		}
 
 		qp->ibqp.qp_num = init_attr->qp_type == IB_QPT_SMI ? 0 : 1;
 
@@ -546,7 +551,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 				      to_mcq(init_attr->recv_cq),
 				      init_attr->sq_sig_type, &init_attr->cap,
 				      qp->ibqp.qp_num, init_attr->port_num,
-				      to_msqp(qp), udata);
+				      qp, udata);
 		break;
 	}
 	default:
@@ -555,6 +560,7 @@ static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
 	}
 
 	if (err) {
+		kfree(qp->sqp);
 		kfree(qp);
 		return ERR_PTR(err);
 	}
@@ -587,7 +593,8 @@ static int mthca_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 				    to_mqp(qp)->rq.db_index);
 	}
 	mthca_free_qp(to_mdev(qp->device), to_mqp(qp));
-	kfree(qp);
+	kfree(to_mqp(qp)->sqp);
+	kfree(to_mqp(qp));
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.h b/drivers/infiniband/hw/mthca/mthca_provider.h
index 84c64bff0d92..8a77483bb33c 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.h
+++ b/drivers/infiniband/hw/mthca/mthca_provider.h
@@ -240,6 +240,16 @@ struct mthca_wq {
 	__be32    *db;
 };
 
+struct mthca_sqp {
+	int             pkey_index;
+	u32             qkey;
+	u32             send_psn;
+	struct ib_ud_header ud_header;
+	int             header_buf_size;
+	void           *header_buf;
+	dma_addr_t      header_dma;
+};
+
 struct mthca_qp {
 	struct ib_qp           ibqp;
 	int                    refcount;
@@ -265,17 +275,7 @@ struct mthca_qp {
 
 	wait_queue_head_t      wait;
 	struct mutex	       mutex;
-};
-
-struct mthca_sqp {
-	struct mthca_qp qp;
-	int             pkey_index;
-	u32             qkey;
-	u32             send_psn;
-	struct ib_ud_header ud_header;
-	int             header_buf_size;
-	void           *header_buf;
-	dma_addr_t      header_dma;
+	struct mthca_sqp *sqp;
 };
 
 static inline struct mthca_ucontext *to_mucontext(struct ib_ucontext *ibucontext)
@@ -313,9 +313,4 @@ static inline struct mthca_qp *to_mqp(struct ib_qp *ibqp)
 	return container_of(ibqp, struct mthca_qp, ibqp);
 }
 
-static inline struct mthca_sqp *to_msqp(struct mthca_qp *qp)
-{
-	return container_of(qp, struct mthca_sqp, qp);
-}
-
 #endif /* MTHCA_PROVIDER_H */
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index c6e95d0d760a..08a2a7afafd3 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -809,7 +809,7 @@ static int __mthca_modify_qp(struct ib_qp *ibqp,
 		qp->alt_port = attr->alt_port_num;
 
 	if (is_sqp(dev, qp))
-		store_attrs(to_msqp(qp), attr, attr_mask);
+		store_attrs(qp->sqp, attr, attr_mask);
 
 	/*
 	 * If we moved QP0 to RTR, bring the IB link up; if we moved
@@ -1368,39 +1368,40 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 		    struct ib_qp_cap *cap,
 		    int qpn,
 		    int port,
-		    struct mthca_sqp *sqp,
+		    struct mthca_qp *qp,
 		    struct ib_udata *udata)
 {
 	u32 mqpn = qpn * 2 + dev->qp_table.sqp_start + port - 1;
 	int err;
 
-	sqp->qp.transport = MLX;
-	err = mthca_set_qp_size(dev, cap, pd, &sqp->qp);
+	qp->transport = MLX;
+	err = mthca_set_qp_size(dev, cap, pd, qp);
 	if (err)
 		return err;
 
-	sqp->header_buf_size = sqp->qp.sq.max * MTHCA_UD_HEADER_SIZE;
-	sqp->header_buf = dma_alloc_coherent(&dev->pdev->dev, sqp->header_buf_size,
-					     &sqp->header_dma, GFP_KERNEL);
-	if (!sqp->header_buf)
+	qp->sqp->header_buf_size = qp->sq.max * MTHCA_UD_HEADER_SIZE;
+	qp->sqp->header_buf =
+		dma_alloc_coherent(&dev->pdev->dev, qp->sqp->header_buf_size,
+				   &qp->sqp->header_dma, GFP_KERNEL);
+	if (!qp->sqp->header_buf)
 		return -ENOMEM;
 
 	spin_lock_irq(&dev->qp_table.lock);
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
 		goto err_out;
 
-	sqp->qp.port      = port;
-	sqp->qp.qpn       = mqpn;
-	sqp->qp.transport = MLX;
+	qp->port      = port;
+	qp->qpn       = mqpn;
+	qp->transport = MLX;
 
 	err = mthca_alloc_qp_common(dev, pd, send_cq, recv_cq,
-				    send_policy, &sqp->qp, udata);
+				    send_policy, qp, udata);
 	if (err)
 		goto err_out_free;
 
@@ -1421,10 +1422,9 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 
 	mthca_unlock_cqs(send_cq, recv_cq);
 
- err_out:
-	dma_free_coherent(&dev->pdev->dev, sqp->header_buf_size,
-			  sqp->header_buf, sqp->header_dma);
-
+err_out:
+	dma_free_coherent(&dev->pdev->dev, qp->sqp->header_buf_size,
+			  qp->sqp->header_buf, qp->sqp->header_dma);
 	return err;
 }
 
@@ -1487,20 +1487,19 @@ void mthca_free_qp(struct mthca_dev *dev,
 
 	if (is_sqp(dev, qp)) {
 		atomic_dec(&(to_mpd(qp->ibqp.pd)->sqp_count));
-		dma_free_coherent(&dev->pdev->dev,
-				  to_msqp(qp)->header_buf_size,
-				  to_msqp(qp)->header_buf,
-				  to_msqp(qp)->header_dma);
+		dma_free_coherent(&dev->pdev->dev, qp->sqp->header_buf_size,
+				  qp->sqp->header_buf, qp->sqp->header_dma);
 	} else
 		mthca_free(&dev->qp_table.alloc, qp->qpn);
 }
 
 /* Create UD header for an MLX send and build a data segment for it */
-static int build_mlx_header(struct mthca_dev *dev, struct mthca_sqp *sqp,
-			    int ind, const struct ib_ud_wr *wr,
+static int build_mlx_header(struct mthca_dev *dev, struct mthca_qp *qp, int ind,
+			    const struct ib_ud_wr *wr,
 			    struct mthca_mlx_seg *mlx,
 			    struct mthca_data_seg *data)
 {
+	struct mthca_sqp *sqp = qp->sqp;
 	int header_size;
 	int err;
 	u16 pkey;
@@ -1513,7 +1512,7 @@ static int build_mlx_header(struct mthca_dev *dev, struct mthca_sqp *sqp,
 	if (err)
 		return err;
 	mlx->flags &= ~cpu_to_be32(MTHCA_NEXT_SOLICIT | 1);
-	mlx->flags |= cpu_to_be32((!sqp->qp.ibqp.qp_num ? MTHCA_MLX_VL15 : 0) |
+	mlx->flags |= cpu_to_be32((!qp->ibqp.qp_num ? MTHCA_MLX_VL15 : 0) |
 				  (sqp->ud_header.lrh.destination_lid ==
 				   IB_LID_PERMISSIVE ? MTHCA_MLX_SLR : 0) |
 				  (sqp->ud_header.lrh.service_level << 8));
@@ -1534,29 +1533,29 @@ static int build_mlx_header(struct mthca_dev *dev, struct mthca_sqp *sqp,
 		return -EINVAL;
 	}
 
-	sqp->ud_header.lrh.virtual_lane    = !sqp->qp.ibqp.qp_num ? 15 : 0;
+	sqp->ud_header.lrh.virtual_lane    = !qp->ibqp.qp_num ? 15 : 0;
 	if (sqp->ud_header.lrh.destination_lid == IB_LID_PERMISSIVE)
 		sqp->ud_header.lrh.source_lid = IB_LID_PERMISSIVE;
 	sqp->ud_header.bth.solicited_event = !!(wr->wr.send_flags & IB_SEND_SOLICITED);
-	if (!sqp->qp.ibqp.qp_num)
-		ib_get_cached_pkey(&dev->ib_dev, sqp->qp.port,
-				   sqp->pkey_index, &pkey);
+	if (!qp->ibqp.qp_num)
+		ib_get_cached_pkey(&dev->ib_dev, qp->port, sqp->pkey_index,
+				   &pkey);
 	else
-		ib_get_cached_pkey(&dev->ib_dev, sqp->qp.port,
-				   wr->pkey_index, &pkey);
+		ib_get_cached_pkey(&dev->ib_dev, qp->port, wr->pkey_index,
+				   &pkey);
 	sqp->ud_header.bth.pkey = cpu_to_be16(pkey);
 	sqp->ud_header.bth.destination_qpn = cpu_to_be32(wr->remote_qpn);
 	sqp->ud_header.bth.psn = cpu_to_be32((sqp->send_psn++) & ((1 << 24) - 1));
 	sqp->ud_header.deth.qkey = cpu_to_be32(wr->remote_qkey & 0x80000000 ?
 					       sqp->qkey : wr->remote_qkey);
-	sqp->ud_header.deth.source_qpn = cpu_to_be32(sqp->qp.ibqp.qp_num);
+	sqp->ud_header.deth.source_qpn = cpu_to_be32(qp->ibqp.qp_num);
 
 	header_size = ib_ud_header_pack(&sqp->ud_header,
 					sqp->header_buf +
 					ind * MTHCA_UD_HEADER_SIZE);
 
 	data->byte_count = cpu_to_be32(header_size);
-	data->lkey       = cpu_to_be32(to_mpd(sqp->qp.ibqp.pd)->ntmr.ibmr.lkey);
+	data->lkey       = cpu_to_be32(to_mpd(qp->ibqp.pd)->ntmr.ibmr.lkey);
 	data->addr       = cpu_to_be64(sqp->header_dma +
 				       ind * MTHCA_UD_HEADER_SIZE);
 
@@ -1735,9 +1734,9 @@ int mthca_tavor_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			break;
 
 		case MLX:
-			err = build_mlx_header(dev, to_msqp(qp), ind, ud_wr(wr),
-					       wqe - sizeof (struct mthca_next_seg),
-					       wqe);
+			err = build_mlx_header(
+				dev, qp, ind, ud_wr(wr),
+				wqe - sizeof(struct mthca_next_seg), wqe);
 			if (err) {
 				*bad_wr = wr;
 				goto out;
@@ -2065,9 +2064,9 @@ int mthca_arbel_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			break;
 
 		case MLX:
-			err = build_mlx_header(dev, to_msqp(qp), ind, ud_wr(wr),
-					       wqe - sizeof (struct mthca_next_seg),
-					       wqe);
+			err = build_mlx_header(
+				dev, qp, ind, ud_wr(wr),
+				wqe - sizeof(struct mthca_next_seg), wqe);
 			if (err) {
 				*bad_wr = wr;
 				goto out;
-- 
2.26.2

