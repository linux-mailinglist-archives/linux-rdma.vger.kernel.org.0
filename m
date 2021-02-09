Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B5314FDE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBINM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 08:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhBINMB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Feb 2021 08:12:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6443664EB8;
        Tue,  9 Feb 2021 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612876280;
        bh=uQ0LZ/owFm/93ruyutGeryAshLmOQ2HKS7PbiZHXtoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCPb80kDPaGeVxoQ2aVz+0JUAYqJersG74pUVoAKs6KCfy2xf0uqMck/xnwP9VtQS
         RNU/S2fM7FNBIc/Vz2etSWPSYnLljTMJ2FeMOeli56FkAfaRAIb4kiusIqngmqVFma
         Ynrh9jg9E9CqbUK9zmuHAHV+qRwYPxQQp8G/5DwmliUA9AGZKbhVnKDSsyRIi/itLf
         g4gB0vG4ikwO9/GdMCtG0xx32QlnIjYVboJYQJBvCxdtdDCABKraHp9IUnVxjoRiil
         lO7CdeRytIGi3BQr3pKrbIMSFOmatSN6LdemOm8gl1xpgDjx7IleM7wRtQDjQxoqNr
         mFlHmMYeoMQoQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Fail QP creation if the device can not support the CQE TS
Date:   Tue,  9 Feb 2021 15:11:07 +0200
Message-Id: <20210209131107.698833-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210209131107.698833-1-leon@kernel.org>
References: <20210209131107.698833-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

In ConnectX6Dx device, HW can work in real time timestamp mode according
to the device capabilities per RQ/SQ/QP.

When the flag IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION is set, the user
expect to get TS on the CQEs in free running format, so we need to fail
the QP creation if the current mode of the device doesn't support it.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 104 +++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 38df809a1bd5..72105146ab1e 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1079,6 +1079,7 @@ static int _create_kernel_qp(struct mlx5_ib_dev *dev,

 	qpc = MLX5_ADDR_OF(create_qp_in, *in, qpc);
 	MLX5_SET(qpc, qpc, uar_page, uar_index);
+	MLX5_SET(qpc, qpc, ts_format, MLX5_QPC_TIMESTAMP_FORMAT_DEFAULT);
 	MLX5_SET(qpc, qpc, log_page_size, qp->buf.page_shift - MLX5_ADAPTER_PAGE_SHIFT);

 	/* Set "fast registration enabled" for all kernel QPs */
@@ -1173,10 +1174,72 @@ static void destroy_flow_rule_vport_sq(struct mlx5_ib_sq *sq)
 	sq->flow_rule = NULL;
 }

+static int get_rq_ts_format(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *send_cq)
+{
+	bool fr_supported =
+		MLX5_CAP_GEN(dev->mdev, rq_ts_format) ==
+			MLX5_RQ_TIMESTAMP_FORMAT_CAP_FREE_RUNNING ||
+		MLX5_CAP_GEN(dev->mdev, rq_ts_format) ==
+			MLX5_RQ_TIMESTAMP_FORMAT_CAP_FREE_RUNNING_AND_REAL_TIME;
+
+	if (send_cq->create_flags & IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION) {
+		if (!fr_supported) {
+			mlx5_ib_dbg(dev, "Free running TS format is not supported\n");
+			return -EOPNOTSUPP;
+		}
+		return MLX5_RQC_TIMESTAMP_FORMAT_FREE_RUNNING;
+	}
+	return MLX5_RQC_TIMESTAMP_FORMAT_DEFAULT;
+}
+
+static int get_sq_ts_format(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *send_cq)
+{
+	bool fr_supported =
+		MLX5_CAP_GEN(dev->mdev, sq_ts_format) ==
+			MLX5_SQ_TIMESTAMP_FORMAT_CAP_FREE_RUNNING ||
+		MLX5_CAP_GEN(dev->mdev, sq_ts_format) ==
+			MLX5_SQ_TIMESTAMP_FORMAT_CAP_FREE_RUNNING_AND_REAL_TIME;
+
+	if (send_cq->create_flags & IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION) {
+		if (!fr_supported) {
+			mlx5_ib_dbg(dev, "Free running TS format is not supported\n");
+			return -EOPNOTSUPP;
+		}
+		return MLX5_SQC_TIMESTAMP_FORMAT_FREE_RUNNING;
+	}
+	return MLX5_SQC_TIMESTAMP_FORMAT_DEFAULT;
+}
+
+static int get_qp_ts_format(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *send_cq,
+			    struct mlx5_ib_cq *recv_cq)
+{
+	bool fr_supported =
+		MLX5_CAP_ROCE(dev->mdev, qp_ts_format) ==
+			MLX5_QP_TIMESTAMP_FORMAT_CAP_FREE_RUNNING ||
+		MLX5_CAP_ROCE(dev->mdev, qp_ts_format) ==
+			MLX5_QP_TIMESTAMP_FORMAT_CAP_FREE_RUNNING_AND_REAL_TIME;
+	int ts_format = MLX5_QPC_TIMESTAMP_FORMAT_DEFAULT;
+
+	if (recv_cq &&
+	    recv_cq->create_flags & IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION)
+		ts_format = MLX5_QPC_TIMESTAMP_FORMAT_FREE_RUNNING;
+
+	if (send_cq &&
+	    send_cq->create_flags & IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION)
+		ts_format = MLX5_QPC_TIMESTAMP_FORMAT_FREE_RUNNING;
+
+	if (ts_format == MLX5_QPC_TIMESTAMP_FORMAT_FREE_RUNNING &&
+	    !fr_supported) {
+		mlx5_ib_dbg(dev, "Free running TS format is not supported\n");
+		return -EOPNOTSUPP;
+	}
+	return ts_format;
+}
+
 static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 				   struct ib_udata *udata,
 				   struct mlx5_ib_sq *sq, void *qpin,
-				   struct ib_pd *pd)
+				   struct ib_pd *pd, struct mlx5_ib_cq *cq)
 {
 	struct mlx5_ib_ubuffer *ubuffer = &sq->ubuffer;
 	__be64 *pas;
@@ -1188,6 +1251,11 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	int err;
 	unsigned int page_offset_quantized;
 	unsigned long page_size;
+	int ts_format;
+
+	ts_format = get_sq_ts_format(dev, cq);
+	if (ts_format < 0)
+		return ts_format;

 	sq->ubuffer.umem = ib_umem_get_peer(&dev->ib_dev, ubuffer->buf_addr,
 				       ubuffer->buf_size, 0, 0);
@@ -1216,6 +1284,7 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (MLX5_CAP_ETH(dev->mdev, multi_pkt_send_wqe))
 		MLX5_SET(sqc, sqc, allow_multi_pkt_send_wqe, 1);
 	MLX5_SET(sqc, sqc, state, MLX5_SQC_STATE_RST);
+	MLX5_SET(sqc, sqc, ts_format, ts_format);
 	MLX5_SET(sqc, sqc, user_index, MLX5_GET(qpc, qpc, user_index));
 	MLX5_SET(sqc, sqc, cqn, MLX5_GET(qpc, qpc, cqn_snd));
 	MLX5_SET(sqc, sqc, tis_lst_sz, 1);
@@ -1264,7 +1333,7 @@ static void destroy_raw_packet_qp_sq(struct mlx5_ib_dev *dev,

 static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 				   struct mlx5_ib_rq *rq, void *qpin,
-				   struct ib_pd *pd)
+				   struct ib_pd *pd, struct mlx5_ib_cq *cq)
 {
 	struct mlx5_ib_qp *mqp = rq->base.container_mibqp;
 	__be64 *pas;
@@ -1275,9 +1344,14 @@ static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 	struct ib_umem *umem = rq->base.ubuffer.umem;
 	unsigned int page_offset_quantized;
 	unsigned long page_size = 0;
+	int ts_format;
 	size_t inlen;
 	int err;

+	ts_format = get_rq_ts_format(dev, cq);
+	if (ts_format < 0)
+		return ts_format;
+
 	page_size = mlx5_umem_find_best_quantized_pgoff(umem, wq, log_wq_pg_sz,
 							MLX5_ADAPTER_PAGE_SHIFT,
 							page_offset, 64,
@@ -1297,6 +1371,7 @@ static int create_raw_packet_qp_rq(struct mlx5_ib_dev *dev,
 		MLX5_SET(rqc, rqc, vsd, 1);
 	MLX5_SET(rqc, rqc, mem_rq_type, MLX5_RQC_MEM_RQ_TYPE_MEMORY_RQ_INLINE);
 	MLX5_SET(rqc, rqc, state, MLX5_RQC_STATE_RST);
+	MLX5_SET(rqc, rqc, ts_format, ts_format);
 	MLX5_SET(rqc, rqc, flush_in_error_en, 1);
 	MLX5_SET(rqc, rqc, user_index, MLX5_GET(qpc, qpc, user_index));
 	MLX5_SET(rqc, rqc, cqn, MLX5_GET(qpc, qpc, cqn_rcv));
@@ -1394,10 +1469,10 @@ static int create_raw_packet_qp_tir(struct mlx5_ib_dev *dev,
 }

 static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-				u32 *in, size_t inlen,
-				struct ib_pd *pd,
+				u32 *in, size_t inlen, struct ib_pd *pd,
 				struct ib_udata *udata,
-				struct mlx5_ib_create_qp_resp *resp)
+				struct mlx5_ib_create_qp_resp *resp,
+				struct ib_qp_init_attr *init_attr)
 {
 	struct mlx5_ib_raw_packet_qp *raw_packet_qp = &qp->raw_packet_qp;
 	struct mlx5_ib_sq *sq = &raw_packet_qp->sq;
@@ -1416,7 +1491,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		if (err)
 			return err;

-		err = create_raw_packet_qp_sq(dev, udata, sq, in, pd);
+		err = create_raw_packet_qp_sq(dev, udata, sq, in, pd,
+					      to_mcq(init_attr->send_cq));
 		if (err)
 			goto err_destroy_tis;

@@ -1438,7 +1514,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			rq->flags |= MLX5_IB_RQ_CVLAN_STRIPPING;
 		if (qp->flags & IB_QP_CREATE_PCI_WRITE_END_PADDING)
 			rq->flags |= MLX5_IB_RQ_PCI_WRITE_END_PADDING;
-		err = create_raw_packet_qp_rq(dev, rq, in, pd);
+		err = create_raw_packet_qp_rq(dev, rq, in, pd,
+					      to_mcq(init_attr->recv_cq));
 		if (err)
 			goto err_destroy_sq;

@@ -1908,6 +1985,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct mlx5_ib_cq *recv_cq;
 	unsigned long flags;
 	struct mlx5_ib_qp_base *base;
+	int ts_format;
 	int mlx5_st;
 	void *qpc;
 	u32 *in;
@@ -1945,6 +2023,13 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (ucmd->sq_wqe_count > (1 << MLX5_CAP_GEN(mdev, log_max_qp_sz)))
 		return -EINVAL;

+	if (init_attr->qp_type != IB_QPT_RAW_PACKET) {
+		ts_format = get_qp_ts_format(dev, to_mcq(init_attr->send_cq),
+					     to_mcq(init_attr->recv_cq));
+		if (ts_format < 0)
+			return ts_format;
+	}
+
 	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
 			      &inlen, base, ucmd);
 	if (err)
@@ -1993,6 +2078,9 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		MLX5_SET(qpc, qpc, log_rq_size, ilog2(qp->rq.wqe_cnt));
 	}

+	if (init_attr->qp_type != IB_QPT_RAW_PACKET)
+		MLX5_SET(qpc, qpc, ts_format, ts_format);
+
 	MLX5_SET(qpc, qpc, rq_type, get_rx_type(qp, init_attr));

 	if (qp->sq.wqe_cnt) {
@@ -2047,7 +2135,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
-					   &params->resp);
+					   &params->resp, init_attr);
 	} else
 		err = mlx5_qpc_create_qp(dev, &base->mqp, in, inlen, out);

--
2.29.2

