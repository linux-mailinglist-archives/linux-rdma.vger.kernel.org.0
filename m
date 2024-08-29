Return-Path: <linux-rdma+bounces-4636-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5356F96478C
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F367B2537B
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C121AD3E4;
	Thu, 29 Aug 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaVBywgb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392D19306A;
	Thu, 29 Aug 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939644; cv=none; b=fIkFUUBQuZLoo0ZnjPDTn+aVgas7VxUBEG1BTkmyIsZUDxaaKqhSe6Gy3eRCoYwxh+gqvHy4KCeRR7T8jJ3jWmJCz7TqYwkTMK6+qVQqXCy1MPrUhpQqEuyoF/1XRzdFJp4qYHoKkSjkyhLpu+fB5onrmgPKEUL9s17E+qCpy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939644; c=relaxed/simple;
	bh=BmMRbA2qEwzOz1sUZJsVWPr0HWKMM6RYtc1oRFXePTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daye4VqG6DLbRsq3PLFAKIMJBJmGaihD65pf351mnVFdgIzCwGF+Xy0aeNXdZOaS4TAcKG/FkrZg/D1mHINR1xs5hgyVVsBiN1PvnyipDnTPsPN11N/0noCd+cEBez9/jaBOSOFeEkPrYojN6KS4zbKhqlvutc4sGlqp6uCW3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaVBywgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A9AC4CEC3;
	Thu, 29 Aug 2024 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724939643;
	bh=BmMRbA2qEwzOz1sUZJsVWPr0HWKMM6RYtc1oRFXePTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaVBywgbBNmKGTFi8oYt1lGWqsq4cAZiAXT/EsqdGc5SXMsQQl9to7z+/aBvP/jSb
	 UAafbTtcm0PhLMBmuHniDyL/dRQuk8cO5KrBQOHS3SUo905du5581wZHArgN0iWSTx
	 AS0Wy5ulmT8yC8hN474vrlaY79ZNh2/A73toc6uXSFwCOv0zAoAOfVu3Tdy/OjjL32
	 MmCcmzmjrPgoMyxJ3Qaxg74yxdEjgI56UFzYDwQbn2L7CCNmtNSprde6AsKvmRcK/3
	 rSlPoxmuBgmq9dYnUbGqCnDiQxWVXRh1FM2yY61XQnGlBz2R4qZWs8ATLECn/yquP3
	 4mQpYMLQKV0Tw==
Date: Thu, 29 Aug 2024 14:53:58 +0100
From: Simon Horman <horms@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] RDMA/mana_ib: use the correct page size for mapping
 user-mode doorbell page
Message-ID: <20240829135358.GA2923441@kernel.org>
References: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
 <1724875569-12912-2-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724875569-12912-2-git-send-email-longli@linuxonhyperv.com>

On Wed, Aug 28, 2024 at 01:06:09PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When mapping doorbell page from user-mode, the driver should use the system
> page size as the doorbell is allocated via mmap() from user-mode.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index f68f54aea820..b26c4ebec2e0 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -511,13 +511,13 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
>  	      PAGE_SHIFT;
>  	prot = pgprot_writecombine(vma->vm_page_prot);
>  
> -	ret = rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size, prot,
> +	ret = rdma_user_mmap_io(ibcontext, vma, pfn, PAGE_SIZE, prot,
>  				NULL);
>  	if (ret)
>  		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
>  	else
>  		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u, ret %d\n",
> -			  pfn, gc->db_page_size, ret);
> +			  pfn, PAGE_SIZE, ret);

This is not a full review, but according to both clang-18 and gcc-14,
this patch should also update the format specifier from %u to %lu.

>  
>  	return ret;
>  }
> -- 
> 2.17.1
> 
> 

