Return-Path: <linux-rdma+bounces-17790-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBkkGEbirmlPJwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17790-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:07:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1B23B461
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945CF30A0072
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F93D6CC8;
	Mon,  9 Mar 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE7PP3LN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C75258EFF;
	Mon,  9 Mar 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068707; cv=none; b=t+qt+KMbTd5zDLKT8pNElXmFaHHz0vDFjw/1vF0XEvBNRrCaZUIf4ynkWFgzqSHhzqhgqEVzJPU686BLQt3gWCGkaS4GDThqDswKSuUSEAqkARgKXYY2l+hcuCr7jSMqV1iDPj1F6yvn0ybJ0XP2B9gxyX4kJcPtVl7FXLdNvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068707; c=relaxed/simple;
	bh=DbnGEpHVevnfQfu6lKr+YEPijas0Ocs85CAyF6ehtvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJjwOBhEALddo4wwKLZT9pi2jA7ZABKykDN/qF9x+VynBuVZGDuf9NtbA9mnbMewg2XP0U/CWCJI7J/scZ2mU8VRQ4u68YqKgpWZS6IvufwM2fwIQXenZnrbT79z3NYYC73CPK1ealT5qFBwq2glQii9G10CGVQrQOrCqpohkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE7PP3LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805BDC4CEF7;
	Mon,  9 Mar 2026 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068706;
	bh=DbnGEpHVevnfQfu6lKr+YEPijas0Ocs85CAyF6ehtvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE7PP3LN85OCryOOM4Rjm5R25wxF+GBgjw/w+mnHJhC+bsJV6zEfkv+P1ng6YBY8P
	 //N/QU2ZINvPyzm4beU3jULs5D0roSZbZlI9Ye4QY3EeHg0PpV7OvdNboPhlXya9RC
	 mKaKxeO4Yk45LH1XeJ2SR1UnMOarje3jQWjrF9MSWX8Nt6kjEmhoXqGGBOrWWTsUh/
	 kPil8KWOZlttPaIsn8abAACGoMmQeBD0hktJ3FaDWu7gaUvvkvLXKg6hkd8+V8INy7
	 2iscFQROGrnSLLjvNcD101gDGl//3UDKnHKP/DT++aUdTcEVNwl9u1HQo4g9kfJQWK
	 jfRttns+JMN4A==
Date: Mon, 9 Mar 2026 17:05:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260309150502.GX12611@unreal>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
X-Rspamd-Queue-Id: E5F1B23B461
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17790-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:30:24PM +0100, Marek Szyprowski wrote:
> On 09.03.2026 10:03, Leon Romanovsky wrote:
> > On Sun, Mar 08, 2026 at 08:09:16PM -0300, Jason Gunthorpe wrote:
> >> On Sun, Mar 08, 2026 at 08:49:02PM +0200, Leon Romanovsky wrote:
> >>> On Sun, Mar 08, 2026 at 03:19:20PM -0300, Jason Gunthorpe wrote:
> >>>> On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:
> >>>>
> >>>>> -This attribute indicates the CPU will not dirty any cacheline overlapping this
> >>>>> -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> >>>>> -multiple small buffers to safely share a cacheline without risk of data
> >>>>> -corruption, suppressing DMA debug warnings about overlapping mappings.
> >>>>> -All mappings sharing a cacheline should have this attribute.
> >>>>> +DMA_ATTR_CPU_CACHE_OVERLAP
> >>>> This is a very specific and well defined use case that allows some cache
> >>>> flushing behaviors to work only under the promise that the CPU doesn't
> >>>> touch the memory to cause cache inconsistencies.
> >>>>
> >>>>> +Another valid use case is on systems that are CPU-coherent and do not use
> >>>>> +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> >>>>> +(such as flushes) will be performed that could overwrite shared cache lines.
> >>>> This is something completely unrelated.
> >>> I disagree. The situation is equivalent in that callers guarantee the
> >>> CPU cache will not be overwritten.
> >> The RDMA callers do no such thing, they just don't work at all if
> >> there is non-coherence in the mapping which is why it is not a bug.
> >>
> >> virtio looks like it does actually keep the caches clean for different
> >> mappings (and probably also in practice forced coherent as well given
> >> qemu is coherent with the VM and VFIO doesn't allow non-coherent DMA
> >> devices)
> >>
> >>>> What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
> >>>> fails any mappings requests that would use any SWIOTLB or cache
> >>>> flushing.
> >>> You are proposing something orthogonal that operates at a different layer
> >>> (DMA mapping). However, for DMA debugging, your new attribute will be
> >>> equivalent to DMA_ATTR_CPU_CACHE_OVERLAP.
> >> DMA_ATTR is a dma mapping flag, if you want some weird dma debugging
> >> flag it should be called DMA_ATTR_DEBUGGING_IGNORE_CACHELINES with
> >> some kind of statement at the user why it is OK.
> > And this is the issue: the existing DMA_ATTR_CPU_CACHE_CLEAN is essentially
> > a debug-oriented attribute. The upper layers are already handled through
> > __dma_from_device_group_begin()/end(), which pad cache lines on
> > non-coherent systems.
> >
> > Marek,
> >
> > What do you see as the right path forward here? RDMA has a legitimate use
> > case where CPU cache lines may overlap. The underlying reason differs from
> > VirtIO, but the outcome is the same. Should I keep the current name? Should
> > we rename it to the proposed DMA_ATTR_CPU_CACHE_OVERLAP or
> > DMA_ATTR_DEBUGGING_IGNORE_CACHELINES? Should we introduce a new
> > DMA_ATTR_REQUIRE_COHERENT attribute instead? Or do you have another
> > recommendation?
> 
> My question here is if RDMA works on any non-coherent DMA systems? If 
> not then it should fail early (during init or probe?) to avoid potential 
> data corruption and new DMA attributes won't help it.

Like Jason wrote, our user‑visible API does not work on non‑coherent
systems, and this is where I'm using the DMA_ATTR_CPU_CACHE_OVERLAP
attribute.

Regarding failure on unsupported systems, I have tried more than once to
make the RDMA fail when the device is known to take the SWIOTLB path
in RDMA and cannot operate correctly, but each attempt was met with a
cold reception:
https://lore.kernel.org/all/d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org/

I'm afraid the outcome will be the same this time as well.

> On the other hand, the DMA_ATTR_CPU_CACHE_OVERLAP attribute is a bit more
> descriptive to me than DMA_ATTR_CPU_CACHE_CLEAN, but this indeed looks
> like a separate issue from the RDMA case.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 

