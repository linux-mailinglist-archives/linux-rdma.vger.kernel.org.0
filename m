Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC71841D41
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 09:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405638AbfFLHMj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 03:12:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404821AbfFLHMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 03:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gHyPffJSXLCM57JngMARDMldvmmJZW1qdq4MDpyHoRk=; b=LZFWfvDwFrroFnYyekMIs/UyE
        bnMyL5wiF6a4qOXH5Y6D53f6fcxweVVJulxgbYu1K/IdrKLLafhSvY4xRz/tsyEb1jMuRSPbF8Rnl
        2jgdlWDjFI2AFrwtJTWCwY7ypwwqq20Wfwdyjg6YBYwVPLrqZcVIAuIDcFv3wcwesz87rKWLcwF6Q
        uIyxuROlw9E3tQxn18S6MXz8HOLuV0akpHIPz5eAdK34NQGGATa54Jl7DFM8Z4t77COuq4Y8dcdsL
        IybD7Zm7ngdxABfUQaFBZFD1S2V2tOJ6I6k+Q28wmxvewZONusKYFagqQ8kY+0GS9kfk6C3OEwpSE
        VocdDksgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1haxQw-0000fi-5q; Wed, 12 Jun 2019 07:12:34 +0000
Date:   Wed, 12 Jun 2019 00:12:34 -0700
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
Message-ID: <20190612071234.GA20306@infradead.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
 <20190608085425.GB32185@infradead.org>
 <20190611194431.GC29375@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611194431.GC29375@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 04:44:31PM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2019 at 01:54:25AM -0700, Christoph Hellwig wrote:
> > FYI, I very much disagree with the direction this is moving.
> > 
> > struct hmm_mirror literally is a trivial duplication of the
> > mmu_notifiers.  All these drivers should just use the mmu_notifiers
> > directly for the mirroring part instead of building a thing wrapper
> > that adds nothing but helping to manage the lifetime of struct hmm,
> > which shouldn't exist to start with.
> 
> Christoph: What do you think about this sketch below?
> 
> It would replace the hmm_range/mirror/etc with a different way to
> build the same locking scheme using some optional helpers linked to
> the mmu notifier?
> 
> (just a sketch, still needs a lot more thinking)

I like the idea.  A few nitpicks:  Can we avoid having to store
the mm in struct mmu_notifier?  I think we could just easily pass
it as a parameter to the helpers.  The write lock case of
mm_invlock_start_write_and_lock is probably worth factoring into
separate helper? I can see cases where drivers want to just use
it directly if they need to force getting the lock without the chance
of a long wait.

