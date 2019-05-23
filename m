Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8128C02
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfEWU7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 16:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731488AbfEWU7x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 16:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF2523082E3F;
        Thu, 23 May 2019 20:59:49 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E799B66084;
        Thu, 23 May 2019 20:59:47 +0000 (UTC)
Date:   Thu, 23 May 2019 16:59:46 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190523205945.GA4170@redhat.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <6ee88cde-5365-9bbc-6c4d-7459d5c3ebe2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ee88cde-5365-9bbc-6c4d-7459d5c3ebe2@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 23 May 2019 20:59:53 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:04:16PM -0700, John Hubbard wrote:
> On 5/23/19 8:34 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > This patch series arised out of discussions with Jerome when looking at the
> > ODP changes, particularly informed by use after free races we have already
> > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > 
> > Overall this brings in a simplified locking scheme and easy to explain
> > lifetime model:
> > 
> >   If a hmm_range is valid, then the hmm is valid, if a hmm is valid then the mm
> >   is allocated memory.
> > 
> >   If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, etc)
> >   then the mmget must be obtained via mmget_not_zero().
> > 
> > Locking of mm->hmm is shifted to use the mmap_sem consistently for all
> > read/write and unlocked accesses are removed.
> > 
> > The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
> > standard mmget() locking to prevent the mm from being released. Many of the
> > debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
> > which is much clearer as to the lifetime intent.
> > 
> > The trailing patches are just some random cleanups I noticed when reviewing
> > this code.
> > 
> > I expect Jerome & Ralph will have some design notes so this is just RFC, and
> > it still needs a matching edit to nouveau. It is only compile tested.
> > 
> 
> Thanks so much for doing this. Jerome has already absorbed these into his
> hmm-5.3 branch, along with Ralph's other fixes, so we can start testing,
> as well as reviewing, the whole set. We'll have feedback soon.
> 

I force pushed an updated branch with couple fix

https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.3

Seems to work ok so far, still doing testing.

Cheers,
Jérôme
