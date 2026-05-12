Return-Path: <linux-rdma+bounces-20489-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNlOHlEnA2qw1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20489-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:12:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32982520DDC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD4B83072D6D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF8A30676D;
	Tue, 12 May 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLI7rP0+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8B306742
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591121; cv=none; b=nVemYV0JoN8EOeIuWBJ4pdDOSNTmcethYc2sasgUixDvxM6Q0608JnsxxAoRhwQdnT5Ly704UxptYF38NpnKGXT1hPfmLw/Ab5CBYsuNoEAcb5yJ39EIDTJl5lgh66jpP4J1xFeSht/E+LhXa8N/ORwfu83rqth//WEBec6UKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591121; c=relaxed/simple;
	bh=rYgIJyg7gtqQ/iYZoPWIPo70sI6/s4gMcfi60z6oovY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmOOshd2dnKHpf5Ak0n8tKnbFzU2y2yUo493pe/uBa7SstaFOmb/YuMRQ4Fyn5t09i84iM9f+57Lb0yEaegMQPFJKAIVyAAAs/Gql0amqpuJBFUBV3wj57namGmaYQ3pq8O6OEjRNiQEU3FBSUMFpApFwPt83EYKvceHFycJSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLI7rP0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6870C2BCF5;
	Tue, 12 May 2026 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778591121;
	bh=rYgIJyg7gtqQ/iYZoPWIPo70sI6/s4gMcfi60z6oovY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLI7rP0+eFPRIMJOfexkWKK3EG7HnekN4uHepGe2z3YuqSkmeMh0THsGBYyfl83p5
	 /pLMEvTAinMXS+qmuUam+KFXGR9vy2G1zZqcyesY+bzMZUS1NIAIbH2cg0HE3dxSAN
	 6Hlxgovk7eAobzhd+oGDSBM8YAJ06mmmsaKZ3mgclAkjJ9Qv7eW0TrRBgijAgskUhS
	 njRo+H1GTuvb7hjLLfDyrhihjOfELdhBlSmxDE1Eb/KHjvS7g9+7TqKyMGAUqR20i2
	 /PyKE7OovoB6eXLsfP/F+NV8w5KfC36s8SD2O1k5SR5D0hZQuSZvpDfDfeE+5DKusV
	 anUmRa6mUuLlA==
Date: Tue, 12 May 2026 16:05:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <20260512130515.GV15586@unreal>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506111447.2697789-3-jiri@resnulli.us>
X-Rspamd-Queue-Id: 32982520DDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20489-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 01:14:47PM +0200, Jiri Pirko wrote:
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

DMA_ATTR_REQUIRE_COHERENT was our answer to "layering violation claim".

Thanks

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
> index 611d693eb9a2..b1877b83b021 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -167,6 +167,9 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
>  	int pinned, ret;
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  
> +	if (device->cc_dma_bounce)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	/*
>  	 * If the combination of the addr and size requested for this memory
>  	 * region causes an integer overflow, return error.
> -- 
> 2.53.0
> 

