Return-Path: <linux-rdma+bounces-1962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D238A6A2F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933111C212A4
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010E12AAD5;
	Tue, 16 Apr 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV3tiomg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80D12A176
	for <linux-rdma@vger.kernel.org>; Tue, 16 Apr 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269042; cv=none; b=AVu0C7OrB9tQLfzAuuM6r1FPMvMkR576XzfuGo3qmhUSUsvmJsXp0gxcXCHWthel/Hj9lTNn23EWB+rgqNuUEqfym191YEH1Sma42biiMeZjaAqCp0ZSoORCG/KSWkZWzv+pQOQ0wgQXrAmdSC3/Bl0FwvsG9O5mvjpjbyKRF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269042; c=relaxed/simple;
	bh=PA0Sdvp08t+XN/jinEMxMgneO6ID2fiPPprz/JtX1rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8yjEcRz34KK5qGRIeSnfxkA2K/z4LZk4C/+zhqgOFYg0nfTBmdM8lZB7iH7yIEWcKlGxFNtuDDx+CM6dzi5ZD5PwVVWBiv+xw+Wq90q8OWulRylUAgqEVTmGo9HymPEDhF6ijdWcYcP5ZWG/Yd9pPxwlYa6L4NfNd+BrMlTjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV3tiomg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA0BC2BD10;
	Tue, 16 Apr 2024 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269042;
	bh=PA0Sdvp08t+XN/jinEMxMgneO6ID2fiPPprz/JtX1rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EV3tiomg3fV0kMlZsOZbMSvMK9THJ24KdeOz2gQA5r0uRaTnEGkHOo+AcB3WiJ3wo
	 TPbfYkH8ZEeQ14F64HJWj8VWkjtQGPycIcioBllfXHChqefzzKqYddk8UnCsRuP9Hz
	 NfojG54AGjLce6OgXNLHWruCrGk8ZtWnA/kKO6ty8+eqd5bWyZ5bcHPAjxuvItt/HX
	 E/MDlpTf8FRUrxYVfSPwGjbzsx6MO45R+1dcqZBYITUMt62IUgLNI7DAUm2xOxYPIN
	 V2ig7b5EnYsvrZQ530+t1G3+MdRrtGSNBz04cfxbvSgXk5dnMwA3g/A71P+7nIb93K
	 ScUKN2YdZJ65w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Track DCT, DCI and REG_UMR QPs as diver_detail resources.
Date: Tue, 16 Apr 2024 15:03:51 +0300
Message-ID: <452432d7d0917f053a80a893a614169857fe3b10.1713268997.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2607bb3ddec3cae3443c2ea19e9f700825d20a98.1713268997.git.leon@kernel.org>
References: <2607bb3ddec3cae3443c2ea19e9f700825d20a98.1713268997.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Allow user to see driver-specific QPs (the "driver_detail" QPs)
through the rdmatool, when requested.

When creating DCT, DCI and REG_UMR QPs, we designate them as driver_detail
resources.

When filling the QP info for the rdma tool, for the driver_detail QPs:
-the QP type is IB_QPT_DRIVER
-the subtype is a string with the QP name ("DCT", "DCI", "REG_UMR")

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c       |  3 +--
 drivers/infiniband/hw/mlx5/restrack.c | 29 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 83727bde54f5..8c16c9278ce4 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3099,7 +3099,6 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	switch (qp->type) {
 	case MLX5_IB_QPT_DCT:
 		err = create_dct(dev, pd, qp, params);
-		rdma_restrack_no_track(&qp->ibqp.res);
 		break;
 	case MLX5_IB_QPT_DCI:
 		err = create_dci(dev, pd, qp, params);
@@ -3111,9 +3110,9 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		err = mlx5_ib_create_gsi(pd, qp, params->attr);
 		break;
 	case MLX5_IB_QPT_HW_GSI:
-	case MLX5_IB_QPT_REG_UMR:
 		rdma_restrack_no_track(&qp->ibqp.res);
 		fallthrough;
+	case MLX5_IB_QPT_REG_UMR:
 	default:
 		if (params->udata)
 			err = create_user_qp(dev, pd, qp, params);
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 4ac429e72004..affcf8fe943c 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -156,6 +156,34 @@ static int fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ibcq)
 	return fill_res_raw(msg, dev, MLX5_SGMT_TYPE_PRM_QUERY_CQ, cq->mcq.cqn);
 }
 
+static int fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
+{
+	struct mlx5_ib_qp *qp = to_mqp(ibqp);
+	int ret;
+
+	if (qp->type < IB_QPT_DRIVER)
+		return 0;
+
+	switch (qp->type) {
+	case MLX5_IB_QPT_REG_UMR:
+		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE,
+				     "REG_UMR");
+		break;
+	case MLX5_IB_QPT_DCT:
+		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE, "DCT");
+		break;
+	case MLX5_IB_QPT_DCI:
+		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE, "DCI");
+		break;
+	default:
+		return 0;
+	}
+	if (ret)
+		return ret;
+
+	return nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_TYPE, IB_QPT_DRIVER);
+}
+
 static int fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ibqp)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
@@ -168,6 +196,7 @@ static const struct ib_device_ops restrack_ops = {
 	.fill_res_cq_entry_raw = fill_res_cq_entry_raw,
 	.fill_res_mr_entry = fill_res_mr_entry,
 	.fill_res_mr_entry_raw = fill_res_mr_entry_raw,
+	.fill_res_qp_entry = fill_res_qp_entry,
 	.fill_res_qp_entry_raw = fill_res_qp_entry_raw,
 	.fill_stat_mr_entry = fill_stat_mr_entry,
 };
-- 
2.44.0


