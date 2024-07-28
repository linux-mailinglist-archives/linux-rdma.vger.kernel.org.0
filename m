Return-Path: <linux-rdma+bounces-4038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A093E3FC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C281C20F44
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8AB676;
	Sun, 28 Jul 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiyZYwyy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAE8F62
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jul 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722153219; cv=none; b=HP8LO4U4ieNfNoXom996XCZ0Y3jnADlEvDOZSYTg5GehtugyFRDpq7qfSU8D3ZJ/a+qASu9g2UKP0NdZRwXpYV9EePlAsaOJumo/5eSxYdF4kOV6dADkEUq4hv97CfcNkmKgqNp0rNfWX5j8KePniksb6GvT25X1WKAu+cBW8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722153219; c=relaxed/simple;
	bh=wPcfNH1706wjJFj0mLoppgCSzSptlWV64eIq3MQSZCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dylL2Z3SUNw8EwpR0G773AOTRVPasH1tDn/uVnCHZuLnVmImvij6SzzJ6pdkEfhSXABhVgYpi5ormQJMuM21Vo15QyMbDHOtzFIki7f65UoR1oP86rPGYzIDxbRHlf2wiXrjq5o+UBaBmCdVkiii51QEa2rmExr+tPLM5eeaTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiyZYwyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3DBC116B1;
	Sun, 28 Jul 2024 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722153219;
	bh=wPcfNH1706wjJFj0mLoppgCSzSptlWV64eIq3MQSZCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiyZYwyyRHAAFWsjnYRRrxPFFSgEu7z0PNOKcd6ZHEDm4PyVJyjyiv1duTY0B98b1
	 DSbtLGVATqbGN7ZSsO8d59lIZV1BgLaeNpMBmjW/HmCAxksdCwzVB6QHaQHHRnmjlH
	 7wU4Dom823loDzsh8tTUyN3BtryiXQFL7xZN67m62LnPukAABC0yLuArqtwzMiLkTj
	 lYkNv/52j0/uZpqY+dZeRjaAxHv4ZZ5ECBLPbVAJHtcKAaNxFy1Tk4ki5xRh1jIb0y
	 Sn/yg0U7XWe2ZugR+lYz6IQfkcXUmrN57GAqQRme1QUSWidjGKO85e7HHh3qUUq42e
	 3tENsWYL0qGYw==
Date: Sun, 28 Jul 2024 10:53:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: flyingpenghao@gmail.com
Cc: dennis.dalessandro@cornelisnetworks.com, linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH]   infiniband/hw/hfi1/tid_rdma: use kmalloc_array_node()
Message-ID: <20240728075334.GC4296@unreal>
References: <20240725071716.26136-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725071716.26136-1-flyingpeng@tencent.com>

On Thu, Jul 25, 2024 at 03:17:16PM +0800, flyingpenghao@gmail.com wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> kmalloc_array_node() is a NUMA-aware version of kmalloc_array that
> has overflow checking and can be used as a replacement for kmalloc_node.

Original code is correct, the overflow is not going to happen.

Thanks

> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> index c465966a1d9c..6b1921f6280b 100644
> --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> @@ -1636,7 +1636,7 @@ static int hfi1_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
>  
>  	if (likely(req->flows))
>  		return 0;
> -	flows = kmalloc_node(MAX_FLOWS * sizeof(*flows), gfp,
> +	flows = kmalloc_array_node(MAX_FLOWS, sizeof(*flows), gfp,
>  			     req->rcd->numa_id);
>  	if (!flows)
>  		return -ENOMEM;
> -- 
> 2.27.0
> 

