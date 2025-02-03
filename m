Return-Path: <linux-rdma+bounces-7364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5DA25A2D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 13:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FCC167902
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7663204C11;
	Mon,  3 Feb 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fySYIp2/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95201204C06
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587065; cv=none; b=d6xDvKnfe86ViOsMmdpRvnsmomcBzHwP7BGMCEgAMOHvBj92Vr/LFBlALR3PhQPcpE4wKmTgVUS6ImcBlmOW1K0t6i92Qf6DaAVBaijBC4RtP4avuRF+Utr04M6tHDsQ9EK/dTHgd7SHlpIIzo2PDQyIw4KYKoJ7mm+RMAL6lgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587065; c=relaxed/simple;
	bh=wc8t7IkQedrxrk3QZzk2mATS2I/jqMvjVe214qPsHVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvXDJCs5TCqjS+meJhW/YqDkEFjxpFe9xI4C+K/FpDcyaROALiIA++MFNjsr9bFwNBYi+V6cYG/sceycoIaxd8cGv9FQC14vMdgm6fd0k3ghxOMWrXfPLRaTXBZ4V85CI9PjCiKXXaaX/BeuLHHUAmVCBglbuVkYROi80zvntGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fySYIp2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1D7C4CED2;
	Mon,  3 Feb 2025 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738587065;
	bh=wc8t7IkQedrxrk3QZzk2mATS2I/jqMvjVe214qPsHVA=;
	h=From:To:Cc:Subject:Date:From;
	b=fySYIp2//Q72SjQdXmeNodo8vsWHYApWBKxhmmzINTf7SYhaSXeqbnSKkQfcFJk1K
	 DCa4/wi4d4SiOQjoAsS+BnT4Fyt/M59llU375ZtjCiAizSqkripHS4XmPJG5c7hJBV
	 2D0Uf8NcHDuY50ql7OgGp/u4CDov0iYk/TjjS3tHLRLf4t7hEaNMULe054j649XFMi
	 NJogNkR9rTAnnS2pFx6cyLzkRiK1LHIiZIvMRJn+tr4Fqalm4oZqMz5a7GbShVR9v3
	 HdnkEOu2JKzjPX41GPSmsJEIEpyOl9RZ1PKZuteZbZJpj0fWWriphrMHH0rHIW+M3a
	 yJd/Uyimzor9g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Artemy Kovalyov <artemyko@mnvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix a race for DMABUF MR which can lead to CQE with error
Date: Mon,  3 Feb 2025 14:50:59 +0200
Message-ID: <70617067abbfaa0c816a2544c922e7f4346def58.1738587016.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

This patch addresses a potential race condition for a DMABUF MR that can
result in a CQE with an error on the UMR QP.

During the __mlx5_ib_dereg_mr() flow, the following sequence of calls
occurs:
mlx5_revoke_mr()
mlx5r_umr_revoke_mr()
mlx5r_umr_post_send_wait()
At this point, the lkey is freed from the hardware's perspective.

However, concurrently, mlx5_ib_dmabuf_invalidate_cb() might be triggered
by another task attempting to invalidate the MR having that freed lkey.

Since the lkey has already been freed, this can lead to a CQE error,
causing the UMR QP to enter an error state.

To resolve this race condition, the dma_resv_lock() which was hold as
part of the mlx5_ib_dmabuf_invalidate_cb() is now also acquired as part
of the mlx5_revoke_mr() scope.

Upon a successful revoke, we set umem_dmabuf->private which points to
that MR to NULL, preventing any further invalidation attempts on its
lkey.

Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Artemy Kovalyov <artemyko@mnvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 9e8993ea68e7..32ab489517f6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1605,7 +1605,7 @@ static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
 
 	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
 
-	if (!umem_dmabuf->sgt)
+	if (!umem_dmabuf->sgt || !mr)
 		return;
 
 	mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP);
@@ -2088,11 +2088,16 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 	bool is_odp = is_odp_mr(mr);
+	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
+			!to_ib_umem_dmabuf(mr->umem)->pinned;
 	int ret = 0;
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
+	if (is_odp_dma_buf)
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv, NULL);
+
 	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
 		/* upon storing to a clean temp entry - schedule its cleanup */
@@ -2128,6 +2133,12 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 	}
 
+	if (is_odp_dma_buf) {
+		if (!ret)
+			to_ib_umem_dmabuf(mr->umem)->private = NULL;
+		dma_resv_unlock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+	}
+
 	return ret;
 }
 
-- 
2.48.1


