Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33838A6D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfFGMee (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:34:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41061 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbfFGMee (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 08:34:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so1096121qkk.8
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A2FbqDaOIm85eFPjOPRRz/esCZO+J4vaz7zIDfIOxvA=;
        b=cejnsklTN8gSa78nEyihP29Lx9J/VrusPGqXCyf5Rd+9hsmueFkxF1/YWmjS5sZO9/
         HH7v0sLRxeqlre/3LEQrtuC+ECX1CoDlHi7RjWJwsqX6IeTPRlBpObDM60nJLr+PMIIZ
         uzHsDgz4cQDDPKWcxBmzLfOKqAFg0G5K+NTmL3XYc/xpH9SNkaui88s0XGcmaj3ydsNz
         lFmSis1GsZQ0McoTZeDRJxbCFy9jepSrW5xnowcXy9X8ErbPrOuk0a0CsrL2yro8PtIO
         QOyIHW79VvRsPULJ5mPeQG+Tpqjmic/6xvxDcab8YmZz75UNLwahdhxIcfW61W60/Fm1
         QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A2FbqDaOIm85eFPjOPRRz/esCZO+J4vaz7zIDfIOxvA=;
        b=VFn6ogHTXAdy29hWerHn9QJP6mFb3PGpfjD3y+FuQXsFMfA1e3Ud7IZIF30bCS1tuY
         6+XhGOhs8nzUmF6VcjdzW1LPOIfAQcYHV2pu2S0r3QzzZxJ+uiy5o9wJbr1pCCRvcHgj
         9pPwAbCjjgJduBkFEh1LTlk/9bmR7xPaXKLrSngxYBl0f6cb3i1znsHm+ZWyFSOWSbdb
         7o/Ts47kR4YPRj9qsJlXu1jKIdonxQIJBNXjk23HUg+Np0AlZyBurxkW7RBVU8opZ9RY
         FD3cF5C06Qi1F5Sb/6XoloT3M6M/JliHIomByvAl97V8BJt6UEiy91mEqrhNr9fpWCFQ
         1K+g==
X-Gm-Message-State: APjAAAXGzRlBf8D81PWUcjtJVctOLZ+Xq0JReVXHt1FgivkD8EQbzN2o
        bM4i/bnmTfolJ5IqKR4NGHS+2A==
X-Google-Smtp-Source: APXvYqxt6cvXSe1Vnp7yMI6I6KtFfMUDzTi4iQ4hvnAcaJXl648GbcSmQKXBch+Om0G7zfr9TuWsKw==
X-Received: by 2002:a05:620a:5b0:: with SMTP id q16mr42567473qkq.212.1559910873269;
        Fri, 07 Jun 2019 05:34:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t29sm1505233qtt.42.2019.06.07.05.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:34:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZE4m-00071G-Dh; Fri, 07 Jun 2019 09:34:32 -0300
Date:   Fri, 7 Jun 2019 09:34:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
Message-ID: <20190607123432.GB14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
 <9c72d18d-2924-cb90-ea44-7cd4b10b5bc2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c72d18d-2924-cb90-ea44-7cd4b10b5bc2@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 07:29:08PM -0700, John Hubbard wrote:
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> ...
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 8e7403f081f44a..547002f56a163d 100644
> > +++ b/mm/hmm.c
> ...
> > @@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
> >  		mm->hmm = NULL;
> >  	spin_unlock(&mm->page_table_lock);
> >  
> > -	kfree(hmm);
> > +	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
> 
> 
> It occurred to me to wonder if it is best to use the MMU notifier's
> instance of srcu, instead of creating a separate instance for HMM.

It *has* to be the MMU notifier SRCU because we are synchornizing
against the read side of that SRU inside the mmu notifier code, ie:

int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
        id = srcu_read_lock(&srcu);
        hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
                if (mn->ops->invalidate_range_start) {
                   ^^^^^

Here 'mn' is really hmm (hmm = container_of(mn, struct hmm,
mmu_notifier)), so we must protect the memory against free for the mmu
notifier core.

Thus we have no choice but to use its SRCU.

CH also pointed out a more elegant solution, which is to get the write
side of the mmap_sem during hmm_mirror_unregister - no notifier
callback can be running in this case. Then we delete the kref, srcu
and so forth.

This is much clearer/saner/better, but.. requries the callers of
hmm_mirror_unregister to be safe to get the mmap_sem write side.

I think this is true, so maybe this patch should be switched, what do
you think?

> > @@ -153,10 +158,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
> >  
> >  static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> >  {
> > -	struct hmm *hmm = mm_get_hmm(mm);
> > +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
> >  	struct hmm_mirror *mirror;
> >  	struct hmm_range *range;
> >  
> > +	/* hmm is in progress to free */
> 
> Well, sometimes, yes. :)

It think it is in all cases actually.. The only way we see a 0 kref
and still reach this code path is if another thread has alreay setup
the hmm_free in the call_srcu..

> Maybe this wording is clearer (if we need any comment at all):

I always find this hard.. This is a very standard pattern when working
with RCU - however in my experience few people actually know the RCU
patterns, and missing the _unless_zero is a common bug I find when
looking at code.

This is mm/ so I can drop it, what do you think?

Thanks,
Jason
