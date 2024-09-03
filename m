Return-Path: <linux-rdma+bounces-4719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7A969C23
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3094828204D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2A1D61A8;
	Tue,  3 Sep 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z68HkWQ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614F1C987D;
	Tue,  3 Sep 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363488; cv=none; b=C7lrRKtbFnA66DHzewH3HtcoBcd9lEuzdm1ill7OgZ9AbDRd4gU+JObrz3rCvbtHpKgnzlzBC4lvczH5Y9kyjgl/ZfL7V0VgrwKIWhcpQdIMMMt+HsdtQUhBouUZXTLqQs7IOrbvLDtStfcfr4C3p36pwsJA6JaGuYZybqi+XpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363488; c=relaxed/simple;
	bh=7YkLVfDvwqZC1kkvFsE4e6XFiN9ReJHTL5wzLfjOt0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW3+UehyXWsdscVg1ubcmApg1xhGS5yNIW/6lqYJLni4hSmfJQ2iEK2PhuP8ehCAgUdio7PMDMFGaWL5vGvXTgf7YddeNkCv7a1bLQeeW8BS4kwlo/KF4fmW408vTGazv+Wwlr+Ka+GTUmEy3b3wNfjhDFQjFo/jb4KJHli64js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z68HkWQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0405C4CEC4;
	Tue,  3 Sep 2024 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363488;
	bh=7YkLVfDvwqZC1kkvFsE4e6XFiN9ReJHTL5wzLfjOt0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z68HkWQ5vqiyQqsDRqxvk1wfpo1ZIpI18khknPCVXZULTupULkMjtpMPjMvNn1tuE
	 ptire0iszZPI2FpW8IZwizAdEEXv8DwiOGsyf0UvY7mo1wy73wcqxa9HhArqFQYmGo
	 ByNlwTdMkkqxeKeWQazzerbBHd13gageHSUIaQtn3x32uPnpoz743nLFOUUU73oxif
	 gtg+CzqYGtYOXsK+AD9dl8hyGIuvIa1I/Zv6In8ng8ozGF3u/5do3HdoVzhGvUUZwO
	 OCVXMbTqYF0a3zb5p7cQNvjJh5/9Q3KYd/ZvNq4Ob6t0uPxRRzYwyaitQsOPqd56Tw
	 8u3i3EIy7Z+XA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Support OOO RX WQE consumption
Date: Tue,  3 Sep 2024 14:37:52 +0300
Message-ID: <06ac609a5f358c8fb0a090d22c61a2f9329d82e6.1725362773.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725362773.git.leon@kernel.org>
References: <cover.1725362773.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Srouji <edwards@nvidia.com>

Support QP with out-of-order (OOO) capabilities enabled.
This allows WRs on the receiver side of the QP to be consumed OOO,
permitting the sender side to transmit messages without guaranteeing
arrival order on the receiver side.

When enabled, the completion ordering of WRs remains in-order,
regardless of the Receive WRs consumption order.
RDMA Read and RDMA Atomic operations on the responder side continue to
be executed in-order, while the ordering of data placement for RDMA
Write and Send operations is not guaranteed.

Atomic operations larger than 8 bytes are currently not supported.
Therefore, when this feature is enabled, the created QP restricts its
atomic support to 8 bytes at most.

In addition, when querying the device, a new flag is returned in
response to indicate that the Kernel supports OOO QP.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    |  8 +++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 51 +++++++++++++++++++++++++---
 include/uapi/rdma/mlx5-abi.h         |  5 +++
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b85ad3c0bfa1..6cefefd2b578 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1154,6 +1154,14 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 				MLX5_IB_QUERY_DEV_RESP_PACKET_BASED_CREDIT_MODE;
 
 		resp.flags |= MLX5_IB_QUERY_DEV_RESP_FLAGS_SCAT2CQE_DCT;
+
+		if (MLX5_CAP_GEN_2(mdev, dp_ordering_force) &&
+		    (MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_xrc) ||
+		    MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_dc) ||
+		    MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_rc) ||
+		    MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_ud) ||
+		    MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_uc)))
+			resp.flags |= MLX5_IB_QUERY_DEV_RESP_FLAGS_OOO_DP;
 	}
 
 	if (offsetofend(typeof(resp), sw_parsing_caps) <= uhw_outlen) {
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5505eb70939b..926a965e4570 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -532,6 +532,7 @@ struct mlx5_ib_qp {
 	struct mlx5_bf	        bf;
 	u8			has_rq:1;
 	u8			is_rss:1;
+	u8			is_ooo_rq:1;
 
 	/* only for user space QPs. For kernel
 	 * we have it from the bf object
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e39b1a101e97..837b662b41de 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1960,7 +1960,7 @@ static int atomic_size_to_mode(int size_mask)
 }
 
 static int get_atomic_mode(struct mlx5_ib_dev *dev,
-			   enum ib_qp_type qp_type)
+			   struct mlx5_ib_qp *qp)
 {
 	u8 atomic_operations = MLX5_CAP_ATOMIC(dev->mdev, atomic_operations);
 	u8 atomic = MLX5_CAP_GEN(dev->mdev, atomic);
@@ -1970,7 +1970,7 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 	if (!atomic)
 		return -EOPNOTSUPP;
 
-	if (qp_type == MLX5_IB_QPT_DCT)
+	if (qp->type == MLX5_IB_QPT_DCT)
 		atomic_size_mask = MLX5_CAP_ATOMIC(dev->mdev, atomic_size_dc);
 	else
 		atomic_size_mask = MLX5_CAP_ATOMIC(dev->mdev, atomic_size_qp);
@@ -1984,6 +1984,10 @@ static int get_atomic_mode(struct mlx5_ib_dev *dev,
 	     atomic_operations & MLX5_ATOMIC_OPS_FETCH_ADD))
 		atomic_mode = MLX5_ATOMIC_MODE_IB_COMP;
 
+	/* OOO DP QPs do not support larger than 8-Bytes atomic operations */
+	if (atomic_mode > MLX5_ATOMIC_MODE_8B && qp->is_ooo_rq)
+		atomic_mode = MLX5_ATOMIC_MODE_8B;
+
 	return atomic_mode;
 }
 
@@ -2839,6 +2843,29 @@ static int check_valid_flow(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	return 0;
 }
 
+static bool get_dp_ooo_cap(struct mlx5_core_dev *mdev, enum ib_qp_type qp_type)
+{
+	if (!MLX5_CAP_GEN_2(mdev, dp_ordering_force))
+		return false;
+
+	switch (qp_type) {
+	case IB_QPT_RC:
+		return MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_rc);
+	case IB_QPT_XRC_INI:
+	case IB_QPT_XRC_TGT:
+		return MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_xrc);
+	case IB_QPT_UC:
+		return MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_uc);
+	case IB_QPT_UD:
+		return MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_ud);
+	case MLX5_IB_QPT_DCI:
+	case MLX5_IB_QPT_DCT:
+		return MLX5_CAP_GEN(mdev, dp_ordering_ooo_all_dc);
+	default:
+		return false;
+	}
+}
+
 static void process_vendor_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 				bool cond, struct mlx5_ib_qp *qp)
 {
@@ -3365,7 +3392,7 @@ static int set_qpc_atomic_flags(struct mlx5_ib_qp *qp,
 	if (access_flags & IB_ACCESS_REMOTE_ATOMIC) {
 		int atomic_mode;
 
-		atomic_mode = get_atomic_mode(dev, qp->type);
+		atomic_mode = get_atomic_mode(dev, qp);
 		if (atomic_mode < 0)
 			return -EOPNOTSUPP;
 
@@ -4316,6 +4343,11 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	if (qp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
 		MLX5_SET(qpc, qpc, deth_sqpn, 1);
 
+	if (qp->is_ooo_rq && cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
+		MLX5_SET(qpc, qpc, dp_ordering_1, 1);
+		MLX5_SET(qpc, qpc, dp_ordering_force, 1);
+	}
+
 	mlx5_cur = to_mlx5_state(cur_state);
 	mlx5_new = to_mlx5_state(new_state);
 
@@ -4531,7 +4563,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		if (attr->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC) {
 			int atomic_mode;
 
-			atomic_mode = get_atomic_mode(dev, MLX5_IB_QPT_DCT);
+			atomic_mode = get_atomic_mode(dev, qp);
 			if (atomic_mode < 0)
 				return -EOPNOTSUPP;
 
@@ -4573,6 +4605,10 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		MLX5_SET(dctc, dctc, hop_limit, attr->ah_attr.grh.hop_limit);
 		if (attr->ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE)
 			MLX5_SET(dctc, dctc, eth_prio, attr->ah_attr.sl & 0x7);
+		if (qp->is_ooo_rq) {
+			MLX5_SET(dctc, dctc, dp_ordering_1, 1);
+			MLX5_SET(dctc, dctc, dp_ordering_force, 1);
+		}
 
 		err = mlx5_core_create_dct(dev, &qp->dct.mdct, qp->dct.in,
 					   MLX5_ST_SZ_BYTES(create_dct_in), out,
@@ -4676,11 +4712,16 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				       min(udata->inlen, sizeof(ucmd))))
 			return -EFAULT;
 
-		if (ucmd.comp_mask ||
+		if (ucmd.comp_mask & ~MLX5_IB_MODIFY_QP_OOO_DP ||
 		    memchr_inv(&ucmd.burst_info.reserved, 0,
 			       sizeof(ucmd.burst_info.reserved)))
 			return -EOPNOTSUPP;
 
+		if (ucmd.comp_mask & MLX5_IB_MODIFY_QP_OOO_DP) {
+			if (!get_dp_ooo_cap(dev->mdev, qp->type))
+				return -EOPNOTSUPP;
+			qp->is_ooo_rq = 1;
+		}
 	}
 
 	if (qp->type == IB_QPT_GSI)
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index d4f6a36dffb0..8a6ad6c6841c 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -252,6 +252,7 @@ enum mlx5_ib_query_dev_resp_flags {
 	MLX5_IB_QUERY_DEV_RESP_FLAGS_CQE_128B_PAD  = 1 << 1,
 	MLX5_IB_QUERY_DEV_RESP_PACKET_BASED_CREDIT_MODE = 1 << 2,
 	MLX5_IB_QUERY_DEV_RESP_FLAGS_SCAT2CQE_DCT = 1 << 3,
+	MLX5_IB_QUERY_DEV_RESP_FLAGS_OOO_DP = 1 << 4,
 };
 
 enum mlx5_ib_tunnel_offloads {
@@ -439,6 +440,10 @@ struct mlx5_ib_burst_info {
 	__u16       reserved;
 };
 
+enum mlx5_ib_modify_qp_mask {
+	MLX5_IB_MODIFY_QP_OOO_DP = 1 << 0,
+};
+
 struct mlx5_ib_modify_qp {
 	__u32			   comp_mask;
 	struct mlx5_ib_burst_info  burst_info;
-- 
2.46.0


