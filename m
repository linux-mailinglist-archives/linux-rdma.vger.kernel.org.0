Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9C29CA2
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391181AbfEXRBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 13:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390532AbfEXRBx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 13:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47BC286663;
        Fri, 24 May 2019 17:01:53 +0000 (UTC)
Received: from redhat.com (ovpn-120-223.rdu2.redhat.com [10.10.120.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F71152F3;
        Fri, 24 May 2019 17:01:52 +0000 (UTC)
Date:   Fri, 24 May 2019 13:01:49 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524170148.GB3346@redhat.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
 <20190524165931.GF16845@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524165931.GF16845@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 24 May 2019 17:01:53 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 01:59:31PM -0300, Jason Gunthorpe wrote:
> On Fri, May 24, 2019 at 12:49:02PM -0400, Jerome Glisse wrote:
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
> 
> That just says the hmm APIs handle locking. I asked how the apis
> implement that locking internally.
> 
> Are you trying to say that if I do this, hmm will still work completely
> correctly?

Yes it will keep working correctly. You would just be doing potentialy
useless work.

> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 8396a65710e304..42977744855d26 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -981,8 +981,8 @@ long hmm_range_snapshot(struct hmm_range *range)
>  
>  	do {
>  		/* If range is no longer valid force retry. */
> -		if (!range->valid)
> -			return -EAGAIN;
> +/*		if (!range->valid)
> +			return -EAGAIN;*/
>  
>  		vma = find_vma(hmm->mm, start);
>  		if (vma == NULL || (vma->vm_flags & device_vma))
> @@ -1080,10 +1080,10 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>  
>  	do {
>  		/* If range is no longer valid force retry. */
> -		if (!range->valid) {
> +/*		if (!range->valid) {
>  			up_read(&hmm->mm->mmap_sem);
>  			return -EAGAIN;
> -		}
> +		}*/
>  
>  		vma = find_vma(hmm->mm, start);
>  		if (vma == NULL || (vma->vm_flags & device_vma))
> @@ -1134,7 +1134,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>  			start = hmm_vma_walk.last;
>  
>  			/* Keep trying while the range is valid. */
> -		} while (ret == -EBUSY && range->valid);
> +		} while (ret == -EBUSY /*&& range->valid*/);
>  
>  		if (ret) {
>  			unsigned long i;
