Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C752720E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 00:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEVWGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 18:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfEVWGw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 18:06:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 430608553D;
        Wed, 22 May 2019 22:06:52 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DC6218205;
        Wed, 22 May 2019 22:06:51 +0000 (UTC)
Date:   Wed, 22 May 2019 18:06:49 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522220649.GC20179@redhat.com>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522201247.GH6054@ziepe.ca>
 <05e7f491-b8a4-4214-ab75-9ecf1128aaa6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e7f491-b8a4-4214-ab75-9ecf1128aaa6@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 22 May 2019 22:06:52 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 02:12:31PM -0700, Ralph Campbell wrote:
> 
> On 5/22/19 1:12 PM, Jason Gunthorpe wrote:
> > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > 
> > >   static void put_per_mm(struct ib_umem_odp *umem_odp)
> > >   {
> > >   	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
> > > @@ -325,9 +283,10 @@ static void put_per_mm(struct ib_umem_odp *umem_odp)
> > >   	up_write(&per_mm->umem_rwsem);
> > >   	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
> > > -	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
> > > +	hmm_mirror_unregister(&per_mm->mirror);
> > >   	put_pid(per_mm->tgid);
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
> 
> You might also want to look at my patch where
> I try to fix some of these same issues (5/5).
> 
> https://marc.info/?l=linux-mm&m=155718572908765&w=2

I need to review the patchset but i do not want to invert referencing
ie having mm hold reference on hmm. Will review tommorrow. I wanted to
do that today but did not had time.

