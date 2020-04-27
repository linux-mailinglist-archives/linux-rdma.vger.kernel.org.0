Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890951BA903
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgD0Psp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgD0Pso (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EEE5206D9;
        Mon, 27 Apr 2020 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002523;
        bh=yz4VI0jrgXwXbYAMzQnJWK6XlsZLs5WKYcGj5unIB1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKNYXG2qI8RU7jiyBsG43h7BOVRsorh/fsDj/yOrCwfvMPv4+1WPFdeoeuzx/P2wG
         7nikePO9gEI2kISFIgKOZh0Cp6AydreuW3KWR8Xzl7Bby9Jvm4hXj2+nAqiHjPsiKb
         Ew2nb9t1njGzDudr18veLBG0kLtB0y4UeSr8zigQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 33/36] RDMA/mlx5: Copy response to the user in one place
Date:   Mon, 27 Apr 2020 18:46:33 +0300
Message-Id: <20200427154636.381474-34-leon@kernel.org>
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

Update all the places in create QP flows to copy response
to the user in one place.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 113 +++++++++++++++-----------------
 1 file changed, 52 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0d06706e6ce1..9ca742189281 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1015,17 +1015,8 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		goto err_free;
 	}
 
-	err = ib_copy_to_udata(udata, resp, min(udata->outlen, sizeof(*resp)));
-	if (err) {
-		mlx5_ib_dbg(dev, "copy failed\n");
-		goto err_unmap;
-	}
-
 	return 0;
 
-err_unmap:
-	mlx5_ib_db_unmap_user(context, &qp->db);
-
 err_free:
 	kvfree(*in);
 
@@ -1551,14 +1542,8 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 
 	qp->trans_qp.base.mqp.qpn = qp->sq.wqe_cnt ? sq->base.mqp.qpn :
 						     rq->base.mqp.qpn;
-	err = ib_copy_to_udata(udata, resp, min(udata->outlen, sizeof(*resp)));
-	if (err)
-		goto err_destroy_tir;
-
 	return 0;
 
-err_destroy_tir:
-	destroy_raw_packet_qp_tir(dev, rq, qp->flags_en, pd);
 err_destroy_rq:
 	destroy_raw_packet_qp_rq(dev, rq);
 err_destroy_sq:
@@ -1618,6 +1603,7 @@ struct mlx5_create_qp_params {
 	u8 is_rss_raw : 1;
 	struct ib_qp_init_attr *attr;
 	u32 uidx;
+	struct mlx5_ib_create_qp_resp resp;
 };
 
 static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
@@ -1629,7 +1615,6 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct ib_udata *udata = params->udata;
 	struct mlx5_ib_ucontext *mucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
-	struct mlx5_ib_create_qp_resp resp = {};
 	int inlen;
 	int outlen;
 	int err;
@@ -1662,12 +1647,6 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (qp->flags_en & MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC)
 		lb_flag |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
 
-	err = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
-	if (err) {
-		mlx5_ib_dbg(dev, "copy failed\n");
-		return -EINVAL;
-	}
-
 	inlen = MLX5_ST_SZ_BYTES(create_tir_in);
 	outlen = MLX5_ST_SZ_BYTES(create_tir_out);
 	in = kvzalloc(inlen + outlen, GFP_KERNEL);
@@ -1803,34 +1782,30 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		goto err;
 
 	if (mucontext->devx_uid) {
-		resp.comp_mask |= MLX5_IB_CREATE_QP_RESP_MASK_TIRN;
-		resp.tirn = qp->rss_qp.tirn;
+		params->resp.comp_mask |= MLX5_IB_CREATE_QP_RESP_MASK_TIRN;
+		params->resp.tirn = qp->rss_qp.tirn;
 		if (MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner)) {
-			resp.tir_icm_addr =
+			params->resp.tir_icm_addr =
 				MLX5_GET(create_tir_out, out, icm_address_31_0);
-			resp.tir_icm_addr |= (u64)MLX5_GET(create_tir_out, out,
-							   icm_address_39_32)
-					     << 32;
-			resp.tir_icm_addr |= (u64)MLX5_GET(create_tir_out, out,
-							   icm_address_63_40)
-					     << 40;
-			resp.comp_mask |=
+			params->resp.tir_icm_addr |=
+				(u64)MLX5_GET(create_tir_out, out,
+					      icm_address_39_32)
+				<< 32;
+			params->resp.tir_icm_addr |=
+				(u64)MLX5_GET(create_tir_out, out,
+					      icm_address_63_40)
+				<< 40;
+			params->resp.comp_mask |=
 				MLX5_IB_CREATE_QP_RESP_MASK_TIR_ICM_ADDR;
 		}
 	}
 
-	err = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
-	if (err)
-		goto err_copy;
-
 	kvfree(in);
 	/* qpn is reserved for that QP */
 	qp->trans_qp.base.mqp.qpn = 0;
 	qp->is_rss = true;
 	return 0;
 
-err_copy:
-	mlx5_cmd_destroy_tir(dev->mdev, qp->rss_qp.tirn, mucontext->devx_uid);
 err:
 	kvfree(in);
 	return err;
@@ -1995,7 +1970,6 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_ib_create_qp_resp resp = {};
 	struct mlx5_ib_cq *send_cq;
 	struct mlx5_ib_cq *recv_cq;
 	unsigned long flags;
@@ -2038,8 +2012,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (ucmd->sq_wqe_count > (1 << MLX5_CAP_GEN(mdev, log_max_qp_sz)))
 		return -EINVAL;
 
-	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &resp, &inlen,
-			      base, ucmd);
+	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
+			      &inlen, base, ucmd);
 	if (err)
 		return err;
 
@@ -2139,7 +2113,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		qp->raw_packet_qp.sq.ubuffer.buf_addr = ucmd->sq_buf_addr;
 		raw_packet_qp_copy_info(qp, &qp->raw_packet_qp);
 		err = create_raw_packet_qp(dev, qp, in, inlen, pd, udata,
-					   &resp);
+					   &params->resp);
 	} else
 		err = mlx5_core_create_qp(dev, &base->mqp, in, inlen);
 
@@ -2865,6 +2839,25 @@ static int get_qp_uidx(struct mlx5_ib_qp *qp,
 	return get_qp_user_index(ucontext, ucmd, sizeof(*ucmd), &params->uidx);
 }
 
+static int mlx5_ib_destroy_dct(struct mlx5_ib_qp *mqp)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mqp->ibqp.device);
+
+	if (mqp->state == IB_QPS_RTR) {
+		int err;
+
+		err = mlx5_core_destroy_dct(dev, &mqp->dct.mdct);
+		if (err) {
+			mlx5_ib_warn(dev, "failed to destroy DCT %d\n", err);
+			return err;
+		}
+	}
+
+	kfree(mqp->dct.in);
+	kfree(mqp);
+	return 0;
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 				struct ib_udata *udata)
 {
@@ -2955,6 +2948,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	}
 
 	kfree(params.ucmd);
+	params.ucmd = NULL;
 
 	if (is_qp0(attr->qp_type))
 		qp->ibqp.qp_num = 0;
@@ -2965,8 +2959,24 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 
 	qp->trans_qp.xrcdn = xrcdn;
 
+	if (udata)
+		/*
+		 * It is safe to copy response for all user create QP flows,
+		 * including MLX5_IB_QPT_DCT, which doesn't need it.
+		 * In that case, resp will be filled with zeros.
+		 */
+		err = ib_copy_to_udata(udata, &params.resp, params.outlen);
+	if (err)
+		goto destroy_qp;
+
 	return &qp->ibqp;
 
+destroy_qp:
+	if (qp->type == MLX5_IB_QPT_DCT)
+		mlx5_ib_destroy_dct(qp);
+	else
+		destroy_qp_common(dev, qp, udata);
+	qp = NULL;
 free_qp:
 	kfree(qp);
 free_ucmd:
@@ -2974,25 +2984,6 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 	return ERR_PTR(err);
 }
 
-static int mlx5_ib_destroy_dct(struct mlx5_ib_qp *mqp)
-{
-	struct mlx5_ib_dev *dev = to_mdev(mqp->ibqp.device);
-
-	if (mqp->state == IB_QPS_RTR) {
-		int err;
-
-		err = mlx5_core_destroy_dct(dev, &mqp->dct.mdct);
-		if (err) {
-			mlx5_ib_warn(dev, "failed to destroy DCT %d\n", err);
-			return err;
-		}
-	}
-
-	kfree(mqp->dct.in);
-	kfree(mqp);
-	return 0;
-}
-
 int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(qp->device);
-- 
2.25.3

