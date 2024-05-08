Return-Path: <linux-rdma+bounces-2338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD848BF869
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 10:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330FB1F24570
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0902446D5;
	Wed,  8 May 2024 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="O051azcW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7883FBBD
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156594; cv=none; b=ndF58i1oO8ESxmow5wTl1auRJpMncvb7aEUDSvdRsgY61kPOO51Mh8F7YUkoSpnBUg3BBuyzy0/QWGJDPiVm2VM8yaQsLDtBrhRlELbRBGKUR3YqoG/wkDUEWireiVhQx8d0eSZNM5FhgfHdzwtBxP4f/V1MWA69neIlxn2BTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156594; c=relaxed/simple;
	bh=L9G2zXTS16Mb+4am/gUrC3INgoVtn6qnR/OXIt3yAGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsD2DQGpsAqsOeEvDwj2LmCqJs5CDvDMjefKjpgYEKR9I7reBy4+kMTSJcGWsexL1uXL/OzFbDHf+yr2OzVcXUoOtSXft0sQYM8RmE8M70OjNW3f8hLbOFv5TD8YvOkOm9wgaPN2fm85Gb7vyvbFUakejQix6GtS/t8kYUFjp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=O051azcW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ad24baa2so135301466b.1
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2024 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715156591; x=1715761391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xX8T7z7JX/d3uw4bZ2bZEEE/EwwDbdoePKTyocl8yug=;
        b=O051azcWeaUdieG5z6eGWGsCxpkth8aoKM7Uxqs31yUSx1RF57dkPOV4vdKxMp5/dy
         fsau1jvbVsPyEXRadd0Z/cGo70XACc/u5KEalTe9iMLz5YM0GJGTsygKzU5aKD2PConV
         NPMRZ2Q9gxEprU9MbE8FoGNLB1+a6OY0Pxf7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156591; x=1715761391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX8T7z7JX/d3uw4bZ2bZEEE/EwwDbdoePKTyocl8yug=;
        b=JjJ7TJHGJ0EpF1l0pHDj0o/LyGxAlmJb679pxRL3zmFXMgcr/JxSDR5BlZYUbl8szJ
         uWqHsmg3DkVBuFPrqCpDg6qi/+WIYfd2V+8nEhtP8ygshi0P8faYEPmvDNEUuQH0nj0k
         RmfuGvRoZB9Xnr1azNUQefCx6nYXV1ZT6GdLddEhYgEIZKZw3hgHLQkeW4eVhM1Psri+
         CNtMYSakXgE0eN6nqvGPuwqm3cqewniKOUWMYdCwUzvGpOd6FZApj6gI0ZhqW59gnr7t
         6k4Ks0fD5Rc4SDhGhQulLIqzQ+VRIX2LIu0hX1Bb7UHsPcJgw2t8jX58QJDxNUpsCk6f
         gQBw==
X-Forwarded-Encrypted: i=1; AJvYcCUYPynV9RWGZQr8UMyJa6smE3/z6jc36r18Prdjt2/JGMduUm0jfZC1+F/6JCfqkkfZGsC2zGd1O7euYiuauF7sUlqDnxzXHi3E5A==
X-Gm-Message-State: AOJu0Yzp6DxHXiqmNFMZpB+ZovkfKwjBsePW6rFZkaCLk8+wFJ0R3ghg
	LMhzfOpUNsdGg1mJw+I+FcwzxLevSdClgXQJA/oEAi9Vu/WT6A7dhq3JTAFXdUTswlplsZcz+5h
	J
X-Google-Smtp-Source: AGHT+IERZtXNeoCiRmo1mqas8Y/UQ6pzLyLJDXpgtWRZ1RzE0ZKKFqa1dMwitwttSdKyrV7CIRB1ew==
X-Received: by 2002:a17:906:f359:b0:a59:dbb0:ddcf with SMTP id a640c23a62f3a-a59fb6fba8fmr121830766b.0.1715156591554;
        Wed, 08 May 2024 01:23:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709067c4800b00a59a9cfec7esm5128792ejp.133.2024.05.08.01.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:23:11 -0700 (PDT)
Date: Wed, 8 May 2024 10:23:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 2/2] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <Zjs2bVVxBHEGUhF_@phenom.ffwll.local>
References: <20240422063602.3690124-1-vivek.kasireddy@intel.com>
 <20240422063602.3690124-3-vivek.kasireddy@intel.com>
 <20240430162450.711f4616.alex.williamson@redhat.com>
 <20240501125309.GB941030@nvidia.com>
 <IA0PR11MB718509BB8B56455710DB2033F8182@IA0PR11MB7185.namprd11.prod.outlook.com>
 <20240508003153.GC4650@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508003153.GC4650@nvidia.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, May 07, 2024 at 09:31:53PM -0300, Jason Gunthorpe wrote:
> On Thu, May 02, 2024 at 07:50:36AM +0000, Kasireddy, Vivek wrote:
> > Hi Jason,
> > 
> > > 
> > > On Tue, Apr 30, 2024 at 04:24:50PM -0600, Alex Williamson wrote:
> > > > > +static vm_fault_t vfio_pci_dma_buf_fault(struct vm_fault *vmf)
> > > > > +{
> > > > > +	struct vm_area_struct *vma = vmf->vma;
> > > > > +	struct vfio_pci_dma_buf *priv = vma->vm_private_data;
> > > > > +	pgoff_t pgoff = vmf->pgoff;
> > > > > +
> > > > > +	if (pgoff >= priv->nr_pages)
> > > > > +		return VM_FAULT_SIGBUS;
> > > > > +
> > > > > +	return vmf_insert_pfn(vma, vmf->address,
> > > > > +			      page_to_pfn(priv->pages[pgoff]));
> > > > > +}
> > > >
> > > > How does this prevent the MMIO space from being mmap'd when disabled
> > > at
> > > > the device?  How is the mmap revoked when the MMIO becomes disabled?
> > > > Is it part of the move protocol?
> > In this case, I think the importers that mmap'd the dmabuf need to be tracked
> > separately and their VMA PTEs need to be zapped when MMIO access is revoked.
> 
> Which, as we know, is quite hard.
> 
> > > Yes, we should not have a mmap handler for dmabuf. vfio memory must be
> > > mmapped in the normal way.
> > Although optional, I think most dmabuf exporters (drm ones) provide a mmap
> > handler. Otherwise, there is no easy way to provide CPU access (backup slow path)
> > to the dmabuf for the importer.
> 
> Here we should not, there is no reason since VFIO already provides a
> mmap mechanism itself. Anything using this API should just call the
> native VFIO function instead of trying to mmap the DMABUF. Yes, it
> will be inconvient for the scatterlist case you have, but the kernel
> side implementation is much easier ..

Just wanted to confirm that it's entirely legit to not implement dma-buf
mmap. Same for the in-kernel vmap functions. Especially for really funny
buffers like these it's just not a good idea, and the dma-buf interfaces
are intentionally "everything is optional".

Similarly you can (and should) reject and dma_buf_attach to devices where
p2p connectevity isn't there, or well really for any other reason that
makes stuff complicated and is out of scope for your use-case. It's better
to reject strictly and than accidentally support something really horrible
(we've been there).

The only real rule with all the interfaces is that when attach() worked,
then map must too (except when you're in OOM). Because at least for some
drivers/subsystems, that's how userspace figures out whether a buffer can
be shared.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

