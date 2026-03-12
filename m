Return-Path: <linux-rdma+bounces-18122-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PSnJOrtsmnAQwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18122-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:46:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D250D275DEB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32CB8300939B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3439151C;
	Thu, 12 Mar 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZmu8XZn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA21E7660;
	Thu, 12 Mar 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333986; cv=none; b=GncL6VaYdQ98lNyHMwIJetvIhZpO5qKvv35UlOeynqGda5JMYLk4DIW05Vc85GPDhYjAWRVZbzLrNo4GqgQSxiZAVOPPgTQHEFZPK4yzy+P1mna40mUVHYhiw4q1MaxsSsCFZJTyQNsIEq5UZI9oia9CAvWrCzJGLsZ6/BDj6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333986; c=relaxed/simple;
	bh=g4W57IAgppszhhmuom1c6GdIWffwgLTuE6LrTOJwXps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoL3ElGlesLX4iw57wPIJhpWE5BJVmQbbBeVhvtZ7Fj+pGzcTZNVQCqmZsMU1joIUod6YJZ8ES3uiaVykKIqjniU7pEwmMkTpS5t6Qh8zKcvvDNC5Magkjd7hU+AUL5xawmcZcZJnBZJ9xUkiYcgNByQv99hMVJCoVKUKsAiBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZmu8XZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E9EC4CEF7;
	Thu, 12 Mar 2026 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773333985;
	bh=g4W57IAgppszhhmuom1c6GdIWffwgLTuE6LrTOJwXps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZmu8XZnuXQA+Zlr+DGheTwhpLckrEO2t6JNHpcxW0vx7U575iAJy32RP6EXBhWw6
	 eBEt4hHQC6MmOaapPF0E0vmRmScasxsxx+W1xSJCpjsIJb5Rxt9yi+poJlX1dA9KHR
	 doFbcFgH+JNRk8+fY7aFKcFVBKHMLTKw8lW75K7b2L8zlLxtABKvR0f2TNL7Fc7kuM
	 n5diM3RZ+ujPHLJoj6PqBRojByoKgqXep+yXPg2a5K8Eb8QXHhr7WqRwTdcaLIbzx8
	 7hiitACIX5AqL902Vp5+AQyG4SquimpfkKuxsVAi/vLG5ezGXH0PJvYL+F3BkyVjOk
	 BbhQwqQ69ra8A==
Date: Thu, 12 Mar 2026 18:46:22 +0200
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
Subject: Re: [PATCH v2 4/8] dma-mapping: Introduce DMA require coherency
 attribute
Message-ID: <20260312164622.GZ12611@unreal>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
 <20260312121937.GD1469476@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312121937.GD1469476@ziepe.ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18122-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D250D275DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 09:19:37AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 09:08:47PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The mapping buffers which carry this attribute require DMA coherent system.
> > This means that they can't take SWIOTLB path, can perform CPU cache overlap
> > and doesn't perform cache flushing.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Documentation/core-api/dma-attributes.rst | 12 ++++++++++++
> >  include/linux/dma-mapping.h               |  7 +++++++
> >  include/trace/events/dma.h                |  3 ++-
> >  kernel/dma/debug.c                        |  3 ++-
> >  kernel/dma/mapping.c                      |  6 ++++++
> >  5 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> > index 48cfe86cc06d7..69d094f144c70 100644
> > --- a/Documentation/core-api/dma-attributes.rst
> > +++ b/Documentation/core-api/dma-attributes.rst
> > @@ -163,3 +163,15 @@ data corruption.
> >  
> >  All mappings that share a cache line must set this attribute to suppress DMA
> >  debug warnings about overlapping mappings.
> > +
> > +DMA_ATTR_REQUIRE_COHERENT
> > +-------------------------
> > +
> > +The mapping buffers which carry this attribute require DMA coherent system. This means
> > +that they can't take SWIOTLB path, can perform CPU cache overlap and doesn't perform
> > +cache flushing.
> 
> DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
> system where SWIOTLB or cache management is required. This should only
> be used to support uAPI designs that require continuous HW DMA
> coherence with userspace processes, for example RDMA and DRM. At a
> minimum the memory being mapped must be userspace memory from
> pin_user_pages() or similar.
> 
> Drivers should consider using dma_mmap_pages() instead of this
> interface when building their uAPIs, when possible.
> 
> It must never be used in an in-kernel driver that only works with
> kernal memory.
> 
> > @@ -164,6 +164,9 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> >  	if (WARN_ON_ONCE(!dev->dma_mask))
> >  		return DMA_MAPPING_ERROR;
> >  
> > +	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
> > +		return DMA_MAPPING_ERROR;
> 
> This doesn't capture enough conditions.. is_swiotlb_force_bounce(),
> dma_kmalloc_needs_bounce(), dma_capable(), etc all need to be blocked
> too

These checks exist in dma_direct_map_phys() and here is the common check
between direct and IOMMU modes.

Thanks

> 
> So check it inside swiotlb_map() too, and maybe shift the above
> into the existing branches:
> 
>         if (!dev_is_dma_coherent(dev) &&
>             !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
>                 arch_sync_dma_for_device(phys, size, dir);
> 
> Jason

