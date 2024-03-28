Return-Path: <linux-rdma+bounces-1348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DCC876BC9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 21:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E1D1C216F9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249E55E06D;
	Fri,  8 Mar 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JA++mUN6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1155DF26
	for <linux-rdma@vger.kernel.org>; Fri,  8 Mar 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929426; cv=none; b=MlA9BlOAAcXiA9vZIbQCtpL8bDTWZ52bFE6aX3K6v4qAozT291lAZVTabG90zwsTZBP9rtJ/N5NwuFSrPTQhJ16wG0Z69bwimr/FyxFAKoSwf1Or8Jd5Wv44ipswQ0m94byN8dcJsdelcMuT7hhBW2rdx0mKfsjOVPkvfi9dR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929426; c=relaxed/simple;
	bh=rY0A8eHAZI5cB1A3V08JRigtUPLCemhE15iuR8N+mnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idam/7DfJMbg+iuU1zmHx5FOVrUVb6G6F0mXKObI8ejheCVaoLzQzTL17wkqqlB14tF7AA30xCANSf7BukTInavK4JZUx+1S0wpEgxnws6tPeYN/xiqS0zfEvCYrhqzbFQL8nUF7R7z30GTg+BNNd2YhFiD1HJLSgAzGg2NAvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JA++mUN6; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a1bc321852so787384eaf.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Mar 2024 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709929424; x=1710534224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwAnb64EwkeKmrTREui8emTN6ZYCNogBTHISie/yQU0=;
        b=JA++mUN6qf41+Xed6p4Z+H5PhtGQNIDEvXPgdgaIPFZELSI7wqn38/PePhxy879qVa
         dxvja0Op082DnEjyrhAwgqIGSwEe1Z+iiA76lNBYh7zWqTNBPdJd/EXg21KmLtPdqwWU
         w1JBMNk8sOCzFjKW/t5qyzJ31cKXQri3BrrE2w52j0hnWoz1ZDuTE5reXXgGN44KF6ct
         YvuLwUjssC4rdjcP9SM6lAVDhjlqcQD0DfQ3ugh7PgeY21/eqmaynXx0fy/OS0oA2srm
         rrMAlpE+MeXB7kp7BX2B6EKe7DQosXXKGixCM/qaWs9swVugGCsuRGw4FDmVB+tOcNC6
         E1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709929424; x=1710534224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwAnb64EwkeKmrTREui8emTN6ZYCNogBTHISie/yQU0=;
        b=Vie/nQEc/T2yVe4d+fCKHJQapBwn0cQPnyXsO0RbiTsa6VEAzrP23ernhuW3hWekdW
         DRdWoxSLvWmb399NGQooKBs6FxsRNaXfYCjoDpOTTWmygNtVKiRoowPDtrfopGUlaMUZ
         va9HrikNuPpDC7RO0IN5uEbk49w74TQMLtqp687cfe8T3yMbmD3PpcHR3EcpyKnBtQMr
         XB0mv+MKtpwOzLB+Lrof36SitcRXIpms6ltJIDOciwSpAidGjVdyOwfoYNKRjJp/W8WQ
         mlAqhwKxtl/xQSJefG2oEvgamXPHedMC/IUNgG0bhkog2u5cCy7UrzyPHJ0fMd7I/roO
         rYVg==
X-Forwarded-Encrypted: i=1; AJvYcCULg9F4KZYXUxqCZZ5gHwwNWHiMUokbwdfUEN2gQOXgcvlEGroxb9sMxuX7EqoiiIW+VjGbhdCWz6cpIR6nFh7R6paxBv8zXW1KuQ==
X-Gm-Message-State: AOJu0Yzkq5ni/WJDGCeep6wo3vlQ72xIqWH6Et/88NQ6kCUGHXIcfV1E
	QRQic//MwJ92yufLI6jdg4RQwHt9MT8seVZaQeup6jf71hakRyyi9d+ejWZttfI=
X-Google-Smtp-Source: AGHT+IF/qfykmuaRb5uNoRhqiqioiMWJKv2ds3n4ZiUYzIpQ3ydAyGQZJUUw4tTE2mYtsW4uV3seEQ==
X-Received: by 2002:a4a:311e:0:b0:5a1:c4b6:bb76 with SMTP id k30-20020a4a311e000000b005a1c4b6bb76mr357202ooa.5.1709929424080;
        Fri, 08 Mar 2024 12:23:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830130e00b006e513edb0e3sm18031otq.17.2024.03.08.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:23:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigko-007vqd-D8;
	Fri, 08 Mar 2024 16:23:42 -0400
Date: Fri, 8 Mar 2024 16:23:42 -0400
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
Message-ID: <20240308202342.GZ9225@ziepe.ca>
References: <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
 <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308164920.GA17991@lst.de>

On Fri, Mar 08, 2024 at 05:49:20PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 07, 2024 at 05:01:16PM -0400, Jason Gunthorpe wrote:
> > > 
> > > It's just kinda hard to do.  For aligned IOMMU mapping you'd only
> > > have one dma_addr_t mappings (or maybe a few if P2P regions are
> > > involved), so this probably doesn't matter.  For direct mappings
> > > you'd have a few, but maybe the better answer is to use THP
> > > more aggressively and reduce the number of segments.
> > 
> > Right, those things have all been done. 100GB of huge pages is still
> > using a fair amount of memory for storing dma_addr_t's.
> > 
> > It is hard to do perfectly, but I think it is not so bad if we focus
> > on the direct only case and simple systems that can exclude swiotlb
> > early on.
> 
> Even with direct mappings only we still need to take care of
> cache synchronization.

Yes, we still have to unmap, but the unmap for cache synchronization
doesn't need the dma_addr_t to flush the CPU cache.

> > > If all flows includes multiple non-coalesced regions that just makes
> > > things very complicated, and that's exactly what I'd want to avoid.
> > 
> > I don't see how to avoid it unless we say RDMA shouldn't use this API,
> > which is kind of the whole point from my perspective..
> 
> The DMA API callers really need to know what is P2P or not for
> various reasons.  And they should generally have that information
> available, either from pin_user_pages that needs to special case
> it or from the in-kernel I/O submitter that build it from P2P and
> normal memory.

I think that is a BIO thing. RDMA just calls with FOLL_PCI_P2PDMA and
shoves the resulting page list into in a scattertable. It never checks
if any returned page is P2P - it has no reason to care. dma_map_sg()
does all the work.

That is the kind of abstraction I am coming to this problem with.

You are looking at BIO where you already needed to split things up for
other reasons, but I think that is a uniquely block thing that will
not be shared in other subsystems.

> > If you don't preserve that then we are calling, 4k at a time, a
> > dma_map_page() which is not anywhere close to the same outcome as what
> > dma_map_sg did. I may not get contiguous IOVA, I may not get 3 SGLs,
> > and we call into the IOVA allocator a huge number of times.
> 
> Again, your callers must know what is a P2P region and what is not.

I don't see this at all. We don't do this today in RDMA. There is no
"P2P region".

> > > That's why I really just want 2 cases.  If the caller guarantees the
> > > range is coalescable and there is an IOMMU use the iommu-API like
> > > API, else just iter over map_single/page.
> > 
> > But how does the caller even know if it is coalescable? Other than the
> > trivial case of a single CPU range, that is a complicated detail based
> > on what pages are inside the range combined with the capability of the
> > device doing DMA. I don't see a simple way for the caller to figure
> > this out. You need to sweep every page and collect some information on
> > it. The above is to abstract that detail.
> 
> dma_get_merge_boundary already provides this information in terms
> of the device capabilities.  And given that the callers knows what
> is P2P and what is not we have all the information that is needed.

Encrypted memory too.

RDMA also doesn't call dma_get_merge_boundary(). It doesn't keep track
of P2P regions. It doesn't break out encrypted memory. It has no
purpose to do any of those things.

You fundamentally cannot subdivide a memory registration.

So we could artificially introduce the concept of limited coalescing
into RDMA, dmabuf and others just to drive this new API - but really
that feels much much worse than just making the DMA API still able to
do IOMMU coalescing in more cases.

Even if we did that, it will still be less efficient than today where
we just call dma_map_sg() on the jumble of pages.

Jason

