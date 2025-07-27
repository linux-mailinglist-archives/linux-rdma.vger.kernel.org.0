Return-Path: <linux-rdma+bounces-12492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DECB12F57
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jul 2025 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7273B8F62
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jul 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07518204F99;
	Sun, 27 Jul 2025 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prOl4PTP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB686329
	for <linux-rdma@vger.kernel.org>; Sun, 27 Jul 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753615682; cv=none; b=BEFxgcMMUwPx8HKdHqoIT3HM7a/4LW8ndCU70IFZirCbjYHe1m1vDwCYOFI08z46L1hvXaNGEEXtoxPqKy1ZeRwyDOrCnuYOdL7hW6/L9ouLuewo/cas+ZT5leNCG9BVS/xG2MKSoh+YfR1zBmqWsXV2AHPmfFkYPGjp3Vm5uoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753615682; c=relaxed/simple;
	bh=ekRYp898Xjx8fzQrst3Fs6j1VbXn1I/ecnTrIxx+ukg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvUq303LB4hVq9q2LvccGMMwIgJIS3ZpEp3SARdiKqljCDSM+jSd5UXfXXqayS5Bh07QOdUvgYF1MbEuKUdNt97+id0I6jPMwWoN8zTM7YbDiuTlfYctVnrfckYXEdjDiU8mcLLDRDShGK5UtYrU/KOkNaCQlx2lpBdNbS9xotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prOl4PTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686D8C4CEEB;
	Sun, 27 Jul 2025 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753615682;
	bh=ekRYp898Xjx8fzQrst3Fs6j1VbXn1I/ecnTrIxx+ukg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prOl4PTPF8f5Ge8liIQrpG16G/iAjnvjCTjjTXFrRUu4ROMAiKi6VlxIx3IsbmoUs
	 +yqdc+J7h2flxVcvW+erLf70NbRkh4caqRW6MxUEPDEMCYCETu4iURTS1PguO8j5EF
	 D86vF5uDN5TL2h3K3QJ9KKs+rN4KvkGhUqKzM2acdZp5qrOPlGZ0RlIIBCEoKQQ052
	 gwXs3IjxfJnVi99ze9lL9VEE/cFzY/L9HQDpJzECKvRm96SFbxpz+ck6jUatRYKBwr
	 lkJIhueS/TSAcESDZy5OwO7aEQgjQJ6bcxO34r/W8OzyXeaZYms2YXCMvZoAKOUBF5
	 QnOxXMwPEXADQ==
Date: Sun, 27 Jul 2025 14:27:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: Re: [PATCH for-next 1/3] RDMA/erdma: Use dma_map_page to map scatter
 MTT buffer
Message-ID: <20250727112757.GZ402218@unreal>
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
 <20250725055410.67520-2-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725055410.67520-2-boshiyu@linux.alibaba.com>

On Fri, Jul 25, 2025 at 01:53:54PM +0800, Boshi Yu wrote:
> Each high-level indirect MTT entry is assumed to point to exactly one page
> of the low-level MTT buffer, but dma_map_sg may merge contiguous physical
> pages when mapping. To avoid extra overhead from splitting merged regions,
> use dma_map_page to map the scatter MTT buffer page by page.
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 110 ++++++++++++++--------
>  drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
>  2 files changed, 71 insertions(+), 43 deletions(-)

<...>

> +	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
> +	if (!pg_dma)
> +		return 0;
>  
> -	sg_init_table(sglist, npages);
> +	addr = buf;
>  	for (i = 0; i < npages; i++) {
> -		pg = vmalloc_to_page(buf);
> +		pg = vmalloc_to_page(addr);

<...>
> +
> +		pg_dma[i] = dma_map_page(&dev->pdev->dev, pg, 0, PAGE_SIZE,
> +					 DMA_TO_DEVICE);

Does it work?

Thanks

