Return-Path: <linux-rdma+bounces-358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B991F80CE50
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73800281CC9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86ED487BC;
	Mon, 11 Dec 2023 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1mY8OMM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B381A3
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702304780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnVWnfgDWlNIvaTnQGAKn3Bh79PthC+vFqsZ7u+oMf4=;
	b=A1mY8OMMRBJTUKTy33RfTKC9SFOSoIc0TyTvXQikpFf6uqaRaVt7fJO5bcgdgqXylAbHcu
	DwUWL3QRWfVG0nyoF4hd9EuDd9vlxKWCsF1B1CAl2AvzapegKF1aWivRF8xpsJUmuCgY47
	BuUfSsCrJc641s592P08q0SzezluaD4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-Z1beNDiiO1yzcjg0xiOVzw-1; Mon, 11 Dec 2023 09:26:17 -0500
X-MC-Unique: Z1beNDiiO1yzcjg0xiOVzw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2868fb54e3eso5434507a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 06:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304776; x=1702909576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnVWnfgDWlNIvaTnQGAKn3Bh79PthC+vFqsZ7u+oMf4=;
        b=akQ9k6nAsCV+2T5D2UhhtK544zuNcIFMowk5Q7P9t1+ziva+pbl+MSxf6ocp+KKOJo
         1eH6wR/NKTLJRtbM+wnLaoakooTR8HTYKfh4LEdptfa1GsZyhY9Fo14FOv9FWC5+a2UD
         XAVEsWgCvO5J6ZxyuUWDdtcYeymjq7VAxXFUdC1rNLv/hK46q67lmhs9rJPOEiZXTxke
         8D0QRPZUqq94J8W8gmkNqJDLYqNWdK/R6PEDoPTtVw0hi+To1k7vrB2aO5SKC1627cbc
         NqPDR1FjkzP7Ndwpgu4E8yHnQgw9LhwW3bozzJM2r61zago3x13cni5TyuXiJ4I7PVdq
         2y2g==
X-Gm-Message-State: AOJu0YzUJzyeywFKYHmDS/pOCmVyKXaef4E5LKAcSXpXIxuW1XYF/3B5
	uB1Zgez+Y9bBq3ZlnLJVQNaJAOqT7nG33HK+EuKEcU15JrS97Ld02EooZDyVnWtDQ1y+3JkBD0A
	GdZxG87d/W0fjY5DbZMswDvUaw/GDAFXCGk1Lxw==
X-Received: by 2002:a17:90b:46c8:b0:286:b46e:b749 with SMTP id jx8-20020a17090b46c800b00286b46eb749mr3279127pjb.48.1702304776152;
        Mon, 11 Dec 2023 06:26:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRnx1L3UxwGpcJj3W5vld8cCQ9/lD+wWIpH0jT69gQNc9vz0wASTpXBtmviP6JvVqIF+XD9GpjfogGudKKZwQ=
X-Received: by 2002:a17:90b:46c8:b0:286:b46e:b749 with SMTP id
 jx8-20020a17090b46c800b00286b46eb749mr3279117pjb.48.1702304775795; Mon, 11
 Dec 2023 06:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211130426.1500427-1-neelx@redhat.com> <20231211130426.1500427-2-neelx@redhat.com>
 <20231211134542.GG4870@unreal>
In-Reply-To: <20231211134542.GG4870@unreal>
From: Daniel Vacek <neelx@redhat.com>
Date: Mon, 11 Dec 2023 15:25:39 +0100
Message-ID: <CACjP9X8zarONgO-QLvyzh-w7ax-7Fx0jdBWCF3VFQ09KDcaYnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] IB/ipoib: Fix mcast list locking
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 2:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Dec 11, 2023 at 02:04:24PM +0100, Daniel Vacek wrote:
> > We need an additional protection against list removal between ipoib_mca=
st_join_task()
> > and ipoib_mcast_dev_flush() in case the &priv->lock needs to be dropped=
 while
> > iterating the &priv->multicast_list in ipoib_mcast_join_task(). If the =
mcast
> > is removed while the lock was dropped, the for loop spins forever resul=
ting
> > in a hard lockup (as was reported on RHEL 4.18.0-372.75.1.el8_6 kernel)=
:
> >
> >     Task A (kworker/u72:2 below)       | Task B (kworker/u72:0 below)
> >     -----------------------------------+-------------------------------=
----
> >     ipoib_mcast_join_task(work)        | ipoib_ib_dev_flush_light(work)
> >       spin_lock_irq(&priv->lock)       | __ipoib_ib_dev_flush(priv, ...=
)
> >       list_for_each_entry(mcast,       | ipoib_mcast_dev_flush(dev =3D =
priv->dev)
> >           &priv->multicast_list, list) |   mutex_lock(&priv->mcast_mute=
x)
> >         ipoib_mcast_join(dev, mcast)   |
> >           spin_unlock_irq(&priv->lock) |
> >                                        |   spin_lock_irqsave(&priv->loc=
k, flags)
> >                                        |   list_for_each_entry_safe(mca=
st, tmcast,
> >                                        |                  &priv->multic=
ast_list, list)
> >                                        |     list_del(&mcast->list);
> >                                        |     list_add_tail(&mcast->list=
, &remove_list)
> >                                        |   spin_unlock_irqrestore(&priv=
->lock, flags)
> >           spin_lock_irq(&priv->lock)   |
> >                                        |   ipoib_mcast_remove_list(&rem=
ove_list)
> >    (Here, mcast is no longer on the    |     list_for_each_entry_safe(m=
cast, tmcast,
> >     &priv->multicast_list and we keep  |                            rem=
ove_list, list)
> >     spinning on the &remove_list of the \ >>>  wait_for_completion(&mca=
st->done)
> >     other thread which is blocked and the|
> >     list is still valid on it's stack.)  | mutex_unlock(&priv->mcast_mu=
tex)
> >
> > Fix this by adding mutex_lock(&priv->mcast_mutex) to ipoib_mcast_join_t=
ask().
>
> I don't entirely understand the issue and the proposed solution.
> There is only one spin_unlock_irq() in the middle of list_for_each_entry(=
mcast, &priv->multicast_list, list)
> and it is right before return statement which will break the loop. So
> how will loop spin forever?

There's another unlock/lock pair around ib_sa_join_multicast() call in
ipoib_mcast_join() no matter the outcome of the condition. The
ib_sa_join_multicast() cannot be called with the lock being held due
to GFP_KERNEL allocation can possibly sleep. That's what's causing the
issue.

Actually if you check the code, only if the mentioned condition is
false (and the loop is not broken and returned from
ipoib_mcast_join_task()) the lock is released and re-acquired,
creating the window for
ipoib_ib_dev_flush_light()/ipoib_mcast_dev_flush() to break the list.
The vmcore data shows/confirms that clearly.

--nX


> Thanks
>
> > Unfortunately we could not reproduce the lockup and confirm this fix bu=
t
> > based on the code review I think this fix should address such lockups.
> >
> > crash> bc 31
> > PID: 747      TASK: ff1c6a1a007e8000  CPU: 31   COMMAND: "kworker/u72:2=
"
> > --
> >     [exception RIP: ipoib_mcast_join_task+0x1b1]
> >     RIP: ffffffffc0944ac1  RSP: ff646f199a8c7e00  RFLAGS: 00000002
> >     RAX: 0000000000000000  RBX: ff1c6a1a04dc82f8  RCX: 0000000000000000
> >                                   work (&priv->mcast_task{,.work})
> >     RDX: ff1c6a192d60ac68  RSI: 0000000000000286  RDI: ff1c6a1a04dc8000
> >            &mcast->list
> >     RBP: ff646f199a8c7e90   R8: ff1c699980019420   R9: ff1c6a1920c9a000
> >     R10: ff646f199a8c7e00  R11: ff1c6a191a7d9800  R12: ff1c6a192d60ac00
> >                                                          mcast
> >     R13: ff1c6a1d82200000  R14: ff1c6a1a04dc8000  R15: ff1c6a1a04dc82d8
> >            dev                    priv (&priv->lock)     &priv->multica=
st_list (aka head)
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > --- <NMI exception stack> ---
> >  #5 [ff646f199a8c7e00] ipoib_mcast_join_task+0x1b1 at ffffffffc0944ac1 =
[ib_ipoib]
> >  #6 [ff646f199a8c7e98] process_one_work+0x1a7 at ffffffff9bf10967
> >
> > crash> rx ff646f199a8c7e68
> > ff646f199a8c7e68:  ff1c6a1a04dc82f8 <<< work =3D &priv->mcast_task.work
> >
> > crash> list -hO ipoib_dev_priv.multicast_list ff1c6a1a04dc8000
> > (empty)
> >
> > crash> ipoib_dev_priv.mcast_task.work.func,mcast_mutex.owner.counter ff=
1c6a1a04dc8000
> >   mcast_task.work.func =3D 0xffffffffc0944910 <ipoib_mcast_join_task>,
> >   mcast_mutex.owner.counter =3D 0xff1c69998efec000
> >
> > crash> b 8
> > PID: 8        TASK: ff1c69998efec000  CPU: 33   COMMAND: "kworker/u72:0=
"
> > --
> >  #3 [ff646f1980153d50] wait_for_completion+0x96 at ffffffff9c7d7646
> >  #4 [ff646f1980153d90] ipoib_mcast_remove_list+0x56 at ffffffffc0944dc6=
 [ib_ipoib]
> >  #5 [ff646f1980153de8] ipoib_mcast_dev_flush+0x1a7 at ffffffffc09455a7 =
[ib_ipoib]
> >  #6 [ff646f1980153e58] __ipoib_ib_dev_flush+0x1a4 at ffffffffc09431a4 [=
ib_ipoib]
> >  #7 [ff646f1980153e98] process_one_work+0x1a7 at ffffffff9bf10967
> >
> > crash> rx ff646f1980153e68
> > ff646f1980153e68:  ff1c6a1a04dc83f0 <<< work =3D &priv->flush_light
> >
> > crash> ipoib_dev_priv.flush_light.func,broadcast ff1c6a1a04dc8000
> >   flush_light.func =3D 0xffffffffc0943820 <ipoib_ib_dev_flush_light>,
> >   broadcast =3D 0x0,
> >
> > The mcast(s) on the &remove_list (the remaining part of the ex &priv->m=
ulticast_list):
> >
> > crash> list -s ipoib_mcast.done.done ipoib_mcast.list -H ff646f1980153e=
10 | paste - -
> > ff1c6a192bd0c200        done.done =3D 0x0,
> > ff1c6a192d60ac00        done.done =3D 0x0,
> >
> > Reported-by: Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.=
com>
> > Signed-off-by: Daniel Vacek <neelx@redhat.com>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/i=
nfiniband/ulp/ipoib/ipoib_multicast.c
> > index 5b3154503bf4..8e4f2c8839be 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > @@ -580,6 +580,7 @@ void ipoib_mcast_join_task(struct work_struct *work=
)
> >       }
> >       netif_addr_unlock_bh(dev);
> >
> > +     mutex_lock(&priv->mcast_mutex);
> >       spin_lock_irq(&priv->lock);
> >       if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
> >               goto out;
> > @@ -634,6 +635,7 @@ void ipoib_mcast_join_task(struct work_struct *work=
)
> >                               /* Found the next unjoined group */
> >                               if (ipoib_mcast_join(dev, mcast)) {
> >                                       spin_unlock_irq(&priv->lock);
> > +                                     mutex_unlock(&priv->mcast_mutex);
> >                                       return;
> >                               }
> >                       } else if (!delay_until ||
> > @@ -655,6 +657,7 @@ void ipoib_mcast_join_task(struct work_struct *work=
)
> >               ipoib_mcast_join(dev, mcast);
> >
> >       spin_unlock_irq(&priv->lock);
> > +     mutex_unlock(&priv->mcast_mutex);
> >  }
> >
> >  void ipoib_mcast_start_thread(struct net_device *dev)
> > --
> > 2.43.0
> >
>


