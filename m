Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EC29DAE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfEXSD0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 14:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfEXSD0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 14:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D1175F793;
        Fri, 24 May 2019 18:03:25 +0000 (UTC)
Received: from redhat.com (ovpn-120-223.rdu2.redhat.com [10.10.120.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B3CC36FB;
        Fri, 24 May 2019 18:03:24 +0000 (UTC)
Date:   Fri, 24 May 2019 14:03:22 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524180321.GD3346@redhat.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca>
 <20190524170148.GB3346@redhat.com>
 <20190524175203.GG16845@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524175203.GG16845@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 24 May 2019 18:03:25 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 02:52:03PM -0300, Jason Gunthorpe wrote:
> On Fri, May 24, 2019 at 01:01:49PM -0400, Jerome Glisse wrote:
> > On Fri, May 24, 2019 at 01:59:31PM -0300, Jason Gunthorpe wrote:
> > > On Fri, May 24, 2019 at 12:49:02PM -0400, Jerome Glisse wrote:
> > > > On Fri, May 24, 2019 at 11:36:49AM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> > > > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > > > 
> > > > > > This patch series arised out of discussions with Jerome when looking at the
> > > > > > ODP changes, particularly informed by use after free races we have already
> > > > > > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > > > > > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > > > > 
> > > > > So the last big difference with ODP's flow is how 'range->valid'
> > > > > works.
> > > > > 
> > > > > In ODP this was done using the rwsem umem->umem_rwsem which is
> > > > > obtained for read in invalidate_start and released in invalidate_end.
> > > > > 
> > > > > Then any other threads that wish to only work on a umem which is not
> > > > > undergoing invalidation will obtain the write side of the lock, and
> > > > > within that lock's critical section the virtual address range is known
> > > > > to not be invalidating.
> > > > > 
> > > > > I cannot understand how hmm gets to the same approach. It has
> > > > > range->valid, but it is not locked by anything that I can see, so when
> > > > > we test it in places like hmm_range_fault it seems useless..
> > > > > 
> > > > > Jerome, how does this work?
> > > > > 
> > > > > I have a feeling we should copy the approach from ODP and use an
> > > > > actual lock here.
> > > > 
> > > > range->valid is use as bail early if invalidation is happening in
> > > > hmm_range_fault() to avoid doing useless work. The synchronization
> > > > is explained in the documentation:
> > > 
> > > That just says the hmm APIs handle locking. I asked how the apis
> > > implement that locking internally.
> > > 
> > > Are you trying to say that if I do this, hmm will still work completely
> > > correctly?
> > 
> > Yes it will keep working correctly. You would just be doing potentialy
> > useless work.
> 
> I don't see how it works correctly.
> 
> Apply the comment out patch I showed and this trivially happens:
> 
>       CPU0                                               CPU1
>   hmm_invalidate_start()
>     ops->sync_cpu_device_pagetables()
>       device_lock()
>        // Wipe out page tables in device, enable faulting
>       device_unlock()
> 
>                                                        DEVICE PAGE FAULT
>                                                        device_lock()
>                                                        hmm_range_register()
>                                                        hmm_range_dma_map()
>                                                        device_unlock()
>   hmm_invalidate_end()

No in the above scenario hmm_range_register() will not mark the range
as valid thus the driver will bailout after taking its lock and checking
the range->valid value.

> 
> The mmu notifier spec says:
> 
>  	 * Invalidation of multiple concurrent ranges may be
> 	 * optionally permitted by the driver. Either way the
> 	 * establishment of sptes is forbidden in the range passed to
> 	 * invalidate_range_begin/end for the whole duration of the
> 	 * invalidate_range_begin/end critical section.
> 
> And I understand "establishment of sptes is forbidden" means
> "hmm_range_dmap_map() must fail with EAGAIN". 

No it means that secondary page table entry (SPTE) must not materialize
thus what hmm_range_dmap_map() is doing if fine and safe as long as the
driver do not use the result to populate the device page table if there
was an invalidation for the range.

> 
> This is why ODP uses an actual lock held across the critical region
> which completely prohibits reading the CPU pages tables, or
> establishing new mappings.
> 
> So, I still think we need a true lock, not a 'maybe valid' flag.

The rational in HMM is to never block mm so that mm can always make
progress as whatever mm is doing will take precedence and thus it
would be useless to block mm while we do something if what we are
doing is about to become invalid.

Cheers,
Jérôme
