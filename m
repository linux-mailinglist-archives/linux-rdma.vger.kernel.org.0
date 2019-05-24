Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9428EC6
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 03:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfEXBXY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 21:23:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46579 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfEXBXY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 21:23:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so6251812qtz.13
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ob1haUFm9FIqRuYLZIZ42lM0yuIKUzBg3HV4kFfNrOY=;
        b=KLYYYyhfR7qLmYFT7PD/6mbnTSqoa5EKCxrWbEJljTnUQGQzjmXq0/IE4iv/pV5tD+
         kV90GBjIM2Ex+gNXJsl8+DLghIGsZp0eyO36a7M9uJCwTwz1EDXCTwLzXHv2jqHbWs3b
         mxaFuu0KU/naSa1V4DBVXwbnqPaUZQ9eZb9qTQ9SUqxg1Pd1X6YWj4JNmyLmctFvLjcB
         jOt27076LQFHlY//bHsfmB5Qj7Z20kguVEUwen4NQ6Uxxq10xnVB7JoVwramPLyEO6IZ
         Nu7979o6iWuxKxSllKta16tysjzPYGoaCQsSw0iPpivVUHu3cOXoo2x3QIlb+DkG4KwQ
         Uy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ob1haUFm9FIqRuYLZIZ42lM0yuIKUzBg3HV4kFfNrOY=;
        b=r31IiE8w42tUZmy0UGgBFeGhGXPf9qn4Y+za/XNaJkF8sPLU8xuZCcxvyizkh8V4pw
         3HG4hBXZZ7Rai76Lhkj2LdTh5Nk9gIQ5xllR4qiYgITxdqWLD78alU+hzKZ+Z9doTyVE
         aW/JMRtngRpAHwHuLH6YvSWPHQm+ORRluSXk/gmEzU2ET+/gTqGOK0oSEn8MVh8b1RzQ
         H9+VqEaDKsNrMWezQulO0z8v797Rm4D3wsU1e7Ig+WfVaoLaiK8eX4P8D8Z5PaTvJ3V3
         FGE8DDR7H5pii9M2VIpDIwzzMlTY7V2ysUr/bwSp1YDDSNNZcb2twTaG7TvcOABWHRLe
         xbfw==
X-Gm-Message-State: APjAAAUOXLTkHzDO6lDx5sdpajGuc3qylzyFs+IRQ/PjjvEPM6U2bR3a
        VZoULs1QQO6d0o5Sn81RVZbkkg==
X-Google-Smtp-Source: APXvYqwsxMpcSzONxYLiLCOcNY8OkbIwVOP7XkNW4vjUWReqycLJjAvzE6AKOyHvlwsEdD3dsyM4VA==
X-Received: by 2002:ac8:2bb3:: with SMTP id m48mr30921288qtm.218.1558661002696;
        Thu, 23 May 2019 18:23:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d23sm821597qta.26.2019.05.23.18.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 18:23:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTyvY-0003c5-PL; Thu, 23 May 2019 22:23:20 -0300
Date:   Thu, 23 May 2019 22:23:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 04/11] mm/hmm: Simplify hmm_get_or_create and make it
 reliable
Message-ID: <20190524012320.GA13614@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-5-jgg@ziepe.ca>
 <6945b6c9-338a-54e6-64df-2590d536910a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6945b6c9-338a-54e6-64df-2590d536910a@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 04:38:28PM -0700, Ralph Campbell wrote:
> 
> On 5/23/19 8:34 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > As coded this function can false-fail in various racy situations. Make it
> > reliable by running only under the write side of the mmap_sem and avoiding
> > the false-failing compare/exchange pattern.
> > 
> > Also make the locking very easy to understand by only ever reading or
> > writing mm->hmm while holding the write side of the mmap_sem.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >   mm/hmm.c | 75 ++++++++++++++++++++------------------------------------
> >   1 file changed, 27 insertions(+), 48 deletions(-)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index e27058e92508b9..ec54be54d81135 100644
> > +++ b/mm/hmm.c
> > @@ -40,16 +40,6 @@
> >   #if IS_ENABLED(CONFIG_HMM_MIRROR)
> >   static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
> > -static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
> > -{
> > -	struct hmm *hmm = READ_ONCE(mm->hmm);
> > -
> > -	if (hmm && kref_get_unless_zero(&hmm->kref))
> > -		return hmm;
> > -
> > -	return NULL;
> > -}
> > -
> >   /**
> >    * hmm_get_or_create - register HMM against an mm (HMM internal)
> >    *
> > @@ -64,11 +54,20 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
> >    */
> >   static struct hmm *hmm_get_or_create(struct mm_struct *mm)
> >   {
> > -	struct hmm *hmm = mm_get_hmm(mm);
> > -	bool cleanup = false;
> > +	struct hmm *hmm;
> > -	if (hmm)
> > -		return hmm;
> > +	lockdep_assert_held_exclusive(mm->mmap_sem);
> > +
> > +	if (mm->hmm) {
> > +		if (kref_get_unless_zero(&mm->hmm->kref))
> > +			return mm->hmm;
> > +		/*
> > +		 * The hmm is being freed by some other CPU and is pending a
> > +		 * RCU grace period, but this CPU can NULL now it since we
> > +		 * have the mmap_sem.
> > +		 */
> > +		mm->hmm = NULL;
> 
> Shouldn't there be a "return NULL;" here so it doesn't fall through and
> allocate a struct hmm below?

No, this function should only return NULL on memory allocation
failure.

In this case another thread is busy freeing the hmm but wasn't able to
update mm->hmm to null due to a locking constraint. So we make it null
on behalf of the other thread and allocate a fresh new hmm that is
valid. The freeing thread will complete the free and do nothing with
mm->hmm.

> >   static void hmm_fee_rcu(struct rcu_head *rcu)
> 
> I see Jerome already saw and named this hmm_free_rcu()
> which I agree with.

I do love my typos :)

> >   {
> > +	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
> > +
> > +	down_write(&hmm->mm->mmap_sem);
> > +	if (hmm->mm->hmm == hmm)
> > +		hmm->mm->hmm = NULL;
> > +	up_write(&hmm->mm->mmap_sem);
> > +	mmdrop(hmm->mm);
> > +
> >   	kfree(container_of(rcu, struct hmm, rcu));
> >   }
> >   static void hmm_free(struct kref *kref)
> >   {
> >   	struct hmm *hmm = container_of(kref, struct hmm, kref);
> > -	struct mm_struct *mm = hmm->mm;
> > -
> > -	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
> > -	spin_lock(&mm->page_table_lock);
> > -	if (mm->hmm == hmm)
> > -		mm->hmm = NULL;
> > -	spin_unlock(&mm->page_table_lock);
> > -
> > -	mmdrop(hmm->mm);
> > +	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, hmm->mm);
> >   	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
> >   }
> > 
> 
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.

Ah, you should not send this trailer to the public mailing lists.

Thanks,
Jason
