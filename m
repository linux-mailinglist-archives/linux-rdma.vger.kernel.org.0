Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08D01BA8FC
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgD0Psl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgD0Psl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AAC7206D9;
        Mon, 27 Apr 2020 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002520;
        bh=TeXTvyNoEP/ajapm9FZuY+Ezs5r8FG5Kio5gINVuW2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asJNWMgQeqo9jppiGXczrkBpuRqqgqk9GrN5Pe3pIa7vr/5R3FC10GCjs/yss6Ki0
         h+hm7QSX8oaRYYn0+Rzlv+tBmeHavl7prZ2Ls+r4w2wM1OmNsqgl04+6a8cb/HFgUw
         Rh4GDFePDRFYHhjV8qTf8MaOHmJMwFKeCGlQACVs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 30/36] RDMA/mlx5: Group all create QP parameters to simplify in-kernel interfaces
Date:   Mon, 27 Apr 2020 18:46:30 +0300
Message-Id: <20200427154636.381474-31-leon@kernel.org>
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

The amount of parameters passed in and out between internal mlx5
create QP functions is too large to easily follow the flow. Change
it by grouping all create QP parameter into one structure.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 148 +++++++++++++++++---------------
 1 file changed, 81 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6b390b0e43af..3807e1687cb2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1610,14 +1610,24 @@ static void destroy_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *q
 			     to_mpd(qp->ibqp.pd)->uid);
 }
 
-static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-				 struct ib_qp_init_attr *init_attr,
-				 struct mlx5_ib_create_qp_rss *ucmd,
-				 struct ib_udata *udata)
+struct mlx5_create_qp_params {
+	struct ib_udata *udata;
+	size_t inlen;
+	void *ucmd;
+	u8 is_rss_raw : 1;
+	struct ib_qp_init_attr *attr;
+	u32 uidx;
+};
+
+static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+				 struct mlx5_ib_qp *qp,
+				 struct mlx5_create_qp_params *params)
 {
+	struct ib_qp_init_attr *init_attr = params->attr;
+	struct mlx5_ib_create_qp_rss *ucmd = params->ucmd;
+	struct ib_udata *udata = params->udata;
 	struct mlx5_ib_ucontext *mucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_create_qp_resp resp = {};
 	int inlen;
 	int outlen;
@@ -1632,7 +1642,8 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	u32 tdn = mucontext->tdn;
 	u8 lb_flag = 0;
 
-	min_resp_len = offsetof(typeof(resp), bfreg_index) + sizeof(resp.bfreg_index);
+	min_resp_len =
+		offsetof(typeof(resp), bfreg_index) + sizeof(resp.bfreg_index);
 	if (udata->outlen < min_resp_len)
 		return -EINVAL;
 
@@ -1909,11 +1920,12 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 	return atomic_mode;
 }
 
-static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev,
-			     struct ib_qp_init_attr *attr,
-			     struct mlx5_ib_qp *qp, struct ib_udata *udata,
-			     u32 uidx)
+static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+			     struct mlx5_create_qp_params *params)
 {
+	struct ib_qp_init_attr *attr = params->attr;
+	struct ib_udata *udata = params->udata;
+	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -1985,11 +1997,13 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev,
 }
 
 static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
-			  struct ib_qp_init_attr *init_attr,
-			  struct mlx5_ib_create_qp *ucmd,
-			  struct ib_udata *udata, struct mlx5_ib_qp *qp,
-			  u32 uidx)
+			  struct mlx5_ib_qp *qp,
+			  struct mlx5_create_qp_params *params)
 {
+	struct ib_qp_init_attr *init_attr = params->attr;
+	struct mlx5_ib_create_qp *ucmd = params->ucmd;
+	struct ib_udata *udata = params->udata;
+	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -2173,9 +2187,11 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 }
 
 static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
-			    struct ib_qp_init_attr *attr, struct mlx5_ib_qp *qp,
-			    u32 uidx)
+			    struct mlx5_ib_qp *qp,
+			    struct mlx5_create_qp_params *params)
 {
+	struct ib_qp_init_attr *attr = params->attr;
+	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -2469,9 +2485,11 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 }
 
 static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-		      struct ib_qp_init_attr *attr,
-		      struct mlx5_ib_create_qp *ucmd, u32 uidx)
+		      struct mlx5_create_qp_params *params)
 {
+	struct ib_qp_init_attr *attr = params->attr;
+	struct mlx5_ib_create_qp *ucmd = params->ucmd;
+	u32 uidx = params->uidx;
 	void *dctc;
 
 	qp->dct.in = kzalloc(MLX5_ST_SZ_BYTES(create_dct_in), GFP_KERNEL);
@@ -2782,16 +2800,14 @@ static size_t process_udata_size(struct ib_qp_init_attr *attr,
 	return min(ucmd, inlen);
 }
 
-static int create_raw_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-			 struct ib_qp_init_attr *attr, void *ucmd,
-			 struct ib_udata *udata, u32 uidx)
+static int create_raw_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+			 struct mlx5_ib_qp *qp,
+			 struct mlx5_create_qp_params *params)
 {
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	if (params->is_rss_raw)
+		return create_rss_raw_qp_tir(dev, pd, qp, params);
 
-	if (attr->rwq_ind_tbl)
-		return create_rss_raw_qp_tir(pd, qp, attr, ucmd, udata);
-
-	return create_user_qp(dev, pd, attr, ucmd, udata, qp, uidx);
+	return create_user_qp(dev, pd, qp, params);
 }
 
 static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
@@ -2821,60 +2837,59 @@ static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	return ret;
 }
 
-static int get_qp_uidx(struct mlx5_ib_qp *qp, struct ib_udata *udata,
-		       struct mlx5_ib_create_qp *ucmd,
-		       struct ib_qp_init_attr *attr, u32 *uidx)
+static int get_qp_uidx(struct mlx5_ib_qp *qp,
+		       struct mlx5_create_qp_params *params)
 {
+	struct mlx5_ib_create_qp *ucmd = params->ucmd;
+	struct ib_udata *udata = params->udata;
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
-	if (attr->rwq_ind_tbl)
+	if (params->is_rss_raw)
 		return 0;
 
-	return get_qp_user_index(ucontext, ucmd, sizeof(*ucmd), uidx);
+	return get_qp_user_index(ucontext, ucmd, sizeof(*ucmd), &params->uidx);
 }
 
-struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
-				struct ib_qp_init_attr *init_attr,
+struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 				struct ib_udata *udata)
 {
-	u32 uidx = MLX5_IB_DEFAULT_UIDX;
+	struct mlx5_create_qp_params params = {};
 	struct mlx5_ib_dev *dev;
 	struct mlx5_ib_qp *qp;
 	enum ib_qp_type type;
-	void *ucmd = NULL;
 	u16 xrcdn = 0;
 	int err;
 
 	dev = pd ? to_mdev(pd->device) :
-		   to_mdev(to_mxrcd(init_attr->xrcd)->ibxrcd.device);
+		   to_mdev(to_mxrcd(attr->xrcd)->ibxrcd.device);
 
-	err = check_qp_type(dev, init_attr, &type);
-	if (err) {
-		mlx5_ib_dbg(dev, "Unsupported QP type %d\n",
-			    init_attr->qp_type);
+	err = check_qp_type(dev, attr, &type);
+	if (err)
 		return ERR_PTR(err);
-	}
 
-	err = check_valid_flow(dev, pd, init_attr, udata);
+	err = check_valid_flow(dev, pd, attr, udata);
 	if (err)
 		return ERR_PTR(err);
 
-	if (init_attr->qp_type == IB_QPT_GSI)
-		return mlx5_ib_gsi_create_qp(pd, init_attr);
+	if (attr->qp_type == IB_QPT_GSI)
+		return mlx5_ib_gsi_create_qp(pd, attr);
 
-	if (udata) {
-		size_t inlen =
-			process_udata_size(init_attr, udata);
+	params.udata = udata;
+	params.uidx = MLX5_IB_DEFAULT_UIDX;
+	params.attr = attr;
+	params.is_rss_raw = !!attr->rwq_ind_tbl;
 
-		if (!inlen)
+	if (udata) {
+		params.inlen = process_udata_size(attr, udata);
+		if (!params.inlen)
 			return ERR_PTR(-EINVAL);
 
-		ucmd = kzalloc(inlen, GFP_KERNEL);
-		if (!ucmd)
+		params.ucmd = kzalloc(params.inlen, GFP_KERNEL);
+		if (!params.ucmd)
 			return ERR_PTR(-ENOMEM);
 
-		err = ib_copy_from_udata(ucmd, udata, inlen);
+		err = ib_copy_from_udata(params.ucmd, udata, params.inlen);
 		if (err)
 			goto free_ucmd;
 	}
@@ -2887,50 +2902,49 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 
 	qp->type = type;
 	if (udata) {
-		err = process_vendor_flags(dev, qp, ucmd, init_attr);
+		err = process_vendor_flags(dev, qp, params.ucmd, attr);
 		if (err)
 			goto free_qp;
 
-		err = get_qp_uidx(qp, udata, ucmd, init_attr, &uidx);
+		err = get_qp_uidx(qp, &params);
 		if (err)
 			goto free_qp;
 	}
-	err = process_create_flags(dev, qp, init_attr);
+	err = process_create_flags(dev, qp, attr);
 	if (err)
 		goto free_qp;
 
-	err = check_qp_attr(dev, qp, init_attr);
+	err = check_qp_attr(dev, qp, attr);
 	if (err)
 		goto free_qp;
 
 	switch (qp->type) {
 	case IB_QPT_RAW_PACKET:
-		err = create_raw_qp(pd, qp, init_attr, ucmd, udata, uidx);
+		err = create_raw_qp(dev, pd, qp, &params);
 		break;
 	case MLX5_IB_QPT_DCT:
-		err = create_dct(pd, qp, init_attr, ucmd, uidx);
+		err = create_dct(pd, qp, &params);
 		break;
 	case IB_QPT_XRC_TGT:
-		xrcdn = to_mxrcd(init_attr->xrcd)->xrcdn;
-		err = create_xrc_tgt_qp(dev, init_attr, qp, udata, uidx);
+		xrcdn = to_mxrcd(attr->xrcd)->xrcdn;
+		err = create_xrc_tgt_qp(dev, qp, &params);
 		break;
 	default:
 		if (udata)
-			err = create_user_qp(dev, pd, init_attr, ucmd, udata,
-					     qp, uidx);
+			err = create_user_qp(dev, pd, qp, &params);
 		else
-			err = create_kernel_qp(dev, pd, init_attr, qp, uidx);
+			err = create_kernel_qp(dev, pd, qp, &params);
 	}
 	if (err) {
-		mlx5_ib_dbg(dev, "create_qp failed %d\n", err);
+		mlx5_ib_err(dev, "create_qp failed %d\n", err);
 		goto free_qp;
 	}
 
-	kfree(ucmd);
+	kfree(params.ucmd);
 
-	if (is_qp0(init_attr->qp_type))
+	if (is_qp0(attr->qp_type))
 		qp->ibqp.qp_num = 0;
-	else if (is_qp1(init_attr->qp_type))
+	else if (is_qp1(attr->qp_type))
 		qp->ibqp.qp_num = 1;
 	else
 		qp->ibqp.qp_num = qp->trans_qp.base.mqp.qpn;
@@ -2942,7 +2956,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 free_qp:
 	kfree(qp);
 free_ucmd:
-	kfree(ucmd);
+	kfree(params.ucmd);
 	return ERR_PTR(err);
 }
 
-- 
2.25.3

