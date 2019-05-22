Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E802E27267
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEVWjI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 18:39:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfEVWjI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 18:39:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so4481175qtk.6
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UMLE3HAwx27IoVBbcznO88OARo8jwYRssCcya47nG+w=;
        b=HPp1yf7UaNRX/NHm7Qrb6+fAjoR2gcBQuHExLlVFljSVAj6YPgk7u5skIrg1t+Q676
         L+k/DF0Ep78EEOSTSdjakOaul6IT4peNpU0CBpdsaewjQM5qFjASu8RuDwae8Lkm2wgp
         jm8zl83EuwQTP1qNxJMUNJPygZbR1PsHjnGhvWR3dYIyYw2wWZpKRqnHD/TpRw6n0FHS
         3qvSUrjQ6yP/Pp8MSoZIhlXnd+WCyuzsdHTnwA++L7r5QQbNMt2cV3ivlSRvH1X6TNTH
         2E9gAxB/pokrMV8S24PNfis99/Hc+RHOiv9NicXOZ4QkaAU4eZrpIg4BFNPp5GSW+Z44
         b6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UMLE3HAwx27IoVBbcznO88OARo8jwYRssCcya47nG+w=;
        b=ckpmbYKrszkDCj3sFOxz9cp9gIIVsv2wZxag8UiQru0V4+jmMOx3eGyd/pbfxpIagC
         aqxdlsQy6tJqBwgJxx8WX+MFvSCjmwRth1Ha6bZhop2hBEi1l4hsZK3ZzPHdcY4DNb15
         eyTqxrtFpP1OYvOSOknwsQG6/rd2LWBsyh6D/qrzVzz/4LwHL3W+Vd6dDbOZL5qAsHH5
         xPn9BYpEfBiIfR1S4je6HDQV7JAOySBfybg6N4RMozXGkqclpIFE4oWBnHxUlaXepv9T
         BPrW+6hoxYXeqOHmIg/4z2T3dDb7FBcVGURLMhSCUwr+n84GyRuvt74AxaJGV/KT2n9u
         AI3Q==
X-Gm-Message-State: APjAAAXvL2mAEKYlwy3S9SkVQHtPXReChwp+0e6j+ZJBofTk0k+IAYvH
        plO6a3mE6oe0nuUrCKYMzMM4lQ==
X-Google-Smtp-Source: APXvYqxj4GChHyUq+eruEvlXXg5Xkh+OFkyniU+6VTOrc4UcOOoOthn42FnxYVAYbRcTGFHyw0omgw==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr73884142qvf.132.1558564747382;
        Wed, 22 May 2019 15:39:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x3sm14024223qtk.75.2019.05.22.15.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 15:39:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTZt4-00046O-2c; Wed, 22 May 2019 19:39:06 -0300
Date:   Wed, 22 May 2019 19:39:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522223906.GA15389@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522201247.GH6054@ziepe.ca>
 <20190522220419.GB20179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522220419.GB20179@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 06:04:20PM -0400, Jerome Glisse wrote:
> On Wed, May 22, 2019 at 05:12:47PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > 
> > >  static void put_per_mm(struct ib_umem_odp *umem_odp)
> > >  {
> > >  	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
> > > @@ -325,9 +283,10 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
> > >  	up_write(&per_mm->umem_rwsem);
> > >  
> > >  	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
> > > -	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
> > > +	hmm_mirror_unregister(&per_mm->mirror);
> > >  	put_pid(per_mm->tgid);
> > > -	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
> > > +
> > > +	kfree(per_mm);
> > 
> > Notice that mmu_notifier only uses SRCU to fence in-progress ops
> > callbacks, so I think hmm internally has the bug that this ODP
> > approach prevents.
> > 
> > hmm should follow the same pattern ODP has and 'kfree_srcu' the hmm
> > struct, use container_of in the mmu_notifier callbacks, and use the
> > otherwise vestigal kref_get_unless_zero() to bail:
> > 
> > From 0cb536dc0150ba964a1d655151d7b7a84d0f915a Mon Sep 17 00:00:00 2001
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > Date: Wed, 22 May 2019 16:52:52 -0300
> > Subject: [PATCH] hmm: Fix use after free with struct hmm in the mmu notifiers
> > 
> > mmu_notifier_unregister_no_release() is not a fence and the mmu_notifier
> > system will continue to reference hmm->mn until the srcu grace period
> > expires.
> > 
> >          CPU0                                     CPU1
> >                                                __mmu_notifier_invalidate_range_start()
> >                                                  srcu_read_lock
> >                                                  hlist_for_each ()
> >                                                    // mn == hmm->mn
> > hmm_mirror_unregister()
> >   hmm_put()
> >     hmm_free()
> >       mmu_notifier_unregister_no_release()
> >          hlist_del_init_rcu(hmm-mn->list)
> > 			                           mn->ops->invalidate_range_start(mn, range);
> > 					             mm_get_hmm()
> >       mm->hmm = NULL;
> >       kfree(hmm)
> >                                                      mutex_lock(&hmm->lock);
> > 
> > Use SRCU to kfree the hmm memory so that the notifiers can rely on hmm
> > existing. Get the now-safe hmm struct through container_of and directly
> > check kref_get_unless_zero to lock it against free.
> 
> It is already badly handled with BUG_ON()

You can't crash the kernel because userspace forced a race, and no it
isn't handled today because there is no RCU locking in mm_get_hmm nor
is there a kfree_rcu for the struct hmm to make the
kref_get_unless_zero work without use-after-free.

> i just need to convert those to return and to use
> mmu_notifier_call_srcu() to free hmm struct.

Isn't that what this patch does?

> The way race is avoided is because mm->hmm will either be NULL or
> point to another hmm struct before an existing hmm is free. 

There is no locking on mm->hmm so it is useless to prevent races.

> Also if range_start/range_end use kref_get_unless_zero() but right
> now this is BUG_ON if it turn out to be NULL, it should just return
> on NULL.

Still needs rcu.

Also the container_of is necessary to avoid some race where you could
be doing:

                  CPU0                                     CPU1                         CPU2
                                                       hlist_for_each ()
       mmu_notifier_unregister_no_release(hmm1)             
       spin_lock(&mm->page_table_lock);                                
       mm->hmm = NULL
       spin_unlock(&mm->page_table_lock);                                                                                      
                                                      				 hmm2 = hmm_get_or_create()
                                                        mn == hmm1->mn
                                                        mn->ops->invalidate_range_start(mn, range)
							  mm_get_mm() == hmm2
                                                      hist_for_each con't
                                                        mn == hmm2->mn
                                                        mn->ops->invalidate_range_start(mn, range)
							  mm_get_mm() == hmm2

Now we called the same notifier twice on hmm2. Ooops.

There is no reason to risk this confusion just to avoid container_of.

So we agree this patch is necessary? Can you test it an ack it please?

Jason
