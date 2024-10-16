Return-Path: <linux-rdma+bounces-5432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A909E9A0EC6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 17:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC1EB248EC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F620F5AD;
	Wed, 16 Oct 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zqip9kRY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246F18C920
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093474; cv=none; b=s8pBifC4O2N+rlNxc/GEXhIne3WRoTRBP+VJLg5IVeFe0HGAg/NIQIWb1oM8xs7CZMTunwN8EDpURHjt6YC+/a4BhaTLrG38eNUWBFK5d3xRhln7rXMW4fE++IMosIdcJlcK5Or5MRco+t3gXy3cAN7+z6h2ky8AK8j0IvRTyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093474; c=relaxed/simple;
	bh=Wt8M3OtL2Uo77t8ctBBB63Tcked/Ps5DjEWBtq0fbIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUESt5vQFLlQomrwsOhQ4v3++BiYjzO+Liw390MrxxDvg/U6OPlnEBjhSt9SQaC2HuxSnOuMO53ogJdChF58NCnjhUDlWNuGLjV0gsi6xavG4y+Owt3BwVgdYpWytZkYkcoE393wBOmyY1g1ELrCQnvYr2oujeMA7irL4zvrC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zqip9kRY; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46098928354so2053861cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729093470; x=1729698270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQGH0HVIW9SU96PYTPyuC1ydSkg4GgQM+hqbTFWgoGo=;
        b=Zqip9kRYKVSvXHp7HRlWSobILUazYDJWn3S70BRDHKzzygMj7RjJyWRY/u4gkwDb7i
         zu99uQr/LaryTvQSI9sTOtd8Fz71S94VlHQlj1d70D+Zy/HK+eVx0Sc0Nt7PcLE06RFi
         9ilY988OiafcKdIng2VAYMBThg6B3coZ9hRyH7w4HIETGQfchV5tQrdpIBVHyuJ43KyX
         N8zOm968B+oxmznksC+cJoDNDahEjIjPzY7HXHMmpM2fpydyER9XGTyN8Jxl/fCgVHYy
         BPsPOwaDm6pgmMlxaxBIQdy0OpxyWe3meCmoabvtZXUXbLTmnqsdA0cTRqXt+tkxf3J5
         +tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093470; x=1729698270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQGH0HVIW9SU96PYTPyuC1ydSkg4GgQM+hqbTFWgoGo=;
        b=hzXrgI+7Pms61wXIB8Gvjk/mGjRHFJjIQYB2d9i4wfpthF0KLf4fNrfvLkzqkPtB1/
         3EpdympA3dO9qr7s4nagOYlCtDu2M+CDuZFZzPHBbdulz4hkE/SvGBKUfzp4TmC6fQC/
         jEDu/SpOSeaidlV4Z388o4tADDdAykyIV7FnbNjNoF1EIz6Ul8rz6F1EQWryIJUCVCzd
         WOisuAz8VyVnxVDcyMUumDG9+J/wUFoBghkvd4UsD6F9SKoAEb8EaWw9P2paev0bQDVo
         T3BG12MgRH3n1z/8Dtv3VRR+VgWuFvh6MtuwL8W1MLUGQSE5E4UTA/ADHZj2T3OxjbvP
         2pDg==
X-Forwarded-Encrypted: i=1; AJvYcCU7VfWzSk6bEQB2bRnawDgGBfnpjQffN8NtFMS4Le9YvkIEQlOXNA/+vbyXF1lh6K8BR+Gc95ZK2Xw5@vger.kernel.org
X-Gm-Message-State: AOJu0YzeckFNzBA48oR3G0blOTvVjj1M/w85d2f/lDFscbsIbCUw3AkR
	wRl1/4BRqilHQbdjqCHqQoxLi/ismsqjn0pPL46fdD/CQ5Z1VGhBjCiyIeVeP2o=
X-Google-Smtp-Source: AGHT+IHphNZzLqFYrOFx7/ySDq7sBcTOs9Dks5qU/HFioLD65ljv8EK1dQjanMksDh9hLfIE6iUrIw==
X-Received: by 2002:a05:622a:2608:b0:458:4bc9:e949 with SMTP id d75a77b69052e-46058424bc2mr231836401cf.22.1729093470391;
        Wed, 16 Oct 2024 08:44:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a6760sm18990161cf.6.2024.10.16.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:44:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t16CK-000COv-F5;
	Wed, 16 Oct 2024 12:44:28 -0300
Date: Wed, 16 Oct 2024 12:44:28 -0300
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
Message-ID: <20241016154428.GD4020792@ziepe.ca>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw9F2uiq6-znYmTk@infradead.org>

On Tue, Oct 15, 2024 at 09:49:30PM -0700, Christoph Hellwig wrote:

> > +	/*
> > +	 * Used for private (un-addressable) device memory only. Return a
> > +	 * corresponding struct page, that can be mapped to device
> > +	 * (e.g using dma_map_page)
> > +	 */
> > +	struct page *(*get_dma_page_for_device)(struct page *private_page);
> 
> We are talking about P2P memory here.  How do you manage to get a page
> that dma_map_page can be used on?  All P2P memory needs to use the P2P
> aware dma_map_sg as the pages for P2P memory are just fake zone device
> pages.

FWIW, I've been expecting this series to be rebased on top of Leon's
new DMA API series so it doesn't have this issue.. I think this series
is at RFC quality, but shows more of the next steps.

I'm guessing they got their testing done so far on a system without an
iommu translation?

> which also makes it clear that returning a page from the method is
> not that great, a PFN might work a lot better, e.g.
> 
> 	unsigned long (*device_private_dma_pfn)(struct page *page);

Ideally I think we should not have the struct page * at all through
these APIs if we can avoid it..

Jason

