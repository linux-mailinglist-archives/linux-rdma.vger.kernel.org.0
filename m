Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDED29D82
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 19:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfEXRvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 13:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfEXRvr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 13:51:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 954453086246;
        Fri, 24 May 2019 17:51:46 +0000 (UTC)
Received: from redhat.com (ovpn-120-223.rdu2.redhat.com [10.10.120.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6188E6092D;
        Fri, 24 May 2019 17:51:45 +0000 (UTC)
Date:   Fri, 24 May 2019 13:51:42 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524175142.GC3346@redhat.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <7f82b770-85a3-9b01-48b2-9e458191b8d6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f82b770-85a3-9b01-48b2-9e458191b8d6@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 24 May 2019 17:51:46 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 10:47:16AM -0700, Ralph Campbell wrote:
> 
> On 5/24/19 9:49 AM, Jerome Glisse wrote:
> > On Fri, May 24, 2019 at 11:36:49AM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > > 
> > > > This patch series arised out of discussions with Jerome when looking at the
> > > > ODP changes, particularly informed by use after free races we have already
> > > > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > > > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > > 
> > > So the last big difference with ODP's flow is how 'range->valid'
> > > works.
> > > 
> > > In ODP this was done using the rwsem umem->umem_rwsem which is
> > > obtained for read in invalidate_start and released in invalidate_end.
> > > 
> > > Then any other threads that wish to only work on a umem which is not
> > > undergoing invalidation will obtain the write side of the lock, and
> > > within that lock's critical section the virtual address range is known
> > > to not be invalidating.
> > > 
> > > I cannot understand how hmm gets to the same approach. It has
> > > range->valid, but it is not locked by anything that I can see, so when
> > > we test it in places like hmm_range_fault it seems useless..
> > > 
> > > Jerome, how does this work?
> > > 
> > > I have a feeling we should copy the approach from ODP and use an
> > > actual lock here.
> > 
> > range->valid is use as bail early if invalidation is happening in
> > hmm_range_fault() to avoid doing useless work. The synchronization
> > is explained in the documentation:
> > 
> > 
> > Locking within the sync_cpu_device_pagetables() callback is the most important
> > aspect the driver must respect in order to keep things properly synchronized.
> > The usage pattern is::
> > 
> >   int driver_populate_range(...)
> >   {
> >        struct hmm_range range;
> >        ...
> > 
> >        range.start = ...;
> >        range.end = ...;
> >        range.pfns = ...;
> >        range.flags = ...;
> >        range.values = ...;
> >        range.pfn_shift = ...;
> >        hmm_range_register(&range);
> > 
> >        /*
> >         * Just wait for range to be valid, safe to ignore return value as we
> >         * will use the return value of hmm_range_snapshot() below under the
> >         * mmap_sem to ascertain the validity of the range.
> >         */
> >        hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
> > 
> >   again:
> >        down_read(&mm->mmap_sem);
> >        ret = hmm_range_snapshot(&range);
> >        if (ret) {
> >            up_read(&mm->mmap_sem);
> >            if (ret == -EAGAIN) {
> >              /*
> >               * No need to check hmm_range_wait_until_valid() return value
> >               * on retry we will get proper error with hmm_range_snapshot()
> >               */
> >              hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
> >              goto again;
> >            }
> >            hmm_range_unregister(&range);
> >            return ret;
> >        }
> >        take_lock(driver->update);
> >        if (!hmm_range_valid(&range)) {
> >            release_lock(driver->update);
> >            up_read(&mm->mmap_sem);
> >            goto again;
> >        }
> > 
> >        // Use pfns array content to update device page table
> > 
> >        hmm_range_unregister(&range);
> >        release_lock(driver->update);
> >        up_read(&mm->mmap_sem);
> >        return 0;
> >   }
> > 
> > The driver->update lock is the same lock that the driver takes inside its
> > sync_cpu_device_pagetables() callback. That lock must be held before calling
> > hmm_range_valid() to avoid any race with a concurrent CPU page table update.
> > 
> > 
> > Cheers,
> > Jérôme
> 
> 
> Given the above, the following patch looks necessary to me.
> Also, looking at drivers/gpu/drm/nouveau/nouveau_svm.c, it
> doesn't check the return value to avoid calling up_read(&mm->mmap_sem).
> Besides, it's better to keep the mmap_sem lock/unlock in the caller.

No, nouveau use the old API so check hmm_vma_fault() within hmm.h, i have
patch to convert it to new API for 5.3


> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 836adf613f81..8b6ef97a8d71 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -1092,10 +1092,8 @@ long hmm_range_fault(struct hmm_range *range, bool
> block)
> 
>  	do {
>  		/* If range is no longer valid force retry. */
> -		if (!range->valid) {
> -			up_read(&hmm->mm->mmap_sem);
> +		if (!range->valid)
>  			return -EAGAIN;
> -		}
> 
>  		vma = find_vma(hmm->mm, start);
>  		if (vma == NULL || (vma->vm_flags & device_vma))
> 
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
