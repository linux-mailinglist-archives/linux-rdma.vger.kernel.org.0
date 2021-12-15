Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE84763C3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 21:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhLOUwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 15:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhLOUwL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 15:52:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D95C06173E;
        Wed, 15 Dec 2021 12:52:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b7so19976057edd.6;
        Wed, 15 Dec 2021 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykWVuEkJPX6pUAAxvof1FIo/afOxa44cYEh33Y562v8=;
        b=YH6X+CDp4rJCNysACqkEwJgzIYmUM/WTXgENJMxwdH/QpFhl0QpgmoeL3MULutYgqG
         +ohu3tneuITECHisVjBMK3Aik//5wLq4q9J4/Q/DbPWhyaeqdY8P/zHA7qzmN49sNkWs
         nR3K+H5NI4Mh8R6nAFu4gwX19CbGtlqz2pEQaprXHYu2eFMWBY4zN27OlWAQHaGtcSI3
         Dphem7RchLOQrbflAce+cTPGogccqpJEYqlQ0YxZFgQhnaSeMHi5WBa36UFKCnNA8ZPI
         fojeAfNPl6XauRs3Zr+mVKSrYBt2wC+wxBsIraYlf0L3zABSiOq4zD6gMvE0ZvwMZ4Nr
         q0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykWVuEkJPX6pUAAxvof1FIo/afOxa44cYEh33Y562v8=;
        b=VBQh91adCxI/g5m4vLzkEDNdauBFTAS6/iqThp4mqU0WWV3Md87/Zd5udo40Jidpg6
         bOBbjL6+gwzDhqHVhOjBPTo35uVdGOdwLMwe2SsaKc0ZHBDQg+c9dtOcbfdxpRFqxjKk
         X0L9AWdK+tS7uphg1PJ0XkLXjZ3dQNlc/G2BnD0tv4nAgXq59nOeTMgU9Sx2fRiqgIL0
         xdOmNzEYrC6mEZyb7e9jORLwZF4s88kjSYjSJP6evohMMIT8FBt8u56o6pMeuiKjKET3
         2GVe2gJ8eWk2lp7GO4DrBVOcSjjuu1Jn+E8mzEI5ld+msGmYbedu+JHbcPxPfrrlxAjL
         Tjbw==
X-Gm-Message-State: AOAM530ZgHNqRpXxBqS0aA8CmSERjino9OaB35sDoqGvBbcsJ/Doqt4+
        ZVwptwNb5scU52ldRqHRMAKDqWwfohS9erAl3VE=
X-Google-Smtp-Source: ABdhPJwMIctubBZSGRFLeDH0OE/gyWFLjnj5kRplIzj2r8tet1dkYqI4lhQ3LzMuXiyMtKJwHmUMvGtkhem3RpanpRo=
X-Received: by 2002:a05:6402:d09:: with SMTP id eb9mr16696784edb.216.1639601529688;
 Wed, 15 Dec 2021 12:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20211215111845.2514-1-urezki@gmail.com> <20211215111845.2514-8-urezki@gmail.com>
 <YbpGWpskiByQNcJO@pc638.lan> <20211215194952.GY6385@nvidia.com>
In-Reply-To: <20211215194952.GY6385@nvidia.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 15 Dec 2021 21:51:58 +0100
Message-ID: <CA+KHdyVtaf+Upz=ns9evt5osnHb6LL=+dfsMxPeruEnQUqej1A@mail.gmail.com>
Subject: Re: [PATCH] RDMA/hfi1: Switch to kvfree_rcu() API
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 8:49 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Dec 15, 2021 at 08:47:38PM +0100, Uladzislau Rezki wrote:
> > On Wed, Dec 15, 2021 at 12:18:44PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Instead of invoking a synchronize_rcu() to free a pointer
> > > after a grace period we can directly make use of new API
> > > that does the same but in more efficient way.
> > >
> > > TO: linux-rdma@vger.kernel.org
> > > TO: Jason Gunthorpe <jgg@nvidia.com>
> > > TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > > Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >  drivers/infiniband/hw/hfi1/sdma.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
> > > index f07d328689d3..7264a35e8f4c 100644
> > > +++ b/drivers/infiniband/hw/hfi1/sdma.c
> > > @@ -1292,8 +1292,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
> > >     sdma_map_free(rcu_access_pointer(dd->sdma_map));
> > >     RCU_INIT_POINTER(dd->sdma_map, NULL);
> > >     spin_unlock_irq(&dd->sde_map_lock);
> > > -   synchronize_rcu();
> > > -   kfree(dd->per_sdma);
> > > +   kvfree_rcu(dd->per_sdma);
> > >     dd->per_sdma = NULL;
> > >
> > >     if (dd->sdma_rht) {
> > + linux-rdma@vger.kernel.org
> > + Jason Gunthorpe <jgg@nvidia.com>
> > + Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>
> If it is not in the rdma patchworks it won't get applied..
>
> https://patchwork.kernel.org/project/linux-rdma/list/
>
Do you mean that i should:

Cc: <linux-rdma@vger.kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

instead?

Thanks!

-- 
Uladzislau Rezki
