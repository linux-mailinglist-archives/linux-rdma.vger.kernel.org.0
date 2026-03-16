Return-Path: <linux-rdma+bounces-18222-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HQ5B8hquGn5dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18222-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:40:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0F2A04BC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031D8306328D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AFA3EFD38;
	Mon, 16 Mar 2026 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGDr2I5J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9B3ED111;
	Mon, 16 Mar 2026 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693574; cv=none; b=UYCXXFJ1HzT5Hhj60T0d58o4hikIdxzBmS+j0rXgk1v8G8ivp3Tx6OpwHEGprGmjBC+S/SCUH4jZIPW0jbIlacJCQyR9iI2LCtFTKE3g9rNxjN/YYB3VknQS2/81zAFHuqmAN8cQ38CZRmyaNighHHK43NHXO+ZRGC2fvfUp7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693574; c=relaxed/simple;
	bh=e3RhwnNiwK1x/eHOGy59Ae3i6XSohKUkLWxBcoMgZBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MINaxekAExsRI8yWGil8rP3fBuLOx2fqHTYDh0k1Y51gA8m3AWrFcvXJc4GbDn8l2IREFAefOodB5sOWXbSPoqqmbFKiZjqoDgBpyeRz+xJM+M8pAWpQCu2uZH4CzoDfAGNhk9VZ+pF/9rwew24HZXYEz/jBVfWXaJ9xXyA0mvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGDr2I5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22662C19421;
	Mon, 16 Mar 2026 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773693574;
	bh=e3RhwnNiwK1x/eHOGy59Ae3i6XSohKUkLWxBcoMgZBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGDr2I5JcvQ6vJ3DIMejIHnlwRwdvsorfSEnknaKSiitD38CtJ6sFxept3ygj/Q7N
	 yAHSy9gmn+44EX68ntr5N7Hr8WQ2uFLRO51rUpGyqrMdxu/Fe06F6gFaFDj/J5gVPD
	 QlxnPuZEhN38bbayFCrU9R8lYGXqH4g8vuJoMzQaxmbWIRSldzdam8TNyC7EY61gKX
	 /h4z5PoRxc3DjADAzngUsqiWDjBq3d754JXL4IcedLvxbST9Jh8bftxXsnWoVqPBfC
	 eMpyvvZ+k4OpKkJ98UuclDiF9VFYue2g6aB34fIZRnu2iZFGKN+7STsAmFTQPQBORG
	 PPVv6vlTlCocw==
Date: Mon, 16 Mar 2026 22:39:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 4/8] dma-mapping: Introduce DMA require coherency
 attribute
Message-ID: <20260316203928.GN61385@unreal>
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
 <20260316-dma-debug-overlap-v3-4-1dde90a7f08b@nvidia.com>
 <659bd750-c67a-4290-8c2d-58bc13c9e2a6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659bd750-c67a-4290-8c2d-58bc13c9e2a6@infradead.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18222-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7DE0F2A04BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 12:17:39PM -0700, Randy Dunlap wrote:
> 
> 
> On 3/16/26 12:06 PM, Leon Romanovsky wrote:
> > diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> > index 48cfe86cc06d7..441bdc9d08318 100644
> > --- a/Documentation/core-api/dma-attributes.rst
> > +++ b/Documentation/core-api/dma-attributes.rst
> > @@ -163,3 +163,19 @@ data corruption.
> >  
> >  All mappings that share a cache line must set this attribute to suppress DMA
> >  debug warnings about overlapping mappings.
> > +
> > +DMA_ATTR_REQUIRE_COHERENT
> > +-------------------------
> > +
> > +DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
> > +system where SWIOTLB or cache management is required. This should only
> > +be used to support uAPI designs that require continuous HW DMA
> > +coherence with userspace processes, for example RDMA and DRM. At a
> > +minimum the memory being mapped must be userspace memory from
> > +pin_user_pages() or similar.
> > +
> > +Drivers should consider using dma_mmap_pages() instead of this
> > +interface when building their uAPIs, when possible.
> > +
> > +It must never be used in an in-kernel driver that only works with
> > +kernal memory.
> 
>    kernel

Thanks, let's hope that it is the only one comment :).

> 
> -- 
> ~Randy
> 

