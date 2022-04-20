Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FEB508D60
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 18:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380627AbiDTQfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380626AbiDTQfm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 12:35:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0A4475F
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:32:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o18so1351913qtk.7
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xRLmzqJMZzOU3mDlH551IG6h6uzWdyaQhaluamilZXc=;
        b=YYqHKfxcqyTcmog83MVTEUNxrPzFpCALx40XM4h2pY40FgxfWcXQtdDVQWjuJTi3ny
         ooCFeReyJv0Q5skc6CfrpfwDkIWMp5LEuqLos6ZT9PvF4TYoC4AzokR39cWe4iywfErx
         FqGaoAeF2cv3OAD/bKDfiwsZz1abj0QjBBoMDld37/6sOsf1mgjRSHKtccSxqE/eye4E
         nU8qXP3z95sPS46ZDFSugcH6Ly++IEVeyfO+rfUTuIptw+drJW0Yjm3RqBx2XJBuEc/B
         OA69CdpO6yu/6nisdGjitE+ANf4Ta+msjv+ki/8i4qGdx0ME3wvcuv0I6ygUdr+bcBUy
         uNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRLmzqJMZzOU3mDlH551IG6h6uzWdyaQhaluamilZXc=;
        b=57raR8jt9VRUUugduf50druz8Wlqpr3fZhQI4XMf1rJJFemATzv5ap9TjfIsnYq035
         eJQGvWwtgZ0XWlKDomTR476Wne961/MVBGoZH8C00s+5eAgUMayILA+jAyuIps668gcH
         CPO3sqsjIErk3opfNOv92pOpN5VBWDJhuJ4HyIjuta3ehxc7gmVn4wOWids+pmngOeCU
         HTuoGtpvtq0Et9eosozZs5Egjy4TAkXmhgzlCX18x78rZsJsLSV7HfxNI9dvD3H2PbXH
         8KLPvbGN9whm4IXWpzHn8cA6QU3AuIHxJePoOtc2kmYhN8OGEPbLUJkLaH5e5JUsuYqb
         T3XQ==
X-Gm-Message-State: AOAM533RBSfNyA5o7bfT+zksasUaRnUNALTnkoaj2h5IzEvuKB5YhYgL
        77BA8A6JB1NyfTe+GfDNL7Vo2ndlmTuggQ==
X-Google-Smtp-Source: ABdhPJxzvaVb57wHfKfEScQuSueNAAJeFmsRWVZj3DBoxWLJZXxGZ8r3sptIoINdpD2tigqCyVVCBA==
X-Received: by 2002:a05:622a:3cc:b0:2f1:e803:85dd with SMTP id k12-20020a05622a03cc00b002f1e80385ddmr14403898qtx.11.1650472371427;
        Wed, 20 Apr 2022 09:32:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm1691437qkf.101.2022.04.20.09.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:32:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nhDG5-0061KK-L4; Wed, 20 Apr 2022 13:32:49 -0300
Date:   Wed, 20 Apr 2022 13:32:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv5 1/2] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220420163249.GQ64706@ziepe.ca>
References: <20220417024343.568777-1-yanjun.zhu@linux.dev>
 <Yl+rT9tMRDYZwSKD@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+rT9tMRDYZwSKD@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 09:42:23AM +0300, Leon Romanovsky wrote:
> On Sat, Apr 16, 2022 at 10:43:42PM -0400, yanjun.zhu@linux.dev wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > This is a dead lock problem.
> > The ah_pool xa_lock first is acquired in this:
> > 
> > {SOFTIRQ-ON-W} state was registered at:
> > 
> >   lock_acquire+0x1d2/0x5a0
> >   _raw_spin_lock+0x33/0x80
> >   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
> > 
> > Then ah_pool xa_lock is acquired in this:
> > 
> > {IN-SOFTIRQ-W}:
> > 
> > Call Trace:
> >  <TASK>
> >   dump_stack_lvl+0x44/0x57
> >   mark_lock.part.52.cold.79+0x3c/0x46
> >   __lock_acquire+0x1565/0x34a0
> >   lock_acquire+0x1d2/0x5a0
> >   _raw_spin_lock_irqsave+0x42/0x90
> >   rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
> >   rxe_get_av+0x168/0x2a0 [rdma_rxe]
> > </TASK>
> > 
> > From the above, in the function __rxe_add_to_pool,
> > xa_lock is acquired. Then the function __rxe_add_to_pool
> > is interrupted by softirq. The function
> > rxe_pool_get_index will also acquire xa_lock.
> > 
> > Finally, the dead lock appears.
> > 
> > [  296.806097]        CPU0
> > [  296.808550]        ----
> > [  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
> > [  296.814583]   <Interrupt>
> > [  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
> > [  296.820961]
> >                  *** DEADLOCK ***
> > 
> > Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
> > Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > V4->V5: Commit logs are changed to avoid confusion.
> > V3->V4: xa_lock_irq locks are used.
> > V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
> >         GFP_ATOMIC is used in __rxe_add_to_pool.
> > V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
> >  drivers/infiniband/sw/rxe/rxe_pool.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> > index 87066d04ed18..f1f06dc7e64f 100644
> > +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> > @@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
> >  
> >  	atomic_set(&pool->num_elem, 0);
> >  
> > -	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
> > +	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
> >  	pool->limit.min = info->min_index;
> >  	pool->limit.max = info->max_index;
> >  }
> > @@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
> >  	elem->obj = obj;
> >  	kref_init(&elem->ref_cnt);
> >  
> > -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > -			      &pool->next, GFP_KERNEL);
> > +	xa_lock_irq(&pool->xa);
> > +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > +				&pool->next, GFP_KERNEL);
> > +	xa_unlock_irq(&pool->xa);

It should just use xa_alloc_cyclic_irq() and xa_erase_irq(). Don't
open code the lock.

> I may admit that I didn't follow your previous discussions, so maybe you
> already explained it. But why do you need xa_lock_irq() here?

The spinlock type needs to be consistent in all users.

You can only use the naked version if the spinlock is always obtained
from a process context.

You can only use bh version if the spinlock is always obtained from a
process context or bh/softirq

You can always use the irq version

What I don't understand is why IRQ and not BH? AFAIK there is no case
where rxe is called from a real IRQ, right? Or is it because you can't
nest BH under the IRQ spinlock from CM?

Jason
