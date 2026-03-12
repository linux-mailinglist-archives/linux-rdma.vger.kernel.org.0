Return-Path: <linux-rdma+bounces-18123-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F3oGqLvsmnAQwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18123-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:53:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA927600E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C7330E8332
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277973FB075;
	Thu, 12 Mar 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk2jgHEx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB13FB05F;
	Thu, 12 Mar 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334071; cv=none; b=jx0Eg/uhT0zDhtvZ3+qHCeECsfrfO9NN0LC5GjdcsX4ict4XPZPso6U+0Y3zy48V741yvb61R6UsBOyPK7pH80axoS55w8Dj2Yw4i0+6nhQrREbKxWKFtTuRco4U9siTYITj2Y51H/dGqtIPlK2Nr3ViZPhjLDspN9nJ/lxYVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334071; c=relaxed/simple;
	bh=bgaeZYcsitfVCRSp3Rb+I23Wjj9WuTcz7df8k9CxCU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPlrUJfyP1r5dpu1N3BVy1kLQgN6HHK0kMwnPkhOfdrc8zb9RMA39M/PEVSs51CvrIMJ1txWJwCJ95ERX4kLBqY7+PTr1o7UmSDmetrjAgeL3yO0LrOuJbTdPOfUbfS6CnHl3z9NetaR7pNzA1BMgBGzzBbSHYOde84qawVRUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk2jgHEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4EEC4CEF7;
	Thu, 12 Mar 2026 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773334070;
	bh=bgaeZYcsitfVCRSp3Rb+I23Wjj9WuTcz7df8k9CxCU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sk2jgHEx9bowGHuBUzaTSIxN6dUlkVZ5hiKf7nbs7hz2diGk+BqZlhbT3RVHASW+t
	 Chek9Pxn+aNegRCgrWLKCc41aGJFNL429DoAlqDkqrfAksE8bx8qjVtW8qPl/E9554
	 fL5fjcd2PTMR53v0L6TdvU2THoyhfWVUwsHZx0z557SH71dZ32MbJ2/ROUh1+f43Mw
	 y2hPlFqV7pRvRCga0doEN8wd1K3aoRv147GHVkDLPuW/0DGR3VKjHMbdgaQXZ1IcBb
	 9xrq+LkDTQ+VuDVm22x3MJM+kg1e5RtiEnHVaUwye0odgqLVuMwo08x+iJeBE7/abI
	 +kiyEnpHUEX8A==
Date: Thu, 12 Mar 2026 18:47:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/8] dma-direct: prevent SWIOTLB path when
 DMA_ATTR_REQUIRE_COHERENT is set
Message-ID: <20260312164747.GA12611@unreal>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>
 <20260312122058.GE1469476@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312122058.GE1469476@ziepe.ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18123-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 29AA927600E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 09:20:58AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 09:08:48PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > DMA_ATTR_REQUIRE_COHERENT indicates that SWIOTLB must not be used.
> > Ensure the SWIOTLB path is declined whenever the DMA direct path is
> > selected.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  kernel/dma/direct.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> > index e89f175e9c2d0..6184ff303f080 100644
> > --- a/kernel/dma/direct.h
> > +++ b/kernel/dma/direct.h
> > @@ -84,7 +84,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> >  	dma_addr_t dma_addr;
> >  
> >  	if (is_swiotlb_force_bounce(dev)) {
> > -		if (attrs & DMA_ATTR_MMIO)
> > +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> >  			return DMA_MAPPING_ERROR;
> >  
> >  		return swiotlb_map(dev, phys, size, dir, attrs);
> 
> Oh here it is, still maybe it is better to put it in swiotlb_map() ?

It is better do not call function which is not going to work. We have
same flow for DMA_ATTR_REQUIRE_COHERENT and DMA_ATTR_MMIO, which both
don't work with SWIOTLB.

Thanks

> 
> Jason
> 

