Return-Path: <linux-rdma+bounces-18100-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKDmGmqvsmlGOwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18100-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:19:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F9271958
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C8F3047BDC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B001A682B;
	Thu, 12 Mar 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BKS8aTvx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6577E792
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317982; cv=none; b=mUToSmqrHC7G2x1ZGy9pQxMtvV5H/G8qWTIVj7KIHJeO6L67IRRxObEgX/+HarGKOj9dKbmk0Iyoq/7fseIXcCK7KVGfbtOpJ8yhT+ttL03M/U3HjodkORRExIQuMIrrR48QYsq5yy6wTiCd7wzTgeT1k6d1QB0wwqMY3YTh57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317982; c=relaxed/simple;
	bh=Oj/7ehc0cCCCDQU/7pS4vL4fF7AXLJnL/YyNxYgW3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEVaGulSccxCh9sSHv3LWr1nVjKuP0PGMzZ4kY9xeJND6f3rcsu1rDyEaVYbuMPUGkMCAaadKsuq90AmxY0U7lwsk5u5O3rxMNZwXVL62u5UlFxI/IGp9a2/E4DTF5TwYiyXImaxZARKhISCjx4mZN0Ou2PYaCdEa4iZe64kk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BKS8aTvx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd7a75c680so196921585a.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773317980; x=1773922780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=BKS8aTvxZ3yh3IKjkSO1betRitYvAMjkK4YVAlshSXkv+ZnnBOXn7O7vaa1xC/RfHE
         zkAT2IkDbxusmUdQBc03On3Qiajg5+h3X3muwby/ijTjxLZBSm5SYsOa7xok8BrqH3LN
         GLFLO/42YieyVkWFv+HoGj95X8UG3+cuKr33MM8HWMqACq0QTUPGEYEcq/UsSdyMbSFX
         GAifEack/sIllT9LxthUXMJMeOlziVtcG2Ljouz+6y6o8KqRsAM6HTyboxZrtMUgzNsk
         RMbV/Q6WtRTyCeZUGeROzDdlUhO5p8muQs9pa4NEB7B0le9KZsotXJ3Ii6ruCleOy2Ub
         FnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317980; x=1773922780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=MeiW9sSkYRzenDYKUjG1rOprwSyGzdtOmFlGdk/N+wAQV3nancIW6wTH34OaNdwYJb
         U04l5Q0xkdIpPChZB+i9ycwbaR6e3qbWtbARngoP+f6cn2QWEKXkmbNvYBivXfB5/kr+
         8HxZzpAJjJRbSa3wt/PjGWHz2QnjOm2F2RPTl3CnZl8O7/ttAD/cIbCu5o7jZoHPoZmL
         zUK9mcfoi5Ofgq9roWh+a58KypYiB9a9dON6SmezMZzjT+Bbks2/vkEjFEDrbVAtj8Vj
         AiEzxGuGuhfmiW7NhLJhYdEgantxNkgmUTp586Ehd1Jy2Ksd3xODSusNa3g8CbV7AvRZ
         f6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUOUS13cNGkmtqQ5K6INHHjDOlzu1dEzeX8JGUW626z7TtCAzeJPkXWJSjGndkz/bRo3jG9u6ZEylLE@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIj3dWXeK5MlW6O3JmgcJb3QQeF9igMsgG0PGD/knydoWvRSj
	1TgHQyOMY3MdHye6uWAKoSt5U5GjduaCxryw3avLflcLcJ18BsINjGZG3zYph2kCfMM=
X-Gm-Gg: ATEYQzzJEevevifhpE4FcT2qmpVh6Vaoy6KN14I8+ZShIe+Cj0BmgTjzRk/NWSP5QM1
	rqgLQ3Zm+nguR/woV6VgVAGxOWs/bo9HkWgOKPNbtSMwM9n+rref5FH7cEYcPYLfWxoiDFW4ISl
	QE4VATuAJjPSOIYD7pgsbzBX7AmtavI7uP/cRGuy6DuXRp89VbLTmOLHgljFwvQzlJsdILNrcjs
	MGZ83v8EiShCpbbaK8bn6Kn/cD+iy7AXmFQNqvGhjPDlRQPuPTLboiRzSpujd0tTRYlgQZw+jrd
	T8vlEoHW38E1eT6Es8xlTELFOhJ5S3v6wWtOuUhK38sb957kdRE3BZU41DnUhPMA34riDhBKsfE
	8hRjhKQmGWB0V0Kl5piJz5MxvWxiehpVtCATwjaVblbsJlgpxd5+N+VS0kJ4AwjKpO3onLK3t58
	Tnl+GJ1qMfb4Q/0MOgx8zJXnSyDjPIt4Y5MmSCbZMgU1vgEVr/g6kZmGbo4gqC0zz/shDjGL1tI
	+H5ic3u
X-Received: by 2002:a05:620a:4041:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cdaa7b6b03mr382866785a.15.1773317979843;
        Thu, 12 Mar 2026 05:19:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm321675885a.34.2026.03.12.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:19:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f0r-00000006esN-1WXU;
	Thu, 12 Mar 2026 09:19:37 -0300
Date: Thu, 12 Mar 2026 09:19:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
Message-ID: <20260312121937.GD1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18100-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 2B0F9271958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mapping buffers which carry this attribute require DMA coherent system.
> This means that they can't take SWIOTLB path, can perform CPU cache overlap
> and doesn't perform cache flushing.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-attributes.rst | 12 ++++++++++++
>  include/linux/dma-mapping.h               |  7 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  kernel/dma/debug.c                        |  3 ++-
>  kernel/dma/mapping.c                      |  6 ++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 48cfe86cc06d7..69d094f144c70 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -163,3 +163,15 @@ data corruption.
>  
>  All mappings that share a cache line must set this attribute to suppress DMA
>  debug warnings about overlapping mappings.
> +
> +DMA_ATTR_REQUIRE_COHERENT
> +-------------------------
> +
> +The mapping buffers which carry this attribute require DMA coherent system. This means
> +that they can't take SWIOTLB path, can perform CPU cache overlap and doesn't perform
> +cache flushing.

DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
system where SWIOTLB or cache management is required. This should only
be used to support uAPI designs that require continuous HW DMA
coherence with userspace processes, for example RDMA and DRM. At a
minimum the memory being mapped must be userspace memory from
pin_user_pages() or similar.

Drivers should consider using dma_mmap_pages() instead of this
interface when building their uAPIs, when possible.

It must never be used in an in-kernel driver that only works with
kernal memory.

> @@ -164,6 +164,9 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>  	if (WARN_ON_ONCE(!dev->dma_mask))
>  		return DMA_MAPPING_ERROR;
>  
> +	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
> +		return DMA_MAPPING_ERROR;

This doesn't capture enough conditions.. is_swiotlb_force_bounce(),
dma_kmalloc_needs_bounce(), dma_capable(), etc all need to be blocked
too

So check it inside swiotlb_map() too, and maybe shift the above
into the existing branches:

        if (!dev_is_dma_coherent(dev) &&
            !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
                arch_sync_dma_for_device(phys, size, dir);

Jason

