Return-Path: <linux-rdma+bounces-20488-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCZfJiAoA2qw1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20488-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:16:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E85520F01
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 860D5315DB0B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364A3E1716;
	Tue, 12 May 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+MW/yvv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E23E1713
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591017; cv=none; b=Ahh5dSUU/aJwNCK3uogHCxaqWKwmrn2uj0ZybzZ9YsbeZ7X8rsJ4uVObR5mHl2gXEz8ptKvNcsW/31zGlmYqa2NxaUIgU9GG0L2b0ek7E3Ll+DFO67Dz6LjpYxr9ita4/eG5Gvm1Tm5gLwabLly7jsMux/FjpaVuZMThl0Cpbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591017; c=relaxed/simple;
	bh=Z2tbvm4NKsfaWJ2v6lIIlSKvTP+8a2WRkICN9HNxmoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfP6f2yr07cLl2VJeT6MPpbCJiFgb71MLC3Z8VASFUSMz+dgSBiup94iCfhSKmrIibCI8RWj6KaVJ1Q5Rgo0tntITosBFyyweyGukMa4ezcWR8ioF3cmHR4QAjEtsPn6rOJ0wWwfAd5MEXHxr7al0LBn2RiuJL4G8Sfcq+sGFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+MW/yvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE5DC2BCB0;
	Tue, 12 May 2026 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778591017;
	bh=Z2tbvm4NKsfaWJ2v6lIIlSKvTP+8a2WRkICN9HNxmoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+MW/yvvDerqqiwWmw5hZv8JMGqwCReytw3bPPG/rtmopz1FQKWa3Jj7OoNW+UrAS
	 rDpVHn3BUcnOgQFm1NNC6dbQ1EmX8qGYx7gFvBt1GznHfjmFlJ+Am7wcgrqWzzJdA5
	 FEEBmzBG8FDwf050KpSITw156fCEQCEQZV84JcEMXEfR0euN6do53ehQR5+eKFDQLn
	 MIEfwQbEs4s3mmoPECfZ+WMi/mCkFLjlutJWTcUC86/3D2IWKJT9eBgx60G4donFPk
	 ZRZQV3bu1Li6EgK3enh7nWDfw7g73L+HNYdbEevL65vkKkYd0+GmGR52HFK3QdL1Cz
	 AxPNHYqDXVMTA==
Date: Tue, 12 May 2026 16:03:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce
 requirement to userspace
Message-ID: <20260512130329.GU15586@unreal>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506111447.2697789-2-jiri@resnulli.us>
X-Rspamd-Queue-Id: 10E85520F01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20488-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 01:14:46PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In CoCo guests, device DMA to regular userspace memory does not work
> because the DMA mapping layer redirects all mappings through swiotlb
> bounce buffers. Since RDMA devices access registered memory directly
> without CPU involvement, there is no opportunity for swiotlb to
> synchronize between the bounce buffer and the original pages.
> 
> Expose this condition to userspace as IB_UVERBS_DEVICE_CC_DMA_BOUNCE
> in device_cap_flags_exi.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/infiniband/core/device.c     | 6 ++++++
>  drivers/infiniband/core/uverbs_cmd.c | 2 ++
>  include/rdma/ib_verbs.h              | 3 +++
>  include/uapi/rdma/ib_user_verbs.h    | 2 ++
>  4 files changed, 13 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index b89efaaa81ec..ad3da92c9318 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -42,6 +42,8 @@
>  #include <linux/security.h>
>  #include <linux/notifier.h>
>  #include <linux/hashtable.h>
> +#include <linux/cc_platform.h>
> +#include <linux/swiotlb.h>
>  #include <rdma/rdma_netlink.h>
>  #include <rdma/ib_addr.h>
>  #include <rdma/ib_cache.h>
> @@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
>  	 */
>  	WARN_ON(dma_device && !dma_device->dma_parms);
>  	device->dma_device = dma_device;
> +	if (dma_device &&
> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	    is_swiotlb_force_bounce(dma_device))

It is the wrong place. When I worked on my DMA series, I tried something
similar (a call into SWIOTLB) to notify users that RDMA would not work.

The general feedback was that this is a layering violation, and that any
knowledge of SWIOTLB (and its API) should not leak out of the DMA API.

You shouldn't call to is_swiotlb_force_bounce() here.

Thanks

