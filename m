Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8026729D83
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfEXRwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 13:52:05 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36648 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfEXRwF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 13:52:05 -0400
Received: by mail-vk1-f195.google.com with SMTP id l199so2377452vke.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+rg9b6r0Ck12KGDIIHf4Mjd6CCd8h8PIMGpeDnJK64=;
        b=VCjAMtvrb+TKSVvfjv/E5qoiSgGpnMPZG3YnUFjIkSTBAWtqQ/ovAahyHASG1biPB1
         8PWpUm1LOHNvc510wWJoI2pq5trdF+7ufxXoUcA4EKPBmCBd+MYTt9FrKRhE0fqaT7bR
         k3jfL6PvxnvESSxl7A/yNdmTyAaYePpuXmc1ArqiP3d+vgxUw35RoVEvZL0QNByBuVDf
         vPW454PtGcprZxs/J+5IXcTvmG4M08BnZ5hEBIrPlXC3TXOJF/XZtAgjJ0MEv5Q6hrz9
         Hw2NrQdkiVFib+YxWloX7LjQ/VLJPO7tfS5z0Q390+7cGnOn1tqsQoQxibD3GbGu5O6o
         wMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+rg9b6r0Ck12KGDIIHf4Mjd6CCd8h8PIMGpeDnJK64=;
        b=rVYXTL9/x844oyfed4Cls3t1/idid/TUa1stEB2zVTMdEVZhR5yiyuSi2vYwmrq34U
         9Fu5OkvlaSuKwg/BURAVGbtk6rWf6qYoeQttx2pnWdXpMQ/l2U5mxuvkBQiOA78b6QJz
         yRtqRaC7y95YZVyvV8dkWZTEZ54k5BsCHJ5kd2ZXRq6GLHCCDvfsPIEKP07WnWjXCncE
         A8tmfn2HIoyAe87J6Vg5TqntYFTL4/PQZa0j9kshKAw/N0+eJYXMXNwSm3qd1Qp2iCyx
         NtZdHABoVZzmGBeSM+70snYSBoXfUPpYIGC2HZdsnrNYPS/KDMinsYSKvPyG42/gMH89
         cFjg==
X-Gm-Message-State: APjAAAVTmKAC+4w4PxKgCoOyjNccwnGKlcZ6KWXVvfU7FSy0piykaBbW
        ZK8+skQMynIudo32cXuefbGV5w==
X-Google-Smtp-Source: APXvYqwMCPgTCNq3GF7Ypgkdwg24jSDdOVt2u6iTnBQLRZ6zlSxp9CQmNF2rPsG9xY7T4Hw/AaYJhA==
X-Received: by 2002:a1f:b44b:: with SMTP id d72mr6596646vkf.29.1558720324467;
        Fri, 24 May 2019 10:52:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 142sm2125089vkp.56.2019.05.24.10.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 10:52:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUEMN-0000yB-HG; Fri, 24 May 2019 14:52:03 -0300
Date:   Fri, 24 May 2019 14:52:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524175203.GG16845@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca>
 <20190524170148.GB3346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524170148.GB3346@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 01:01:49PM -0400, Jerome Glisse wrote:
> On Fri, May 24, 2019 at 01:59:31PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 24, 2019 at 12:49:02PM -0400, Jerome Glisse wrote:
> > > On Fri, May 24, 2019 at 11:36:49AM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> > > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > > 
> > > > > This patch series arised out of discussions with Jerome when looking at the
> > > > > ODP changes, particularly informed by use after free races we have already
> > > > > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > > > > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > > > 
> > > > So the last big difference with ODP's flow is how 'range->valid'
> > > > works.
> > > > 
> > > > In ODP this was done using the rwsem umem->umem_rwsem which is
> > > > obtained for read in invalidate_start and released in invalidate_end.
> > > > 
> > > > Then any other threads that wish to only work on a umem which is not
> > > > undergoing invalidation will obtain the write side of the lock, and
> > > > within that lock's critical section the virtual address range is known
> > > > to not be invalidating.
> > > > 
> > > > I cannot understand how hmm gets to the same approach. It has
> > > > range->valid, but it is not locked by anything that I can see, so when
> > > > we test it in places like hmm_range_fault it seems useless..
> > > > 
> > > > Jerome, how does this work?
> > > > 
> > > > I have a feeling we should copy the approach from ODP and use an
> > > > actual lock here.
> > > 
> > > range->valid is use as bail early if invalidation is happening in
> > > hmm_range_fault() to avoid doing useless work. The synchronization
> > > is explained in the documentation:
> > 
> > That just says the hmm APIs handle locking. I asked how the apis
> > implement that locking internally.
> > 
> > Are you trying to say that if I do this, hmm will still work completely
> > correctly?
> 
> Yes it will keep working correctly. You would just be doing potentialy
> useless work.

I don't see how it works correctly.

Apply the comment out patch I showed and this trivially happens:

      CPU0                                               CPU1
  hmm_invalidate_start()
    ops->sync_cpu_device_pagetables()
      device_lock()
       // Wipe out page tables in device, enable faulting
      device_unlock()

						     DEVICE PAGE FAULT
						       device_lock()
						       hmm_range_register()
                                                       hmm_range_dma_map()
						       device_unlock()
  hmm_invalidate_end()

The mmu notifier spec says:

 	 * Invalidation of multiple concurrent ranges may be
	 * optionally permitted by the driver. Either way the
	 * establishment of sptes is forbidden in the range passed to
	 * invalidate_range_begin/end for the whole duration of the
	 * invalidate_range_begin/end critical section.

And I understand "establishment of sptes is forbidden" means
"hmm_range_dmap_map() must fail with EAGAIN". 

This is why ODP uses an actual lock held across the critical region
which completely prohibits reading the CPU pages tables, or
establishing new mappings.

So, I still think we need a true lock, not a 'maybe valid' flag.

Jason
