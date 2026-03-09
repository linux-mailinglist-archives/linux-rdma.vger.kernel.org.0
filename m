Return-Path: <linux-rdma+bounces-17753-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOkHI42NrmnlFwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17753-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:06:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F52235E13
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9230A302963E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1A0376489;
	Mon,  9 Mar 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFBfbL1e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5973E47B;
	Mon,  9 Mar 2026 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047026; cv=none; b=SWR3brc0yBoX4tOHuxuUe1e6PqdUuh96l260Y6oA6oIarvUAMZUVof8o1eflR90B8VbnL/CtB41ayKH9vhd8T+1NLEvGSC4v9VKewZMzV9a7W+TL8BX/r4MSyMjL7jWi21iY4lslsAwhVLGOnb6DebIzAywaw+q+sYFeD7ze85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047026; c=relaxed/simple;
	bh=kSDROP9IQjvBUSAyPonTwVkd0K8lsZ7gTLjiEtj28Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXD1qblP5+E3ZnUdkgNU3KV7IV+HxCKoqEhH6A3HSOHhG2Q/TgLseCBpaCD51ZhseaKWGwILoF8b/U142IHt+gEMwSOJxmaTvbmkRcTwgLgrvHTxeQizR91D7Q6cMva5MoLpKTMP1KlwkKGjaz9nyKwrE7Ht33jZ211NYXBDOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFBfbL1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E98C2BCB1;
	Mon,  9 Mar 2026 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773047026;
	bh=kSDROP9IQjvBUSAyPonTwVkd0K8lsZ7gTLjiEtj28Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFBfbL1eN4cFAmF5H1JfgbhSnAUKt069jyxJtD6j98AZOuEhgvvTlHkHniae5dGvN
	 /QPZvCjn2IuAfw/q0YF0SGcs50q2FJj1eK2RhpwgpNwUNfFaYUdBbW0I0m1wHir3Lt
	 M8s6XKTl+UCfp0nYfFnIxKKgM6CpnElK7TDMDSlWjx69g1GxtepXLquAZsbkk1kzTp
	 pDljsgSteA22r7FtTxpnrVzlG9bsl4+TnTh78EkVdCuuuM3F5w00GWOU1rZrTw7nkY
	 50kOUyofYTO/xOdkuR+rv3w2eTw0IISvUTO7zxdAFYYRZijowOtm4fGc2G3K3cD3Ec
	 CLm7coZ05l3OA==
Date: Mon, 9 Mar 2026 11:03:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260309090342.GS12611@unreal>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308230916.GI1687929@ziepe.ca>
X-Rspamd-Queue-Id: 41F52235E13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17753-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 08:09:16PM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 08, 2026 at 08:49:02PM +0200, Leon Romanovsky wrote:
> > On Sun, Mar 08, 2026 at 03:19:20PM -0300, Jason Gunthorpe wrote:
> > > On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:
> > > 
> > > > -This attribute indicates the CPU will not dirty any cacheline overlapping this
> > > > -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> > > > -multiple small buffers to safely share a cacheline without risk of data
> > > > -corruption, suppressing DMA debug warnings about overlapping mappings.
> > > > -All mappings sharing a cacheline should have this attribute.
> > > > +DMA_ATTR_CPU_CACHE_OVERLAP
> > > 
> > > This is a very specific and well defined use case that allows some cache
> > > flushing behaviors to work only under the promise that the CPU doesn't
> > > touch the memory to cause cache inconsistencies.
> > > 
> > > > +Another valid use case is on systems that are CPU-coherent and do not use
> > > > +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> > > > +(such as flushes) will be performed that could overwrite shared cache lines.
> > > 
> > > This is something completely unrelated. 
> > 
> > I disagree. The situation is equivalent in that callers guarantee the
> > CPU cache will not be overwritten.
> 
> The RDMA callers do no such thing, they just don't work at all if
> there is non-coherence in the mapping which is why it is not a bug.
> 
> virtio looks like it does actually keep the caches clean for different
> mappings (and probably also in practice forced coherent as well given
> qemu is coherent with the VM and VFIO doesn't allow non-coherent DMA
> devices)
> 
> > > What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
> > > fails any mappings requests that would use any SWIOTLB or cache
> > > flushing.
> > 
> > You are proposing something orthogonal that operates at a different layer
> > (DMA mapping). However, for DMA debugging, your new attribute will be
> > equivalent to DMA_ATTR_CPU_CACHE_OVERLAP.
> 
> DMA_ATTR is a dma mapping flag, if you want some weird dma debugging
> flag it should be called DMA_ATTR_DEBUGGING_IGNORE_CACHELINES with
> some kind of statement at the user why it is OK.

And this is the issue: the existing DMA_ATTR_CPU_CACHE_CLEAN is essentially
a debug-oriented attribute. The upper layers are already handled through
__dma_from_device_group_begin()/end(), which pad cache lines on
non-coherent systems.

Marek,

What do you see as the right path forward here? RDMA has a legitimate use
case where CPU cache lines may overlap. The underlying reason differs from
VirtIO, but the outcome is the same. Should I keep the current name? Should
we rename it to the proposed DMA_ATTR_CPU_CACHE_OVERLAP or
DMA_ATTR_DEBUGGING_IGNORE_CACHELINES? Should we introduce a new
DMA_ATTR_REQUIRE_COHERENT attribute instead? Or do you have another
recommendation?

Thanks

> 
> Jason

