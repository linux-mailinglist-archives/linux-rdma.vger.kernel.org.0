Return-Path: <linux-rdma+bounces-2249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F78BB125
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3497E283985
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB5156C71;
	Fri,  3 May 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TE0zOntu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E76156C60
	for <linux-rdma@vger.kernel.org>; Fri,  3 May 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754564; cv=none; b=sH05cAxBKlrTcARhWj6KeSlfSkxcsw5pE5kT+iNjFgNaGwLJqUCSIdvlbml31Jh44pJvewMvEHTKRPjfn6Y8jvcVdh8N9h8dO//sMHL9/I3vkc1XPYESCIzxvbF7DYvvpZvYolLXY/Uf9M2UMtYJmSSA+weHVQJBasjk9hAlfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754564; c=relaxed/simple;
	bh=yC4oGgKTnqIzx0SwseiUuBVl6ikYuhNImy0LdahK+hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b20XlMiMTL59/qDGhxznsBD5NQKMc0tE2MGTsJPzqshd8fVfBwrNTsD71mHc2hI1rRAaMzoSNLkme/yuf3WLcHcap9xL2XStl4XCRknxGOV1LwFUY0EYEohnRlNFbe3YoRbwl67FzHSdoxXpsoUC4hlfU3GPCGUBcWNPrgCop5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TE0zOntu; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ee2fda66easo3066091a34.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 May 2024 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714754561; x=1715359361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MCkvEl6vfBsR3xGXbm5ipuSQzsyNXlO2daQS9IANas=;
        b=TE0zOntu+3apuUKJVLSWkF78FO0PGQCdxodCLGmkOG0wDvF3GWppAPWCmWBOQEOVP7
         YJ0Awj7odvTnTxD7vMXpoZopROrJtOXzJGabZ2jhSyO+WopjtgVDLsz4G+jXyfSm4UF4
         EiNl9NasSl5dKmhqBeXXbIPT0YdbeujHt75WCQoNJpGi1zArUz2uf+scBJO1IVeny7rA
         7J/LRfVdPcY9Qbl8U/57m+oK1acU2EgPsYIT3f5ACWjsN4eIJbE4Pv3Q5vCn1+YCHw30
         0ZNw1sxQvHLt0Qd4fsCjym+bhijRBVpaf21oauLcQxGy0r/Im7WfZStR2gC6XmaOBkMB
         Cvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714754561; x=1715359361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MCkvEl6vfBsR3xGXbm5ipuSQzsyNXlO2daQS9IANas=;
        b=N5JEwwGIRwt3yXGABRQVXG9P+HdJNGTkP3OAKwpaX7IFQsLUOhHp/nthNQI2gcIS/7
         N9DNa41kHxZNmHv93y2Hv1HqpuVnJd7x+Jt1QklZn/XxnZwt6wlfBp4Mud+Wl8PQhUMW
         Rl+lj6IQOhQVvkDKs+MioS5mKFmFpx4Z8OhR/RAStS0FOwWJ6WNKB8dYEfHahBeb6Dhs
         NEW8AkMo5HRWrBdQwh/usHeY+b3KJiykmm8Do1WqfRrTrPap3kf24dtPCsPAhhMZB+jF
         HGUmsXU6iHtGAaN3EQr1T6W29EefLs6+LvG/fA7WN+Nttzvr97I5Th2E3d/49X3VPJPN
         Id5g==
X-Forwarded-Encrypted: i=1; AJvYcCU6bhEt6tyhQ2JR1yuGSkG9LEDl5un2jiOf5kjQxWsX90c4UXJfTOfDqHDTY5e45N1cYzkk1g40siKUjJDpNQzs7F+4IuwlrvapNA==
X-Gm-Message-State: AOJu0Yx29vLNcQKrAZcknzcTL4kxzX9Mzg4uN0SAGWP9Gzmlu8R1R18v
	TIbSsq6+J9J4j7iOsrANhzKehUoGrNHRDXBiF4IBOMAyaDre3hO9HU8L/5Qsb/0=
X-Google-Smtp-Source: AGHT+IFVT2rAsXVdMpvr8pAPF1WuNA1CE6Xv9L67MOMLKugSh13tMbQmSyNxDuuJNWHb/QOcrYHVYQ==
X-Received: by 2002:a05:6830:33fb:b0:6ee:1cc5:68c3 with SMTP id i27-20020a05683033fb00b006ee1cc568c3mr3499852otu.12.1714754561211;
        Fri, 03 May 2024 09:42:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ca14-20020a056830610e00b006ee5b409f23sm701317otb.22.2024.05.03.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:42:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2vzb-007ETb-4i;
	Fri, 03 May 2024 13:42:39 -0300
Date: Fri, 3 May 2024 13:42:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: "leon@kernel.org" <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240503164239.GB901876@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>

On Thu, May 02, 2024 at 11:32:55PM +0000, Zeng, Oak wrote:

> > Instead of teaching DMA to know these specific datatypes, let's separate
> > existing DMA mapping routine to two steps and give an option to advanced
> > callers (subsystems) perform all calculations internally in advance and
> > map pages later when it is needed.
> 
> I looked into how this scheme can be applied to DRM subsystem and GPU drivers. 
> 
> I figured RDMA can apply this scheme because RDMA can calculate the
> iova size. Per my limited knowledge of rdma, user can register a
> memory region (the reg_user_mr vfunc) and memory region's sized is
> used to pre-allocate iova space. And in the RDMA use case, it seems
> the user registered region can be very big, e.g., 512MiB or even GiB

In RDMA the iova would be linked to the SVA granual we discussed
previously.

> In GPU driver, we have a few use cases where we need dma-mapping. Just name two:
> 
> 1) userptr: it is user malloc'ed/mmap'ed memory and registers to gpu
> (in Intel's driver it is through a vm_bind api, similar to mmap). A
> userptr can be of any random size, depending on user malloc
> size. Today we use dma-map-sg for this use case. The down side of
> our approach is, during userptr invalidation, even if user only
> munmap partially of an userptr, we invalidate the whole userptr from
> gpu page table, because there is no way for us to partially
> dma-unmap the whole sg list. I think we can try your new API in this
> case. The main benefit of the new approach is the partial munmap
> case.

Yes, this is one of the main things it will improve.
 
> We will have to pre-allocate iova for each userptr, and we have many
> userptrs of random size... So we might be not as efficient as RDMA
> case where I assume user register a few big memory regions.

You are already doing this. dma_map_sg() does exactly the same IOVA
allocation under the covers.
 
> 2) system allocator: it is malloc'ed/mmap'ed memory be used for GPU
> program directly, without any other extra driver API call. We call
> this use case system allocator.
 
> For system allocator, driver have no knowledge of which virtual
> address range is valid in advance. So when GPU access a
> malloc'ed/mmap'ed address, we have a page fault. We then look up a
> CPU vma which contains the fault address. I guess we can use the CPU
> vma size to allocate the iova space of the same size?

No. You'd follow what we discussed in the other thread.

If you do a full SVA then you'd split your MM space into granuals and
when a fault hits a granual you'd allocate the IOVA for the whole
granual. RDMA ODP is using a 512M granual currently.

If you are doing sub ranges then you'd probably allocate the IOVA for
the well defined sub range (assuming the typical use case isn't huge)

> But there will be a true difficulty to apply your scheme to this use
> case. It is related to the STICKY flag. As I understand it, the
> sticky flag is designed for driver to mark "this page/pfn has been
> populated, no need to re-populate again", roughly...Unlike userptr
> and RDMA use cases where the backing store of a buffer is always in
> system memory, in the system allocator use case, the backing store
> can be changing b/t system memory and GPU's device private
> memory. Even worse, we have to assume the data migration b/t system
> and GPU is dynamic. When data is migrated to GPU, we don't need
> dma-map. And when migration happens to a pfn with STICKY flag, we
> still need to repopulate this pfn. So you can see, it is not easy to
> apply this scheme to this use case. At least I can't see an obvious
> way.

You are already doing this today, you are keeping the sg list around
until you unmap it.

Instead of keeping the sg list you'd keep a much smaller datastructure
per-granual. The sticky bit is simply a convient way for ODP to manage
the smaller data structure, you don't have to use it.

But you do need to keep track of what pages in the granual have been
DMA mapped - sg list was doing this before. This could be a simple
bitmap array matching the granual size.

Looking (far) forward we may be able to have a "replace" API that
allows installing a new page unconditionally regardless of what is
already there.

Jason

