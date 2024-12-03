Return-Path: <linux-rdma+bounces-6194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0954E9E1E10
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1551665B8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D131F12F5;
	Tue,  3 Dec 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPLWNTMK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED11EB9EB
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233360; cv=none; b=UUI39wVsYl4cyZcS9GW9z8jgaRy2Cf2Tj+QayBR7X8YySmB1Wj+iExuth2kluBhAWWjEEP+mH8wtslf54b9AlNZgEdkl+rZTY0pYp9owRMv1hSOdMhIJtG8dG8yxPGIRv6QLg6iigCQRDcEaqPz0vBMiSUs7su2AtIiURjtamf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233360; c=relaxed/simple;
	bh=g/bU6NEVFLBRwWs+T6mHcX0F9cK3DnIi6nyBGDG6xNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwA9dapHZHp9+M9ne73xlC57eQ5hFCWh36yaruL3wVB9myEpJsYSfHiFtOzAX8LvjYVvhifV0x87HHYX5VRgmJJzVuxPaGkrB0HNp1XiuRcYb8YWKpNexr30dgbaMI2pgITsC4lPpGmh2WRIfrgvfT9unIKsD0o87SrQd+wmmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPLWNTMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8498C4CEE3;
	Tue,  3 Dec 2024 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233359;
	bh=g/bU6NEVFLBRwWs+T6mHcX0F9cK3DnIi6nyBGDG6xNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPLWNTMKa7BL+Que2gNkT8Wzvbm/oYc8Vs90axCXN2DkXBeisXIL4nsFI3EVNm/mQ
	 QV6R521S0cWE1YXCY6ynNysajw9wDSPNdfy/ZxCmsvjqncYKLhWum/rvqKeIZOPle7
	 MFhZZc+8JqEUZRV0TOKW1ojhmgp1map/qrinkkxC6j5Ly/eteB7QKlkQoyeZKNzmpZ
	 L/8n34LMj4W+zqdvjd+TsCSgKoEa07WXjSoJ4xgF53LLwINwBH/rSzj74og63s4/l3
	 899sijUK5MSYnsnTJyuoEaXOT/A8QD5l/HItgx5rYI8NLBvfbjzZT5OmUJ7111cUNM
	 bj9lqINXyvbfw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx4: Use DMA iterator to write MTT
Date: Tue,  3 Dec 2024 15:42:26 +0200
Message-ID: <0bf595962c964fb8918743405acf9103a5a85983.1733233299.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c39ec6f5d4664c439a72f2961728ebb5895a9f07.1733233299.git.leonro@nvidia.com>
References: <c39ec6f5d4664c439a72f2961728ebb5895a9f07.1733233299.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Replace an open coding of rdma_umem_for_each_dma_block() with
the proper function.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 119 +++-----------------------------
 1 file changed, 8 insertions(+), 111 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 819c98562e6a..e77645a673fb 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -87,123 +87,20 @@ struct ib_mr *mlx4_ib_get_dma_mr(struct ib_pd *pd, int acc)
 	return ERR_PTR(err);
 }
 
-static int mlx4_ib_umem_write_mtt_block(struct mlx4_ib_dev *dev,
-					struct mlx4_mtt *mtt,
-					u64 mtt_size, u64 mtt_shift, u64 len,
-					u64 cur_start_addr, u64 *pages,
-					int *start_index, int *npages)
-{
-	u64 cur_end_addr = cur_start_addr + len;
-	u64 cur_end_addr_aligned = 0;
-	u64 mtt_entries;
-	int err = 0;
-	int k;
-
-	len += (cur_start_addr & (mtt_size - 1ULL));
-	cur_end_addr_aligned = round_up(cur_end_addr, mtt_size);
-	len += (cur_end_addr_aligned - cur_end_addr);
-	if (len & (mtt_size - 1ULL)) {
-		pr_warn("write_block: len %llx is not aligned to mtt_size %llx\n",
-			len, mtt_size);
-		return -EINVAL;
-	}
-
-	mtt_entries = (len >> mtt_shift);
-
-	/*
-	 * Align the MTT start address to the mtt_size.
-	 * Required to handle cases when the MR starts in the middle of an MTT
-	 * record. Was not required in old code since the physical addresses
-	 * provided by the dma subsystem were page aligned, which was also the
-	 * MTT size.
-	 */
-	cur_start_addr = round_down(cur_start_addr, mtt_size);
-	/* A new block is started ... */
-	for (k = 0; k < mtt_entries; ++k) {
-		pages[*npages] = cur_start_addr + (mtt_size * k);
-		(*npages)++;
-		/*
-		 * Be friendly to mlx4_write_mtt() and pass it chunks of
-		 * appropriate size.
-		 */
-		if (*npages == PAGE_SIZE / sizeof(u64)) {
-			err = mlx4_write_mtt(dev->dev, mtt, *start_index,
-					     *npages, pages);
-			if (err)
-				return err;
-
-			(*start_index) += *npages;
-			*npages = 0;
-		}
-	}
-
-	return 0;
-}
-
 int mlx4_ib_umem_write_mtt(struct mlx4_ib_dev *dev, struct mlx4_mtt *mtt,
 			   struct ib_umem *umem)
 {
-	u64 *pages;
-	u64 len = 0;
-	int err = 0;
-	u64 mtt_size;
-	u64 cur_start_addr = 0;
-	u64 mtt_shift;
-	int start_index = 0;
-	int npages = 0;
-	struct scatterlist *sg;
-	int i;
-
-	pages = (u64 *) __get_free_page(GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	struct ib_block_iter biter;
+	int err, i = 0;
+	u64 addr;
 
-	mtt_shift = mtt->page_shift;
-	mtt_size = 1ULL << mtt_shift;
-
-	for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, i) {
-		if (cur_start_addr + len == sg_dma_address(sg)) {
-			/* still the same block */
-			len += sg_dma_len(sg);
-			continue;
-		}
-		/*
-		 * A new block is started ...
-		 * If len is malaligned, write an extra mtt entry to cover the
-		 * misaligned area (round up the division)
-		 */
-		err = mlx4_ib_umem_write_mtt_block(dev, mtt, mtt_size,
-						   mtt_shift, len,
-						   cur_start_addr,
-						   pages, &start_index,
-						   &npages);
-		if (err)
-			goto out;
-
-		cur_start_addr = sg_dma_address(sg);
-		len = sg_dma_len(sg);
-	}
-
-	/* Handle the last block */
-	if (len > 0) {
-		/*
-		 * If len is malaligned, write an extra mtt entry to cover
-		 * the misaligned area (round up the division)
-		 */
-		err = mlx4_ib_umem_write_mtt_block(dev, mtt, mtt_size,
-						   mtt_shift, len,
-						   cur_start_addr, pages,
-						   &start_index, &npages);
+	rdma_umem_for_each_dma_block(umem, &biter, BIT(mtt->page_shift)) {
+		addr = rdma_block_iter_dma_address(&biter);
+		err = mlx4_write_mtt(dev->dev, mtt, i++, 1, &addr);
 		if (err)
-			goto out;
+			return err;
 	}
-
-	if (npages)
-		err = mlx4_write_mtt(dev->dev, mtt, start_index, npages, pages);
-
-out:
-	free_page((unsigned long) pages);
-	return err;
+	return 0;
 }
 
 static struct ib_umem *mlx4_get_umem_mr(struct ib_device *device, u64 start,
-- 
2.47.0


