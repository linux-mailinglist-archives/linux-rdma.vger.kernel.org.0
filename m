Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E8042528
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406734AbfFLMLY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:11:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406690AbfFLMLY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 08:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FtzE4Thitu+oCRZIQWiIw67zmtUw4+rU6GSw0OsJqek=; b=HVzDiOF7tENNW0oMxkkgJMas1
        A3Yn5kiw+tQwG9J5FUng0C7nSST4hyp8v3p18AHc5XwjtR6rAoFHNODTRx/v2fZRrLZlSdXubpHkO
        /yf6f47UsoARpMNaJna9cWEs6OSWNZDLcZhimsZOXGr3+tvZi0GfJTJ669IDU4/XmTMbwDPZkDLos
        LkW4qzLloWsxOYO77T/vfAsa9XmXmdlVIVcnfe/mZHLEYOok7gUbzJbkQhuYCWV6f2BXLYvXNJByE
        49az5xb9jJu4yw8HZj1I9aQBcwOdxtzvM/r1F0DMIfJCPxSuOTX6jM1XJNcjnvOhbZVMk4d/cCXtK
        lQGR+DnYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hb264-0008NQ-37; Wed, 12 Jun 2019 12:11:20 +0000
Date:   Wed, 12 Jun 2019 05:11:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190612121120.GA24966@infradead.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
 <20190608085425.GB32185@infradead.org>
 <20190611194431.GC29375@ziepe.ca>
 <20190612071234.GA20306@infradead.org>
 <20190612114125.GA3876@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612114125.GA3876@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 08:41:25AM -0300, Jason Gunthorpe wrote:
> > I like the idea.  A few nitpicks: Can we avoid having to store the
> > mm in struct mmu_notifier? I think we could just easily pass it as a
> > parameter to the helpers.
> 
> Yes, but I think any driver that needs to use this API will have to
> hold the 'struct mm_struct' and the 'struct mmu_notifier' together (ie
> ODP does this in ib_ucontext_per_mm), so if we put it in the notifier
> then it is trivially available everwhere it is needed, and the
> mmu_notifier code takes care of the lifetime for the driver.

True.  Well, maybe keep it for now at least.

> The entire purpose of the invlock is to avoid getting the write lock
> on mmap_sem as a fast path - if the driver wishes to use mmap_sem
> locking only then it should just do so directly and forget about the
> invlock.

May worry here is that there migh be cases where the driver needs
to expedite the action, in which case jumping straight to the write
lock.  But again we can probably skip this for now and see if it really
ends up being needed.
