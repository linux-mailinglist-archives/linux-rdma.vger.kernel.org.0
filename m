Return-Path: <linux-rdma+bounces-12318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91771B0B412
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 09:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003A77AF360
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3981ADC90;
	Sun, 20 Jul 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIAtlwqt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88272F50;
	Sun, 20 Jul 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752995905; cv=none; b=DUUP9vOhbByEs8Pg+ovObcFkx0NGVC12RYYdMj/h1PPrPnOvjHX+KoTcLKm+WfLqnIjIH6hrNgTti55QUjMqLC2SN9yZbr6oNbtJ7bbTHHZ/glJ6adOtYl8G/4QyBrTLkb73bMdCa58vEiivWkVR53aDjO72lXJ2g8tISLPdcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752995905; c=relaxed/simple;
	bh=UE01BYiDfTSkU90M2y71VUbbgQt5iPxl3tihD9JAOjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIDi1d1PE6CBZjaRRUUUpMBEomlw59qoWC04elZq1HaK/8hLZSulLl1EsMdpTKeCEjuo2rldk0SW+bg4biWqO0yL0Ny7DY/RAt2ohpkPKNtJawf6N5YTnZAWEZK85V3s3NhT4TXH5xkn59BVwsHedm7GrKrp7n6mf0qg3R56MLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIAtlwqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14B8C4CEE7;
	Sun, 20 Jul 2025 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752995905;
	bh=UE01BYiDfTSkU90M2y71VUbbgQt5iPxl3tihD9JAOjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIAtlwqt903Ua7eVmSoJNpnKmY46n3LpXbAjQp7mC1KMK1X2sDIqkAviL38hwXjY4
	 JDbrub8ENkkGwLe9dHhBzsMAK1haY68PqeuAN6e+fWKG/424uve8PyD+QV20PFZAoC
	 YV40RTxcjm+7EY9YDqQb9dZPVg+j6ovzZzpML9rnWQxBy+jsjJYqMI/DvULIBZWQj8
	 2yRY1xQ1wPYo3rzs/nRLNzgFq1Q09YgiKqW9r4Nkrr8EN2qqLC3rZamiSdeB/C9bLS
	 61/58FZyFv6TS1DcaA2o6kcf4kKQhnSF2bvsoBnFn766u1iRQtzUVN4QnGXV6Q+LRt
	 2Cnnd5TFJ1xqQ==
Date: Sun, 20 Jul 2025 10:18:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Edward Srouji <edwards@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RDMA/mlx5: issue with error checking
Message-ID: <20250720071821.GD402218@unreal>
References: <79166fb1-3b73-4d37-af02-a17b22eb8e64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79166fb1-3b73-4d37-af02-a17b22eb8e64@gmail.com>

On Thu, Jul 17, 2025 at 12:36:06PM +0100, Colin King (gmail) wrote:
> Hi
> 
> Static analysis detected an issue with the following commit:
> 
> commit e73242aa14d2ec7f4a1a13688366bb36dc0fe5b7
> Author: Edward Srouji <edwards@nvidia.com>
> Date:   Wed Jul 9 09:42:11 2025 +0300
> 
>     RDMA/mlx5: Optimize DMABUF mkey page size
> 
> 
> The issue is as follows:
> 
> int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
>                                  unsigned int page_shift)
> {
>         unsigned int old_page_shift = mr->page_shift;
>         size_t zapped_blocks;
>         size_t total_blocks;
>         int err;
> 
>         zapped_blocks = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift,
>                                             mr->data_direct);
>         if (zapped_blocks < 0)
>                 return zapped_blocks;
> 
> The variable zapped_blocks is a size_t type and is being assigned a int
> return value from the call to _mlx5r_umr_zap_mkey. Since zapped_blocks is an
> unsigned type, the error check for zapped_blocks < 0 will never be true.  I
> suspect total_blocks should be a ssize_t type, but that probably also means
> total_blocks should be ssize_t too, but don't have the hardware to test this
> fix and I'm concerned that this change may break the code. Hence I'm
> reporting this issue.

Thanks for the report, this will probably fix it.

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 993d24f35ccbe..a27bee9a38138 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -996,6 +996,7 @@ _mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr, unsigned int flags,
 static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 			       unsigned int flags,
 			       unsigned int page_shift,
+			       size_t *nblocks,
 			       bool dd)
 {
 	unsigned int old_page_shift = mr->page_shift;
@@ -1004,7 +1005,6 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	size_t page_shift_nblocks;
 	unsigned int max_log_size;
 	int access_mode;
-	size_t nblocks;
 	int err;
 
 	access_mode = dd ? MLX5_MKC_ACCESS_MODE_KSM : MLX5_MKC_ACCESS_MODE_MTT;
@@ -1018,26 +1018,26 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
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
@@ -1046,7 +1046,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 	/* Change page size to the max page size now that the MR is completely
 	 * non-present.
 	 */
-	if (nblocks) {
+	if (*nblocks) {
 		err = mlx5r_umr_update_mr_page_shift(mr, max_page_shift, dd);
 		if (err) {
 			mr->page_shift = old_page_shift;
@@ -1054,7 +1054,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 		}
 	}
 
-	return err ? err : nblocks;
+	return 0;
 }
 
 /**
@@ -1089,10 +1089,10 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
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

> 
> Colin
> 
> 






