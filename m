Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CC271E8
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfEVVth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 17:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbfEVVth (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 17:49:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E276837EEB;
        Wed, 22 May 2019 21:49:22 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CADDF52E7;
        Wed, 22 May 2019 21:49:19 +0000 (UTC)
Date:   Wed, 22 May 2019 17:49:18 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522214917.GA20179@redhat.com>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522192219.GF6054@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522192219.GF6054@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 22 May 2019 21:49:36 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 04:22:19PM -0300, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> 
> > > > +long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
> > > > +			       struct hmm_range *range)
> > > >  {
> > > > +	struct device *device = umem_odp->umem.context->device->dma_device;
> > > > +	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
> > > >  	struct ib_umem *umem = &umem_odp->umem;
> > > > -	struct task_struct *owning_process  = NULL;
> > > > -	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
> > > > -	struct page       **local_page_list = NULL;
> > > > -	u64 page_mask, off;
> > > > -	int j, k, ret = 0, start_idx, npages = 0, page_shift;
> > > > -	unsigned int flags = 0;
> > > > -	phys_addr_t p = 0;
> > > > -
> > > > -	if (access_mask == 0)
> > > > +	struct mm_struct *mm = per_mm->mm;
> > > > +	unsigned long idx, npages;
> > > > +	long ret;
> > > > +
> > > > +	if (mm == NULL)
> > > > +		return -ENOENT;
> > > > +
> > > > +	/* Only drivers with invalidate support can use this function. */
> > > > +	if (!umem->context->invalidate_range)
> > > >  		return -EINVAL;
> > > >  
> > > > -	if (user_virt < ib_umem_start(umem) ||
> > > > -	    user_virt + bcnt > ib_umem_end(umem))
> > > > -		return -EFAULT;
> > > > +	/* Sanity checks. */
> > > > +	if (range->default_flags == 0)
> > > > +		return -EINVAL;
> > > >  
> > > > -	local_page_list = (struct page **)__get_free_page(GFP_KERNEL);
> > > > -	if (!local_page_list)
> > > > -		return -ENOMEM;
> > > > +	if (range->start < ib_umem_start(umem) ||
> > > > +	    range->end > ib_umem_end(umem))
> > > > +		return -EINVAL;
> > > >  
> > > > -	page_shift = umem->page_shift;
> > > > -	page_mask = ~(BIT(page_shift) - 1);
> > > > -	off = user_virt & (~page_mask);
> > > > -	user_virt = user_virt & page_mask;
> > > > -	bcnt += off; /* Charge for the first page offset as well. */
> > > > +	idx = (range->start - ib_umem_start(umem)) >> umem->page_shift;
> > > 
> > > Is this math OK? What is supposed to happen if the range->start is not
> > > page aligned to the internal page size?
> > 
> > range->start is align on 1 << page_shift boundary within pagefault_mr
> > thus the above math is ok. We can add a BUG_ON() and comments if you
> > want.
> 
> OK
> 
> > > > +	range->pfns = &umem_odp->pfns[idx];
> > > > +	range->pfn_shift = ODP_FLAGS_BITS;
> > > > +	range->values = odp_hmm_values;
> > > > +	range->flags = odp_hmm_flags;
> > > >  
> > > >  	/*
> > > > -	 * owning_process is allowed to be NULL, this means somehow the mm is
> > > > -	 * existing beyond the lifetime of the originating process.. Presumably
> > > > -	 * mmget_not_zero will fail in this case.
> > > > +	 * If mm is dying just bail out early without trying to take mmap_sem.
> > > > +	 * Note that this might race with mm destruction but that is fine the
> > > > +	 * is properly refcounted so are all HMM structure.
> > > >  	 */
> > > > -	owning_process = get_pid_task(umem_odp->per_mm->tgid, PIDTYPE_PID);
> > > > -	if (!owning_process || !mmget_not_zero(owning_mm)) {
> > > 
> > > But we are not in a HMM context here, and per_mm is not a HMM
> > > structure. 
> > > 
> > > So why is mm suddenly guarenteed valid? It was a bug report that
> > > triggered the race the mmget_not_zero is fixing, so I need a better
> > > explanation why it is now safe. From what I see the hmm_range_fault
> > > is doing stuff like find_vma without an active mmget??
> > 
> > So the mm struct can not go away as long as we hold a reference on
> > the hmm struct and we hold a reference on it through both hmm_mirror
> > and hmm_range struct. So struct mm can not go away and thus it is
> > safe to try to take its mmap_sem.
> 
> This was always true here, though, so long as the umem_odp exists the
> the mm has a grab on it. But a grab is not a get..
> 
> The point here was the old code needed an mmget() in order to do
> get_user_pages_remote()
> 
> If hmm does not need an external mmget() then fine, we delete this
> stuff and rely on hmm.
> 
> But I don't think that is true as we have:
> 
>           CPU 0                                           CPU1
>                                                        mmput()
>                        				        __mmput()
> 							 exit_mmap()
> down_read(&mm->mmap_sem);
> hmm_range_dma_map(range, device,..
>   ret = hmm_range_fault(range, block);
>      if (hmm->mm == NULL || hmm->dead)
> 							   mmu_notifier_release()
> 							     hmm->dead = true
>      vma = find_vma(hmm->mm, start);
>         .. rb traversal ..                                 while (vma) remove_vma()
> 
> *goes boom*
> 
> I think this is violating the basic constraint of the mm by acting on
> a mm's VMA's without holding a mmget() to prevent concurrent
> destruction.
> 
> In other words, mmput() destruction does not respect the mmap_sem - so
> holding the mmap sem alone is not enough locking.
> 
> The unlucked hmm->dead simply can't save this. Frankly every time I
> look a struct with 'dead' in it, I find races like this.
> 
> Thus we should put the mmget_notzero back in.

So for some reason i thought exit_mmap() was setting the mm_rb
to empty node and flushing vmacache so that find_vma() would
fail. Might have been in some patch that never went upstream.

Note that right before find_vma() there is also range->valid
check which will also intercept mm release.

Anyway the easy fix is to get ref on mm user in range_register.

> 
> I saw some other funky looking stuff in hmm as well..
> 
> > Hence it is safe to take mmap_sem and it is safe to call in hmm, if
> > mm have been kill it will return EFAULT and this will propagate to
> > RDMA.
>  
> > As per_mm i removed the per_mm->mm = NULL from release so that it is
> > always safe to use that field even in face of racing mm "killing".
> 
> Yes, that certainly wasn't good.
> 
> > > > -	 * An array of the pages included in the on-demand paging umem.
> > > > -	 * Indices of pages that are currently not mapped into the device will
> > > > -	 * contain NULL.
> > > > +	 * An array of the pages included in the on-demand paging umem. Indices
> > > > +	 * of pages that are currently not mapped into the device will contain
> > > > +	 * 0.
> > > >  	 */
> > > > -	struct page		**page_list;
> > > > +	uint64_t *pfns;
> > > 
> > > Are these actually pfns, or are they mangled with some shift? (what is range->pfn_shift?)
> > 
> > They are not pfns they have flags (hence range->pfn_shift) at the
> > bottoms i just do not have a better name for this.
> 
> I think you need to have a better name then

Suggestion ? i have no idea for a better name, it has pfn value
in it.

Cheers,
Jérôme
