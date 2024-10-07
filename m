Return-Path: <linux-rdma+bounces-5283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E121A9935BB
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9577281DB2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87C1DD553;
	Mon,  7 Oct 2024 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifm+2Xsa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE32187342
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324618; cv=none; b=BoBCRtLYfNfuCxWfaAeTl7XUoMeTgS/4SGgkwgg7GugQqw4+vfuKKUyZZT0Wlimev8z4ri+fXY3dYyaBmMonE9i8Jct58c9zjc9nnfJdLSjg4J3sh5AA1lmsOTs3R2DxyH7JE+iVv1bYJN1dXKxiSilWle5p3umBLPMCzAoaiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324618; c=relaxed/simple;
	bh=5gYL3LX3/QyJ08683JVeXtcHeV6ecKEDNQ4Bevu1kcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWw+1JtypHOhhPY/FEoy2d49DydETeAe8UPXdWmVvq/sxflDkgoVPLNAViS1qT85jSg6BdYg+Cd6REBjFaFprnvG4MVbmhSMCWqmv/KbohS8f+vE0TZ2QJY0fdXANSURz80aKdKbXlwZ7i0rYd3buB2Q+JZAkjxJE4bPDLwx8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifm+2Xsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429BDC4CEC6;
	Mon,  7 Oct 2024 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324618;
	bh=5gYL3LX3/QyJ08683JVeXtcHeV6ecKEDNQ4Bevu1kcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ifm+2XsaVWtuE/lDsMV1FXOTuvEJAJFHJG9GiWn9qWCnrR9QUvnq3EUis42YwQgES
	 cxz5qB0s6AASzcAK6k1JD/LwXTnmsws98ZVcHGz8zDP/B1d8uzzKRtrIzsRE3E7PJH
	 XqzLaupGbpX4Peh4yfWCrM1lwLe1nnpHo30LM+QlrXmprSsiB96oEuNm9lzkV/aFea
	 ybbsNkGmmb14K3hHU2LBZGTXQcFukByBvkSDMshFiLmWKbtYgYAl3aJa4WJeo4a9wt
	 XqrDDpCFJy1p8tpQtOv7GnwfHmMT1Gi092anD7q2+RRs5zo2ggZt3eUSet/TPc8rjo
	 GRhenFSXmnGRA==
Date: Mon, 7 Oct 2024 21:10:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc v2] RDMA/core: Fix ENODEV error for iWARP test
 over vlan
Message-ID: <20241007181010.GB25819@unreal>
References: <20241007130941.62709-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007130941.62709-1-anumula@chelsio.com>

On Mon, Oct 07, 2024 at 06:39:41PM +0530, Anumula Murali Mohan Reddy wrote:
> If traffic is over vlan, cma_validate_port() fails to match vlan
> net_device ifindex with bound_if_index and results in ENODEV error.
> It is because rdma_copy_src_l2_addr() always assigns bound_if_index with
> real net_device ifindex.
> This patch fixes the issue by assigning bound_if_index with vlan
> net_device index if traffic is over vlan.
> 
> Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v1:
> Added fixes line
> Addressed static checker warnings
> Targeting to rc since this is a bug fix
> ---
>  drivers/infiniband/core/addr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index be0743dac3ff..8962fc0fe4c4 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -269,6 +269,8 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
>  		break;
>  #endif
>  	}
> +	if (dev && is_vlan_dev(dev))

You should take "ret" into consideration here, and probably the right
way is to check is "if (!ret && dev && is_vlan_dev(dev))". The "&& dev
&&" is not really needed, but it is a good thing to have it for static
checkers.

Thanks

> +		dev = vlan_dev_real_dev(dev);
>  	return ret ? ERR_PTR(ret) : dev;
>  }
>  
> -- 
> 2.39.3
> 
> 

