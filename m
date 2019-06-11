Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309483D170
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391834AbfFKPxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33161 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391827AbfFKPxN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:13 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:53:00 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxLG023036;
        Tue, 11 Jun 2019 18:53:00 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 14/21] RDMA/core: Rename signature qp create flag and signature device capability
Date:   Tue, 11 Jun 2019 18:52:50 +0300
Message-Id: <1560268377-26560-15-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Rename IB_QP_CREATE_SIGNATURE_EN to IB_QP_CREATE_INTEGRITY_EN
and IB_DEVICE_SIGNATURE_HANDOVER to IB_DEVICE_INTEGRITY_HANDOVER.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/rw.c             |  4 ++--
 drivers/infiniband/hw/mlx5/main.c        |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  3 +--
 drivers/infiniband/hw/mlx5/qp.c          | 14 +++++++-------
 drivers/infiniband/ulp/iser/iser_verbs.c |  4 ++--
 drivers/infiniband/ulp/isert/ib_isert.c  |  4 ++--
 include/rdma/ib_verbs.h                  |  4 ++--
 7 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 3b224f5d036a..289aef824269 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -680,7 +680,7 @@ void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr)
 	 * we'll need two additional MRs for the registrations and the
 	 * invalidation.
 	 */
-	if (attr->create_flags & IB_QP_CREATE_SIGNATURE_EN)
+	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN)
 		factor += 6;	/* (inv + reg) * (data + prot + sig) */
 	else if (rdma_rw_can_use_mr(dev, attr->port_num))
 		factor += 2;	/* inv + reg */
@@ -701,7 +701,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 	u32 nr_mrs = 0, nr_sig_mrs = 0;
 	int ret = 0;
 
-	if (attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) {
+	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN) {
 		nr_sig_mrs = attr->cap.max_rdma_ctxs;
 		nr_mrs = attr->cap.max_rdma_ctxs * 2;
 	} else if (rdma_rw_can_use_mr(dev, attr->port_num)) {
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 1458f1b18d19..4e8a7547d354 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -888,7 +888,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	}
 	props->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
 	if (MLX5_CAP_GEN(mdev, sho)) {
-		props->device_cap_flags |= IB_DEVICE_SIGNATURE_HANDOVER;
+		props->device_cap_flags |= IB_DEVICE_INTEGRITY_HANDOVER;
 		/* At this stage no support for signature handover */
 		props->sig_prot_cap = IB_PROT_T10DIF_TYPE_1 |
 				      IB_PROT_T10DIF_TYPE_2 |
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 07bac37c3450..32ae7af0b17d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -431,8 +431,7 @@ struct mlx5_ib_qp {
 
 	int			create_type;
 
-	/* Store signature errors */
-	bool			signature_en;
+	bool			integrity_en;
 
 	struct list_head	qps_list;
 	struct list_head	cq_recv_list;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7c9fd335d43d..53d6baf167ec 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -442,9 +442,9 @@ static int calc_send_wqe(struct ib_qp_init_attr *attr)
 	}
 
 	size += attr->cap.max_send_sge * sizeof(struct mlx5_wqe_data_seg);
-	if (attr->create_flags & IB_QP_CREATE_SIGNATURE_EN &&
+	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN &&
 	    ALIGN(max_t(int, inl_size, size), MLX5_SEND_WQE_BB) < MLX5_SIG_WQE_SIZE)
-			return MLX5_SIG_WQE_SIZE;
+		return MLX5_SIG_WQE_SIZE;
 	else
 		return ALIGN(max_t(int, inl_size, size), MLX5_SEND_WQE_BB);
 }
@@ -496,8 +496,8 @@ static int calc_sq_size(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr,
 			      sizeof(struct mlx5_wqe_inline_seg);
 	attr->cap.max_inline_data = qp->max_inline_data;
 
-	if (attr->create_flags & IB_QP_CREATE_SIGNATURE_EN)
-		qp->signature_en = true;
+	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN)
+		qp->integrity_en = true;
 
 	wq_size = roundup_pow_of_two(attr->cap.max_send_wr * wqe_size);
 	qp->sq.wqe_cnt = wq_size / MLX5_SEND_WQE_BB;
@@ -1042,7 +1042,7 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev,
 	void *qpc;
 	int err;
 
-	if (init_attr->create_flags & ~(IB_QP_CREATE_SIGNATURE_EN |
+	if (init_attr->create_flags & ~(IB_QP_CREATE_INTEGRITY_EN |
 					IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
 					IB_QP_CREATE_IPOIB_UD_LSO |
 					IB_QP_CREATE_NETIF_QP |
@@ -4717,7 +4717,7 @@ static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
 
 	if (unlikely(send_wr->num_sge != 0) ||
 	    unlikely(wr->access & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->signature_en) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->integrity_en) ||
 	    unlikely(!sig_mr->sig->sig_status_checked))
 		return -EINVAL;
 
@@ -4766,7 +4766,7 @@ static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
 
 	if (unlikely(wr->wr.num_sge != 1) ||
 	    unlikely(wr->access_flags & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->signature_en) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->integrity_en) ||
 	    unlikely(!sig_mr->sig->sig_status_checked))
 		return -EINVAL;
 
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index ea9cf04ad002..a6548de0e218 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -399,7 +399,7 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 	init_attr.qp_type	= IB_QPT_RC;
 	if (ib_conn->pi_support) {
 		init_attr.cap.max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
-		init_attr.create_flags |= IB_QP_CREATE_SIGNATURE_EN;
+		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
 		iser_conn->max_cmds =
 			ISER_GET_MAX_XMIT_CMDS(ISER_QP_SIG_MAX_REQ_DTOS);
 	} else {
@@ -712,7 +712,7 @@ static void iser_addr_handler(struct rdma_cm_id *cma_id)
 	/* connection T10-PI support */
 	if (iser_pi_enable) {
 		if (!(device->ib_device->attrs.device_cap_flags &
-		      IB_DEVICE_SIGNATURE_HANDOVER)) {
+		      IB_DEVICE_INTEGRITY_HANDOVER)) {
 			iser_warn("T10-PI requested but not supported on %s, "
 				  "continue without T10-PI\n",
 				  dev_name(&ib_conn->device->ib_device->dev));
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 3f8ced4341b6..df6c303103d5 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -133,7 +133,7 @@ isert_create_qp(struct isert_conn *isert_conn,
 	attr.sq_sig_type = IB_SIGNAL_REQ_WR;
 	attr.qp_type = IB_QPT_RC;
 	if (device->pi_capable)
-		attr.create_flags |= IB_QP_CREATE_SIGNATURE_EN;
+		attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
 
 	ret = rdma_create_qp(cma_id, device->pd, &attr);
 	if (ret) {
@@ -309,7 +309,7 @@ isert_create_device_ib_res(struct isert_device *device)
 
 	/* Check signature cap */
 	device->pi_capable = ib_dev->attrs.device_cap_flags &
-			     IB_DEVICE_SIGNATURE_HANDOVER ? true : false;
+			     IB_DEVICE_INTEGRITY_HANDOVER ? true : false;
 
 	return 0;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8fd13356c12b..3b1799b0f0c0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -264,7 +264,7 @@ enum ib_device_cap_flags {
 	 */
 	IB_DEVICE_CROSS_CHANNEL			= (1 << 27),
 	IB_DEVICE_MANAGED_FLOW_STEERING		= (1 << 29),
-	IB_DEVICE_SIGNATURE_HANDOVER		= (1 << 30),
+	IB_DEVICE_INTEGRITY_HANDOVER		= (1 << 30),
 	IB_DEVICE_ON_DEMAND_PAGING		= (1ULL << 31),
 	IB_DEVICE_SG_GAPS_REG			= (1ULL << 32),
 	IB_DEVICE_VIRTUAL_FUNCTION		= (1ULL << 33),
@@ -1067,7 +1067,7 @@ enum ib_qp_create_flags {
 	IB_QP_CREATE_MANAGED_SEND               = 1 << 3,
 	IB_QP_CREATE_MANAGED_RECV               = 1 << 4,
 	IB_QP_CREATE_NETIF_QP			= 1 << 5,
-	IB_QP_CREATE_SIGNATURE_EN		= 1 << 6,
+	IB_QP_CREATE_INTEGRITY_EN		= 1 << 6,
 	/* FREE					= 1 << 7, */
 	IB_QP_CREATE_SCATTER_FCS		= 1 << 8,
 	IB_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
-- 
2.16.3

