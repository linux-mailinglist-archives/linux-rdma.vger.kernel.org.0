Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A322C3D171
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391842AbfFKPxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33173 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388958AbfFKPxN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:13 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:53:01 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxLH023036;
        Tue, 11 Jun 2019 18:53:00 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 15/21] RDMA/core: Validate integrity handover device cap
Date:   Tue, 11 Jun 2019 18:52:51 +0300
Message-Id: <1560268377-26560-16-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Protect the case that a ULP tries to allocate a QP with signature
enabled flag while the LLD doesn't support this feature.
While we're here, also move integrity_en attribute from mlx5_qp to
ib_qp as a preparation for adding new integrity API to the rw-API
(that is part of ib_core module).

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/infiniband/core/verbs.c      | 6 ++++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 --
 drivers/infiniband/hw/mlx5/qp.c      | 7 ++-----
 include/rdma/ib_verbs.h              | 1 +
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 54b25adc65d3..3f1632cd49cb 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1158,6 +1158,10 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	    qp_init_attr->cap.max_recv_sge))
 		return ERR_PTR(-EINVAL);
 
+	if ((qp_init_attr->create_flags & IB_QP_CREATE_INTEGRITY_EN) &&
+	    !(device->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * If the callers is using the RDMA API calculate the resources
 	 * needed for the RDMA READ/WRITE operations.
@@ -1233,6 +1237,8 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	qp->max_write_sge = qp_init_attr->cap.max_send_sge;
 	qp->max_read_sge = min_t(u32, qp_init_attr->cap.max_send_sge,
 				 device->attrs.max_sge_rd);
+	if (qp_init_attr->create_flags & IB_QP_CREATE_INTEGRITY_EN)
+		qp->integrity_en = true;
 
 	return qp;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 32ae7af0b17d..06de3507e3d6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -431,8 +431,6 @@ struct mlx5_ib_qp {
 
 	int			create_type;
 
-	bool			integrity_en;
-
 	struct list_head	qps_list;
 	struct list_head	cq_recv_list;
 	struct list_head	cq_send_list;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 53d6baf167ec..4cbafcb215e8 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -496,9 +496,6 @@ static int calc_sq_size(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr,
 			      sizeof(struct mlx5_wqe_inline_seg);
 	attr->cap.max_inline_data = qp->max_inline_data;
 
-	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN)
-		qp->integrity_en = true;
-
 	wq_size = roundup_pow_of_two(attr->cap.max_send_wr * wqe_size);
 	qp->sq.wqe_cnt = wq_size / MLX5_SEND_WQE_BB;
 	if (qp->sq.wqe_cnt > (1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz))) {
@@ -4717,7 +4714,7 @@ static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
 
 	if (unlikely(send_wr->num_sge != 0) ||
 	    unlikely(wr->access & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->integrity_en) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->ibqp.integrity_en) ||
 	    unlikely(!sig_mr->sig->sig_status_checked))
 		return -EINVAL;
 
@@ -4766,7 +4763,7 @@ static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
 
 	if (unlikely(wr->wr.num_sge != 1) ||
 	    unlikely(wr->access_flags & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->integrity_en) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->ibqp.integrity_en) ||
 	    unlikely(!sig_mr->sig->sig_status_checked))
 		return -EINVAL;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3b1799b0f0c0..0da1fa1d02ee 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1722,6 +1722,7 @@ struct ib_qp {
 	struct ib_qp_security  *qp_sec;
 	u8			port;
 
+	bool			integrity_en;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
-- 
2.16.3

