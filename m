Return-Path: <linux-rdma+bounces-18124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIpfMUXwsmlBRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:56:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 428052761AF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BFE0318AC40
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A523FD14D;
	Thu, 12 Mar 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/Ncuhpr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199A3FCB0C;
	Thu, 12 Mar 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334242; cv=none; b=BW9HjGml4zmPstx44XU1zalKwHNSox7vryNonVfzW7FzOF7a7HKchXkduvzj1b3YN19TYsO9bX0Haq7cM6HFySfSaH4MCSYi6tZ8X8Yw2YMGq07MTtJK2qp9DaCAYai46WMUmU/YbPTM7PjLA7D5TuXgeyvKjZmmwajur3KCx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334242; c=relaxed/simple;
	bh=I7ohnXz5SQWGkR4iqkJFGqlNZU7QTgaFdwYwVFc0xzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrBxEy4YJXrlv4mJnK4/9dvxANnE/wa6QJAi9q4s3b/MQwjJzVSnbwgzCKjxtfvqgtL5Pa0NpBSxwepdxtpkDVC6jrzMnZzrVHpsW50n2PtW3DE9+s+aG28+syTOVE0HDuyTTIPMZdIExgfmEyh2nAJmIepSmSYcF3SFIKJl4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/Ncuhpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70359C2BC87;
	Thu, 12 Mar 2026 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773334242;
	bh=I7ohnXz5SQWGkR4iqkJFGqlNZU7QTgaFdwYwVFc0xzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/Ncuhprz30y2xAin6UFvnTvzocNQuIqes6ui7gpDr2Q7sh24Z5OkTNZJtridjidu
	 qHJA5XMMmx34FwJfNQTd9eWNuC/TsCnuMW0QQw2WMFgajgUTOtCfMLOlkV7P3EYHhH
	 Nx4YTBgI13YFouzZbuB9ZuPbGPAZ2nHx5tpawOo/y4xbwSwX4qBFaw+N1s+ukFqidC
	 0py6Mr7JAg2AnYENLQ57jutZWMr2iGKWHhZqFgi67nenSrz73gVlv8Eod4sKTgKCrr
	 cy/u7fNxZj8vYe+9tPI3ClTIVdvGPi/HMv2yRFXiddhyGIhxb0pVk4KDsI95EkyaWL
	 rkkqouFhYoZ0w==
Date: Thu, 12 Mar 2026 18:50:38 +0200
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
Subject: Re: [PATCH v2 8/8] mm/hmm: Indicate that HMM requires DMA coherency
Message-ID: <20260312165038.GB12611@unreal>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>
 <20260312122645.GG1469476@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312122645.GG1469476@ziepe.ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18124-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 428052761AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 09:26:45AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 09:08:51PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > HMM mirroring can work on coherent systems without SWIOTLB path only.
> > Until introduction of DMA_ATTR_REQUIRE_COHERENT, there was no reliable
> > way to indicate that and various approximation was done:
> 
> HMM is fundamentally about allowing a sophisticated device to
> independently DMA to a process's memory concurrently with the CPU
> accessing the same memory. It is similar to SVA but does not rely on
> IOMMU support. Since the entire use model is concurrent access to the
> same memory it becomes fatally broken as a uAPI if SWIOTLB is
> replacing the memory, or the CPU caches are incoherent with DMA.
> 
> Till now there was no reliable way to indicate that and various
> approximation was done:
> 
> > int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
> >                       size_t nr_entries, size_t dma_entry_size)
> > {
> > <...>
> >         /*
> >          * The HMM API violates our normal DMA buffer ownership rules and can't
> >          * transfer buffer ownership.  The dma_addressing_limited() check is a
> >          * best approximation to ensure no swiotlb buffering happens.
> >          */
> >         dma_need_sync = !dev->dma_skip_sync;
> >         if (dma_need_sync || dma_addressing_limited(dev))
> >                 return -EOPNOTSUPP;
> 
> Can it get dropped now then?

Better not, it allows us to reject caller much earlier than DMA mapping
flow. It is much saner to fail during UMEM ODP creation than start to
fail for ODP pagefaults.

> 
> > So let's mark mapped buffers with DMA_ATTR_REQUIRE_COHERENT attribute
> > to prevent DMA debugging warnings for cache overlapped entries.
> 
> Well, that isn't the main motivation, this prevents silent data
> corruption if someone tries to use hmm in a system with swiotlb or
> incoherent DMA,
> 
> Looks OK otherwise
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
> 

