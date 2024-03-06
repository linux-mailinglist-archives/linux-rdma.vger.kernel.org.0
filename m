Return-Path: <linux-rdma+bounces-1294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BAE873AFC
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D204B1F2A45F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE913666B;
	Wed,  6 Mar 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EHbRTffY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CF13664D
	for <linux-rdma@vger.kernel.org>; Wed,  6 Mar 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739813; cv=none; b=s0OENUJtmu89vLTiXYHOx3Lw48qF7NHCin/QGB+kl7LpQqlT6Lag0pnk3DbwsEFskkMFvfeBiRhb7Z1Zd5h3HkO61b41JR53rmHR7fQ5oa7Hqxq0Hh57+Lu/rQNPWapQVM2HlrEBJypkCICAR2lqMBvAqFssUWmBCVJSEXUhH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739813; c=relaxed/simple;
	bh=pGaDc0TLwfeotZCgvBcO4BGO9qk0bmKODRVmJ9jH1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olqPzeZsyW2DL1Fn8lwVBz5vQsJIIFeLydlLqc1yQp0bJ5yk6MNprZynvGTuCOWr0XPgjRog3AwiZg2ukuEuzQpJiliPa3osuZ4q6P822etWkVU9WPYTzlfFQ3cZy0nw18vlwb4WHzExfFlhCKFQATWvTEBFi9A59HHJLr/BIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EHbRTffY; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a11ed428c5so2278132eaf.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Mar 2024 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709739810; x=1710344610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1cN5gYBP45I54WCStxe7DUVSwP4yg1UztQaoI/QgCY=;
        b=EHbRTffYRUPXi/5DH5IevGwnWlcrTDhMcLaL1V7n8fKyTJ3zWc9GzowCcApsqb4F/j
         OAvS90y7UEP4b6YqKcflqWW3qa+9Cpai4UMVePHbjxruVuIK6Qpvw+95onDilF2IwIYz
         gzkxxOC+kczjYtmKUDMoOV4dtPdPMkdCIcC0Z2rAD8AIp8thVggKPrA61LG0p/82v8S7
         HHX0rK4u0RDL59n+x6QuLIprN12eVoVIiAm8geP4mTuO8hkg66lhfAgl9I/sRRkS9z0p
         OPtl/BDe2lWdfFN+MtXlT70pUOfAog7UHhd9W2RvAXQcH7aWmTVfsVi5orHgjUUAPLDK
         Qd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739810; x=1710344610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1cN5gYBP45I54WCStxe7DUVSwP4yg1UztQaoI/QgCY=;
        b=h4bZSMh5XI6kqCGSYyaC6keSQzNWUiysckPOruYveuoWNAQSXrrbg6enPUML3MaOTB
         2hoC+06pOfnzSsWxghk2vxK4z91Hb6pfbomvwJ68+Ek01ntfiV3UA9qMRAqlZIpzUNWX
         IT1FQsVmc4pxRhFu7HfJecqw0FslQlmyM4rApQSSybHVFSXwAgPzGel/IylOfZegUVP5
         tZ9rN4gNYr3aebUnR1lIc7kSalr1Vn5AnZEsr1F9iDpR13rKE/wuj+TcTLcBZnl7BTJO
         S7/C4xVU4jmWNMO3QyyRCAgJcswGam+65otIgtKtbgYHA5kl/LWFRteEOOoilcqOcAb/
         P9ng==
X-Forwarded-Encrypted: i=1; AJvYcCXp77YiCqNRImg2nDaoj/CnxY8+69A8QNYwWsQOTr2kMH/8TG00i3hRn92Dm1AnMorPelxusI4OcCseXmEJ7BU5U4Vs3jJVTh3nLQ==
X-Gm-Message-State: AOJu0Yz+ZlePVS1RUywCIkPVrXv+w2bwxpkERTWfOxRsYekpDxs79jNE
	V1j+d84HGxUDDPnKUYvaBQEqRZDhSnzVD8/BMiUjEJ492yjXFdl+0mooBb4FNlw=
X-Google-Smtp-Source: AGHT+IF835JdG2KV+Fg3U6AZj/VvG5X03U44hahvSgMdG82XDPKZTf6weC4/9ghDsNohTNUCXi+btw==
X-Received: by 2002:a05:6358:78a:b0:17c:1bc7:16d5 with SMTP id n10-20020a056358078a00b0017c1bc716d5mr5567125rwj.5.1709739810357;
        Wed, 06 Mar 2024 07:43:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j10-20020ae9c20a000000b007871bac855fsm6707680qkg.47.2024.03.06.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:43:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhtQW-001c2D-PU;
	Wed, 06 Mar 2024 11:43:28 -0400
Date: Wed, 6 Mar 2024 11:43:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240306154328.GM9225@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
 <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306144416.GB19711@lst.de>

On Wed, Mar 06, 2024 at 03:44:16PM +0100, Christoph Hellwig wrote:

> Except that the flows are fundamentally different for the "can coalesce"
> vs "can't coalesce" case.  In the former we have one dma_addr_t range,
> and in the latter as many as there are input vectors (this is ignoring
> the weird iommu merging case where we we coalesce some but not all
> segments, but I'd rather not have that in a new API).

I don't think they are so fundamentally different, at least in our
past conversations I never came out with the idea we should burden the
driver with two different flows based on what kind of alignment the
transfer happens to have.

Certainly if we split the API to focus one API on doing only
page-aligned transfers the aligned part does become a little.

At least the RDMA drivers could productively use just a page aligned
interface. But I didn't think this would make BIO users happy so never
even thought about it..

> The total transfer size should just be passed in by the callers and
> be known, and there should be no offset.

The API needs the caller to figure out the total number of IOVA pages
it needs, rounding up the CPU ranges to full aligned pages. That
becomes the IOVA allocation.

offset is something that arises to support non-aligned transfers.

> So if we want to efficiently be able to handle these cases we need
> two APIs in the driver and a good framework to switch between them.

But, what does the non-page-aligned version look like? Doesn't it
still look basically like this?

And what is the actual difference if the input is aligned? The caller
can assume it doesn't need to provide a per-range dma_addr_t during
unmap.

It still can't assume the HW programming will be linear due to the P2P
!ACS support.

And it still has to call an API per-cpu range to actually program the
IOMMU.

So are they really so different to want different APIs? That strikes
me as a big driver cost.

> I'd still prefer to wrap it with dma callers to handle things like
> swiotlb and maybe Xen grant tables and to avoid the type confusion
> between dma_addr_t and then untyped iova in the iommu layer, but
> having this layer or not is probably worth a discussion.

I'm surprised by the idea of random drivers reaching past dma-iommu.c
and into the iommu layer to setup DMA directly on the DMA API's
iommu_domain?? That seems like completely giving up on the DMA API
abstraction to me. :(

IMHO, it needs to be wrapped, the wrapper needs to do all the special
P2P stuff, at a minimum. The wrapper should multiplex to all the
non-iommu cases for the driver too.

We still need to achieve some kind of abstraction here that doesn't
bruden every driver with different code paths for each DMA back end!
Don't we??

Jason

