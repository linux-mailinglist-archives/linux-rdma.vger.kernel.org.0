Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767DC1BA8C3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgD0PsK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgD0PsK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62310206BF;
        Mon, 27 Apr 2020 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002489;
        bh=wpQSvN4Qs9XiPTGU4KGizILtzTLapv9m6Qjij0UzXJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWKiq26FLZvK0z6ZzJg3ZOW8DMGFltJ24zGYlj0nssF0nq8TPgs6CFzeQIUuq7Wsj
         7znd6EAjLdsAVgqdVw97tDuMVshweoNXOHy8vPuDsGwN4qJYTY8MacjwufrYteAYZt
         iL6kCheY+rPCmnO0SW4DhlV7Io7/USkofZPhESTI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 22/36] RDMA/mlx5: Combine copy of create QP command in RSS RAW QP
Date:   Mon, 27 Apr 2020 18:46:22 +0300
Message-Id: <20200427154636.381474-23-leon@kernel.org>
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

Change the create QP flow to handle all copy_from_user() operations in
one place.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 156 +++++++++++++++++---------------
 1 file changed, 82 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 454433a18b97..4f69105f082b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1624,6 +1624,7 @@ static void destroy_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *q
 
 static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 				 struct ib_qp_init_attr *init_attr,
+				 struct mlx5_ib_create_qp_rss *ucmd,
 				 struct ib_udata *udata)
 {
 	struct mlx5_ib_ucontext *mucontext = rdma_udata_to_drv_context(
@@ -1641,46 +1642,26 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	u32 outer_l4;
 	size_t min_resp_len;
 	u32 tdn = mucontext->tdn;
-	struct mlx5_ib_create_qp_rss ucmd = {};
-	size_t required_cmd_sz;
 	u8 lb_flag = 0;
 
 	min_resp_len = offsetof(typeof(resp), bfreg_index) + sizeof(resp.bfreg_index);
 	if (udata->outlen < min_resp_len)
 		return -EINVAL;
 
-	required_cmd_sz = offsetof(typeof(ucmd), flags) + sizeof(ucmd.flags);
-	if (udata->inlen < required_cmd_sz) {
-		mlx5_ib_dbg(dev, "invalid inlen\n");
-		return -EINVAL;
-	}
-
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd))) {
-		mlx5_ib_dbg(dev, "inlen is not supported\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen))) {
-		mlx5_ib_dbg(dev, "copy failed\n");
-		return -EFAULT;
-	}
-
-	if (ucmd.comp_mask) {
+	if (ucmd->comp_mask) {
 		mlx5_ib_dbg(dev, "invalid comp mask\n");
 		return -EOPNOTSUPP;
 	}
 
-	if (ucmd.flags & ~(MLX5_QP_FLAG_TUNNEL_OFFLOADS |
+	if (ucmd->flags & ~(MLX5_QP_FLAG_TUNNEL_OFFLOADS |
 			   MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC |
 			   MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC)) {
 		mlx5_ib_dbg(dev, "invalid flags\n");
 		return -EOPNOTSUPP;
 	}
 
-	if (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_INNER &&
-	    !(ucmd.flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS)) {
+	if (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_INNER &&
+	    !(ucmd->flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS)) {
 		mlx5_ib_dbg(dev, "Tunnel offloads must be set for inner RSS\n");
 		return -EOPNOTSUPP;
 	}
@@ -1717,29 +1698,29 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 
 	hfso = MLX5_ADDR_OF(tirc, tirc, rx_hash_field_selector_outer);
 
-	if (ucmd.flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS)
+	if (ucmd->flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS)
 		MLX5_SET(tirc, tirc, tunneled_offload_en, 1);
 
 	MLX5_SET(tirc, tirc, self_lb_block, lb_flag);
 
-	if (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_INNER)
+	if (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_INNER)
 		hfso = MLX5_ADDR_OF(tirc, tirc, rx_hash_field_selector_inner);
 	else
 		hfso = MLX5_ADDR_OF(tirc, tirc, rx_hash_field_selector_outer);
 
-	switch (ucmd.rx_hash_function) {
+	switch (ucmd->rx_hash_function) {
 	case MLX5_RX_HASH_FUNC_TOEPLITZ:
 	{
 		void *rss_key = MLX5_ADDR_OF(tirc, tirc, rx_hash_toeplitz_key);
 		size_t len = MLX5_FLD_SZ_BYTES(tirc, rx_hash_toeplitz_key);
 
-		if (len != ucmd.rx_key_len) {
+		if (len != ucmd->rx_key_len) {
 			err = -EINVAL;
 			goto err;
 		}
 
 		MLX5_SET(tirc, tirc, rx_hash_fn, MLX5_RX_HASH_FN_TOEPLITZ);
-		memcpy(rss_key, ucmd.rx_hash_key, len);
+		memcpy(rss_key, ucmd->rx_hash_key, len);
 		break;
 	}
 	default:
@@ -1747,7 +1728,7 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 		goto err;
 	}
 
-	if (!ucmd.rx_hash_fields_mask) {
+	if (!ucmd->rx_hash_fields_mask) {
 		/* special case when this TIR serves as steering entry without hashing */
 		if (!init_attr->rwq_ind_tbl->log_ind_tbl_size)
 			goto create_tir;
@@ -1755,29 +1736,31 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 		goto err;
 	}
 
-	if (((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV4) ||
-	     (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV4)) &&
-	     ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV6) ||
-	     (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV6))) {
+	if (((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV4) ||
+	     (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV4)) &&
+	     ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV6) ||
+	     (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV6))) {
 		err = -EINVAL;
 		goto err;
 	}
 
 	/* If none of IPV4 & IPV6 SRC/DST was set - this bit field is ignored */
-	if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV4) ||
-	    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV4))
+	if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV4) ||
+	    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV4))
 		MLX5_SET(rx_hash_field_select, hfso, l3_prot_type,
 			 MLX5_L3_PROT_TYPE_IPV4);
-	else if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV6) ||
-		 (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV6))
+	else if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV6) ||
+		 (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV6))
 		MLX5_SET(rx_hash_field_select, hfso, l3_prot_type,
 			 MLX5_L3_PROT_TYPE_IPV6);
 
-	outer_l4 = ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_TCP) ||
-		    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_TCP)) << 0 |
-		   ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_UDP) ||
-		    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_UDP)) << 1 |
-		   (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_IPSEC_SPI) << 2;
+	outer_l4 = ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_TCP) ||
+		    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_TCP))
+			   << 0 |
+		   ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_UDP) ||
+		    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_UDP))
+			   << 1 |
+		   (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_IPSEC_SPI) << 2;
 
 	/* Check that only one l4 protocol is set */
 	if (outer_l4 & (outer_l4 - 1)) {
@@ -1786,32 +1769,32 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	}
 
 	/* If none of TCP & UDP SRC/DST was set - this bit field is ignored */
-	if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_TCP) ||
-	    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_TCP))
+	if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_TCP) ||
+	    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_TCP))
 		MLX5_SET(rx_hash_field_select, hfso, l4_prot_type,
 			 MLX5_L4_PROT_TYPE_TCP);
-	else if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_UDP) ||
-		 (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_UDP))
+	else if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_UDP) ||
+		 (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_UDP))
 		MLX5_SET(rx_hash_field_select, hfso, l4_prot_type,
 			 MLX5_L4_PROT_TYPE_UDP);
 
-	if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV4) ||
-	    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV6))
+	if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV4) ||
+	    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_IPV6))
 		selected_fields |= MLX5_HASH_FIELD_SEL_SRC_IP;
 
-	if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV4) ||
-	    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV6))
+	if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV4) ||
+	    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_IPV6))
 		selected_fields |= MLX5_HASH_FIELD_SEL_DST_IP;
 
-	if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_TCP) ||
-	    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_UDP))
+	if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_TCP) ||
+	    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_SRC_PORT_UDP))
 		selected_fields |= MLX5_HASH_FIELD_SEL_L4_SPORT;
 
-	if ((ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_TCP) ||
-	    (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_UDP))
+	if ((ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_TCP) ||
+	    (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_DST_PORT_UDP))
 		selected_fields |= MLX5_HASH_FIELD_SEL_L4_DPORT;
 
-	if (ucmd.rx_hash_fields_mask & MLX5_RX_HASH_IPSEC_SPI)
+	if (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_IPSEC_SPI)
 		selected_fields |= MLX5_HASH_FIELD_SEL_IPSEC_SPI;
 
 	MLX5_SET(rx_hash_field_select, hfso, selected_fields, selected_fields);
@@ -2513,11 +2496,16 @@ static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 }
 
 static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-				struct mlx5_ib_create_qp *ucmd)
+				void *ucmd, struct ib_qp_init_attr *attr)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
-	int flags = ucmd->flags;
 	bool cond;
+	int flags;
+
+	if (attr->rwq_ind_tbl)
+		flags = ((struct mlx5_ib_create_qp_rss *)ucmd)->flags;
+	else
+		flags = ((struct mlx5_ib_create_qp *)ucmd)->flags;
 
 	switch (flags & (MLX5_QP_FLAG_TYPE_DCT | MLX5_QP_FLAG_TYPE_DCI)) {
 	case MLX5_QP_FLAG_TYPE_DCI:
@@ -2657,21 +2645,32 @@ static size_t process_udata_size(struct ib_qp_init_attr *attr,
 				 struct ib_udata *udata)
 {
 	size_t ucmd = sizeof(struct mlx5_ib_create_qp);
+	size_t inlen = udata->inlen;
 
 	if (attr->qp_type == IB_QPT_DRIVER)
-		return (udata->inlen < ucmd) ? 0 : ucmd;
+		return (inlen < ucmd) ? 0 : ucmd;
+
+	if (!attr->rwq_ind_tbl)
+		return ucmd;
+
+	if (inlen < offsetofend(struct mlx5_ib_create_qp_rss, flags))
+		return 0;
+
+	ucmd = sizeof(struct mlx5_ib_create_qp_rss);
+	if (inlen > ucmd && !ib_is_udata_cleared(udata, ucmd, inlen - ucmd))
+		return 0;
 
-	return ucmd;
+	return min(ucmd, inlen);
 }
 
 static int create_raw_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
-			 struct ib_qp_init_attr *attr,
-			 struct mlx5_ib_create_qp *ucmd, struct ib_udata *udata)
+			 struct ib_qp_init_attr *attr, void *ucmd,
+			 struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 
 	if (attr->rwq_ind_tbl)
-		return create_rss_raw_qp_tir(pd, qp, attr, udata);
+		return create_rss_raw_qp_tir(pd, qp, attr, ucmd, udata);
 
 	return create_qp_common(dev, pd, attr, ucmd, udata, qp);
 }
@@ -2707,10 +2706,10 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct ib_udata *udata)
 {
-	struct mlx5_ib_create_qp ucmd = {};
 	struct mlx5_ib_dev *dev;
 	struct mlx5_ib_qp *qp;
 	enum ib_qp_type type;
+	void *ucmd = NULL;
 	u16 xrcdn = 0;
 	int err;
 
@@ -2731,25 +2730,31 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	if (init_attr->qp_type == IB_QPT_GSI)
 		return mlx5_ib_gsi_create_qp(pd, init_attr);
 
-	if (udata && !init_attr->rwq_ind_tbl) {
+	if (udata) {
 		size_t inlen =
 			process_udata_size(init_attr, udata);
 
 		if (!inlen)
 			return ERR_PTR(-EINVAL);
 
-		err = ib_copy_from_udata(&ucmd, udata, inlen);
+		ucmd = kzalloc(inlen, GFP_KERNEL);
+		if (!ucmd)
+			return ERR_PTR(-ENOMEM);
+
+		err = ib_copy_from_udata(ucmd, udata, inlen);
 		if (err)
-			return ERR_PTR(err);
+			goto free_ucmd;
 	}
 
 	qp = kzalloc(sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return ERR_PTR(-ENOMEM);
+	if (!qp) {
+		err = -ENOMEM;
+		goto free_ucmd;
+	}
 
 	qp->type = type;
 	if (udata) {
-		err = process_vendor_flags(dev, qp, &ucmd);
+		err = process_vendor_flags(dev, qp, ucmd, init_attr);
 		if (err)
 			goto free_qp;
 	}
@@ -2766,20 +2771,21 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 
 	switch (qp->type) {
 	case IB_QPT_RAW_PACKET:
-		err = create_raw_qp(pd, qp, init_attr, &ucmd, udata);
+		err = create_raw_qp(pd, qp, init_attr, ucmd, udata);
 		break;
 	case MLX5_IB_QPT_DCT:
-		err = create_dct(pd, qp, init_attr, &ucmd, udata);
+		err = create_dct(pd, qp, init_attr, ucmd, udata);
 		break;
 	default:
-		err = create_qp_common(dev, pd, init_attr,
-				       (udata) ? &ucmd : NULL, udata, qp);
+		err = create_qp_common(dev, pd, init_attr, ucmd, udata, qp);
 	}
 	if (err) {
 		mlx5_ib_dbg(dev, "create_qp_common failed\n");
 		goto free_qp;
 	}
 
+	kfree(ucmd);
+
 	if (is_qp0(init_attr->qp_type))
 		qp->ibqp.qp_num = 0;
 	else if (is_qp1(init_attr->qp_type))
@@ -2793,6 +2799,8 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 
 free_qp:
 	kfree(qp);
+free_ucmd:
+	kfree(ucmd);
 	return ERR_PTR(err);
 }
 
-- 
2.25.3

