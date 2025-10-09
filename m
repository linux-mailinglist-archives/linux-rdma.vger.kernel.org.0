Return-Path: <linux-rdma+bounces-13810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FCBCA9A2
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Oct 2025 20:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30D4427B4A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Oct 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38472238D52;
	Thu,  9 Oct 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poHDTori"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D16A31;
	Thu,  9 Oct 2025 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035741; cv=none; b=VsMONSrCKBl4vhPhlTp/Yl9iUBUuDFCxYcomj5rZ3jPRKvaRTlmxrAxN8NgVsjffo0wlh25lLh/rXnzDnHkusJ9XGujyP2uohpCxdVQ1qFw+eV53V+U7HXZfiq9Q0Y5Swaz0UPBjmB9AIWwwGazWnEtT3Wc01omrbeCz2Pmn4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035741; c=relaxed/simple;
	bh=F0hir9GjRzHAXaFh2pTy5Xub+O0yw5SADm7gb0L7x5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEhK9i9dSma5wC/upKN6tSusRULWrbtjpAIHhNaf218jnik08nPrSq3YaQz7ohJzXXG8F8AdXbp8M7RZIlkNVfRnG2tfH9bWpLqK6szPrv9EbbwotBmsntsASCawKk4HyqHkrMpcXMFFNwwzfkg38y0gOPEebx5714onox5ZmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poHDTori; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220FBC4CEE7;
	Thu,  9 Oct 2025 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760035739;
	bh=F0hir9GjRzHAXaFh2pTy5Xub+O0yw5SADm7gb0L7x5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poHDTorirStuE8vGHjRMSa1+JospDLX0EHINjuFJs8BAtej3QDe6Sv43EE2I/emD4
	 nvgQ14vLi27LlBdU27iVAyd6TCKhXCxaf5hLavXwJAfjegrSPZ4s70ys3xhehkZEB5
	 GpGK8IVr5mb9nrX1asJx51qpKiF3UauXysv7BrlN4CLl05HQn5iuwp8sw6HfNp/fyl
	 pBL9y/mLGhT7c5/Ruvd5JyfSXXgTZhzNNqAMEV9bfBHoHWTqpNKwtH155Cg+cF3B5S
	 gl8IWqFw8kceWAMopIr787Ta3bZPgc5XO+HxgLvwXpyUY0dd7muiLI0ud2ASlqtQwr
	 3suzThaad+kxA==
Date: Thu, 9 Oct 2025 21:48:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: fix umem release in UVERBS_METHOD_CQ_CREATE
Message-ID: <20251009184854.GB14552@unreal>
References: <aOflenF0XHtm80G9@homelab>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOflenF0XHtm80G9@homelab>

On Fri, Oct 10, 2025 at 12:40:26AM +0800, Shuhao Fu wrote:
> In `UVERBS_METHOD_CQ_CREATE`, umem should be released if anything goes
> wrong. Currently, if `create_cq_umem` fails, umem would not be
> released or referenced, causing a possible leak.

It is only partially true. UMEM is released inside .create_cq_umem()
implementation. However there is an issue there that it doesn't release
in all flows. You need to change efa_create_cq_umem() too.

> 
> Fixes: 1a40c362ae26 ("RDMA/uverbs: Add a common way to create CQ with umem")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> ---
>  drivers/infiniband/core/uverbs_std_types_cq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
> index 37cd37556510..9344020dede1 100644
> --- a/drivers/infiniband/core/uverbs_std_types_cq.c
> +++ b/drivers/infiniband/core/uverbs_std_types_cq.c
> @@ -193,8 +193,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
>  
>  	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
>  		ib_dev->ops.create_cq(cq, &attr, attrs);
> -	if (ret)
> +	if (ret) {
> +		ib_umem_release(umem);
>  		goto err_free;
> +	}
>  
>  	obj->uevent.uobject.object = cq;
>  	obj->uevent.uobject.user_handle = user_handle;
> -- 
> 2.39.5
> 
> 

