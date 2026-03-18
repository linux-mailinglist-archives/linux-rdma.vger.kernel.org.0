Return-Path: <linux-rdma+bounces-18294-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF9eBnxgumnFUgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18294-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:21:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC312B7CD0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 09:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD19C302571A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9537881F;
	Wed, 18 Mar 2026 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaorMzDl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1274377544;
	Wed, 18 Mar 2026 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821944; cv=none; b=Fjf1+g+NwKwoZKhP0gHy3ne/X6bXmC8BlfUn2WBddVnazKJLjbDdtmHZn1S41FGw9N8CA0O9Y6MJEx3FRGQNxm5xKlfecifSzUoHd9ShRKgkHL7zG0se6AJskE3HX6v0p/3y3PT2tKW/XVkjDT1lcVqeMe7Wz/cIfwC7agJGHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821944; c=relaxed/simple;
	bh=jVeQZp0h7g+obL73Q3BKVJM80mNeyIKHbMpYvZlI/EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5+WGDa3dwmljbCnlY6xlNX7fTyLuMQ4K8nyPCNdLrTiglqBqwCWew7FNb0ONFwHkWMQzn3AB9Q78QKoX9ACr5q0cstCMqcZ6+tQM9y9QSbKE/MEwyyfXh6LU1uNesP7VpxeVeGN1FWdweYxc72w2j/K2V7BUhvCWEl4JcXSiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaorMzDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78818C19421;
	Wed, 18 Mar 2026 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773821944;
	bh=jVeQZp0h7g+obL73Q3BKVJM80mNeyIKHbMpYvZlI/EM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaorMzDlLJ2+D0bII3A53j63hnSxrjJGHbtDoCBjpAfjf52OE/no45FdOEDejAHRh
	 Q4Z76a9d8zbmglulrhmHrYtmvPsrWYnsRaZkSI/UchSyQrCmizli9RDszWfk6XXFKt
	 aranseGkN99fprSjS157PfMdIHUFwsV2p1bAi2UFxZXFIz/EAYgiB/URpZ5JbOxNxe
	 jW+7XnQhbRstMMHYEsKG+lGQMl3YAciYRQ7GWy9pBq2l+Zz9MXxxmoueb7kjGBHVgf
	 +ldwzEHFsYidjsNvg3b12ZQyiYT4f22PXh5B2feb8k0aRkk7Bo+Kv5lcBkdpLlf4BE
	 alySAZY/1b4Lw==
Date: Wed, 18 Mar 2026 10:18:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v3 0/8] RDMA: Enable operation with DMA debug enabled
Message-ID: <20260318081858.GE61385@unreal>
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
 <CGME20260317190552eucas1p28f3e818f88d252b1e4161332be084177@eucas1p2.samsung.com>
 <20260317190538.GD61385@unreal>
 <de23ccf6-75ef-48af-8c69-2f416c564f2d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de23ccf6-75ef-48af-8c69-2f416c564f2d@samsung.com>
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
	TAGGED_FROM(0.00)[bounces-18294-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CC312B7CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:03:00AM +0100, Marek Szyprowski wrote:
> Hi Leon,
> 
> On 17.03.2026 20:05, Leon Romanovsky wrote:
> > On Mon, Mar 16, 2026 at 09:06:44PM +0200, Leon Romanovsky wrote:
> >> Add a new DMA_ATTR_REQUIRE_COHERENT attribute to the DMA API to mark
> >> mappings that must run on a DMA‑coherent system. Such buffers cannot
> >> use the SWIOTLB path, may overlap with CPU caches, and do not depend on
> >> explicit cache flushing.
> >>
> >> Mappings using this attribute are rejected on systems where cache
> >> side‑effects could lead to data corruption, and therefore do not need
> >> the cache‑overlap debugging logic. This series also includes fixes for
> >> DMA_ATTR_CPU_CACHE_CLEAN handling.
> >> Thanks.
> > <...>
> >
> >> ---
> >> Leon Romanovsky (8):
> >>        dma-debug: Allow multiple invocations of overlapping entries
> >>        dma-mapping: handle DMA_ATTR_CPU_CACHE_CLEAN in trace output
> >>        dma-mapping: Clarify valid conditions for CPU cache line overlap
> >>        dma-mapping: Introduce DMA require coherency attribute
> >>        dma-direct: prevent SWIOTLB path when DMA_ATTR_REQUIRE_COHERENT is set
> >>        iommu/dma: add support for DMA_ATTR_REQUIRE_COHERENT attribute
> >>        RDMA/umem: Tell DMA mapping that UMEM requires coherency
> >>        mm/hmm: Indicate that HMM requires DMA coherency
> >>
> >>   Documentation/core-api/dma-attributes.rst | 38 ++++++++++++++++++++++++-------
> >>   drivers/infiniband/core/umem.c            |  5 ++--
> >>   drivers/iommu/dma-iommu.c                 | 21 +++++++++++++----
> >>   drivers/virtio/virtio_ring.c              | 10 ++++----
> >>   include/linux/dma-mapping.h               | 15 ++++++++----
> >>   include/trace/events/dma.h                |  4 +++-
> >>   kernel/dma/debug.c                        |  9 ++++----
> >>   kernel/dma/direct.h                       |  7 +++---
> >>   kernel/dma/mapping.c                      |  6 +++++
> >>   mm/hmm.c                                  |  4 ++--
> >>   10 files changed, 86 insertions(+), 33 deletions(-)
> > Marek,
> >
> > Despite the "RDMA ..." tag in the subject, the diffstat clearly shows that
> > you are the appropriate person to take this patch.
> 
> I plan to take the first 2 patches to the dma-mapping-fixes branch 
> (v7.0-rc) and the next to dma-mapping-for-next. Should I also take the 
> RDMA and HMM patches, or do You want a stable branch for merging them 
> via respective subsystem trees?

I suggest taking all patches into the -fixes branch, as the "RDMA/..." patch
also resolves the dmesg splat. With -fixes, there is no need to worry about
a shared branch since we do not expect merge conflicts in that area.

If you still prefer to split the series between -fixes and -next, it would be
better to use a shared branch in that case. There are patches on the RDMA
list targeted for -next that touch ib_umem_get().

Thanks

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 

