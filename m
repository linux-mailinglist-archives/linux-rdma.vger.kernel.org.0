Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE23DE90
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfD2JAo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 05:00:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfD2JAm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 05:00:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6CA5AD3A;
        Mon, 29 Apr 2019 09:00:40 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 83A30E0117; Mon, 29 Apr 2019 11:00:40 +0200 (CEST)
Date:   Mon, 29 Apr 2019 11:00:40 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20190429090040.GB21672@unicorn.suse.cz>
References: <20190428115207.GA11924@ziepe.ca>
 <20190429060947.GB3665@osiris>
 <20190429084030.GA4275@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429084030.GA4275@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 08:40:37AM +0000, Jason Gunthorpe wrote:
> On Mon, Apr 29, 2019 at 08:09:47AM +0200, Heiko Carstens wrote:
> > On Sun, Apr 28, 2019 at 11:52:12AM +0000, Jason Gunthorpe wrote:
> > > Hi Linus,
> > > 
> > > Third rc pull request
> > > 
> > > Nothing particularly special here. There is a small merge conflict
> > > with Adrea's mm_still_valid patches which is resolved as below:
> > ...
> > > Jason Gunthorpe (3):
> > >       RDMA/mlx5: Do not allow the user to write to the clock page
> > >       RDMA/mlx5: Use rdma_user_map_io for mapping BAR pages
> > >       RDMA/ucontext: Fix regression with disassociate
> > 
> > This doesn't compile. The patch below would fix it, but not sure if
> > this is what is intended:
> > 
> > drivers/infiniband/core/uverbs_main.c: In function 'rdma_umap_fault':
> > drivers/infiniband/core/uverbs_main.c:898:28: error: 'struct vm_fault' has no member named 'vm_start'
> >    vmf->page = ZERO_PAGE(vmf->vm_start);
> >                             ^~
> > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> > index 7843e89235c3..65fe89b3fa2d 100644
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -895,7 +895,7 @@ static vm_fault_t rdma_umap_fault(struct vm_fault *vmf)
> >  
> >  	/* Read only pages can just use the system zero page. */
> >  	if (!(vmf->vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
> > -		vmf->page = ZERO_PAGE(vmf->vm_start);
> > +		vmf->page = ZERO_PAGE(vmf->vma->vm_start);
> >  		get_page(vmf->page);
> >  		return 0;
> >  	}
> > 
> 
> Thanks Heiko, this looks right to me. 
> 
> I'm surprised to be seeing this at this point, these patches should
> have been seen by 0 day for several days now, and they were in
> linux-next already too..

Most architectures have versions of ZERO_PAGE() which ignore the
argument so that the code builds anyway. I'm not sure if 0-day also
tests s390x builds (which is where I ran into this).

Michal Kubecek
