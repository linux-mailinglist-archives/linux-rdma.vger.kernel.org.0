Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3059E99A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfH0NhY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:37:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44746 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0NhW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 09:37:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id y22so1072449qkb.11
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4F+jyMe7x0DrmScryO4CRPVX00mde3Nov6/+ivhb0gs=;
        b=cMxk6RUoI9W95sWCXowsIPZRvVJkBQfAyZHR/eRbwvn4gwN8EDikyucD8YM/KOLQ04
         MWZLbwV2BgZd+HoCKEhCn0ucD0A3Od8bhSnum0eb4HEEoR9qpva5wA0cqFN+ZxVMuzRo
         Ogl3hsYUMNJUnpCwBHxQLUK+dk2iTDMChtF+43aQQwHvmXhS3LHjZv0r4PD6fq/QE5Ve
         D8CXc5FDcEj2tgNgbneqwEJ3edpERoUw//aYF8ojumxtPXLl1NPo4rySd0ZZtefYR9MG
         EMyfXcJvmQZ8rIFEoTLYjNFff8hktU3bllVoxmSny4SaLfXL0SQACy4Cuzrxte34OeaX
         AjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4F+jyMe7x0DrmScryO4CRPVX00mde3Nov6/+ivhb0gs=;
        b=idV1yFw1qdgK3opwU45jREAAsf/WkAsgOtuLjhYw4YvYjEj8CIbj2DRrfz3E/Y8+Pw
         pffYlhfy3DAgRduYkAbbglvP/0tQ/LF5d+JtsD/jkAM5ip85DByo+D8JUvpiEs5Qy0OU
         g1ZuFVk9tjC1ScyUJuDVdG7t0vcp55Pp5gHm6mFM4xA/fNxpXNxEww2dvwKMeGb7kWAu
         RMNa7bMS2QgcQs4Vrcb9iViSCNLEg9+Dcub6G/sL78ZilapeW0ANsMEqv/yeorLOrqve
         Cx54lbgLKB8T5hwvr18Eo1Yqm72IsfKW76K0H7AVMPOGIcGZZEcqacqj0q9E/nE+nJRL
         C/Fg==
X-Gm-Message-State: APjAAAWgBVa7jgX61ipfVdTlBY0nt5rFz41BG4+Tz8zJe8Bm64eFwjtp
        MkcaGoEZX/jmdkzJ661EpVuakg==
X-Google-Smtp-Source: APXvYqzQHxtlfKXq5Cj7nUZqhTCednETfEMPtjoSYA63JnWoNEMqLYWpjt1uR6pZwrKsHNJbnsVROQ==
X-Received: by 2002:ae9:f101:: with SMTP id k1mr21248183qkg.193.1566913040962;
        Tue, 27 Aug 2019 06:37:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id h13sm8124634qkk.12.2019.08.27.06.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 06:37:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2bey-0002XU-06; Tue, 27 Aug 2019 10:37:20 -0300
Date:   Tue, 27 Aug 2019 10:37:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ib_umem_get and DMA_API_DEBUG question
Message-ID: <20190827133719.GC7149@ziepe.ca>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
 <20190827120011.GA7149@ziepe.ca>
 <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
 <20190827131722.GB7149@ziepe.ca>
 <53d882a0-8f2b-802e-b985-5a85419ccecd@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d882a0-8f2b-802e-b985-5a85419ccecd@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 04:22:51PM +0300, Gal Pressman wrote:
> On 27/08/2019 16:17, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2019 at 03:53:29PM +0300, Gal Pressman wrote:
> >> On 27/08/2019 15:00, Jason Gunthorpe wrote:
> >>> On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
> >>>> On 26/08/2019 17:05, Gal Pressman wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> Lately I've been seeing DMA-API call traces on our automated testing runs which
> >>>>> complain about overlapping mappings of the same cacheline [1].
> >>>>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
> >>>>> same address, which as a result DMA maps the same physical addresses more than 7
> >>>>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
> >>>>
> >>>> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
> >>>> fail as well. I don't have a stable repro for it though.
> >>>>
> >>>> Is this a known issue as well? The comment there states it might be a bug in the
> >>>> DMA API implementation, but I'm not sure.
> >>>>
> >>>> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
> >>>
> >>> Maybe we are missing a dma_set_seg_boundary ?
> >>>
> >>> PCI uses low defaults:
> >>>
> >>> 	dma_set_max_seg_size(&dev->dev, 65536);
> >>> 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
> >>
> >> What would you set it to?
> > 
> > Full 64 bits.
> > 
> > For umem the driver is responsible to chop up the SGL as required, not
> > the core code.
> 
> But wouldn't this possibly hide driver bugs? Perhaps even in other flows?

The block stack also uses this information, I've been meaning to check
if we should use dma_attrs in umem so we can have different
parameters.

I'm not aware of any issue with the 32 bit boundary on RDMA devices..

Jason
