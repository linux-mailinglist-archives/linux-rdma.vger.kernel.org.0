Return-Path: <linux-rdma+bounces-17729-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UERpNKrErWmf7AEAu9opvQ
	(envelope-from <linux-rdma+bounces-17729-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 19:49:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C7231C7A
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D8EF301705B
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6638F92F;
	Sun,  8 Mar 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5XaO5G+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52293355F3A;
	Sun,  8 Mar 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772995747; cv=none; b=nwVuF0ZMO0KADRtJf8h04YFSXI1Qbmw5By7V33vAzBFccW1k9tuy0TOQbvLw2uxYb9Af1dn2729ggxPkcC/okQnuuok6ZQp/qyyOXE5PeRwnhKveJjlR2pwCdO6NqQWE9ypiunBCPmkzYzh37mvJeLmelIIUeXQwiDqL1cLjF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772995747; c=relaxed/simple;
	bh=9bFQbb+FutILAGNA8r3NFQqualgxHGopEOncA3fbd2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8llbmRWL64tD4ZrEZolizlFQKiItvJaCzle+w7WjKRjptdiET+PUWnDNUXTL9q+mckcJJyN5v/ekGeNMAioTn/LrlIYqbYJKzCCyEaI03PiFpiCHKsgdIfZsU0fhtCpBujDs6O7K2n2DYCgQq7IimM/Z2i8pLZ+7VHJVfbD+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5XaO5G+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6796BC116C6;
	Sun,  8 Mar 2026 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772995746;
	bh=9bFQbb+FutILAGNA8r3NFQqualgxHGopEOncA3fbd2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5XaO5G+1uCNGBaVOMMac70gM9ZNn8Sf/s7A/NtDmgmLgGeXMGK1hbcWQwUJ2tPr9
	 jliYx1YvEkSnKhDzptVKmQ5T2G2ISLGY1/jJiSuLAaCE95giGs3idnWHmFGm417oXt
	 oKnaFVZuRyv/tIRjxhXtuRRgHUY0Ov/vCdDM7UzmBfgeri64hZt2N9E9VAX4jpBZIS
	 6rHNck6tfS50gXSHz2QaNrvDnGSbh5Yz1iboBleC8NgKEtvAvxO8JEJVC5uSHUsy3n
	 kjDUzDOdFkHwJ0PTAiC/pt4rhISObBURs62AoCCJcyQERQ84IQU7hNpKC34s8pWIPg
	 nlfOjLiyfSGgw==
Date: Sun, 8 Mar 2026 20:49:02 +0200
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
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260308184902.GR12611@unreal>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308181920.GH1687929@ziepe.ca>
X-Rspamd-Queue-Id: 923C7231C7A
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
	TAGGED_FROM(0.00)[bounces-17729-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 03:19:20PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:
> 
> > -This attribute indicates the CPU will not dirty any cacheline overlapping this
> > -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> > -multiple small buffers to safely share a cacheline without risk of data
> > -corruption, suppressing DMA debug warnings about overlapping mappings.
> > -All mappings sharing a cacheline should have this attribute.
> > +DMA_ATTR_CPU_CACHE_OVERLAP
> 
> This is a very specific and well defined use case that allows some cache
> flushing behaviors to work only under the promise that the CPU doesn't
> touch the memory to cause cache inconsistencies.
> 
> > +Another valid use case is on systems that are CPU-coherent and do not use
> > +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> > +(such as flushes) will be performed that could overwrite shared cache lines.
> 
> This is something completely unrelated. 

I disagree. The situation is equivalent in that callers guarantee the
CPU cache will not be overwritten. For the RDMA case, this results in
the same behavior as with virtio. For our case, it addresses and
clears the debug warnings.

> 
> What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
> fails any mappings requests that would use any SWIOTLB or cache
> flushing.

You are proposing something orthogonal that operates at a different layer
(DMA mapping). However, for DMA debugging, your new attribute will be
equivalent to DMA_ATTR_CPU_CACHE_OVERLAP.

Thanks

