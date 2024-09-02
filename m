Return-Path: <linux-rdma+bounces-4697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FC9684E5
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10931F234F7
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4509B1D415B;
	Mon,  2 Sep 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF1mKFx7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC11D2794
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273431; cv=none; b=RFznHumLGXKOKI/x92n0PaG9dLcMZ236Ul5GAGlLDvEvS7LEQpR1dgDTMDoDqE32ym6OsBwGAX2PACQHaBEmhUtwBjTkjDajI0xxq0iDcEC6/Y6zec9/otZadAYrDW9jMQeROVVURRjtD6MER9TN3sBaCV5EwlFo9I4++xRMMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273431; c=relaxed/simple;
	bh=ACUvyAxOWUPHw6vdFAMMMPkjsNn5u023/8cmq3XlUO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aki8t9WXdzFocYJLz0Ur14H/YFr8e8nze7AGmOFgLb0LAoWNHoN9WEvvNx7GJM5GmNurAh+AGrYtbfjxZ1ej1MLmkPvTrdZNV3nnxyCSzvVQRNcCCXUg+aKn1X9slwdG/NOuXQF6DZbXQFScRzlxCyRYopr7xYL9fgI5SSNovuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF1mKFx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F4AC4CECA;
	Mon,  2 Sep 2024 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273430;
	bh=ACUvyAxOWUPHw6vdFAMMMPkjsNn5u023/8cmq3XlUO4=;
	h=From:To:Cc:Subject:Date:From;
	b=eF1mKFx72wh3kyz83uwmVNf41LGEd83koTWeOboRVpbQJQiGgSsMhU3Wg/pbrD6nI
	 Y7xhFgWzT+Q09R0rE1Dj8tAMZqAlGj49R4w6c67big2Y+d5G8jXEAQlKY9/7cOnWc8
	 0pPBeyWEa8wXgEpZw1caWHjtuM7MtR7+vnp+FI60GIg1UJNmGNhvVe9mHiMhkdUmIb
	 OoZn+mJ5k++uk0guTNQK+8UCKKiUOSLue8R3yvG0LKbU3a5kZBHXUtHJkNW6qf6h1E
	 cmc41BMPPwHOTcYmWpz3xOpCMB8uTFvRkhBtDtEgrMzaDMDZkF4RNGHJf0KrmU6dqc
	 FmM/DceYBECVw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	Gal Shalom <galshalom@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Enable ATS when allocating MRs
Date: Mon,  2 Sep 2024 13:37:03 +0300
Message-ID: <fafd4c9f14cf438d2882d88649c2947e1d05d0b4.1725273403.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

When allocating MRs, it is not definitive whether they will be used for
peer-to-peer transactions or for other usecases.

Since peer-to-peer transactions benefit significantly from ATS
performance-wise, enable ATS on newly-allocated MRs when supported.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Gal Shalom <galshalom@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3320238a0eb8..7d8c58f803ac 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1080,6 +1080,7 @@ struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
 	MLX5_SET(mkc, mkc, length64, 1);
 	set_mkc_access_pd_addr_fields(mkc, acc | IB_ACCESS_RELAXED_ORDERING, 0,
 				      pd);
+	MLX5_SET(mkc, mkc, ma_translation_mode, MLX5_CAP_GEN(dev->mdev, ats));
 
 	err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
 	if (err)
@@ -2218,6 +2219,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
 				   int access_mode, int page_shift)
 {
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	void *mkc;
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
@@ -2230,6 +2232,9 @@ static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
 	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 	MLX5_SET(mkc, mkc, log_page_size, page_shift);
+	if (access_mode == MLX5_MKC_ACCESS_MODE_PA ||
+	    access_mode == MLX5_MKC_ACCESS_MODE_MTT)
+		MLX5_SET(mkc, mkc, ma_translation_mode, MLX5_CAP_GEN(dev->mdev, ats));
 }
 
 static int _mlx5_alloc_mkey_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
-- 
2.46.0


