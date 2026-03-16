Return-Path: <linux-rdma+bounces-18214-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCf7K4dYuGmKcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18214-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:22:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C529FC3C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26378304D142
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63203E8C6B;
	Mon, 16 Mar 2026 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tWL0Mtpb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60E20ED;
	Mon, 16 Mar 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688670; cv=none; b=iOQ481HoZ7pjbE2d5tqGuUGr9uonZ9XXxiIrh5rNCzV4hKRht1YdwwsdvZvkvz2L9wgvEGntiL7seaaZEiT/uAGrGuS/mHFDwce89pL73HxgHWBkvG43zbE1eO82ZRzLY6Tt69HgRdJWRtL2QaPKZjXhud5nyUpYS6g1XLYk5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688670; c=relaxed/simple;
	bh=MKgmyjFuGH4Jj9wA7VW7D52WTrpFreoKGfMl3FvB1fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvIDWXklrutuxsRzjZbeW8XatdzlWQSGUD3KXHR4p14ZMbwOWTMzMHx6q6RPsuZpSn+SdCsNxHdLpirvC8VBbPCovVOniIIXbBySjxVML79NFAXBdN9T1+NdSaXS4KIviBRnkVRKE49UsRIF7GPU56YVCi1M0AF13ZwPSv37axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tWL0Mtpb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NdWqcb4hqU1+ie/mbBcn2+9eh+rHjQw3OrJ1LmLY49M=; b=tWL0MtpbizoR7d5lDKODkpzvOf
	lDvsaM1JuZ2XHLjneWMAMQxGTGV6OvvyRl37MritY0dwie/z3gEG+d0/VOHhp3P2eZiX9G22KPQgO
	f1DGScXj7+G8ZpQUfcSzD4mVGFcTfQ54QmrIEqwhPaylWk238p8X/TOzShQZgboM0f2NT8W4uT5zt
	CZx0D3R7pvShJzzyrQPy1Hhevhto92gPDT8VbEcg+l4rkNdgX0KN52NxPO0g3nquiF2ZkuvWDe+XO
	fa6r3t7fxaHRuUl1jGYhvn4OPZ9NXRZM5WcRXNmEnqvlnxTbX3TRe68i+grkRz24SZj1zUtPLje9h
	qiPq3Urg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2DRc-00000004kbI-0Mf5;
	Mon, 16 Mar 2026 19:17:40 +0000
Message-ID: <659bd750-c67a-4290-8c2d-58bc13c9e2a6@infradead.org>
Date: Mon, 16 Mar 2026 12:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] dma-mapping: Introduce DMA require coherency
 attribute
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260316-dma-debug-overlap-v3-0-1dde90a7f08b@nvidia.com>
 <20260316-dma-debug-overlap-v3-4-1dde90a7f08b@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260316-dma-debug-overlap-v3-4-1dde90a7f08b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18214-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 2F9C529FC3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/26 12:06 PM, Leon Romanovsky wrote:
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 48cfe86cc06d7..441bdc9d08318 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -163,3 +163,19 @@ data corruption.
>  
>  All mappings that share a cache line must set this attribute to suppress DMA
>  debug warnings about overlapping mappings.
> +
> +DMA_ATTR_REQUIRE_COHERENT
> +-------------------------
> +
> +DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
> +system where SWIOTLB or cache management is required. This should only
> +be used to support uAPI designs that require continuous HW DMA
> +coherence with userspace processes, for example RDMA and DRM. At a
> +minimum the memory being mapped must be userspace memory from
> +pin_user_pages() or similar.
> +
> +Drivers should consider using dma_mmap_pages() instead of this
> +interface when building their uAPIs, when possible.
> +
> +It must never be used in an in-kernel driver that only works with
> +kernal memory.

   kernel

-- 
~Randy


