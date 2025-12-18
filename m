Return-Path: <linux-rdma+bounces-15088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB87CCCA05
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2CA630125D9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200938258E;
	Thu, 18 Dec 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqI+yheP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4A38257D;
	Thu, 18 Dec 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073995; cv=none; b=hmQMZZUHsRYUPlmYTKXKjNHwUr575o+XvKFWKyYkPJHfaD13+hi1861Iw7UhAeBAvSwiWAWlcIpBym/1KOoluBpp+JCD80W6Osvpw/Qb1ZD0RDIZz/aI1o6Ayg0cuSw1Sp9YTOzkQTjIlzUHpd3yOAH255RTSjUKQbV6K2NGDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073995; c=relaxed/simple;
	bh=zwFymrQ5F2DWEzcv03ijEdDl2G6GL23/8iabeBtES84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9bxMOR5Me9D6Ygdd0ZvwvbE8s+jgwQiV4QOQg2LDJPIPTfeIa/o0RMSr0rriL67bGunTJxLrtVAPEJV2ssofSpd1gpKmNT5zk886ko9pD45HqLO9PMKfymbhTXJ8sPQkb2ay9ONM/XkV3ImV3Emo9ljR/dwgMXrATf3BftgarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqI+yheP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1701C4CEFB;
	Thu, 18 Dec 2025 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073995;
	bh=zwFymrQ5F2DWEzcv03ijEdDl2G6GL23/8iabeBtES84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqI+yhePmfgwXHk25ZhXnZu8Yo0Z7456tC3rAKYAOcSsRk23LdaaeA/mcGNRuriyP
	 +kvKvi34WdF6AFnQe7RmW/J0UIT99F9jAQFHWH2FhxBu1zh6gJFpAmOPOrvfvam1Iq
	 hg2CkiG0Z4UnauzVI2mLZc3hfmcHzyAdtBt5WdJeVqDD3ULBehekITlvSOhIt8YABR
	 kBAsmlJdu+/SeJdIP2TBo4PWycgyzrkCpj2w7HeIfnQsctTSwBPDJocrmkYMJSJrhX
	 WlseN8Mh9Dz7vOYtCTLldchFb9UzurAYZjHmCwFoNzZNVKDsx8LbWM3uukPUNF27gN
	 Vm7I02aUZ4gug==
Date: Thu, 18 Dec 2025 18:06:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: bharat@chelsio.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: fix a memory leak in pass_accept_req() error
 path
Message-ID: <20251218160632.GE400630@unreal>
References: <20251215155607.1787217-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215155607.1787217-1-vulab@iscas.ac.cn>

On Mon, Dec 15, 2025 at 03:56:07PM +0000, Wentao Liang wrote:
> In the alloc_ep_skb_list() failure path, the c4iw_put_ep() is
> incorrectly used instead of the kfree(). Since the child_ep's
> reference count hasn't been properly established at this point,
> the c4iw_put_ep() won't actually free the memory, resulting in
> permanent memory leak.
> 
> Fix by releasing child_ep correctly in the fail path.
> 
> Fixes: 4a740838bf44 ("RDMA/iw_cxgb4: Low resource fixes for connection manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index b3b45c49077d..a09eeb48775f 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2665,7 +2665,7 @@ static int pass_accept_req(struct c4iw_dev *dev, struct sk_buff *skb)
>  	}
>  	goto out;
>  fail:
> -	c4iw_put_ep(&child_ep->com);
> +	kfree(child_ep);

You should squash with your previous patch and get Acked-by from cxgb4
maintainers.

Thanks

>  reject:
>  	reject_cr(dev, hwtid, skb);
>  out:
> -- 
> 2.34.1
> 

