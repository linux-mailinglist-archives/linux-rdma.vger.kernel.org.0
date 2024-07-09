Return-Path: <linux-rdma+bounces-3774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A492C39F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C6B1F235B3
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4F182A52;
	Tue,  9 Jul 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="A6g2pnoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D714D6E9
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551798; cv=none; b=AbkORU6MIjK6iqI/0eO5rmqeg4QQ04HJnlQqiSU+k9IGewjWObj6zf8Az9hTJmFad7i2vrFbKmW97uB9tPs9dyLIeCuWyZfKyajq0A4TjtHZZKm6n3Dcw0jJRaLqBMs+XqC1FZ6yxtAej2HW3BpzVFblqwb0ARz445ZnfzKAndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551798; c=relaxed/simple;
	bh=UmMx48wnc0FnxjTp1WjNlbVccTNxzM4x83j7igXR7TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Y0xZF6bX7oc5oAvCJ9VRPB8tdoO62T1D/uywbCBldHgMrAN5HjbqBcZGIxCKn2nKGqrzKr5JZimtpnrZWTdvAdzqLYNeP+CgXZ6HSu2n+LiOOaLXcZ95PrJcrPEzsVqNcTjfSFWak/vtmXuCIJ6ppQFe5US7xvs/eiYoMrySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=A6g2pnoa; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b553b1a159so32574676d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2024 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720551796; x=1721156596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz4SKanGT0p7B5kijsG/hyAEtWawoOPO2+O2oyG1KXg=;
        b=A6g2pnoaWkIIc0CimeecaG6mN13v3n+vMZWH1a2eisPl7oElZ5j8RpC7cpUSns7z7E
         SaXhh3hjwvo58JADJ4Lw0s/jnqxlC0BzTQIPpK7tnTw3bVo/e3D+fRbRqyUbjlLnjChe
         VcL/iF5vlClZpPkk1kOVxFIVZXTJH4WsBu1HbMB3pT8UgIlpcPiRTcjlKhpPxR7637Fk
         DRUQkMUNORI+3EPdhjl+QzUQN9nItiNZ6HEzDLm0u+TDbYIPjlW+C8lfjk3FVZ8v7AWW
         V8oJikbmctWxcgEg3nIGGAnSdH/wLtsUGiM83M8YX4/0gceq+z/kwqBSB9Rw6gHC0ZcK
         NqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551796; x=1721156596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz4SKanGT0p7B5kijsG/hyAEtWawoOPO2+O2oyG1KXg=;
        b=UW18oQMUHDSbdEyKYKZ35QEbNY8D9yHupugB2tmjIQXNMYdfsD90HtitqDFlgOhl49
         LMnvUGkrkSwZP0r7wjZkn8Ecx7exLIwyx1p+eLaE1mTuejRTMHMsgryxcbGr9u93nHTv
         46PFt8XIjAmh0IlH7gw+klyCkkarQdl7ImMEzppp3dBtlYX8kPgKzRL4STOAiqPbkCW7
         ZcJZzX/Ykrwx9LGD7fhBhpk5ACZ+nRCynAzypYRoCts/BmWi3jN/NfMCzm482VzlXr+k
         V8b2y/y2zlf0setYEHNrctovBuvtmu5WCj9grD0d/Vx0w+HZAZKkjiIzSXJScOqEocrU
         g0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJnp2TCulsMO5hMnLCxDriuUgm9DGh4/PH2O6O0zY4Mmy0AXxUoWmlSJWnyT89yENBY43PfxOBra4XXFhF5hxLuIU4kgMvig8zQ==
X-Gm-Message-State: AOJu0YyUvqoHLeWb1xlTwpXvJ4EBfJRQ5TFGKchsZGICnF0JPJGXGyhV
	9m3kBaBlilucEVUJRw6tp2xxzhcB66KwJ0CP8nNzQF8vD8yL14Py/f5EDpKM0mM=
X-Google-Smtp-Source: AGHT+IFhetxp9iNMwbY2wmkBlgDvT9+MA6GFJVeq9xE0noHusNzmV7TqInccd4H71Z7ysufi1Iri/Q==
X-Received: by 2002:a05:6214:1cc2:b0:6b5:52da:46f2 with SMTP id 6a1803df08f44-6b61bc80504mr38822486d6.6.1720551795800;
        Tue, 09 Jul 2024 12:03:15 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba797c0sm11232896d6.91.2024.07.09.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:03:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRFxj-002sHI-8S;
	Tue, 09 Jul 2024 15:53:15 -0300
Date: Tue, 9 Jul 2024 15:53:15 -0300
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
Message-ID: <20240709185315.GM14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
 <20240708165238.GE14050@ziepe.ca>
 <20240709061721.GA16180@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709061721.GA16180@lst.de>

On Tue, Jul 09, 2024 at 08:17:21AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 01:52:38PM -0300, Jason Gunthorpe wrote:
> > Ideally we'd have some template code that consolidates these loops to
> > common code with driver provided hooks - there are a few ways to get
> > that efficiently in C.
> > 
> > I think it will be clearer when we get to RDMA and there we have the
> > same SGL/PRP kind of split up and we can see what is sharable.
> 
> I really would not want to build common code for PRPs - this is a concept
> very specific to RDMA and NVMe.  

I think DRM has it too. If you are populating a GPU page table then it
is basically a convoluted PRP. Probably requires different splitting
logic than what RDMA does, but I've never looked.

> OTOH more common code SGLs would be nice.  If you look at e.g. SCSI
> drivers most of them have a simpe loop of mapping the SG table and
> then copying the fields into the hardware SGL.  This would be a very
> common case for a helper.

Yes, I belive this is very common.

> That whole thing of course opens the question if we want a pure
> in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
> way to migrate and allows to share code easily.  We can look into ways
> to avoiding that more for drivers that care, but most drivers are
> probably best serve with it to keep the code simple and make the
> conversion easier.

My feeling has been that this RFC is the low level interface and we
can bring our own data structure on top.

It would probably make sense to build a scatterlist v2 on top of this
that has an in-memory dma_addr_t/len list close to today. Yes it costs
a memory allocation, or a larger initial allocation, but many places
may not really care. Block drivers have always allocated a SGL, for
instance.

Then the verbosity of this API is less important as we may only use it
in a few places.

My main take away was that we should make the dma_ops interface
simpler and more general so we can have this choice instead of welding
a single datastructure through everything.

> > I'm also cooking something that should let us build a way to iommu map
> > a bio_vec very efficiently, which should transform this into a single
> > indirect call into the iommu driver per bio_vec, and a single radix
> > walk/etc.
>
> I assume you mean array of bio_vecs here.  That would indeed nice.
> We'd still potentially need a few calls for block drivers as
> requests can have multiple bios and thus bio_vec arrays, but it would
> still be a nice reduction of calls.

Yes. iommufd has performance needs here, not sure what it will turn
into but bio_vec[] direct to optimized radix manipuilation is
something I'd be keen to see.

Jason

