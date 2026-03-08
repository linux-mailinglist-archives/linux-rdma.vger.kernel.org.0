Return-Path: <linux-rdma+bounces-17734-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM4hLKoBrmki+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17734-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 00:09:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571442329E7
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 00:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32927301017A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373D35A39D;
	Sun,  8 Mar 2026 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VG5XLHyw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8742475D0
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011361; cv=none; b=DY8fYSzn0FzWmGsMgtPr3S90OHcTSilgnBglehP08aJ3IY3QwRkL1RBgScb4ETEBu14cp0012BI8JouK8U3/StZgom4UH0wZH5O3J7fQGrSvBlWlvOLclE23z1KKCrWoZK8EHn2fBc/kRu1frUk4aHfXuF/681C8e+R4LHqRXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011361; c=relaxed/simple;
	bh=rBbx3d93p2y2jIh4G2U5Gu80cWTEuOIfSXCGSgCzVU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbQayRvYvRQILp1NPoO2rwlTV4xaHgPe+IC+b+Pl7cUigYrpExYT258Hpy7mFIEyMh6Q1qByzdomJVhdkHGNCn19iDrI364sfFhfHoopuxlZMRh3WAQL4zQR8tfuyvC+zpwiAniqSqALb8kxe/JWxNIhziUxss8LH/Aosrrm7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VG5XLHyw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-508fe217a44so19037731cf.2
        for <linux-rdma@vger.kernel.org>; Sun, 08 Mar 2026 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773011359; x=1773616159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJUOBkP/5JQJnNKHejLcwjpKdPk3k1pSv7xveepfvi0=;
        b=VG5XLHywQc9Gws5ePKS1MUsQEqYQuMj40HD3KNtw+Pth6/fCC45oSpQhz2/Al4NsM/
         BC2cmgo33MuGVIOhlNpUvYKkhufDc1x6J2MfwSMP6Iw2PYQGKrYliMe3UvxmVJSsCWup
         6BJruFUt6EXdmUuSi5i3V7Krsf0BQGBCdgW1+yZnCzEOQIOQvQQlyvW1r8G3LblZfqe1
         S6m+D2RlyRl4u50hn2fqpu7yPIX4aaT1K+xgigByFL87JmyWNE5aoZvKuxJiFgVG61tV
         b3hDJkZ54oKcRa30Eeo53XGXCHVAFSvw0xhZXI3mT5/zqECF8LIAtjpwOxOhOIxIUoWb
         8kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773011359; x=1773616159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJUOBkP/5JQJnNKHejLcwjpKdPk3k1pSv7xveepfvi0=;
        b=Fp8r7/lVObohwKPnhouB6OMJ0oCgLWhjVeO4FCdv5XYuSexVH1+Si0xxZcebnyJUzR
         OkdWinopa7NyMWtnuHySarjZvK0aZqLmr/UCZCLEC3da1xq25I305s89thSLqXHsD4nn
         SGoTqxuxbjCKTnaIqMbLZaGwdgtNMEm9hFwOgIp6xjb1tiEwg8hm/hS2oNP7T9By5B40
         AYXL/PSJkfZhCmeNPwGidvEOpawgNBD7uaJ9Py5kvV+dR6PJZVE1cakgXGC/eyrosf3G
         I6QitwE19DNiCMaRNxaiv4J0NkSyBzIy25gFdR1Epw3JgfVOaQyRMFI3aT00QDgqCIj2
         VXtg==
X-Forwarded-Encrypted: i=1; AJvYcCXuQRTuq3AloflNkZgJuLmqCTV2gRnWR4yE0jy77HX4lEiYrIBY3+m8h3WThhIcBzhQhKTb75ZpX6EW@vger.kernel.org
X-Gm-Message-State: AOJu0YzajmlgWculaek/5PhPRf4VweW7VPK5corj54O7a/R4HRBz7hhH
	sIClmFoW+EIiu2WtxbzmGxaS8jYMHAoQLn3+cTvjLE2CdLAJc1nMPnY/V7GGi0K124c=
X-Gm-Gg: ATEYQzxOoZiOduPiRi1kUKZSY1z/oU5vga/ewJxdp5noChTwHwFDqME5bMlc4SKwiwz
	SYT0LUSl4XCrqVdmJBhkSpMU5mAsKnxeaEysGCc0pAhSWYtkYk12wZP+xLm++h6U/f0fq0XEFxE
	kDXih6cV97zRWO+5R4RRvqoreucs1v0p13cPL2PWyTzGIjn/XeTI8CyTeufMyc5Lq9fz9QEfPce
	phYpYGeHScCZblNCb3bYStIHADYUez09EckCAaRa8JJzxSwlgHBJcNE3ykrTMO9Pgo4UirUGT2M
	5jnZDKCEaNz3la+NE2RTL7C2GY2oQAyE0GpogAxyUXjS3N9MCW1lJjthec6+u/zg2m3xVOVko66
	mwgb4t+DBlMKATstgYfbr8wiwV2sqbYlR9U0QdpZkw3QYgop/y42DIbFWEt4ROETW/pHrbFD6IV
	EYFsXt5//AqztxfkAPVPN5PCdZygTCXeOda77RtCmRLYkx+JXA1DDhLRujF5+Wa5sosA0YVduTT
	sW1/7r3
X-Received: by 2002:a05:622a:1995:b0:509:127d:ee06 with SMTP id d75a77b69052e-509127df85cmr39687201cf.58.1773011359286;
        Sun, 08 Mar 2026 16:09:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66da77csm51473791cf.30.2026.03.08.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 16:09:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzNFM-0000000Bzue-3rG7;
	Sun, 08 Mar 2026 20:09:16 -0300
Date: Sun, 8 Mar 2026 20:09:16 -0300
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
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260308230916.GI1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308184902.GR12611@unreal>
X-Rspamd-Queue-Id: 571442329E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17734-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 08:49:02PM +0200, Leon Romanovsky wrote:
> On Sun, Mar 08, 2026 at 03:19:20PM -0300, Jason Gunthorpe wrote:
> > On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:
> > 
> > > -This attribute indicates the CPU will not dirty any cacheline overlapping this
> > > -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> > > -multiple small buffers to safely share a cacheline without risk of data
> > > -corruption, suppressing DMA debug warnings about overlapping mappings.
> > > -All mappings sharing a cacheline should have this attribute.
> > > +DMA_ATTR_CPU_CACHE_OVERLAP
> > 
> > This is a very specific and well defined use case that allows some cache
> > flushing behaviors to work only under the promise that the CPU doesn't
> > touch the memory to cause cache inconsistencies.
> > 
> > > +Another valid use case is on systems that are CPU-coherent and do not use
> > > +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> > > +(such as flushes) will be performed that could overwrite shared cache lines.
> > 
> > This is something completely unrelated. 
> 
> I disagree. The situation is equivalent in that callers guarantee the
> CPU cache will not be overwritten.

The RDMA callers do no such thing, they just don't work at all if
there is non-coherence in the mapping which is why it is not a bug.

virtio looks like it does actually keep the caches clean for different
mappings (and probably also in practice forced coherent as well given
qemu is coherent with the VM and VFIO doesn't allow non-coherent DMA
devices)

> > What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
> > fails any mappings requests that would use any SWIOTLB or cache
> > flushing.
> 
> You are proposing something orthogonal that operates at a different layer
> (DMA mapping). However, for DMA debugging, your new attribute will be
> equivalent to DMA_ATTR_CPU_CACHE_OVERLAP.

DMA_ATTR is a dma mapping flag, if you want some weird dma debugging
flag it should be called DMA_ATTR_DEBUGGING_IGNORE_CACHELINES with
some kind of statement at the user why it is OK.

Jason

