Return-Path: <linux-rdma+bounces-20840-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vVGVKHarCWookgQAu9opvQ
	(envelope-from <linux-rdma+bounces-20840-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:50:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5C560D21
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99C0130094EA
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D0834EF0D;
	Sun, 17 May 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoP0tUoE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B75695
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018611; cv=none; b=NMEmO6a+LHGNyVoA4jfdwXTOIUiRE3EpKMYE45UwTWgut6MwzwHEL3EYzi97Njvr9Mk7HRArsUnhBs4xmYICqqpso69bLqPnSD8WcUY5Vk2NdN+xZpuR/t/z1J7UvkVpIuvJO56RFoBimo2EV1BVKpyt0a6JB5/AIa9oOfEya2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018611; c=relaxed/simple;
	bh=yq/N5A22nBz+xqBpIEBCq1dCOd95g+7CuRguZFIreJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDejdyZP4rAa69qof4hMCO5cgrmHHLXmSx40reIscmBql+7/IIbSLyZdwfRmowd03CeJnok3TUuUTRe+Fv5q/e1GURqY01Kh+6kuPcipaqpivix2tCyoPuWlcrhfb5b+Dktm/4jdsty5XJXhhllANyppMinPYo4AgTQBpCeS1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoP0tUoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B7C2BCB0;
	Sun, 17 May 2026 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018610;
	bh=yq/N5A22nBz+xqBpIEBCq1dCOd95g+7CuRguZFIreJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoP0tUoEcTEhNP70aJaDwk9rnluwWGXNdCjStpTXgLUHAaAuqXzgUUxcDnfXIlSER
	 DWwOBaHbByLryJdiUITecJttBCgjybc/RS2RDWkm8xzzWaxzq5lhuwYpGX8AviW7lO
	 4KPWnTJrCkCuismh8HHMP/r4BdD/r6OZCp1On6I6DUYEIClZP5vFwb1XINHS/x5cP9
	 gdO28/KtWcvk1hmPefkTkx6NFzvzIJAojTakPawQ14Ed8Q2pPBLQ3mhhT8xq9/QjwA
	 Q62eb9d5PloToMCIjTCdjb5t2U6QDkO3dwAs3PL2NQMzBT15zm1SkM5qeo5+EoFrN2
	 q97UW7ObhjN0w==
Date: Sun, 17 May 2026 14:50:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <20260517115006.GG33515@unreal>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-3-jiri@resnulli.us>
 <20260512130515.GV15586@unreal>
 <agMzXaCIhX4m7ldo@FV6GYCPJ69>
 <20260514162506.GR15586@unreal>
 <aga5CzHhdQUW2euI@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aga5CzHhdQUW2euI@FV6GYCPJ69>
X-Rspamd-Queue-Id: DFB5C560D21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20840-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 08:13:17AM +0200, Jiri Pirko wrote:
> Thu, May 14, 2026 at 06:25:06PM +0200, leon@kernel.org wrote:
> >On Tue, May 12, 2026 at 04:04:13PM +0200, Jiri Pirko wrote:
> >> Tue, May 12, 2026 at 03:05:15PM CEST, leon@kernel.org wrote:
> >> >On Wed, May 06, 2026 at 01:14:47PM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> When a device requires DMA bounce buffering inside a Confidential
> >> >> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
> >> >> redirects all mappings through swiotlb bounce buffers, so the device
> >> >> receives DMA addresses pointing to bounce buffer memory rather than
> >> >> the user's pages. Since RDMA devices access registered memory directly
> >> >> without CPU involvement, there is no opportunity for swiotlb to
> >> >> synchronize between the bounce buffer and the original pages.
> >> >> 
> >> >> The registration would already fail later on, since the umem mapping
> >> >> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
> >> >> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
> >> >> instead, so the user gets a specific error code to react to.
> >> >
> >> >DMA_ATTR_REQUIRE_COHERENT was our answer to "layering violation claim".
> >> 
> >> I'm not sure I follow. What's the issue you see?
> >
> >SWIOTLB is the layer below DMA API, RDMA is the layer above DMA API.
> >You shouldn't call to SWIOTLB functions in RDMA code.
> 
> This patch doesn't do that. The patch description only describes the
> current situation and how the patch changes the behaviour.

From previous patch:
+       if (dma_device &&
+           cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+           is_swiotlb_force_bounce(dma_device))
+               device->cc_dma_bounce = 1;

And this patch reads cc_dma_bounce.

Thanks


> 
> [..]

