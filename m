Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233401DAD72
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETI3l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 04:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETI3l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 04:29:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8371206C3;
        Wed, 20 May 2020 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589963380;
        bh=uN2bcn9uKpyuQNTmjnfxRvH9yBbet9vRnmVPE7qzZ6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ek2epOfwdCwm3RKlXUrNeSzWkF1K2L4tSlPbt6sF39jWcnCMvSYulAGnaYU94bbIl
         xw8Pu1zGmLyY5ikPOuSa470Wv7vnB0dvV+CUwZHYtx5QEOfWeMtdYaIDPACvmILedc
         AlusN5zxP44qBRVbi//2gR+vExWfbRkRghconVj8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/8] RDMA/mlx5: Remove manually crafted QP context the query call
Date:   Wed, 20 May 2020 11:29:16 +0300
Message-Id: <20200520082919.440939-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520082919.440939-1-leon@kernel.org>
References: <20200520082919.440939-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

As a preparation to removal hand crafted mlx5_qp_context, convert
query_qp_attr() to use proper MLX5_GET() macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 128 ++++++++++++++------------------
 1 file changed, 56 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9f9241030800..f29e0cc94f81 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4334,48 +4334,34 @@ static inline enum ib_mig_state to_ib_mig_state(int mlx5_mig_state)
 	}
 }
 
-static int to_ib_qp_access_flags(int mlx5_flags)
-{
-	int ib_flags = 0;
-
-	if (mlx5_flags & MLX5_QP_BIT_RRE)
-		ib_flags |= IB_ACCESS_REMOTE_READ;
-	if (mlx5_flags & MLX5_QP_BIT_RWE)
-		ib_flags |= IB_ACCESS_REMOTE_WRITE;
-	if (mlx5_flags & MLX5_QP_BIT_RAE)
-		ib_flags |= IB_ACCESS_REMOTE_ATOMIC;
-
-	return ib_flags;
-}
-
 static void to_rdma_ah_attr(struct mlx5_ib_dev *ibdev,
-			    struct rdma_ah_attr *ah_attr,
-			    struct mlx5_qp_path *path)
+			    struct rdma_ah_attr *ah_attr, void *path)
 {
+	int port = MLX5_GET(ads, path, vhca_port_num);
+	int static_rate;
 
 	memset(ah_attr, 0, sizeof(*ah_attr));
 
-	if (!path->port || path->port > ibdev->num_ports)
+	if (!port || port > ibdev->num_ports)
 		return;
 
-	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, path->port);
+	ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port);
 
-	rdma_ah_set_port_num(ah_attr, path->port);
-	rdma_ah_set_sl(ah_attr, path->dci_cfi_prio_sl & 0xf);
+	rdma_ah_set_port_num(ah_attr, port);
+	rdma_ah_set_sl(ah_attr, MLX5_GET(ads, path, sl));
 
-	rdma_ah_set_dlid(ah_attr, be16_to_cpu(path->rlid));
-	rdma_ah_set_path_bits(ah_attr, path->grh_mlid & 0x7f);
-	rdma_ah_set_static_rate(ah_attr,
-				path->static_rate ? path->static_rate - 5 : 0);
-	if (path->grh_mlid & (1 << 7)) {
-		u32 tc_fl = be32_to_cpu(path->tclass_flowlabel);
+	rdma_ah_set_dlid(ah_attr, MLX5_GET(ads, path, rlid));
+	rdma_ah_set_path_bits(ah_attr, MLX5_GET(ads, path, mlid));
 
-		rdma_ah_set_grh(ah_attr, NULL,
-				tc_fl & 0xfffff,
-				path->mgid_index,
-				path->hop_limit,
-				(tc_fl >> 20) & 0xff);
-		rdma_ah_set_dgid_raw(ah_attr, path->rgid);
+	static_rate = MLX5_GET(ads, path, stat_rate);
+	rdma_ah_set_static_rate(ah_attr, static_rate ? static_rate - 5 : 0);
+	if (MLX5_GET(ads, path, grh)) {
+		rdma_ah_set_grh(ah_attr, NULL, MLX5_GET(ads, path, flow_label),
+				MLX5_GET(ads, path, src_addr_index),
+				MLX5_GET(ads, path, hop_limit),
+				MLX5_GET(ads, path, tclass));
+		memcpy(ah_attr, MLX5_ADDR_OF(ads, path, rgid_rip),
+		       MLX5_FLD_SZ_BYTES(ads, rgid_rip));
 	}
 }
 
@@ -4497,10 +4483,9 @@ static int query_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			 struct ib_qp_attr *qp_attr)
 {
 	int outlen = MLX5_ST_SZ_BYTES(query_qp_out);
-	struct mlx5_qp_context *context;
-	int mlx5_state;
+	void *qpc, *pri_path, *alt_path;
 	u32 *outb;
-	int err = 0;
+	int err;
 
 	outb = kzalloc(outlen, GFP_KERNEL);
 	if (!outb)
@@ -4510,47 +4495,46 @@ static int query_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (err)
 		goto out;
 
-	/* FIXME: use MLX5_GET rather than mlx5_qp_context manual struct */
-	context = (struct mlx5_qp_context *)MLX5_ADDR_OF(query_qp_out, outb, qpc);
+	qpc = MLX5_ADDR_OF(query_qp_out, outb, qpc);
+
+	qp->state = to_ib_qp_state(MLX5_GET(qpc, qpc, state));
+	if (MLX5_GET(qpc, qpc, state) == MLX5_QP_STATE_SQ_DRAINING)
+		qp_attr->sq_draining = 1;
+
+	qp_attr->path_mtu = MLX5_GET(qpc, qpc, mtu);
+	qp_attr->path_mig_state = MLX5_GET(qpc, qpc, pm_state);
+	qp_attr->qkey = MLX5_GET(qpc, qpc, q_key);
+	qp_attr->rq_psn = MLX5_GET(qpc, qpc, next_rcv_psn);
+	qp_attr->sq_psn = MLX5_GET(qpc, qpc, next_send_psn);
+	qp_attr->dest_qp_num = MLX5_GET(qpc, qpc, remote_qpn);
 
-	mlx5_state = be32_to_cpu(context->flags) >> 28;
+	if (MLX5_GET(qpc, qpc, rre))
+		qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ;
+	if (MLX5_GET(qpc, qpc, rwe))
+		qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_WRITE;
+	if (MLX5_GET(qpc, qpc, rae))
+		qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_ATOMIC;
 
-	qp->state		     = to_ib_qp_state(mlx5_state);
-	qp_attr->path_mtu	     = context->mtu_msgmax >> 5;
-	qp_attr->path_mig_state	     =
-		to_ib_mig_state((be32_to_cpu(context->flags) >> 11) & 0x3);
-	qp_attr->qkey		     = be32_to_cpu(context->qkey);
-	qp_attr->rq_psn		     = be32_to_cpu(context->rnr_nextrecvpsn) & 0xffffff;
-	qp_attr->sq_psn		     = be32_to_cpu(context->next_send_psn) & 0xffffff;
-	qp_attr->dest_qp_num	     = be32_to_cpu(context->log_pg_sz_remote_qpn) & 0xffffff;
-	qp_attr->qp_access_flags     =
-		to_ib_qp_access_flags(be32_to_cpu(context->params2));
+	qp_attr->max_rd_atomic = 1 << MLX5_GET(qpc, qpc, log_sra_max);
+	qp_attr->max_dest_rd_atomic = 1 << MLX5_GET(qpc, qpc, log_rra_max);
+	qp_attr->min_rnr_timer = MLX5_GET(qpc, qpc, min_rnr_nak);
+	qp_attr->retry_cnt = MLX5_GET(qpc, qpc, retry_count);
+	qp_attr->rnr_retry = MLX5_GET(qpc, qpc, rnr_retry);
+
+	pri_path = MLX5_ADDR_OF(qpc, qpc, primary_address_path);
+	alt_path = MLX5_ADDR_OF(qpc, qpc, secondary_address_path);
 
 	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC) {
-		to_rdma_ah_attr(dev, &qp_attr->ah_attr, &context->pri_path);
-		to_rdma_ah_attr(dev, &qp_attr->alt_ah_attr, &context->alt_path);
-		qp_attr->alt_pkey_index =
-			be16_to_cpu(context->alt_path.pkey_index);
-		qp_attr->alt_port_num	=
-			rdma_ah_get_port_num(&qp_attr->alt_ah_attr);
-	}
-
-	qp_attr->pkey_index = be16_to_cpu(context->pri_path.pkey_index);
-	qp_attr->port_num = context->pri_path.port;
-
-	/* qp_attr->en_sqd_async_notify is only applicable in modify qp */
-	qp_attr->sq_draining = mlx5_state == MLX5_QP_STATE_SQ_DRAINING;
-
-	qp_attr->max_rd_atomic = 1 << ((be32_to_cpu(context->params1) >> 21) & 0x7);
-
-	qp_attr->max_dest_rd_atomic =
-		1 << ((be32_to_cpu(context->params2) >> 21) & 0x7);
-	qp_attr->min_rnr_timer	    =
-		(be32_to_cpu(context->rnr_nextrecvpsn) >> 24) & 0x1f;
-	qp_attr->timeout	    = context->pri_path.ackto_lt >> 3;
-	qp_attr->retry_cnt	    = (be32_to_cpu(context->params1) >> 16) & 0x7;
-	qp_attr->rnr_retry	    = (be32_to_cpu(context->params1) >> 13) & 0x7;
-	qp_attr->alt_timeout	    = context->alt_path.ackto_lt >> 3;
+		to_rdma_ah_attr(dev, &qp_attr->ah_attr, pri_path);
+		to_rdma_ah_attr(dev, &qp_attr->alt_ah_attr, alt_path);
+		qp_attr->alt_pkey_index = MLX5_GET(ads, alt_path, pkey_index);
+		qp_attr->alt_port_num = MLX5_GET(ads, alt_path, vhca_port_num);
+	}
+
+	qp_attr->pkey_index = MLX5_GET(ads, pri_path, pkey_index);
+	qp_attr->port_num = MLX5_GET(ads, pri_path, vhca_port_num);
+	qp_attr->timeout = MLX5_GET(ads, pri_path, ack_timeout);
+	qp_attr->alt_timeout = MLX5_GET(ads, alt_path, ack_timeout);
 
 out:
 	kfree(outb);
-- 
2.26.2

