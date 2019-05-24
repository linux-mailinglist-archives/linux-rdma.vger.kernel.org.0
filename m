Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE50929E4D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbfEXSqT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 14:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391184AbfEXSqS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 14:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D28230821B3;
        Fri, 24 May 2019 18:46:13 +0000 (UTC)
Received: from redhat.com (ovpn-120-223.rdu2.redhat.com [10.10.120.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 049F11001E6F;
        Fri, 24 May 2019 18:46:10 +0000 (UTC)
Date:   Fri, 24 May 2019 14:46:08 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524184608.GE3346@redhat.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca>
 <20190524170148.GB3346@redhat.com>
 <20190524175203.GG16845@ziepe.ca>
 <20190524180321.GD3346@redhat.com>
 <20190524183225.GI16845@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524183225.GI16845@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 24 May 2019 18:46:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 03:32:25PM -0300, Jason Gunthorpe wrote:
> On Fri, May 24, 2019 at 02:03:22PM -0400, Jerome Glisse wrote:
> > On Fri, May 24, 2019 at 02:52:03PM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 24, 2019 at 01:01:49PM -0400, Jerome Glisse wrote:
> > > > On Fri, May 24, 2019 at 01:59:31PM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, May 24, 2019 at 12:49:02PM -0400, Jerome Glisse wrote:
> > > > > > On Fri, May 24, 2019 at 11:36:49AM -0300, Jason Gunthorpe wrote:
> > > > > > > On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> > > > > > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > > > > > 
> > > > > > > > This patch series arised out of discussions with Jerome when looking at the
> > > > > > > > ODP changes, particularly informed by use after free races we have already
> > > > > > > > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > > > > > > > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > > > > > > 
> > > > > > > So the last big difference with ODP's flow is how 'range->valid'
> > > > > > > works.
> > > > > > > 
> > > > > > > In ODP this was done using the rwsem umem->umem_rwsem which is
> > > > > > > obtained for read in invalidate_start and released in invalidate_end.
> > > > > > > 
> > > > > > > Then any other threads that wish to only work on a umem which is not
> > > > > > > undergoing invalidation will obtain the write side of the lock, and
> > > > > > > within that lock's critical section the virtual address range is known
> > > > > > > to not be invalidating.
> > > > > > > 
> > > > > > > I cannot understand how hmm gets to the same approach. It has
> > > > > > > range->valid, but it is not locked by anything that I can see, so when
> > > > > > > we test it in places like hmm_range_fault it seems useless..
> > > > > > > 
> > > > > > > Jerome, how does this work?
> > > > > > > 
> > > > > > > I have a feeling we should copy the approach from ODP and use an
> > > > > > > actual lock here.
> > > > > > 
> > > > > > range->valid is use as bail early if invalidation is happening in
> > > > > > hmm_range_fault() to avoid doing useless work. The synchronization
> > > > > > is explained in the documentation:
> > > > > 
> > > > > That just says the hmm APIs handle locking. I asked how the apis
> > > > > implement that locking internally.
> > > > > 
> > > > > Are you trying to say that if I do this, hmm will still work completely
> > > > > correctly?
> > > > 
> > > > Yes it will keep working correctly. You would just be doing potentialy
> > > > useless work.
> > > 
> > > I don't see how it works correctly.
> > > 
> > > Apply the comment out patch I showed and this trivially happens:
> > > 
> > >       CPU0                                               CPU1
> > >   hmm_invalidate_start()
> > >     ops->sync_cpu_device_pagetables()
> > >       device_lock()
> > >        // Wipe out page tables in device, enable faulting
> > >       device_unlock()
> > > 
> > >                                                        DEVICE PAGE FAULT
> > >                                                        device_lock()
> > >                                                        hmm_range_register()
> > >                                                        hmm_range_dma_map()
> > >                                                        device_unlock()
> > >   hmm_invalidate_end()
> > 
> > No in the above scenario hmm_range_register() will not mark the range
> > as valid thus the driver will bailout after taking its lock and checking
> > the range->valid value.
> 
> I see your confusion, I only asked about removing valid from hmm.c,
> not the unlocked use of valid in your hmm.rst example. My mistake,
> sorry for being unclear.

No i did understand properly and it is fine to remove all the valid
check within hmm_range_fault() or hmm_range_snapshot() nothing bad
will come out of that.

> 
> Here is the big 3 CPU ladder diagram that shows how 'valid' does not
> work:
> 
>        CPU0                                               CPU1                                          CPU2
>                                                         DEVICE PAGE FAULT
>                                                         range = hmm_range_register()
>
>   // Overlaps with range
>   hmm_invalidate_start()
>     range->valid = false
>     ops->sync_cpu_device_pagetables()
>       take_lock(driver->update);
>        // Wipe out page tables in device, enable faulting
>       release_lock(driver->update);
>                                                                                                    // Does not overlap with range
>                                                                                                    hmm_invalidate_start()
>                                                                                                    hmm_invalidate_end()
>                                                                                                        list_for_each
>                                                                                                            range->valid =  true

                                                                                                             ^
No this can not happen because CPU0 still has invalidate_range in progress and
thus hmm->notifiers > 0 so the hmm_invalidate_range_end() will not set the
range->valid as true.

>
>
>                                                        device_lock()
>                                                        // Note range->valid = true now
>                                                        hmm_range_snapshot(&range);
>                                                        take_lock(driver->update);
>                                                        if (!hmm_range_valid(&range))
>                                                            goto again
>                                                        ESTABLISHE SPTES
>                                                        device_unlock()
>   hmm_invalidate_end()
> 
> 
> And I can make this more complicated (ie overlapping parallel
> invalidates, etc) and show any 'bool' valid cannot work.

It does work. If you want i can remove the range->valid = true from the
hmm_invalidate_range_end() and move it within hmm_range_wait_until_valid()
ie modifying the hmm_range_wait_until_valid() logic, this might look
cleaner.

> > > The mmu notifier spec says:
> > > 
> > >  	 * Invalidation of multiple concurrent ranges may be
> > > 	 * optionally permitted by the driver. Either way the
> > > 	 * establishment of sptes is forbidden in the range passed to
> > > 	 * invalidate_range_begin/end for the whole duration of the
> > > 	 * invalidate_range_begin/end critical section.
> > > 
> > > And I understand "establishment of sptes is forbidden" means
> > > "hmm_range_dmap_map() must fail with EAGAIN". 
> > 
> > No it means that secondary page table entry (SPTE) must not
> > materialize thus what hmm_range_dmap_map() is doing if fine and safe
> > as long as the driver do not use the result to populate the device
> > page table if there was an invalidation for the range.
> 
> Okay, so we agree, if there is an invalidate_start/end critical region
> then it is OK to *call* hmm_range_dmap_map(), however the driver must
> not *use* the result, and you are expecting this bit:
> 
>       take_lock(driver->update);
>       if (!hmm_range_valid(&range)) {
>          goto again
> 
> In your hmm.rst to prevent the pfns from being used by the driver?
> 
> I think the above ladder shows that hmm_range_valid can return true
> during a invalidate_start/end critical region, so this is a problem.
>
> I still think the best solution is to move device_lock() into mirror
> and have hmm manage it for the driver as ODP does. It is certainly the
> simplest solution to understand.

It is un-efficient and would block further than needed forward progress
by mm code.

Cheers,
Jérôme
