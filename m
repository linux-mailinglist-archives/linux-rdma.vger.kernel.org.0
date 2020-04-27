Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049C11BA8D1
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgD0PsR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgD0PsR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A2EE2064C;
        Mon, 27 Apr 2020 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002496;
        bh=y+wT9t+HCOAtabzwjhZ5anqA3axqLDC1mX9bKJdykpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnLk0D4R0pU15AyZc1O1vPwOQqPBrBuseHF3Op2hPLH5EP099iCsdZX6/AKoZQK/P
         c5ISCuORx9S2reVdUbFE2jK30YI3kHyMLlL0Ha416RJ2TCvJ9L31ql8119NYJeiUbp
         w2KnfRPxl1dfH1sjqxgMVDmw5idjVI+SYOULcZwI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 26/36] RDMA/mlx5: Globally parse DEVX UID
Date:   Mon, 27 Apr 2020 18:46:26 +0300
Message-Id: <20200427154636.381474-27-leon@kernel.org>
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

Remove duplication in parsing of DEVX UID.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 51 +++++++++++++++++----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 5a43128d651b..b2174e0817f5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1916,18 +1916,16 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			    struct ib_qp_init_attr *init_attr,
 			    struct mlx5_ib_create_qp *ucmd,
-			    struct ib_udata *udata, struct mlx5_ib_qp *qp)
+			    struct ib_udata *udata, struct mlx5_ib_qp *qp,
+			    u32 uidx)
 {
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_ib_create_qp_resp resp = {};
-	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
-		udata, struct mlx5_ib_ucontext, ibucontext);
 	struct mlx5_ib_cq *send_cq;
 	struct mlx5_ib_cq *recv_cq;
 	unsigned long flags;
-	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	struct mlx5_ib_qp_base *base;
 	int mlx5_st;
 	void *qpc;
@@ -1945,12 +1943,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
 		qp->sq_signal_bits = MLX5_WQE_CTRL_CQ_UPDATE;
 
-	if (udata) {
-		err = get_qp_user_index(ucontext, ucmd, udata->inlen, &uidx);
-		if (err)
-			return err;
-	}
-
 	if (qp->flags & IB_QP_CREATE_SOURCE_QPN)
 		qp->underlay_qpn = init_attr->source_qpn;
 
@@ -2329,18 +2321,10 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 
 static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 		      struct ib_qp_init_attr *attr,
-		      struct mlx5_ib_create_qp *ucmd, struct ib_udata *udata)
+		      struct mlx5_ib_create_qp *ucmd, u32 uidx)
 {
-	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
-		udata, struct mlx5_ib_ucontext, ibucontext);
-	int err = 0;
-	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	void *dctc;
 
-	err = get_qp_user_index(ucontext, ucmd, sizeof(*ucmd), &uidx);
-	if (err)
-		return err;
-
 	qp->dct.in = kzalloc(MLX5_ST_SZ_BYTES(create_dct_in), GFP_KERNEL);
 	if (!qp->dct.in)
 		return -ENOMEM;
@@ -2651,14 +2635,14 @@ static size_t process_udata_size(struct ib_qp_init_attr *attr,
 
 static int create_raw_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 			 struct ib_qp_init_attr *attr, void *ucmd,
-			 struct ib_udata *udata)
+			 struct ib_udata *udata, u32 uidx)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 
 	if (attr->rwq_ind_tbl)
 		return create_rss_raw_qp_tir(pd, qp, attr, ucmd, udata);
 
-	return create_qp_common(dev, pd, attr, ucmd, udata, qp);
+	return create_qp_common(dev, pd, attr, ucmd, udata, qp, uidx);
 }
 
 static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
@@ -2688,10 +2672,24 @@ static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	return ret;
 }
 
+static int get_qp_uidx(struct mlx5_ib_qp *qp, struct ib_udata *udata,
+		       struct mlx5_ib_create_qp *ucmd,
+		       struct ib_qp_init_attr *attr, u32 *uidx)
+{
+	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
+		udata, struct mlx5_ib_ucontext, ibucontext);
+
+	if (attr->rwq_ind_tbl)
+		return 0;
+
+	return get_qp_user_index(ucontext, ucmd, sizeof(*ucmd), uidx);
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct ib_udata *udata)
 {
+	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 	struct mlx5_ib_dev *dev;
 	struct mlx5_ib_qp *qp;
 	enum ib_qp_type type;
@@ -2743,6 +2741,10 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 		err = process_vendor_flags(dev, qp, ucmd, init_attr);
 		if (err)
 			goto free_qp;
+
+		err = get_qp_uidx(qp, udata, ucmd, init_attr, &uidx);
+		if (err)
+			goto free_qp;
 	}
 	err = process_create_flags(dev, qp, init_attr);
 	if (err)
@@ -2757,13 +2759,14 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 
 	switch (qp->type) {
 	case IB_QPT_RAW_PACKET:
-		err = create_raw_qp(pd, qp, init_attr, ucmd, udata);
+		err = create_raw_qp(pd, qp, init_attr, ucmd, udata, uidx);
 		break;
 	case MLX5_IB_QPT_DCT:
-		err = create_dct(pd, qp, init_attr, ucmd, udata);
+		err = create_dct(pd, qp, init_attr, ucmd, uidx);
 		break;
 	default:
-		err = create_qp_common(dev, pd, init_attr, ucmd, udata, qp);
+		err = create_qp_common(dev, pd, init_attr, ucmd, udata, qp,
+				       uidx);
 	}
 	if (err) {
 		mlx5_ib_dbg(dev, "create_qp_common failed\n");
-- 
2.25.3

