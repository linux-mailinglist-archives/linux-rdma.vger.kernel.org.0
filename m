Return-Path: <linux-rdma+bounces-5356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A7999810C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ACA1F26F42
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FAE1A08C5;
	Thu, 10 Oct 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6qBB5ij"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0351BC074
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550229; cv=none; b=cm3dcJsZj5aVPhWktQdcrP6C5UtgqwOY80WY18s06hEdibSItqr/H08a7NAe/R5StW9VCoF2PoMjN/eCxRrYmGqy4i2Bd1+8Kap1TrS0c+WuNj+b5u9CtMDTPx2diTurXA4HeoM1ZcK1OegesRpYIutNO6yh7YV3Ofok9Ugmm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550229; c=relaxed/simple;
	bh=GlU0IJ/igaMWyrKdw/I6XGO6NbL8NYl68+YzL1zMGnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czSZgxBJr2okk9JmxOD75nDjzlh1fH4p9HtbHhxh5bnnkjkbsSUn1/AZOMJ38IeKLt6Yx6tfrLRqBfj43zqT8hEpAGh8jeb7N+DSvqmX8O0DbdDPDSO7lBsRzJU5McJJihL+8Uytxuoe+zNIzAAbV7iwqiq0CUBkHp+UBelkfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6qBB5ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5598AC4CEC6;
	Thu, 10 Oct 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728550228;
	bh=GlU0IJ/igaMWyrKdw/I6XGO6NbL8NYl68+YzL1zMGnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=a6qBB5ijKN/byEEHRPKV14eo4aI7UwpO2wN7usNDmnpFVfhwevQP6/KN7uDERdJlk
	 cApL+4FBMFU0bLeRVfh6ynaWASTSlK3Bliw+5SpzWBUDkjxtanPJ6JF8YbB8MHRmTx
	 p09+9IHh1rJjIoFgk/jeQDk0+kWIkSo55rGwqun+Qg6sj+6oMTe57X/OrwwWvOOmMV
	 JJ0I+Yp51slWJ3w4spwj9PyIFNbpVt2mZU0HIJPRn6wptZzOti/CS8ya+tCPLMrUVI
	 HpH/lIFtoNtZYVKQr6Q0KScoV1jxQpco0B4FgJkXNMAd47jrF5xa3kZ42ljGMjMgds
	 A58wrNjBVMNSQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down
Date: Thu, 10 Oct 2024 11:50:23 +0300
Message-ID: <d85515d6ef21a2fa8ef4c8293dce9b58df8a6297.1728550179.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

After the cited commit below max_dest_rd_atomic and max_rd_atomic values
are being rounded down to the next power of 2. As opposed to the old
behavior and mlx4 driver where they used to be rounded up instead.

In order to stay consistent with older code and other drivers, revert to
using fls round function which rounds up to the next power of 2.

Fixes: f18e26af6aba ("RDMA/mlx5: Convert modify QP to use MLX5_SET macros")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 849a160f99bc..88b6d9797a33 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4297,14 +4297,14 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		MLX5_SET(qpc, qpc, retry_count, attr->retry_cnt);
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC && attr->max_rd_atomic)
-		MLX5_SET(qpc, qpc, log_sra_max, ilog2(attr->max_rd_atomic));
+		MLX5_SET(qpc, qpc, log_sra_max, fls(attr->max_rd_atomic - 1));
 
 	if (attr_mask & IB_QP_SQ_PSN)
 		MLX5_SET(qpc, qpc, next_send_psn, attr->sq_psn);
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC && attr->max_dest_rd_atomic)
 		MLX5_SET(qpc, qpc, log_rra_max,
-			 ilog2(attr->max_dest_rd_atomic));
+			 fls(attr->max_dest_rd_atomic - 1));
 
 	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC)) {
 		err = set_qpc_atomic_flags(qp, attr, attr_mask, qpc);
-- 
2.46.2


