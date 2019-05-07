Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD7164C5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEGNi7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40487 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbfEGNi7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:59 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:41 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFH021865;
        Tue, 7 May 2019 16:38:41 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 17/25] RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
Date:   Tue,  7 May 2019 16:38:31 +0300
Message-Id: <1557236319-9986-18-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a preparation for adding new signature API to the rw-API.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/infiniband/core/verbs.c      | 2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 3 ---
 drivers/infiniband/hw/mlx5/qp.c      | 7 ++-----
 include/rdma/ib_verbs.h              | 1 +
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 151fc2e52b63..7397a20db000 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1223,6 +1223,8 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
 	qp->max_write_sge = qp_init_attr->cap.max_send_sge;
 	qp->max_read_sge = min_t(u32, qp_init_attr->cap.max_send_sge,
 				 device->attrs.max_sge_rd);
+	if (qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN)
+		qp->signature_en = true;
 
 	return qp;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2ad6e483ab9d..c25a5c4bf9d6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -425,9 +425,6 @@ struct mlx5_ib_qp {
 
 	int			create_type;
 
-	/* Store signature errors */
-	bool			signature_en;
-
 	struct list_head	qps_list;
 	struct list_head	cq_recv_list;
 	struct list_head	cq_send_list;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3fb0019c2aca..105ee4477421 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -495,9 +495,6 @@ static int calc_sq_size(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr,
 			      sizeof(struct mlx5_wqe_inline_seg);
 	attr->cap.max_inline_data = qp->max_inline_data;
 
-	if (attr->create_flags & IB_QP_CREATE_SIGNATURE_EN)
-		qp->signature_en = true;
-
 	wq_size = roundup_pow_of_two(attr->cap.max_send_wr * wqe_size);
 	qp->sq.wqe_cnt = wq_size / MLX5_SEND_WQE_BB;
 	if (qp->sq.wqe_cnt > (1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz))) {
@@ -4636,7 +4633,7 @@ static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
 
 	if (unlikely(send_wr->num_sge != 0) ||
 	    unlikely(wr->access & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->signature_en) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->ibqp.signature_en) ||
 	    unlikely(!sig_mr->sig->sig_status_checked))
 		return -EINVAL;
 
@@ -4685,7 +4682,7 @@ static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
 
 	if (unlikely(wr->wr.num_sge != 1) ||
 	    unlikely(wr->access_flags & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->signature_en) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->ibqp.signature_en) ||
 	    unlikely(!sig_mr->sig->sig_status_checked))
 		return -EINVAL;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8e15d8d3f9f4..e0de29206070 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1688,6 +1688,7 @@ struct ib_qp {
 	struct ib_qp_security  *qp_sec;
 	u8			port;
 
+	bool			signature_en;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
-- 
2.16.3

