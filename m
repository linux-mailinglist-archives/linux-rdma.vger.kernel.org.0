Return-Path: <linux-rdma+bounces-5442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1009A22F7
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CE81C225AB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D11DDA39;
	Thu, 17 Oct 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QBY7HbEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAD1DA112
	for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170343; cv=none; b=vFiX0mU+MYd1YgTjqDiEbQ/0EVs2til9OyB4Jzly9J8Z0fiKlHJRira6GlSVAXGqglgaQPdYUDmciGSsyYHiX+vItUMLxoVxoKJ9XRtUMl+Szk9p2nEAEcDR69hImmss3mvneyAUhg17TPlc88R6gefdrYHu3xPUYbWPMgIGXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170343; c=relaxed/simple;
	bh=+1mZ2EnDgiNZEyU5wGe5DDC8TFv/ZPQhAyame6DNc54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikdGIlaoweN4KdEXMm+H6Vz3qhCIxUqZyJ4b0NTzlb7xPhlL2nFqBAANnhMWN+Hfe9fg7VSeS8xoZxZZ2CpyKr/vY60Ez3Ic6K/w/VpiymqNLIs6s5g8xM42r3r0/wxD5xBedIJQ3k+QviCiFWdpzKtH/rP2RE3wpKxhX9pk9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QBY7HbEl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c5ab2de184so5244886d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729170341; x=1729775141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk++0v4zwR7xUpep4iNg0I6MKOHA7nEjzuqiKjJzkok=;
        b=QBY7HbElBdmMPatjmKu+KZSzhkf8RQXNUFNwI1tAWk43au1lJvTSKaUhD38Kbqy55d
         tEGNbaohEnmAugYaRk9DlQqnNpVw4IBbkKrZLQe3O2TmNH3Lj1sEDl/GcSLMQvdvNq+c
         W83w7F/UZu5svgvQw3fItUVJowlAvZuq81lhLyIBnH9pN6biK/lfaufr8DAtFgT/Mpki
         nmKgu0fGp8g6xB1LsNelD8Kfv4SV8OsjchwtQzDl1a/h5uJ9VR08lFD6TKKoSTxtuJhH
         JbOEAX9Z6s+OzoLP6rzKY5MBrBDUNXaGS8tGray2sBHaCn/IM+E5RBbYaIlLFT2AsQLj
         2Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170341; x=1729775141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk++0v4zwR7xUpep4iNg0I6MKOHA7nEjzuqiKjJzkok=;
        b=ldehIBfgHjQfh8WMoR/WBDbZTJllJ1kRr4Gz5SXQb6fYmkXzH0QpdLce0a+6nVs6jm
         UINMJTb72mCM0sjCUBUwrNuhEC+JEohgIo2Xerj2aGGNpKvuACBN4pt+zHenG5vnLjxD
         VWe//G2uvPANHEIXKuoVf6YnCdp+yEtK2hPFVFoH2oXTdn8szJaNYsL/i/LbLblMKGA6
         kNR/zokuv4CPloR+CaT0EtsXwdk93v5VpEgP1Zkx/0BAW8+tQXsdxFIP4aTa8x6Imy6t
         A6NW1p8MlXDr1zNPRu/gy6tatgs4J/z28LyjrakKWgr2ywYNXAOVnhCt2lOi1AaiN59n
         rMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbHmj3STpLHyRyN2YYGuBt9UDoEEINbsOqOHmbNIBf+W0p379aPg24vmnYkpY/Pq82PdN5wJ7iK1r5@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV1e6/9n0iJGidGLEkNinYsinlSGAxB1u3xeGbC4A5GG/OqV7
	C3cbGkU+UcGJ9jCzDhOCUhRV9o5aWBZFarseCGRL+PFO0/AfvZjBZ71PfYIK+mg=
X-Google-Smtp-Source: AGHT+IG5n5S3zHSv/JX5s/LYaf+o3YrOaG8HklVpPKUbKJ/yS6kcQbfiEDJXO6iYDC0yAlGNuOhLug==
X-Received: by 2002:a05:6214:2b93:b0:6cb:d094:d1c4 with SMTP id 6a1803df08f44-6cbf009b918mr251899446d6.30.1729170340973;
        Thu, 17 Oct 2024 06:05:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290fa01sm27747076d6.24.2024.10.17.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:05:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QCB-003suE-SU;
	Thu, 17 Oct 2024 10:05:39 -0300
Date: Thu, 17 Oct 2024 10:05:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <20241017130539.GA897978@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxD71D66qLI0qHpW@infradead.org>

On Thu, Oct 17, 2024 at 04:58:12AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 02:44:45PM -0300, Jason Gunthorpe wrote:
> > > > FWIW, I've been expecting this series to be rebased on top of Leon's
> > > > new DMA API series so it doesn't have this issue..
> > > 
> > > That's not going to make a difference at this level.
> > 
> > I'm not sure what you are asking then.
> > 
> > Patch 2 does pci_p2pdma_add_resource() and so a valid struct page with
> > a P2P ZONE_DEVICE type exists, and that gets returned back to the
> > hmm/odp code.
> > 
> > Today odp calls dma_map_page() which only works by chance in limited
> > cases. With Leon's revision it will call hmm_dma_map_pfn() ->
> > dma_iova_link() which does call pci_p2pdma_map_type() and should do
> > the right thing.
> 
> Again none of this affects the code posted here.  It reshuffles the
> callers but has no direct affect on the patches posted here.

I didn't realize till last night that Leon's series did not have P2P
support.

What I'm trying to say is that this is a multi-series project.

A followup based on Leon's initial work will get the ODP DMA mapping
path able to support ZONE_DEVICE P2P pages.

Once that is done, this series sits on top. This series is only about
hmm and effectively allows hmm_range_fault() to return a ZONE_DEVICE
P2P page.

Yonatan should explain this better in the cover letter and mark it as
a RFC series.

So, I know we are still figuring out the P2P support on the DMA API
side, but my expectation for hmm is that hmm_range_fault() returing a
ZONE_DEVICE P2P page is going to be what we want.

> (and the current DMA series lacks P2P support, I'm trying to figure
> out how to properly handle it at the moment).

Yes, I see, I looked through those patches last night and there is a
gap there.

Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
well.

Thanks,
Jason

