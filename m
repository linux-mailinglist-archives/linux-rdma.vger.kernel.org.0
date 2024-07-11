Return-Path: <linux-rdma+bounces-3840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27092F29B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 01:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EC72824C5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 23:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A801A08DC;
	Thu, 11 Jul 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nz/0cXuE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD51A08BB
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740562; cv=none; b=WDFHamSK8oGJVeT4OTL8pb5EiqEHchtNggzEps5uPjbzP2RgggqtTY+5t3Sh+QnSiWEmRLKH+7SgElZIy9q/kP6wt+EWDbc2fbyWtLEuJt743eFVGiEaa8Bm+K+YEur6wUi7dyl4B14BSclEt0IX5eC9IaSjlew3cQwzAJE1rEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740562; c=relaxed/simple;
	bh=xaEoCHgxGFkkaE365hqIb2Uz8DfpXp/vyPGTl63S9F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFpfseNq6ix2WrWZoeKDlz7dcvrwBfmjnKGqZb49feHdnAmUjDq+OMfn2maCOEik3LMxP6s8YIqaRIj48hP4tHgOGepJd0unSwttuqFgLPSjgvyIZEoWGvRxFicNBHEw5hnvXtBHxaAXXiPJ9blJ3OD7WADORjx9WoTXe5xU81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nz/0cXuE; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e04f1bcbf84so1498114276.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720740560; x=1721345360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=;
        b=nz/0cXuEwIStaA0oAwpp1wkGKcQBjfrSApwM32tnvn3RhiIjxuSY26bM1PK28WOTpi
         XySlNeg8PHIlDdCcsIb67uyNZ23PbkeIJ7JVORXTIUcsn3gi7jlq7wSSSrGljzjfUmvu
         wQXR4GbTzr86ljYEBB0GSmDtsa+6R0I7sq/ALgclKzw6Cj2u4wK1u79kB6FajJAFh1u+
         8n0gCiF2KhWXTuD7lAEp4vQzS5tm3ic1pCx6CMy3ABXNNeMK0rE/diWZhV0iSeYhX8ed
         U9yrjQH5lLUZc0vaGVU54SYPkmSq7pZfZ6TSO7K9aT+ak0J1gIM9+tEcnwoXlOthu3iw
         4X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740560; x=1721345360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqjQlEH3CKHFjb6SyBS/N/HAG+tY7keJdf7Z8lIqTro=;
        b=Rtcn9QhD8cUWfpUUQerlEtgVxU4bwKLSJpluVThmX5MGxp3l9YroM8M3gdcXmRGzQo
         5zbjPefrOcc3mgbIMrrKXWbL9haGRO4hjpEa70tyE16R0ct25+eEgeIZo4omyOteKBjS
         ZvxGRY7jXyb3QylI5aVwkwpWOcOTZnGgsyv7P4OgC1+v11K1VG62SvVrBkkcfJFFMGCf
         +KWGYf3yo5QLi07G3pg4nTWiTQufS2m2zFjkybljazoWrsMzAQ0iWkEemRpEWhK5Wvh7
         kUO3zRukPn7f5ZG7Dn4NA0WlphjIPrko+gf01k65/rQZs9vTt0hJvWGcuR1zkbOip5Vz
         McAA==
X-Forwarded-Encrypted: i=1; AJvYcCXD+2e0BnVckYACW1mSYjDxWGWnwXgYs/PFgnUBwO78DNm2CYTDJMKjttifXEjB+CVronvc7grKtUlyxCYFcDqfI+wHRore3bPeBQ==
X-Gm-Message-State: AOJu0YzQ3RiXMYPyyhZD6okbE8r6BsSNd9w+AfjkdIO1nKkaebMHA4kJ
	PbkvZnHIvGWLMrMDjbvtapYblqE7gW1OjqldodmuMDjt9dOPxrkY2J9tdx+v54Q=
X-Google-Smtp-Source: AGHT+IGo/R/9vr/JQ8/zyNR81M/Hy4HYANX0IxAKDGShf5hUDU3ZGhkQLcCJ3hGHl6ul2XGkV4cgvA==
X-Received: by 2002:a25:aa66:0:b0:e03:5fee:66a with SMTP id 3f1490d57ef6-e041b123aefmr11985783276.42.1720740560216;
        Thu, 11 Jul 2024 16:29:20 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190128d0sm341135085a.44.2024.07.11.16.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:29:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Dx-00FQzB-7b;
	Thu, 11 Jul 2024 20:29:17 -0300
Date: Thu, 11 Jul 2024 20:29:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240711232917.GR14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710062212.GA25895@lst.de>

On Wed, Jul 10, 2024 at 08:22:12AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 09, 2024 at 04:03:20PM -0300, Jason Gunthorpe wrote:
> > > Except for the powerpc bypass IOMMU or not is a global decision,
> > > and the bypass is per I/O.  So I'm not sure what else you want there?
> > 
> > For P2P we know if the DMA will go through the IOMMU or not based on
> > the PCIe fabric path between the initiator (the one doing the DMA) and
> > the target (the one providing the MMIO memory).
> 
> Oh, yes.  So effectively you are asking if we can arbitrarily mix
> P2P sources in a single map request.  I think the only sane answer
> from the iommu/dma subsystem perspective is: hell no.

Well, today we can mix them and the dma_map_sg will sort it out. With
this new API we can't anymore.

So this little detail needs to be taken care of somehow as well, and I
didn't see it in this RFC.

> For the block layer just having one kind per BIO is fine right now,
> although I could see use cases where people would want to combine
> them.  We can probably defer that until it is needed, though.

Do you have an application in mind that would want multi-kind per BIO?

Jason

