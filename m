Return-Path: <linux-rdma+bounces-4243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C436294B8B4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010EF1C243C1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50231891CF;
	Thu,  8 Aug 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDMYXTsM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0C62A02;
	Thu,  8 Aug 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104840; cv=none; b=bdkT+0re+Pl5YxfXwwmjEY/NnF52S0H9ReIDAF6q4rwM2SviYC1sLRTPkIxD/kxKKBzdpenbuDsCTixIqfdxLzKCpwWmc9yK1zekLsFgM2R05rZiw8R4ElCI2ni9BRWHvCPdBdkJjhIjIBv/6Bc/bSFaF7uPvtJ4CConN1CeZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104840; c=relaxed/simple;
	bh=xI/wyD0X/8UQRlRWhHHBBMqTudYAo0TkOl1ukA6PHK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGf8P7ovFWRiISzCNOAM5iTZ6CWG38ohd4DDJpYbrVU1AtDjoFfFvei9lsdXD9uasQrpGDkGs2Gong2lNjKqAvwvfZHuyf4LLjh1kC4AYV4Yxsaguhp0ZfLGAtJH6F0L+XpcKbBuaQKp0v7aXUSTNO4UezYdE1R9A4e+4oAkvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDMYXTsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B337C32782;
	Thu,  8 Aug 2024 08:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723104840;
	bh=xI/wyD0X/8UQRlRWhHHBBMqTudYAo0TkOl1ukA6PHK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDMYXTsMpTYxwuBO1M1Llm2UOhMTiagHX2goLmRynIb/05Az1nsg5MLnkRlmmwHpW
	 JnyjtV3U2xyD0/R8s94OFkkTPxr+EZL3YKeDnA2F6Uy6EihP4O9MsRubQjnpuG1Y98
	 SiD9SwlHR6bfCXmEiUfuubgcHl7Vz7zwT9JQJYh+GMlu3H4ySEBNhKL2n1stasnAHA
	 0h0mzkCu2etEfddRBdbuZ2/egEbQMUZgN0NSn8wvoHfTBaInp8t2k49WY5rRcMVN2U
	 Tc7vrzfCwTMJ+6tETnt280GZM5lV/yeIYMirP9meLd9S5y1j4DxDcGIi829M55B1Q9
	 7Iz0bIn/9AyZQ==
Date: Thu, 8 Aug 2024 11:13:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Fix ib_core building error when
 CONFIG_MMU=n
Message-ID: <20240808081355.GF22826@unreal>
References: <20240808074026.3535706-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808074026.3535706-1-huangjunxian6@hisilicon.com>

On Thu, Aug 08, 2024 at 03:40:26PM +0800, Junxian Huang wrote:
> zap_vma_ptes() depends on CONFIG_MMU. When CONFIG_MMU=n,
> a building error occurs due to the zap_vma_ptes() call in
> uverbs_user_mmap_disassociate():
> 
> ERROR: modpost: "zap_vma_ptes" [drivers/infiniband/core/ib_core.ko] undefined!
> 
> Add "#ifdef CONFIG_MMU" to fix this error.

The fix is to return back include which was removed in 577b3696166a ("RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages").
I already did it as our wip/* branches are possible to rebase.

Thanks

> 
> Fixes: 577b3696166a ("RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408072142.mVX227UI-lkp@intel.com/
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/ib_core_uverbs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
> index 4e27389a75ad..911aec0573cb 100644
> --- a/drivers/infiniband/core/ib_core_uverbs.c
> +++ b/drivers/infiniband/core/ib_core_uverbs.c
> @@ -367,6 +367,7 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
>  }
>  EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
>  
> +#ifdef CONFIG_MMU
>  void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  {
>  	struct rdma_umap_priv *priv, *next_priv;
> @@ -428,7 +429,6 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  		mmput(mm);
>  	}
>  }
> -EXPORT_SYMBOL(uverbs_user_mmap_disassociate);
>  
>  /**
>   * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
> @@ -449,4 +449,14 @@ void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
>  	uverbs_user_mmap_disassociate(ufile);
>  	up_read(&ufile->hw_destroy_rwsem);
>  }
> +#else
> +void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
> +{
> +}
> +
> +void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
> +{
> +}
> +#endif
> +EXPORT_SYMBOL(uverbs_user_mmap_disassociate);
>  EXPORT_SYMBOL(rdma_user_mmap_disassociate);
> -- 
> 2.33.0
> 

