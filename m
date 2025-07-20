Return-Path: <linux-rdma+bounces-12333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13896B0B903
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 01:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF623B6EBE
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B33A1CD;
	Sun, 20 Jul 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S7n5WoR6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5242AA9
	for <linux-rdma@vger.kernel.org>; Sun, 20 Jul 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052471; cv=none; b=ELafx2bR/5Xto7ZgWNieWPkFVQdzI4RTWPM2Elj87sJauNN45VUDTLm1FSSag4mvqn0vwZpl84S8G1cOlV6xAZGTt108xZza8N56ABZSZyP9mgJ0PlGsLSCP1eg+hcUOBgcnOgplkbhPpWXPvE9BsEQRXTVBbgdaGMvLZL7eSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052471; c=relaxed/simple;
	bh=OluhjT6olmlyw3OujUX80Anu8tjhSxcK+0d3MbvZr6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTEhST6EBIzxFnruQF70nLuSp3bRMhvcMYsE2fsCVf0oJ1Uo1SPhgTwpVGKB1JR4eD3KBH9wTktZEGF/I3uK31S/8DrpJlbsVPie8yJcXrkWF5NLFjaTHkBV+m5S1XMZHPX1gGQqDwlIoA9sallHRJQ6j1ZnL7hwkpglUwl75Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S7n5WoR6; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8791d040-cb5b-4633-82f5-7ee090557a92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753052467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDr8y0789q0IT4nUO9DOdWBVA0XzFh2CyeFWlzHpTEc=;
	b=S7n5WoR6n2kuXHZ73QTtnqTzvXrVNRm2/By2hD7aEYmfxWY65n6HGdtepP1rViIj1NFZ6R
	aY/tW3BvpvNtI14mLwJ5pIF7cmPA1bXK2akBxs4iqB9URabV5AM1pfUHYqxUH5O5tUCw7j
	sx4eOY2hVDTkD4TgOeb4Ujpu3VBjnlU=
Date: Sun, 20 Jul 2025 16:00:48 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix returned type from
 _mlx5r_umr_zap_mkey()
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 "Colin King (gmail)" <colin.i.king@gmail.com>,
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
 Michael Guralnik <michaelgur@nvidia.com>
References: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <71d8ea208ac7eaa4438af683b9afaed78625e419.1753003467.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/20 2:25, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> As Colin reported:
>   "The variable zapped_blocks is a size_t type and is being assigned a int
>    return value from the call to _mlx5r_umr_zap_mkey. Since zapped_blocks is an
>    unsigned type, the error check for zapped_blocks < 0 will never be true."
> 
> So separate return error and nblocks assignment.

size_t is an unsigned type, used to represent the size of objects while 
int is a signed 32-bit integer (on most platforms).

Assign an int value to a size_t causes an implicit conversion from 
signed to unsigned.

It may seem harmless, but it can cause subtle and serious bugs depending 
on the scenarios.

Many CVEs in the kernel result from misuse of signed/unsigned types.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
  >
> Fixes: e73242aa14d2 ("RDMA/mlx5: Optimize DMABUF mkey page size")
> Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
> Closes: https://lore.kernel.org/all/79166fb1-3b73-4d37-af02-a17b22eb8e64@gmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/hw/mlx5/umr.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index fa5c4ea685b9d..054f6dae24151 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -992,6 +992,7 @@ _mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr, unsigned int flags,
>   static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>   			       unsigned int flags,
>   			       unsigned int page_shift,
> +			       size_t *nblocks,
>   			       bool dd)
>   {
>   	unsigned int old_page_shift = mr->page_shift;
> @@ -1000,7 +1001,6 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>   	size_t page_shift_nblocks;
>   	unsigned int max_log_size;
>   	int access_mode;
> -	size_t nblocks;
>   	int err;
>   
>   	access_mode = dd ? MLX5_MKC_ACCESS_MODE_KSM : MLX5_MKC_ACCESS_MODE_MTT;
> @@ -1014,26 +1014,26 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>   	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may
>   	 * be used as offset into the XLT later on.
>   	 */
> -	nblocks = ib_umem_num_dma_blocks(mr->umem, 1UL << max_page_shift);
> +	*nblocks = ib_umem_num_dma_blocks(mr->umem, 1UL << max_page_shift);
>   	if (dd)
> -		nblocks = ALIGN(nblocks, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
> +		*nblocks = ALIGN(*nblocks, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
>   	else
> -		nblocks = ALIGN(nblocks, MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT);
> +		*nblocks = ALIGN(*nblocks, MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT);
>   	page_shift_nblocks = ib_umem_num_dma_blocks(mr->umem,
>   						    1UL << page_shift);
>   	/* If the number of blocks at max possible page shift is greater than
>   	 * the number of blocks at the new page size, we should just go over the
>   	 * whole mkey entries.
>   	 */
> -	if (nblocks >= page_shift_nblocks)
> -		nblocks = 0;
> +	if (*nblocks >= page_shift_nblocks)
> +		*nblocks = 0;
>   
>   	/* Make the first nblocks entries non-present without changing
>   	 * page size yet.
>   	 */
> -	if (nblocks)
> +	if (*nblocks)
>   		mr->page_shift = max_page_shift;
> -	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, 0, nblocks, dd);
> +	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, 0, *nblocks, dd);
>   	if (err) {
>   		mr->page_shift = old_page_shift;
>   		return err;
> @@ -1042,7 +1042,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>   	/* Change page size to the max page size now that the MR is completely
>   	 * non-present.
>   	 */
> -	if (nblocks) {
> +	if (*nblocks) {
>   		err = mlx5r_umr_update_mr_page_shift(mr, max_page_shift, dd);
>   		if (err) {
>   			mr->page_shift = old_page_shift;
> @@ -1050,7 +1050,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>   		}
>   	}
>   
> -	return nblocks;
> +	return 0;
>   }
>   
>   /**
> @@ -1085,10 +1085,10 @@ int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
>   	size_t total_blocks;
>   	int err;
>   
> -	zapped_blocks = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift,
> -					    mr->data_direct);
> -	if (zapped_blocks < 0)
> -		return zapped_blocks;
> +	err = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift, &zapped_blocks,
> +				  mr->data_direct);
> +	if (err)
> +		return err;
>   
>   	/* _mlx5r_umr_zap_mkey already enables the mkey */
>   	xlt_flags &= ~MLX5_IB_UPD_XLT_ENABLE;


