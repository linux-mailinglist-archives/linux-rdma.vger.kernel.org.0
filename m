Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5800F1DF782
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbgEWNXB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 09:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387860AbgEWNXB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 May 2020 09:23:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD8D2072C;
        Sat, 23 May 2020 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590240180;
        bh=Q/cvkm679RsUrpJawrLVTSM2ZQ6HZwJcGqoE6vD4HIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArmqLqQ/RNvxkKoOmb+sI/4kVEPNC3IrRFJqMog6Mo0gbThG2v4Fjyo1/ES8vthDd
         DElEzcMLHFjGJDNB11M8nWWdBH6Ku18mBWGgcdVb8A9t6Ws7g/26kfBlYYkygK/B0g
         COgmeO4EWT6whhz4J2/vYEjzqtso6amECLnf0dJk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next v1 3/9] RDMA/mlx5: Set ECE options during QP create
Date:   Sat, 23 May 2020 16:22:37 +0300
Message-Id: <20200523132243.817936-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523132243.817936-1-leon@kernel.org>
References: <20200523132243.817936-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Allow users to ask creation of QPs with specific ECE options.
Such early set even before RDMA-CM connection is established
is useful if user knows exactly which option he needs.

Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 76 ++++++++++++++++++++++++++++-----
 include/uapi/rdma/mlx5-abi.h    |  2 +
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 74c1afeba5cb..390efaeb49bc 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1552,6 +1552,7 @@ struct mlx5_create_qp_params {
 	struct ib_udata *udata;
 	size_t inlen;
 	size_t outlen;
+	size_t ucmd_size;
 	void *ucmd;
 	u8 is_rss_raw : 1;
 	struct ib_qp_init_attr *attr;
@@ -1839,6 +1840,7 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			     struct mlx5_create_qp_params *params)
 {
+	struct mlx5_ib_create_qp *ucmd = params->ucmd;
 	struct ib_qp_init_attr *attr = params->attr;
 	u32 uidx = params->uidx;
 	struct mlx5_ib_resources *devr = &dev->devr;
@@ -1860,6 +1862,8 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (!in)
 		return -ENOMEM;
 
+	if (MLX5_CAP_GEN(mdev, ece_support))
+		MLX5_SET(create_qp_in, in, ece, ucmd->ece_options);
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
 	MLX5_SET(qpc, qpc, st, MLX5_QP_ST_XRC);
@@ -1974,6 +1978,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (is_sqp(init_attr->qp_type))
 		qp->port = init_attr->port_num;
 
+	if (MLX5_CAP_GEN(mdev, ece_support))
+		MLX5_SET(create_qp_in, in, ece, ucmd->ece_options);
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
 	MLX5_SET(qpc, qpc, st, mlx5_st);
@@ -2396,7 +2402,8 @@ static void destroy_qp_common(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	destroy_qp(dev, qp, base, udata);
 }
 
-static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
+static int create_dct(struct mlx5_ib_dev *dev, struct ib_pd *pd,
+		      struct mlx5_ib_qp *qp,
 		      struct mlx5_create_qp_params *params)
 {
 	struct ib_qp_init_attr *attr = params->attr;
@@ -2415,6 +2422,8 @@ static int create_dct(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	MLX5_SET(dctc, dctc, cqn, to_mcq(attr->recv_cq)->mcq.cqn);
 	MLX5_SET64(dctc, dctc, dc_access_key, ucmd->access_key);
 	MLX5_SET(dctc, dctc, user_index, uidx);
+	if (MLX5_CAP_GEN(dev->mdev, ece_support))
+		MLX5_SET(dctc, dctc, ece, ucmd->ece_options);
 
 	if (qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) {
 		int rcqe_sz = mlx5_ib_get_cqe_size(attr->recv_cq);
@@ -2715,13 +2724,17 @@ static int process_udata_size(struct mlx5_ib_dev *dev,
 	size_t inlen = udata->inlen;
 
 	params->outlen = min(outlen, sizeof(struct mlx5_ib_create_qp_resp));
-	if (attr->qp_type == IB_QPT_DRIVER) {
-		params->inlen = (inlen < ucmd) ? 0 : ucmd;
-		goto out;
-	}
+	params->ucmd_size = ucmd;
+	if (attr->qp_type == IB_QPT_DRIVER || !params->is_rss_raw) {
+		/* User has old rdma-core, which doesn't support ECE */
+		size_t min_inlen =
+			offsetof(struct mlx5_ib_create_qp, ece_options);
 
-	if (!params->is_rss_raw) {
-		params->inlen = ucmd;
+		params->inlen = (inlen < min_inlen) ? 0 : min(inlen, ucmd);
+		/*
+		 * We will check in check_ucmd_data() that user
+		 * cleared everything after inlen.
+		 */
 		goto out;
 	}
 
@@ -2733,13 +2746,14 @@ static int process_udata_size(struct mlx5_ib_dev *dev,
 		return -EINVAL;
 
 	ucmd = sizeof(struct mlx5_ib_create_qp_rss);
+	params->ucmd_size = ucmd;
 	if (inlen > ucmd && !ib_is_udata_cleared(udata, ucmd, inlen - ucmd))
 		return -EINVAL;
 
 	params->inlen = min(ucmd, inlen);
 out:
 	if (!params->inlen)
-		mlx5_ib_dbg(dev, "udata is too small or not cleared\n");
+		mlx5_ib_dbg(dev, "udata is too small\n");
 
 	return (params->inlen) ? 0 : -EINVAL;
 }
@@ -2756,7 +2770,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	if (qp->type == MLX5_IB_QPT_DCT) {
-		err = create_dct(pd, qp, params);
+		err = create_dct(dev, pd, qp, params);
 		goto out;
 	}
 
@@ -2855,6 +2869,44 @@ static int mlx5_ib_destroy_dct(struct mlx5_ib_qp *mqp)
 	return 0;
 }
 
+static int check_ucmd_data(struct mlx5_ib_dev *dev,
+			   struct mlx5_create_qp_params *params)
+{
+	struct ib_qp_init_attr *attr = params->attr;
+	struct ib_udata *udata = params->udata;
+	size_t size, last;
+	int ret;
+
+	if (params->is_rss_raw)
+		/*
+		 * These QPs don't have "reserved" field in their
+		 * create_qp input struct, so their data is always valid.
+		 */
+		last = sizeof(struct mlx5_ib_create_qp_rss);
+	else
+		/* IB_QPT_RAW_PACKET doesn't have ECE data */
+		last = (attr->qp_type == IB_QPT_RAW_PACKET) ?
+			       offsetof(struct mlx5_ib_create_qp, ece_options) :
+			       offsetof(struct mlx5_ib_create_qp, reserved);
+
+	if (udata->inlen <= last)
+		return 0;
+
+	/*
+	 * User provides different create_qp structures based on the
+	 * flow and we need to know if he cleared memory after our
+	 * struct create_qp ends.
+	 */
+	size = udata->inlen - last;
+	ret = ib_is_udata_cleared(params->udata, last, size);
+	if (!ret)
+		mlx5_ib_dbg(
+			dev,
+			"udata is not cleared, inlen = %lu, ucmd = %lu, last = %lu, size = %lu\n",
+			udata->inlen, params->ucmd_size, last, size);
+	return ret ? 0 : -EINVAL;
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 				struct ib_udata *udata)
 {
@@ -2888,7 +2940,11 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 		if (err)
 			return ERR_PTR(err);
 
-		params.ucmd = kzalloc(params.inlen, GFP_KERNEL);
+		err = check_ucmd_data(dev, &params);
+		if (err)
+			return ERR_PTR(err);
+
+		params.ucmd = kzalloc(params.ucmd_size, GFP_KERNEL);
 		if (!params.ucmd)
 			return ERR_PTR(-ENOMEM);
 
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 106fbb3bec6a..bc9d9e3cb369 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -322,6 +322,8 @@ struct mlx5_ib_create_qp {
 		__aligned_u64 sq_buf_addr;
 		__aligned_u64 access_key;
 	};
+	__u32  ece_options;
+	__u32  reserved;
 };
 
 /* RX Hash function flags */
-- 
2.26.2

