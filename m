Return-Path: <linux-rdma+bounces-20705-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFfDBW33BWpVdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20705-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:25:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 153CE544A1D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1E503010731
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C5A33A9D1;
	Thu, 14 May 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aClzWqRT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3F3375D5
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775911; cv=none; b=RyH5v3sLEBHcPFxdiSgVi0ghyUij7Uqebn9OkrtLbn1izCFNimwmSt2U2Bc1pPSMncOPRTkfrp3r5+Y6WYy8xpG+oM+e0inBn4Vga8tzrcXM1HE+kbe76tt07WNMhQ9DkVBp53tGDgu5AvsOGDx4FYVusbgMojulFaIYMrKw5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775911; c=relaxed/simple;
	bh=p7m4AOS83Dw45+QiFp9rDaU0/96hXdXM22n8vRk1a3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeTPKDziNyYZ7x7qrxzsdqdTgZS4pTuevKV6Z0vKoSpEUQWwAodRjw36tNXWwU8scIBrsB5TNhkwc4+XkGaLsuq1AjCRlkN/V4txXff7mt5ad2aNwxYOul5bzv902qrqIqjZqxT04QpMOX92nVUiW0v0jtt1Qvd4zhlG/nfy398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aClzWqRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2304C2BCC7;
	Thu, 14 May 2026 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775911;
	bh=p7m4AOS83Dw45+QiFp9rDaU0/96hXdXM22n8vRk1a3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aClzWqRTjUwV1Hz4XPTm1HEQlCrRqAbDEl2/NlBJ7mQSBfb8dG0EMU9PdQHEyhsJj
	 qSg2zUS79+XkJUXW0dX1t0k6ejS1ZCqQIMy5X2yx0uQiTbSZK+HrA8I9zmSsiUVRV8
	 ABDg1EwEnSG+Pl9WEzYl2jNNC5wz72egb1haCn6wpWGLRAWiYPhxlzW2YbE/vCs76Z
	 Ixy7kTh3ezPUQZJ6GKhkGEMfLD5h/P8MRRQ8Q8C95F1euTce3vxNIRJJ3pybavPl8F
	 lAlMiE+MbkYgOkS7Kc0bNEqD9mxgfevJjv0EYbMXmGVi36zPBN+kmeJREXsTgNgUNi
	 IDDSQkGHdx0SQ==
Date: Thu, 14 May 2026 19:25:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <20260514162506.GR15586@unreal>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-3-jiri@resnulli.us>
 <20260512130515.GV15586@unreal>
 <agMzXaCIhX4m7ldo@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agMzXaCIhX4m7ldo@FV6GYCPJ69>
X-Rspamd-Queue-Id: 153CE544A1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20705-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:04:13PM +0200, Jiri Pirko wrote:
> Tue, May 12, 2026 at 03:05:15PM CEST, leon@kernel.org wrote:
> >On Wed, May 06, 2026 at 01:14:47PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> When a device requires DMA bounce buffering inside a Confidential
> >> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
> >> redirects all mappings through swiotlb bounce buffers, so the device
> >> receives DMA addresses pointing to bounce buffer memory rather than
> >> the user's pages. Since RDMA devices access registered memory directly
> >> without CPU involvement, there is no opportunity for swiotlb to
> >> synchronize between the bounce buffer and the original pages.
> >> 
> >> The registration would already fail later on, since the umem mapping
> >> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
> >> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
> >> instead, so the user gets a specific error code to react to.
> >
> >DMA_ATTR_REQUIRE_COHERENT was our answer to "layering violation claim".
> 
> I'm not sure I follow. What's the issue you see?

SWIOTLB is the layer below DMA API, RDMA is the layer above DMA API.
You shouldn't call to SWIOTLB functions in RDMA code.

Thanks

> 
> 
> 
> 
> >
> >Thanks
> >
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >> v1->v2:
> >> - updated patch description with mention of DMA_ATTR_REQUIRE_COHERENT
> >> ---
> >>  drivers/infiniband/core/umem.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> >> index 611d693eb9a2..b1877b83b021 100644
> >> --- a/drivers/infiniband/core/umem.c
> >> +++ b/drivers/infiniband/core/umem.c
> >> @@ -167,6 +167,9 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
> >>  	int pinned, ret;
> >>  	unsigned int gup_flags = FOLL_LONGTERM;
> >>  
> >> +	if (device->cc_dma_bounce)
> >> +		return ERR_PTR(-EOPNOTSUPP);
> >> +
> >>  	/*
> >>  	 * If the combination of the addr and size requested for this memory
> >>  	 * region causes an integer overflow, return error.
> >> -- 
> >> 2.53.0
> >> 

