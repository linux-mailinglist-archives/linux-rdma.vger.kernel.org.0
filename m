Return-Path: <linux-rdma+bounces-18275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BSyDxKmuWlILgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:05:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3F2B15A2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ACE53073F93
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE123F880E;
	Tue, 17 Mar 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRWgTDqb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1513E5ED6;
	Tue, 17 Mar 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774343; cv=none; b=FhaFxk7N+eYDxLw42IvH+vOZ1PbpFV65O0RZem2eqVXg2B430hxhYoo/3l1L4AOUP3espcAWn9svwkC8QOQgkSYoZG133BPxrN4G7n61eW46RAcJPFYhnHUTe/MRoyrrEuBAQ2Sp++YvTzzTDROlCiH6hjp5qtHzMCPrqVszxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774343; c=relaxed/simple;
	bh=syW3z0x80IUsDkJqDO1sfU4YY8HBrpHtA77ObK08ZFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q76V/LLtGIjS2sCJcdINX6Sw0By0nS+Hu6Kkf5jUEnoJmfKa+ZLAkRLO+x/iXpGtBjGDCTe+wGLLse9lX04auWLBhgSuBsYhDBs9NERchuUxOY0tzL/BxylIcdCBveFH+JkPCWBMLseC+DhimqxOpExH55Zrw0nwqryAnOhedck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRWgTDqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F64C4CEF7;
	Tue, 17 Mar 2026 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773774343;
	bh=syW3z0x80IUsDkJqDO1sfU4YY8HBrpHtA77ObK08ZFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRWgTDqbWe3Q1W3JoxRORGEv9cJSyULlIC1z8Bw/dttRqK0xrUjV3jcLj+FCNIlhA
	 yfquFZi5RuoGYh094bwpTEqzMSy1oi20VB/mwVmDasAQXUEDUj69QwmFrLNkzzaaEW
	 TxL4IoR2tfqmdocyZECPzry0Flux1xfTuoo78wga02G7HX9CfQP86SEbWHmeki3bnG
	 fQQPAweWzmsOQWPyYRrr1vn+O2GeAM0lXjxVoRUKicNl0fMpfX0u90da1igsahAgWD
	 lVpeDEoTnLCevj3RHVAGT/mI6ZPAnZpFvQykUFfbUgqTYwv27pZul8kECdVX2mxKrW
	 MJpheC1EsGxUQ==
Date: Tue, 17 Mar 2026 21:05:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/8] RDMA: Enable operation with DMA debug enabled
Message-ID: <20260317190538.GD61385@unreal>
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18275-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: C3B3F2B15A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 09:06:44PM +0200, Leon Romanovsky wrote:
> Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark
> mappings that must run on a DMA‑coherent system. Such buffers cannot
> use the SWIOTLB path, may overlap with CPU caches, and do not depend on
> explicit cache flushing.
> 
> Mappings using this attribute are rejected on systems where cache
> side‑effects could lead to data corruption, and therefore do not need
> the cache‑overlap debugging logic. This series also includes fixes for
> DMA_ATTR_CPU_CACHE_CLEAN handling.
> Thanks.

<...>

> ---
> Leon Romanovsky (8):
>       dma-debug: Allow multiple invocations of overlapping entries
>       dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
>       dma-mapping: Clarify valid conditions for CPU cache line overlap
>       dma-mapping: Introduce DMA require coherency attribute
>       dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
>       iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
>       RDMA/umem: Tell DMA mapping that UMEM requires coherency
>       mm/hmm: Indicate that HMM requires DMA coherency
> 
>  Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
>  drivers/infiniband/core/umem.c            |  5 ++--
>  drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
>  drivers/virtio/virtio_ring.c              | 10 ++++----
>  include/linux/dma-mapping.h               | 15 ++++++++----
>  include/trace/events/dma.h                |  4 +++-
>  kernel/dma/debug.c                        |  9 ++++----
>  kernel/dma/direct.h                       |  7 +++---
>  kernel/dma/mapping.c                      |  6 +++++
>  mm/hmm.c                                  |  4 ++--
>  10 files changed, 86 insertions(+), 33 deletions(-)

Marek,

Despite the "RDMA ..." tag in the subject, the diffstat clearly shows that
you are the appropriate person to take this patch.

Thanks.


> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260305-dma-debug-overlap-21487c3fa02c
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 

