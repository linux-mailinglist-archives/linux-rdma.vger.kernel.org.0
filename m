Return-Path: <linux-rdma+bounces-20855-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGMZOBHqCWpavAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20855-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 18:17:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 414805623DB
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 18:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D71193009B1C
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7876B2F3C0A;
	Sun, 17 May 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFVKosEo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBE1B808
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034639; cv=none; b=GG1ElAJM4vu5UFJrnNXuB7oqiEjvyQ+bC/5f2XiPeWMqqQ6mFfEm3wpJJC9nyL8wxkIzCgUpKu24S5kX2HE6Gnes1o1CDB0o0Lgdvus/FfiD3kZyqO8kgadof6PxQrD+uOFGVphAB4olpfNNBBWEAU4It0brsGv4WDoLKTt0s2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034639; c=relaxed/simple;
	bh=LnLPrHeGKmNEecTUJY86X/MYuMcG45E9TabP04C8SZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbKN/8Gn2mqM0ieKs8d+2XlQAaZ6PELqqqgCZCu5kd9SKTWSGJzMeJjRVqxmYYa9n1tSVqT/enI957q85G/vbNFY7pOnAZZW+/PXzCqajZA8ssR011D5E2A+YvIJS/yP+ks6IYlAAsJmc5soisevyMUCfiH1Hb1ddRBmMEhIdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFVKosEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B29C2BCB0;
	Sun, 17 May 2026 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779034638;
	bh=LnLPrHeGKmNEecTUJY86X/MYuMcG45E9TabP04C8SZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFVKosEoQLho742L83sdqyAD/n7aBOshn2jUOZjajQkBvJIU6H8CBOU6Q4iT9YyzX
	 EYy3crcQ/RTu6xYMwy8DtNiP0BDNVYUgWQ05XSf+RGqnBtxoIylgDgnvy6aLNHsJfH
	 1e01vXXZxc3oHpoop0UmNRQBsu47dxyRi1LqjODD67/T0yOV9YPFFNBsJm1zekOf0J
	 0iogim//WLYXza7aDdUB0YthaoN59y1ARVJrYfOAj1h1DCai9TxnmyegRZh2v9h9cZ
	 Tl7wMD+PnX8h5/RTthby2kHiet/JJLZyRdH7fVC0rLmiwhk3nXSsUFU/Q2eAApBPHd
	 yhik8Ei4eu5+g==
Date: Sun, 17 May 2026 19:17:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v3 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <20260517161712.GL33515@unreal>
References: <20260517141311.2409230-1-jiri@resnulli.us>
 <20260517141311.2409230-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517141311.2409230-3-jiri@resnulli.us>
X-Rspamd-Queue-Id: 414805623DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20855-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 04:13:11PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> When a device requires DMA bounce buffering inside a Confidential
> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
> redirects all mappings through swiotlb bounce buffers, so the device
> receives DMA addresses pointing to bounce buffer memory rather than
> the user's pages. Since RDMA devices access registered memory directly
> without CPU involvement, there is no opportunity for swiotlb to
> synchronize between the bounce buffer and the original pages.
> 
> The registration would already fail later on, since the umem mapping
> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
> instead, so the user gets a specific error code to react to.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - updated patch description with mention of DMA_ATTR_REQUIRE_COHERENT
> ---
>  drivers/infiniband/core/umem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index eb1de32bab9d..b32bc2a5d7d0 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -167,6 +167,9 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
>  	int pinned, ret;
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  
> +	if (device->cc_dma_bounce)
> +		return ERR_PTR(-EOPNOTSUPP);
> +

The series looks reasonable, but I cannot apply it yet because  
`__ib_umem_get_va()` has not been merged.

Thanks

>  	/*
>  	 * If the combination of the addr and size requested for this memory
>  	 * region causes an integer overflow, return error.
> -- 
> 2.54.0
> 

