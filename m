Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B8B27272
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 00:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfEVWmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 18:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEVWmO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 18:42:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E075A30001EB;
        Wed, 22 May 2019 22:42:13 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D720C62660;
        Wed, 22 May 2019 22:42:12 +0000 (UTC)
Date:   Wed, 22 May 2019 18:42:11 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522224211.GF20179@redhat.com>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522201247.GH6054@ziepe.ca>
 <20190522220419.GB20179@redhat.com>
 <20190522223906.GA15389@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522223906.GA15389@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 22 May 2019 22:42:14 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 07:39:06PM -0300, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 06:04:20PM -0400, Jerome Glisse wrote:
> > On Wed, May 22, 2019 at 05:12:47PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > > 
> > > >  static void put_per_mm(struct ib_umem_odp *umem_odp)
> > > >  {
> > > >  	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
> > > > @@ -325,9 +283,10 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
> > > >  	up_write(&per_mm->umem_rwsem);
> > > >  
> > > >  	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
> > > > -	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
> > > > +	hmm_mirror_unregister(&per_mm->mirror);
> > > >  	put_pid(per_mm->tgid);
> > > > -	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
> > > > +
> > > > +	kfree(per_mm);
> > > 
> > > Notice that mmu_notifier only uses SRCU to fence in-progress ops
> > > callbacks, so I think hmm internally has the bug that this ODP
> > > approach prevents.
> > > 
> > > hmm should follow the same pattern ODP has and 'kfree_srcu' the hmm
> > > struct, use container_of in the mmu_notifier callbacks, and use the
> > > otherwise vestigal kref_get_unless_zero() to bail:
> > > 
> > > From 0cb536dc0150ba964a1d655151d7b7a84d0f915a Mon Sep 17 00:00:00 2001
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > Date: Wed, 22 May 2019 16:52:52 -0300
> > > Subject: [PATCH] hmm: Fix use after free with struct hmm in the mmu notifiers
> > > 
> > > mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
> > > system will continue to reference hmm->mn until the srcu grace period
> > > expires.
> > > 
> > >          CPU0                                     CPU1
> > >                                                __mmu_notifier_invalidate_range_start()
> > >                                                  srcu_read_lock
> > >                                                  hlist_for_each ()
> > >                                                    // mn == hmm->mn
> > > hmm_mirror_unregister()
> > >   hmm_put()
> > >     hmm_free()
> > >       mmu_notifier_unregister_no_release()
> > >          hlist_del_init_rcu(hmm-mn->list)
> > > 			                           mn->ops->invalidate_range_start(mn, range);
> > > 					             mm_get_hmm()
> > >       mm->hmm = NULL;
> > >       kfree(hmm)
> > >                                                      mutex_lock(&hmm->lock);
> > > 
> > > Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
> > > existing. Get the now-safe hmm struct through container_of and directly
> > > check kref_get_unless_zero to lock it against free.
> > 
> > It is already badly handled with BUG_ON()
> 
> You can't crash the kernel because userspace forced a race, and no it
> isn't handled today because there is no RCU locking in mm_get_hmm nor
> is there a kfree_rcu for the struct hmm to make the
> kref_get_unless_zero work without use-after-free.
> 
> > i just need to convert those to return and to use
> > mmu_notifier_call_srcu() to free hmm struct.
> 
> Isn't that what this patch does?

Yes but other chunk just need to replace BUG_ON with return

> 
> > The way race is avoided is because mm->hmm will either be NULL or
> > point to another hmm struct before an existing hmm is free. 
> 
> There is no locking on mm->hmm so it is useless to prevent races.

There is locking on mm->hmm

> 
> > Also if range_start/range_end use kref_get_unless_zero() but right
> > now this is BUG_ON if it turn out to be NULL, it should just return
> > on NULL.
> 
> Still needs rcu.
> 
> Also the container_of is necessary to avoid some race where you could
> be doing:
> 
>                   CPU0                                     CPU1                         CPU2
>                                                        hlist_for_each ()
>        mmu_notifier_unregister_no_release(hmm1)             
>        spin_lock(&mm->page_table_lock);                                
>        mm->hmm = NULL
>        spin_unlock(&mm->page_table_lock);                                                                                      
>                                                       				 hmm2 = hmm_get_or_create()
>                                                         mn == hmm1->mn
>                                                         mn->ops->invalidate_range_start(mn, range)
> 							  mm_get_mm() == hmm2
>                                                       hist_for_each con't
>                                                         mn == hmm2->mn
>                                                         mn->ops->invalidate_range_start(mn, range)
> 							  mm_get_mm() == hmm2
> 
> Now we called the same notifier twice on hmm2. Ooops.
> 
> There is no reason to risk this confusion just to avoid container_of.
> 
> So we agree this patch is necessary? Can you test it an ack it please?

A slightly different patch than this one is necessary i will work on
it tomorrow.

Cheers,
Jérôme
