Return-Path: <linux-rdma+bounces-15087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6DCCC9E7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C47043019F93
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095B38257B;
	Thu, 18 Dec 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDd4alPF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E129AAF7;
	Thu, 18 Dec 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073927; cv=none; b=WcVew2lVwIS5wG/bX7DVwTIfXNK8YAMiypYdhNnU2telXiBL7rG5Eo//A72vHIndJjTB1IkmrrUgFXFoqK0e++CB0DMHP/9t9KZ5hqocPyMTqR1V8Bl+qKqszeAWX6d0ZG+ID8OT+bJg6QpoUrF9AvzPyo4ivf9gztvwCsFGu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073927; c=relaxed/simple;
	bh=SxMlS0kJb6kvCoZ7nnXsWRulxsWUUdMu1Y7QIuZa8ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWdt3EIf8GXb5AnJA4SYOUWScli1YN/4rWaLhW2ME0WLYUmXC0i+XSNKQ6DH3lCAwhuEgmuP7aprmx0hSbvaKmDUG5MLTWwsVbHS8zQRxV4Fg32YPRhGmj+r9qzbzAHuc9Kdzv90IKd+qbsQlPuaewcKIAy2sf0XAOXVAa3KDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDd4alPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7DCC116B1;
	Thu, 18 Dec 2025 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073927;
	bh=SxMlS0kJb6kvCoZ7nnXsWRulxsWUUdMu1Y7QIuZa8ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDd4alPFLKF+zpgrHNLS3dnnXto4Vm84e3JHl2WoWIcHGEk3AipV6T5PsOBA0crq4
	 gGAez3towVTr+B3985GsOEFHQ67Q9DiTV4lVcTXYXJkG4fz3M1O9SnqkRErp3LrCdu
	 6WqpYO70koPvjSRS1r6DhENclb2ZDRkAP1hCAj4pA86pmcW12iL5JQU2G3rj/sSlbD
	 mHEtZYXM275ynfKfRON30SKz/VQR6AcBC5/+DxYOBw2/pBRQVsTh5feMz2AF59uBly
	 XDs+zHufiGyQjFb9b9rsW4Q/zDosuiQacWhvE1x9AmKkXm4Ou+1fHAe3GKGmk5NDt/
	 KpxGEhm76OJiw==
Date: Thu, 18 Dec 2025 18:05:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: bharat@chelsio.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: fix dst refcount leak in pass_accept_req()
 error path
Message-ID: <20251218160523.GD400630@unreal>
References: <20251215153356.1783489-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215153356.1783489-1-vulab@iscas.ac.cn>

On Mon, Dec 15, 2025 at 03:33:56PM +0000, Wentao Liang wrote:
> Add missing dst_release() when alloc_ep_skb_list() fails to prevent
> reference count leak of the dst obtained from route lookup.

I'm not convinced this path is correct. I also don't see a call to  
"kfree(child_ep);" in that case.

Thanks

> 
> Fixes: 4a740838bf44 ("RDMA/iw_cxgb4: Low resource fixes for connection manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index b3b45c49077d..3490b8920cf0 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2665,6 +2665,7 @@ static int pass_accept_req(struct c4iw_dev *dev, struct sk_buff *skb)
>  	}
>  	goto out;
>  fail:
> +	dst_release(dst);
>  	c4iw_put_ep(&child_ep->com);
>  reject:
>  	reject_cr(dev, hwtid, skb);
> -- 
> 2.34.1
> 

