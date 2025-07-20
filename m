Return-Path: <linux-rdma+bounces-12321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F39B0B493
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F28F17BDC0
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF51D618C;
	Sun, 20 Jul 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3F9/1dx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE370808
	for <linux-rdma@vger.kernel.org>; Sun, 20 Jul 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753003544; cv=none; b=GVf1Uf5qktpjaure9e7rSvik7sKkQSiPveIy6e+in1qOyPjo85P106bMj9J1wdf/NHtn0a5lSqMvOfOT3vTTCI77udijfJMvVL031wcUohz+bg+VMmnhQtmvtOT5vjaEFFR6gV2lFaLqcUoMUH4LUwZM60mBA5DCiKDA/pifv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753003544; c=relaxed/simple;
	bh=rDoBqPYO+Ssg5AxOof/GQenVakxJXPcNBpKe9i+O0Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJ19FhbB2yDT6O/4H6ff9EcIn+BN33k9z2gh4bIFjxI3cB1pVh44v8DpO3WY2KI65x3T0ePt48LbVl3loHTdDwciyqW7q5o2fk9gdWsen4Po0NBP51n1Oia/NpeXoUml5wXb2ctEM49X9wbhI3Oan8W5Vf5HdEatjzTl/SUz46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3F9/1dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8866DC4CEE7;
	Sun, 20 Jul 2025 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753003542;
	bh=rDoBqPYO+Ssg5AxOof/GQenVakxJXPcNBpKe9i+O0Xo=;
	h=From:To:Cc:Subject:Date:From;
	b=C3F9/1dx6Iip2YFs28wc08+G9gBuqt/hwi29l8M1+et/MmKmH0D/NBOjP3wxf+bGY
	 xBMKfLluzN6ayo7csKEvOV1gJncEBE3O10EeIZq4q7x61BudeNQskb0ZSkL5utUMUf
	 I6O2GkRdac8ybHR5nnOdBMPQYtprVXiI4+4h39lMApWQGlNx+Z8s3O/KZSjE1aHTWr
	 HSFz+eNpNsYVplkmtVQgGY0roStJrOdYrGG/EglPgljTyp8MwOntZuk1rR3+czUbRE
	 amiYk6PXqataP5Qj4PMir4KpS29RraFP12qBhSOurbDed+piJs/TMSmRSNbnj42VcF
	 WEb2Q6mOUkf+g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"Colin King (gmail)" <colin.i.king@gmail.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Fix returned type from _mlx5r_umr_zap_mkey()
Date: Sun, 20 Jul 2025 12:25:34 +0300
Message-ID: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

As Colin reported:
 "The variable zapped_blocks is a size_t type and is being assigned a int
  return value from the call to _mlx5r_umr_zap_mkey. Since zapped_blocks is an
  unsigned type, the error check for zapped_blocks < 0 will never be true."

So separate return error and nblocks assignment.

Fixes: e73242aa14d2 ("RDMA/mlx5: Optimize DMABUF mkey page size")
Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/79166fb1-3b73-4d37-af02-a17b22eb8e64@gmail.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index fa5c4ea685b9d..054f6dae24151 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -992,6 +992,7 @@ _mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr, unsigned int flags,
 static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 			       unsigned int flags,
 			       unsigned int page_shift,
+			       size_t *nblocks,
 			       bool dd)
 {
 	unsigned int old_page_shift = mr->page_shift;
@@ -1000,7 +1001,6 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	size_t page_shift_nblocks;
 	unsigned int max_log_size;
 	int access_mode;
-	size_t nblocks;
 	int err;
 
 	access_mode = dd ? MLX5_MKC_ACCESS_MODE_KSM : MLX5_MKC_ACCESS_MODE_MTT;
@@ -1014,26 +1014,26 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may
 	 * be used as offset into the XLT later on.
 	 */
-	nblocks = ib_umem_num_dma_blocks(mr->umem, 1UL << max_page_shift);
+	*nblocks = ib_umem_num_dma_blocks(mr->umem, 1UL << max_page_shift);
 	if (dd)
-		nblocks = ALIGN(nblocks, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
+		*nblocks = ALIGN(*nblocks, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
 	else
-		nblocks = ALIGN(nblocks, MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT);
+		*nblocks = ALIGN(*nblocks, MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT);
 	page_shift_nblocks = ib_umem_num_dma_blocks(mr->umem,
 						    1UL << page_shift);
 	/* If the number of blocks at max possible page shift is greater than
 	 * the number of blocks at the new page size, we should just go over the
 	 * whole mkey entries.
 	 */
-	if (nblocks >= page_shift_nblocks)
-		nblocks = 0;
+	if (*nblocks >= page_shift_nblocks)
+		*nblocks = 0;
 
 	/* Make the first nblocks entries non-present without changing
 	 * page size yet.
 	 */
-	if (nblocks)
+	if (*nblocks)
 		mr->page_shift = max_page_shift;
-	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, 0, nblocks, dd);
+	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, 0, *nblocks, dd);
 	if (err) {
 		mr->page_shift = old_page_shift;
 		return err;
@@ -1042,7 +1042,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	/* Change page size to the max page size now that the MR is completely
 	 * non-present.
 	 */
-	if (nblocks) {
+	if (*nblocks) {
 		err = mlx5r_umr_update_mr_page_shift(mr, max_page_shift, dd);
 		if (err) {
 			mr->page_shift = old_page_shift;
@@ -1050,7 +1050,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 		}
 	}
 
-	return nblocks;
+	return 0;
 }
 
 /**
@@ -1085,10 +1085,10 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
 	size_t total_blocks;
 	int err;
 
-	zapped_blocks = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift,
-					    mr->data_direct);
-	if (zapped_blocks < 0)
-		return zapped_blocks;
+	err = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift, &zapped_blocks,
+				  mr->data_direct);
+	if (err)
+		return err;
 
 	/* _mlx5r_umr_zap_mkey already enables the mkey */
 	xlt_flags &= ~MLX5_IB_UPD_XLT_ENABLE;
-- 
2.50.1


