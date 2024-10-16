Return-Path: <linux-rdma+bounces-5435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D99A10E0
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB7C1F23191
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898E212EE7;
	Wed, 16 Oct 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K+MB5yBz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582D14A4E2
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100690; cv=none; b=sCBSfPZyo3MyFrRYYGz0pkH6dm9C7ASeWTiB5Jr3ptqFqMw5M7H2C5ETBrzpd94H5WB8GkzT9nf6BMiEV4ViucYnm4oSlvNH/NszSlfY3rJRpjuim7jtdGi8YXethxlyAzC3Pe9PeVxqUGLs7oJGRadKiymw3VSSYJYrkaPiFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100690; c=relaxed/simple;
	bh=Afymd/QhPaZgqKlVfhd3oejD7Z3V+1V/irpIP51C4Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdugkHjPprDv0AnRrCExsrsr8M1nU2We+U47n3wiIbPgB+1LZEQ9TQ4Rms6ThzGgOG9OREJZAwDgmVVuzGWLJTqXjHNXtnJ0T7zNzIXvuqFkXVnLYjU9Kt7ZkGMrHSWzalZReAKsKMv1Eqzg/e7yEdchxjR3527o4kDHE7ZA3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K+MB5yBz; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso634016d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729100688; x=1729705488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o35iiCDiZ5eaKfswFFD+TpBr1+3YZIM/Zzff16IB6bs=;
        b=K+MB5yBztwoCiJcWvOra0tzNNw3dRHZ2+sKvjhWdPLGbHJ6bW67w4sencxg7PpSKFb
         iLreRDgtgI4PcPFxgb2+kV8FozQLkf/517ZyEvYskg5aTg0IIkWJpPyRz5IZ69FoUPuY
         GWxeUvBCNrksdW5TYkldgS9inJXzcjIGZO4hXv1AOrCgU2CNVi9BuuFTpTkV/KA62NDG
         ua1YUhvtBXfBkUuF2GhUOoNf0na6zwRb+xhuYEDPVUXrx/aUmGlwkMM2aOM26hrVVuni
         TEm2nriWZBlrHdZOF5RohPhZ9ka1YyZIAj6LaqIedrUd3rXU9MzG3BXzekHRc+ENh7aL
         OmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729100688; x=1729705488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o35iiCDiZ5eaKfswFFD+TpBr1+3YZIM/Zzff16IB6bs=;
        b=sMHA8OgVYqZHbyleRyOsinZ2Jt0JnB9RLFZSMir//1QqTeViSJHq2l0coRGXvn+7tt
         TSToHNmPmEDxUfCjUrXQb2DNN2RADHA6aucAOHpTG3iEZwg5m1ChzJ8KEdirRUsuKVWt
         VFqB2Xio8IxEje5tGs76QOM9yTmzc4xceKvenvfqbW1xUjUMvTdEDmv+nwItnD57dpH2
         MLIxIasOjBIfUIoI/Wbiyc6jAPioKnl48SRjPsFSZXm9FBu2V4psmEjrOWW1eMfb+oe8
         WB15oWFqpkWC0jWijjqUnDdk9W8Mz5vA4y2t7C86kjBKRUvVUJVWzuHn9BPjbMLXdTcw
         u/xg==
X-Forwarded-Encrypted: i=1; AJvYcCVilT3Ku6mGx6oUWbt6TD41h0duSBR4glJeyI1ijO076DKdbnv77iVGAMOx2WhQHjKkDASp5kpOpoYr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OtpeLLQzMQOeyJZ+MgxmcXq/eNyfviYC5Ob7hciXZQ9Hl5Rd
	GAeYqhrq8dNysu7twGYSBT4SViAfrGndhK3kY2GwIOSrLo+ngA7+B7wnDZmsQ8E=
X-Google-Smtp-Source: AGHT+IHcb2p/EJ+d36NHl0163jeyLVI0sDHNW9tlAjYiB2BbJs8req4vjOwcR9cJR+8TMnyYMuXpMQ==
X-Received: by 2002:a05:6214:5b06:b0:6cb:d1ae:27a6 with SMTP id 6a1803df08f44-6cbf0095668mr259975216d6.24.1729100687504;
        Wed, 16 Oct 2024 10:44:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22961bbasm19822836d6.108.2024.10.16.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:44:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t184j-000h5k-5X;
	Wed, 16 Oct 2024 14:44:45 -0300
Date: Wed, 16 Oct 2024 14:44:45 -0300
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
Message-ID: <20241016174445.GF4020792@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw_sn_DdZRUw5oxq@infradead.org>

On Wed, Oct 16, 2024 at 09:41:03AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 12:44:28PM -0300, Jason Gunthorpe wrote:
> > > We are talking about P2P memory here.  How do you manage to get a page
> > > that dma_map_page can be used on?  All P2P memory needs to use the P2P
> > > aware dma_map_sg as the pages for P2P memory are just fake zone device
> > > pages.
> > 
> > FWIW, I've been expecting this series to be rebased on top of Leon's
> > new DMA API series so it doesn't have this issue..
> 
> That's not going to make a difference at this level.

I'm not sure what you are asking then.

Patch 2 does pci_p2pdma_add_resource() and so a valid struct page with
a P2P ZONE_DEVICE type exists, and that gets returned back to the
hmm/odp code.

Today odp calls dma_map_page() which only works by chance in limited
cases. With Leon's revision it will call hmm_dma_map_pfn() ->
dma_iova_link() which does call pci_p2pdma_map_type() and should do
the right thing.

> > I'm guessing they got their testing done so far on a system without an
> > iommu translation?
> 
> IOMMU or not doens't matter much for P2P.  The important difference is
> through the host bridge or through a switch.  dma_map_page will work
> for P2P through the host brige (assuming the host bridge even support
> it as it also lacks the error handling for when not), but it lacks the
> handling for P2P through a switch.

On most x86 systems the BAR/bus address of the P2P memory is the same
as the CPU address, so without an IOMMU translation dma_map_page()
will return the CPU/host physical address which is the same as the
BAR/bus address and that will take the P2P switch path for testing.

Jason

