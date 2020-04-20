Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1791B0FA1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgDTPMy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730186AbgDTPMD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:12:03 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D195820857;
        Mon, 20 Apr 2020 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395522;
        bh=qTbvEW69Y/wd1xZw28U09Gu+Pxyaz1NBWBkrk+jCXaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpu1lCYX87AjvE90IEcvMEMaZjKern4CBeVOb4fazQPtyjvjAvf5xjmHi7gDomNMu
         wpe8XMuqUbA0KwV1j4mpyEXBBflQ2fF+VGhF2EVqAQ7ZLyoY4gHJnI9/6XZpVoOiDv
         RWMZ50zCgRRRuWNE7vGODFNwhf19l/+BI1Piwe18=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 15/18] RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE signature
Date:   Mon, 20 Apr 2020 18:11:02 +0300
Message-Id: <20200420151105.282848-16-leon@kernel.org>
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

MLX5_QP_FLAG_SIGNATURE is exposed to the users but in the kernel
the create_qp flow treated it differently from other MLX5_QP_FLAG_*s.
Fix it by ditching wq_sig boolean variable and use general flag_en
mechanism.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/odp.c     |  2 +-
 drivers/infiniband/hw/mlx5/qp.c      | 36 +++++++++++++++++-----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4492630e7638..251380ff5706 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -446,7 +446,6 @@ struct mlx5_ib_qp {
 	u32			flags;
 	u8			port;
 	u8			state;
-	int			wq_sig;
 	int			scat_cqe;
 	int			max_inline_data;
 	struct mlx5_bf	        bf;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 16af1105cfcf..e4759310c0e2 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1190,7 +1190,7 @@ static int mlx5_ib_mr_responder_pfault_handler_rq(struct mlx5_ib_dev *dev,
 	struct mlx5_ib_wq *wq = &qp->rq;
 	int wqe_size = 1 << wq->wqe_shift;
 
-	if (qp->wq_sig) {
+	if (qp->flags_en & MLX5_QP_FLAG_SIGNATURE) {
 		mlx5_ib_err(dev, "ODP fault with WQE signatures is not supported\n");
 		return -EFAULT;
 	}
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 82152e86c9d6..a3c693ce1865 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -41,9 +41,6 @@
 #include "cmd.h"
 #include "qp.h"
 
-/* not supported currently */
-static int wq_signature;
-
 enum {
 	MLX5_IB_ACK_REQ_FREQ	= 8,
 };
@@ -392,17 +389,26 @@ static int set_rq_size(struct mlx5_ib_dev *dev, struct ib_qp_cap *cap,
 		cap->max_recv_wr = 0;
 		cap->max_recv_sge = 0;
 	} else {
+		int wq_sig = !!(qp->flags_en & MLX5_QP_FLAG_SIGNATURE);
+
 		if (ucmd) {
 			qp->rq.wqe_cnt = ucmd->rq_wqe_count;
 			if (ucmd->rq_wqe_shift > BITS_PER_BYTE * sizeof(ucmd->rq_wqe_shift))
 				return -EINVAL;
 			qp->rq.wqe_shift = ucmd->rq_wqe_shift;
-			if ((1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data_seg) < qp->wq_sig)
+			if ((1 << qp->rq.wqe_shift) /
+				    sizeof(struct mlx5_wqe_data_seg) <
+			    wq_sig)
 				return -EINVAL;
-			qp->rq.max_gs = (1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data_seg) - qp->wq_sig;
+			qp->rq.max_gs =
+				(1 << qp->rq.wqe_shift) /
+					sizeof(struct mlx5_wqe_data_seg) -
+				wq_sig;
 			qp->rq.max_post = qp->rq.wqe_cnt;
 		} else {
-			wqe_size = qp->wq_sig ? sizeof(struct mlx5_wqe_signature_seg) : 0;
+			wqe_size =
+				wq_sig ? sizeof(struct mlx5_wqe_signature_seg) :
+					 0;
 			wqe_size += cap->max_recv_sge * sizeof(struct mlx5_wqe_data_seg);
 			wqe_size = roundup_pow_of_two(wqe_size);
 			wq_size = roundup_pow_of_two(cap->max_recv_wr) * wqe_size;
@@ -416,7 +422,10 @@ static int set_rq_size(struct mlx5_ib_dev *dev, struct ib_qp_cap *cap,
 				return -EINVAL;
 			}
 			qp->rq.wqe_shift = ilog2(wqe_size);
-			qp->rq.max_gs = (1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data_seg) - qp->wq_sig;
+			qp->rq.max_gs =
+				(1 << qp->rq.wqe_shift) /
+					sizeof(struct mlx5_wqe_data_seg) -
+				wq_sig;
 			qp->rq.max_post = qp->rq.wqe_cnt;
 		}
 	}
@@ -2008,7 +2017,8 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		if (err)
 			return err;
 
-		qp->wq_sig = !!(ucmd->flags & MLX5_QP_FLAG_SIGNATURE);
+		if (ucmd->flags & MLX5_QP_FLAG_SIGNATURE)
+			qp->flags_en |= MLX5_QP_FLAG_SIGNATURE;
 		if (MLX5_CAP_GEN(dev->mdev, sctr_data_cqe))
 			qp->scat_cqe =
 				!!(ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE);
@@ -2045,8 +2055,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			}
 			qp->flags_en |= MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE;
 		}
-	} else {
-		qp->wq_sig = !!wq_signature;
 	}
 
 	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
@@ -2115,7 +2123,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		MLX5_SET(qpc, qpc, latency_sensitive, 1);
 
 
-	if (qp->wq_sig)
+	if (qp->flags_en & MLX5_QP_FLAG_SIGNATURE)
 		MLX5_SET(qpc, qpc, wq_signature, 1);
 
 	if (qp->flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
@@ -5050,7 +5058,7 @@ static void finish_wqe(struct mlx5_ib_qp *qp,
 					     mlx5_opcode | ((u32)opmod << 24));
 	ctrl->qpn_ds = cpu_to_be32(size | (qp->trans_qp.base.mqp.qpn << 8));
 	ctrl->fm_ce_se |= fence;
-	if (unlikely(qp->wq_sig))
+	if (unlikely(qp->flags_en & MLX5_QP_FLAG_SIGNATURE))
 		ctrl->signature = wq_sig(ctrl);
 
 	qp->sq.wrid[idx] = wr_id;
@@ -5502,7 +5510,7 @@ static int _mlx5_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		}
 
 		scat = mlx5_frag_buf_get_wqe(&qp->rq.fbc, ind);
-		if (qp->wq_sig)
+		if (qp->flags_en & MLX5_QP_FLAG_SIGNATURE)
 			scat++;
 
 		for (i = 0; i < wr->num_sge; i++)
@@ -5514,7 +5522,7 @@ static int _mlx5_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 			scat[i].addr       = 0;
 		}
 
-		if (qp->wq_sig) {
+		if (qp->flags_en & MLX5_QP_FLAG_SIGNATURE) {
 			sig = (struct mlx5_rwqe_sig *)scat;
 			set_sig_seg(sig, (qp->rq.max_gs + 1) << 2);
 		}
-- 
2.25.2

