Return-Path: <linux-rdma+bounces-384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E765F80E497
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 08:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A5F1C21AE1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A016401;
	Tue, 12 Dec 2023 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwQWBbzv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5D15AE2
	for <linux-rdma@vger.kernel.org>; Tue, 12 Dec 2023 07:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75CC433C9;
	Tue, 12 Dec 2023 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702364433;
	bh=hY9xSJJblbAWJZgHacsmi+/6bjhkQNzcCd6xAObVzO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwQWBbzvgGSjltK/FvX5mtoHzBN8xqpKHEGvpvsOg8PDzdfe9PWTN9pG0ljZv4Uev
	 lWf28z4v1VflknmJNAPCctcj1gs/ubZQ/hBPeR/78S6oICkoPcHoOkD6CqM8cjIUq0
	 GsCm0jSZB2VKgYElS6tpWVDx5b0KbNblQRU/pqlqt7kArgsqyqjCCSpYCHIu8pm5ff
	 YTM/VEnPuigfxbDat4ygU7TGyvd0rba11kT9PQv7jXIQugaI57F//PCPMgyMYHCpa5
	 K9P2a2KCIMzO1dZKVw0UevvgZ5K61qiRUqoSCofggGju0Dz6APDoFvD/2sQjWvnrQv
	 TjSo1Eoc7Hnsg==
Date: Tue, 12 Dec 2023 09:00:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Subject: Re: [PATCH 1/2] IB/ipoib: Fix mcast list locking
Message-ID: <20231212070028.GJ4870@unreal>
References: <20231211130426.1500427-1-neelx@redhat.com>
 <20231211130426.1500427-2-neelx@redhat.com>
 <20231211134542.GG4870@unreal>
 <CACjP9X8zarONgO-QLvyzh-w7ax-7Fx0jdBWCF3VFQ09KDcaYnQ@mail.gmail.com>
 <20231211150657.GH4870@unreal>
 <CACjP9X8wxW5jYiXcjg+2oGt7_aoc9KJ_XxKokt06B5d+FY6kEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjP9X8wxW5jYiXcjg+2oGt7_aoc9KJ_XxKokt06B5d+FY6kEQ@mail.gmail.com>

On Mon, Dec 11, 2023 at 05:00:11PM +0100, Daniel Vacek wrote:
> On Mon, Dec 11, 2023 at 4:18 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > What about the following change instead of adding extra lock to already
> > too much complicated IPoIB?
> 
> Yeah, that's the other option should also work I believe. And it
> simplifies the code nicely.
> 
> The allocated mcast_member and mcast_group structures are small enough
> so that slab (by default) should not need more then order 1 block to
> eventually extend/refill the full kmalloc-256 cache. Some arches will
> even use order 0 I believe.
> And unless I'm missing something I do not see any other sleeps in that path.
> 
> That said, as long as you are fine with occasional failures under
> memory pressure, it looks OK to me.

Yes, IMHO change from GFP_KERNEL to be GFP_ATOMIC is safer than adding extra lock.

Thanks

> 
> --nX
> 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > index 5b3154503bf4..bca80fe07584 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > @@ -531,21 +531,17 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
> >                 if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags))
> >                         rec.join_state = SENDONLY_FULLMEMBER_JOIN;
> >         }
> > -       spin_unlock_irq(&priv->lock);
> >
> >         multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
> > -                                        &rec, comp_mask, GFP_KERNEL,
> > +                                        &rec, comp_mask, GFP_ATOMIC,
> >                                          ipoib_mcast_join_complete, mcast);
> > -       spin_lock_irq(&priv->lock);
> >         if (IS_ERR(multicast)) {
> >                 ret = PTR_ERR(multicast);
> >                 ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
> >                 /* Requeue this join task with a backoff delay */
> >                 __ipoib_mcast_schedule_join_thread(priv, mcast, 1);
> >                 clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
> > -               spin_unlock_irq(&priv->lock);
> >                 complete(&mcast->done);
> > -               spin_lock_irq(&priv->lock);
> >         }
> >         return 0;
> >  }
> >
> >
> > >
> > > --nX
> > >
> > >
> > > > Thanks
> > > >
> > > > > Unfortunately we could not reproduce the lockup and confirm this fix but
> > > > > based on the code review I think this fix should address such lockups.
> > > > >
> > > > > crash> bc 31
> > > > > PID: 747      TASK: ff1c6a1a007e8000  CPU: 31   COMMAND: "kworker/u72:2"
> > > > > --
> > > > >     [exception RIP: ipoib_mcast_join_task+0x1b1]
> > > > >     RIP: ffffffffc0944ac1  RSP: ff646f199a8c7e00  RFLAGS: 00000002
> > > > >     RAX: 0000000000000000  RBX: ff1c6a1a04dc82f8  RCX: 0000000000000000
> > > > >                                   work (&priv->mcast_task{,.work})
> > > > >     RDX: ff1c6a192d60ac68  RSI: 0000000000000286  RDI: ff1c6a1a04dc8000
> > > > >            &mcast->list
> > > > >     RBP: ff646f199a8c7e90   R8: ff1c699980019420   R9: ff1c6a1920c9a000
> > > > >     R10: ff646f199a8c7e00  R11: ff1c6a191a7d9800  R12: ff1c6a192d60ac00
> > > > >                                                          mcast
> > > > >     R13: ff1c6a1d82200000  R14: ff1c6a1a04dc8000  R15: ff1c6a1a04dc82d8
> > > > >            dev                    priv (&priv->lock)     &priv->multicast_list (aka head)
> > > > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > > > > --- <NMI exception stack> ---
> > > > >  #5 [ff646f199a8c7e00] ipoib_mcast_join_task+0x1b1 at ffffffffc0944ac1 [ib_ipoib]
> > > > >  #6 [ff646f199a8c7e98] process_one_work+0x1a7 at ffffffff9bf10967
> > > > >
> > > > > crash> rx ff646f199a8c7e68
> > > > > ff646f199a8c7e68:  ff1c6a1a04dc82f8 <<< work = &priv->mcast_task.work
> > > > >
> > > > > crash> list -hO ipoib_dev_priv.multicast_list ff1c6a1a04dc8000
> > > > > (empty)
> > > > >
> > > > > crash> ipoib_dev_priv.mcast_task.work.func,mcast_mutex.owner.counter ff1c6a1a04dc8000
> > > > >   mcast_task.work.func = 0xffffffffc0944910 <ipoib_mcast_join_task>,
> > > > >   mcast_mutex.owner.counter = 0xff1c69998efec000
> > > > >
> > > > > crash> b 8
> > > > > PID: 8        TASK: ff1c69998efec000  CPU: 33   COMMAND: "kworker/u72:0"
> > > > > --
> > > > >  #3 [ff646f1980153d50] wait_for_completion+0x96 at ffffffff9c7d7646
> > > > >  #4 [ff646f1980153d90] ipoib_mcast_remove_list+0x56 at ffffffffc0944dc6 [ib_ipoib]
> > > > >  #5 [ff646f1980153de8] ipoib_mcast_dev_flush+0x1a7 at ffffffffc09455a7 [ib_ipoib]
> > > > >  #6 [ff646f1980153e58] __ipoib_ib_dev_flush+0x1a4 at ffffffffc09431a4 [ib_ipoib]
> > > > >  #7 [ff646f1980153e98] process_one_work+0x1a7 at ffffffff9bf10967
> > > > >
> > > > > crash> rx ff646f1980153e68
> > > > > ff646f1980153e68:  ff1c6a1a04dc83f0 <<< work = &priv->flush_light
> > > > >
> > > > > crash> ipoib_dev_priv.flush_light.func,broadcast ff1c6a1a04dc8000
> > > > >   flush_light.func = 0xffffffffc0943820 <ipoib_ib_dev_flush_light>,
> > > > >   broadcast = 0x0,
> > > > >
> > > > > The mcast(s) on the &remove_list (the remaining part of the ex &priv->multicast_list):
> > > > >
> > > > > crash> list -s ipoib_mcast.done.done ipoib_mcast.list -H ff646f1980153e10 | paste - -
> > > > > ff1c6a192bd0c200        done.done = 0x0,
> > > > > ff1c6a192d60ac00        done.done = 0x0,
> > > > >
> > > > > Reported-by: Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
> > > > > Signed-off-by: Daniel Vacek <neelx@redhat.com>
> > > > > ---
> > > > >  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > > > index 5b3154503bf4..8e4f2c8839be 100644
> > > > > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > > > @@ -580,6 +580,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
> > > > >       }
> > > > >       netif_addr_unlock_bh(dev);
> > > > >
> > > > > +     mutex_lock(&priv->mcast_mutex);
> > > > >       spin_lock_irq(&priv->lock);
> > > > >       if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
> > > > >               goto out;
> > > > > @@ -634,6 +635,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
> > > > >                               /* Found the next unjoined group */
> > > > >                               if (ipoib_mcast_join(dev, mcast)) {
> > > > >                                       spin_unlock_irq(&priv->lock);
> > > > > +                                     mutex_unlock(&priv->mcast_mutex);
> > > > >                                       return;
> > > > >                               }
> > > > >                       } else if (!delay_until ||
> > > > > @@ -655,6 +657,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
> > > > >               ipoib_mcast_join(dev, mcast);
> > > > >
> > > > >       spin_unlock_irq(&priv->lock);
> > > > > +     mutex_unlock(&priv->mcast_mutex);
> > > > >  }
> > > > >
> > > > >  void ipoib_mcast_start_thread(struct net_device *dev)
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > >
> >
> 

