Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62F9E8E0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0NRY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:17:24 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:42418 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0NRY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 09:17:24 -0400
Received: by mail-qk1-f174.google.com with SMTP id 201so16896732qkm.9
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8nHCwYnmF+HclWSxd4g4w/0isDPpCpar90n6R1UfwA=;
        b=hMLP5g5UQWuTCKleQ1ZzZ3PoILNzua+ClTnvSFUR1rj7zxeE+BUpgAb+Bn7k0JE7d6
         W5aX3a8KgF1SCm3OYTM5lwvcxaeOWAX48oeiSFbrnU1Ov+zq17NotgSR6gHrJeqt+2aQ
         ouF48wv8zYiwMmL6xpHrlm4nX3k6MWNSEC3V6si92CyaoxwvhuDnqkcD53+iLrBV8gSY
         HG1Ows/LAso734CXH6Zj4YIx2Gm73Anx/HqCjOfhauYvXGR39zNFn5pZnGpHeYWIqxHA
         T0iycpvKZATrOyEHjhb2Rqe/LPB4q6E+hu1YBRVR0Vg5bHNojV+ZMZoKRx0BhPxX3ksj
         bUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8nHCwYnmF+HclWSxd4g4w/0isDPpCpar90n6R1UfwA=;
        b=e78A1nW6hQhTvyXynk7sDC1LRk7M1CXA25i4bOuOJBzVEY9d95LNOBUiihLq7HSJFt
         5a38Xmf5DEZWUQijACFCORsnMWBmcTH93IDdPpQeTkSRNmwhPS9pQ/deOu0iShtzTvcH
         6w9qOs9O6yZlYw3oFgDNhX6eT6PK10Gr9HK8oGMDjKiB1lW1o2jrO098DmcDZa/+Nnw/
         NE0eozbWv2zhMsst3QgYEqNv+baVgC//UHM7JByBHtPSyunQy7AkDZlowwc+ohgWhqDw
         8GKczXxVtsCeq0Z+Z+PGEYbpfFKUdW08hrREUrJB0MoEnI8b75bjmjIRgsOY9t6JUyP5
         hdEg==
X-Gm-Message-State: APjAAAXFb77K/Ne4SRj6z72akumFdfTmcSjjnJ2wj977vE0H3LAEnzXI
        wAWeRRr3pXIIyRGZh1E3syIWNw==
X-Google-Smtp-Source: APXvYqwGt3sUFVFtgBxre5149Ux+O9OHlq/WA6gFqDWjsSnMJ7jehv0zhiBuqZujcWdGc1nfg4e53w==
X-Received: by 2002:a05:620a:12e7:: with SMTP id f7mr21696286qkl.471.1566911843580;
        Tue, 27 Aug 2019 06:17:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id q25sm7805990qkm.30.2019.08.27.06.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 06:17:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2bLe-0002LT-HU; Tue, 27 Aug 2019 10:17:22 -0300
Date:   Tue, 27 Aug 2019 10:17:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ib_umem_get and DMA_API_DEBUG question
Message-ID: <20190827131722.GB7149@ziepe.ca>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
 <20190827120011.GA7149@ziepe.ca>
 <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 03:53:29PM +0300, Gal Pressman wrote:
> On 27/08/2019 15:00, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
> >> On 26/08/2019 17:05, Gal Pressman wrote:
> >>> Hi all,
> >>>
> >>> Lately I've been seeing DMA-API call traces on our automated testing runs which
> >>> complain about overlapping mappings of the same cacheline [1].
> >>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
> >>> same address, which as a result DMA maps the same physical addresses more than 7
> >>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
> >>
> >> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
> >> fail as well. I don't have a stable repro for it though.
> >>
> >> Is this a known issue as well? The comment there states it might be a bug in the
> >> DMA API implementation, but I'm not sure.
> >>
> >> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
> > 
> > Maybe we are missing a dma_set_seg_boundary ?
> > 
> > PCI uses low defaults:
> > 
> > 	dma_set_max_seg_size(&dev->dev, 65536);
> > 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
> 
> What would you set it to?

Full 64 bits.

For umem the driver is responsible to chop up the SGL as required, not
the core code.

Jason
