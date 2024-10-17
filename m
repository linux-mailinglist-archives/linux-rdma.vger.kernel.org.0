Return-Path: <linux-rdma+bounces-5446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B190B9A2432
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CB42844BB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107711DDC3C;
	Thu, 17 Oct 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kjYGn2Ax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814FC147
	for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172807; cv=none; b=qPxdcHGOrusQc12c5EEIizoVwxlANkrkArvTQV2JyaZXkkI1j+x/eq1mvvYPDNiT4OPQ5yUnRg78LCpZQUOx10CIdT3avPFczHdms8bkfxy09GkQGQmsMwxJ/L20GBTsPJIs4hzLlsem9C7br4t1J8YedYKJ2GwSalptn03NLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172807; c=relaxed/simple;
	bh=GavC1bCf/RUg1YwBTQ9ARQYBuRar7SYI7Mn3S3262Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO4gw0eJtUNX7U7Hhv3y13TlMfkqBONR01vb8qbtJhi3qI5iBOZ2xkUheosWpRaDnxA/h5VLuAgHkV6+BsGsQWlkIvrlyx29a5GQ/vcrsB1WjhFrMmng5r2Db/jTRWcI/6blolhHKwE5mJwSuuP7RmIIw629QLLFyPCfZHENgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kjYGn2Ax; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5a5a59094so8355047b3.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729172805; x=1729777605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0nQN0NCObfK5Vn1zgRw1TpjVIw9ZxydvJ5Q22r05Dw=;
        b=kjYGn2AxsIbtBEhJQaEWVNW+QGvPe00E0SyvGpTtjd/WeJknr+jaInkwRBT1aZBgk3
         YEqOd3lW2uP6+xiqXvxLV705NNEOyl1r5T2awTjYghtGvb2z3BjYnsUSmMFwdbzllZ2p
         fS5ymmIVf1UkBFoPTlkFfbeYL7xMieKJB7lbPKfbB6Q4/JAaGkWfoQHITOqeKFJ7ZW5c
         PxWpL3McQDeHo5wzX/8ANCR3uhLb7a0W47QrOau5Tyj37pkh7cQm94ogzcpuwPhNhXRa
         HSBDMpDof6vCymN9h/aghUdVGhcF9K6h2VeoLp9Oxvb309LabGRw7D6NKYoxSgbziGCw
         b+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172805; x=1729777605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0nQN0NCObfK5Vn1zgRw1TpjVIw9ZxydvJ5Q22r05Dw=;
        b=m6Hu8ZdZhGoT96cS4bziw/4qLJP8KvXSvcnyT9YGhhIkE7sWK43AWVeqNSVM+YAzVt
         4eaJwE6bY78JOEK8tfQL+DKYfKnaGqgAdHgdxBIhKfmYcT8mnMEuwW5FNlgmCeS7NrHM
         lj2TjZR+Km9rHb5TMwSq+d+yu2/8ztTRemdNYM8gpxuPtgNtq8lIX5jL7O950NBD8Rjz
         +MxSea0qvTGw4cEdQKcVliVB49wz4pT9DGJ3TJIFwDQLbBj2maO4rcfkZCBHDGFhA8V+
         suRV6/yJoNC5Liyo3KfctyRNsd4OF9yOovA0W1GgGzQhVoetSq/b8GQpyY562ajRAyxI
         WXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQHVmkVi8zVOgwtC2fmwo/maDqSNBwb8wsSL7yJllA79BIdsr+5XG4Ygv36NLZYbcS4EwuhPZTgq4b@vger.kernel.org
X-Gm-Message-State: AOJu0YxyP3Ega+Fvnjb8RgeFc9UvLk+xT6/9RgTOdTAkOtrwKQAjKeZU
	2c/W1I7ItwftaUbLBgwtshA9UAq/Oz+pb2ifAhMxPV9tMnLlrn561zgZkAsJ+hg=
X-Google-Smtp-Source: AGHT+IGpgOmzimpqGZo+yKVQ9O8UZLb6Hva6cSsO+ZYcAVIT1sMFZwMiYnH2dMe9t9IABxyKBdXUOw==
X-Received: by 2002:a05:690c:3586:b0:6e3:3521:88ff with SMTP id 00721157ae682-6e3641411f4mr162528807b3.18.1729172805398;
        Thu, 17 Oct 2024 06:46:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229245f1sm28440036d6.57.2024.10.17.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:46:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1Qpw-00404r-FW;
	Thu, 17 Oct 2024 10:46:44 -0300
Date: Thu, 17 Oct 2024 10:46:44 -0300
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
Message-ID: <20241017134644.GA948948@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
 <ZxENV_EppCYIXfOW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxENV_EppCYIXfOW@infradead.org>

On Thu, Oct 17, 2024 at 06:12:55AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:05:39AM -0300, Jason Gunthorpe wrote:
> > Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
> > well.
> 
> ODP is a lot simpler than NVMe for P2P actually :(

What is your thinking there? I'm looking at the latest patches and I
would expect dma_iova_init() to accept a phys so it can call
pci_p2pdma_map_type() once for the whole transaction. It is a slow
operation.

Based on the result of pci_p2pdma_map_type() it would have to take one
of three paths: direct, iommu, or acs/switch.

It feels like dma_map_page() should become a new function that takes
in the state and then it can do direct or acs based on the type held
in the state.

ODP would have to refresh the state for each page, but could follow
the same code structure.

Jason

