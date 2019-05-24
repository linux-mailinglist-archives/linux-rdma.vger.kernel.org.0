Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21129E09
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfEXSc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 14:32:28 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33313 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfEXSc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 14:32:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id y6so6508786vsb.0
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBNyc5CPAmbiINPqRu6KqRyhmB4w6u5PfIg88eslVLU=;
        b=YWqynlFNBAug8jIE3xWfAsUD1mrEFp3uP2s0S6tSFMnUEtHGtcNr3gsx0andO6mBgy
         NW/5KXSlHz7Z4L1yax8bFrA8IGBTqNj43ApkimJyhaKaP/M1VmwshfglfzLWC8IyjhZN
         CAtnN2kKvokGYdJT3osURqKYzm1R2IL3v7GfXs7eRJZR+hPtOIcDzSI2+JdEcyEAP6AX
         GygnQNgyl08CKqZWpSLtDs0zEpPwRcQ8KYZ/XNdt8nyilkepgqI6XDeM6Ye2qOq2/8CF
         kFRdnWgjJ7MEfLX86cxYJAD1A4qCD2E9tx4H+ShKQON8sz0qoahPUTWslPSkwuDzVll8
         wHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBNyc5CPAmbiINPqRu6KqRyhmB4w6u5PfIg88eslVLU=;
        b=VQwQp/AanWupy23TEBWcqJYLwOp9G7DAIW79+F/DAq0F8txiVBRpzUk2yP8kreQtIg
         1hxJkhN4Q5QOvYbnfYwSftgeG8Ty1RPEC5/56G3pQP7xtoqudTH3PYUUeRHnyz8wYpuN
         XI+I9jdFBApkZytxkm245oDMubdbtMUNKVNE5nrhVpXPP5UN9ZbTMKvHHIi5IfnS70D9
         CPrB7RFW059lbRdoMttfWqVo0HiuQnFxknO37lgJ+bGVis4Z2jsw9VpCEjuE0vwB3ak5
         KYO1sNOeGol643WX+urF2b/OYT4HewtutN0PU4c6hunAszZJxgg6wm+QO+fMnAhPcr6i
         3VwA==
X-Gm-Message-State: APjAAAXDEJyttdjXmtxrh22TBOzDnSiCFhT+HQhFmTsch3K7oOrZShkV
        zd+P0wAXyFEy20U747MCocXHmWWN2XQ=
X-Google-Smtp-Source: APXvYqza6sK27lcJnthNOQYY1zw+bnSzJJDiypReLkD4CroSrCQz+RqGyNwe6stEQGandHXFmqNMEg==
X-Received: by 2002:a67:fc51:: with SMTP id p17mr18214640vsq.159.1558722746706;
        Fri, 24 May 2019 11:32:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id e76sm2223442vke.54.2019.05.24.11.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 11:32:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUEzR-0001Jh-IP; Fri, 24 May 2019 15:32:25 -0300
Date:   Fri, 24 May 2019 15:32:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524183225.GI16845@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca>
 <20190524170148.GB3346@redhat.com>
 <20190524175203.GG16845@ziepe.ca>
 <20190524180321.GD3346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524180321.GD3346@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 02:03:22PM -0400, Jerome Glisse wrote:
> On Fri, May 24, 2019 at 02:52:03PM -0300, Jason Gunthorpe wrote:
> > On Fri, May 24, 2019 at 01:01:49PM -0400, Jerome Glisse wrote:
> > > On Fri, May 24, 2019 at 01:59:31PM -0300, Jason Gunthorpe wrote:
> > > > On Fri, May 24, 2019 at 12:49:02PM -0400, Jerome Glisse wrote:
> > > > > On Fri, May 24, 2019 at 11:36:49AM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> > > > > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > > > > 
> > > > > > > This patch series arised out of discussions with Jerome when looking at the
> > > > > > > ODP changes, particularly informed by use after free races we have already
> > > > > > > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > > > > > > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > > > > > 
> > > > > > So the last big difference with ODP's flow is how 'range->valid'
> > > > > > works.
> > > > > > 
> > > > > > In ODP this was done using the rwsem umem->umem_rwsem which is
> > > > > > obtained for read in invalidate_start and released in invalidate_end.
> > > > > > 
> > > > > > Then any other threads that wish to only work on a umem which is not
> > > > > > undergoing invalidation will obtain the write side of the lock, and
> > > > > > within that lock's critical section the virtual address range is known
> > > > > > to not be invalidating.
> > > > > > 
> > > > > > I cannot understand how hmm gets to the same approach. It has
> > > > > > range->valid, but it is not locked by anything that I can see, so when
> > > > > > we test it in places like hmm_range_fault it seems useless..
> > > > > > 
> > > > > > Jerome, how does this work?
> > > > > > 
> > > > > > I have a feeling we should copy the approach from ODP and use an
> > > > > > actual lock here.
> > > > > 
> > > > > range->valid is use as bail early if invalidation is happening in
> > > > > hmm_range_fault() to avoid doing useless work. The synchronization
> > > > > is explained in the documentation:
> > > > 
> > > > That just says the hmm APIs handle locking. I asked how the apis
> > > > implement that locking internally.
> > > > 
> > > > Are you trying to say that if I do this, hmm will still work completely
> > > > correctly?
> > > 
> > > Yes it will keep working correctly. You would just be doing potentialy
> > > useless work.
> > 
> > I don't see how it works correctly.
> > 
> > Apply the comment out patch I showed and this trivially happens:
> > 
> >       CPU0                                               CPU1
> >   hmm_invalidate_start()
> >     ops->sync_cpu_device_pagetables()
> >       device_lock()
> >        // Wipe out page tables in device, enable faulting
> >       device_unlock()
> > 
> >                                                        DEVICE PAGE FAULT
> >                                                        device_lock()
> >                                                        hmm_range_register()
> >                                                        hmm_range_dma_map()
> >                                                        device_unlock()
> >   hmm_invalidate_end()
> 
> No in the above scenario hmm_range_register() will not mark the range
> as valid thus the driver will bailout after taking its lock and checking
> the range->valid value.

I see your confusion, I only asked about removing valid from hmm.c,
not the unlocked use of valid in your hmm.rst example. My mistake,
sorry for being unclear.

Here is the big 3 CPU ladder diagram that shows how 'valid' does not
work:

       CPU0                                               CPU1                                          CPU2
                                                        DEVICE PAGE FAULT
                                                        range = hmm_range_register()

   // Overlaps with range
   hmm_invalidate_start()
     range->valid = false
     ops->sync_cpu_device_pagetables()
       take_lock(driver->update);
        // Wipe out page tables in device, enable faulting
       release_lock(driver->update);
												    // Does not overlap with range
												    hmm_invalidate_start()
												    hmm_invalidate_end()
													list_for_each
													    range->valid =  true


                                                        device_lock()
							// Note range->valid = true now
							hmm_range_snapshot(&range);
							take_lock(driver->update);
							if (!hmm_range_valid(&range))
							    goto again
							ESTABLISHE SPTES
                                                        device_unlock()
   hmm_invalidate_end()

And I can make this more complicated (ie overlapping parallel
invalidates, etc) and show any 'bool' valid cannot work.

> > The mmu notifier spec says:
> > 
> >  	 * Invalidation of multiple concurrent ranges may be
> > 	 * optionally permitted by the driver. Either way the
> > 	 * establishment of sptes is forbidden in the range passed to
> > 	 * invalidate_range_begin/end for the whole duration of the
> > 	 * invalidate_range_begin/end critical section.
> > 
> > And I understand "establishment of sptes is forbidden" means
> > "hmm_range_dmap_map() must fail with EAGAIN". 
> 
> No it means that secondary page table entry (SPTE) must not
> materialize thus what hmm_range_dmap_map() is doing if fine and safe
> as long as the driver do not use the result to populate the device
> page table if there was an invalidation for the range.

Okay, so we agree, if there is an invalidate_start/end critical region
then it is OK to *call* hmm_range_dmap_map(), however the driver must
not *use* the result, and you are expecting this bit:

      take_lock(driver->update);
      if (!hmm_range_valid(&range)) {
         goto again

In your hmm.rst to prevent the pfns from being used by the driver?

I think the above ladder shows that hmm_range_valid can return true
during a invalidate_start/end critical region, so this is a problem.

I still think the best solution is to move device_lock() into mirror
and have hmm manage it for the driver as ODP does. It is certainly the
simplest solution to understand.

Jason
