Return-Path: <linux-rdma+bounces-4056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7EA93EE47
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 09:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAAFB23A44
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087084DFE;
	Mon, 29 Jul 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JeUtblMp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A646F2F8
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237355; cv=none; b=RrkJTfVRcwRZATb58B0/3oDCkJfPfUuDgL5Q1IkGDlNtajjDneHU63u+u2aaltBdlXoD/b85+Bsaaqk9QeoQBV4tsJe41ErHpMQG8y13l2YQgEo1uj417XPYuIUNq1ytqQH/uVXjTi6OHJ9poWdqA4HEx5Jj/11bJOl8D4TbdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237355; c=relaxed/simple;
	bh=lqfF7gMXnt4XqJ30QtPijYyTo3Oy01azEv8h2g7w8+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdWBBwFak30vUuHUsMyesrWXuh7T7AV4I7VKaOjYUCIlBV1UfgK7RSuxy+HByk6xCWf8RTclcncIbv01SO5I1O3GfqffLbHM0n+TxQchrG56skSDN73QpA32Ca93etSJYgF7a+YtA0G2qa4EeU/tqIfscYpS6sMpdK3Kbzfn/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JeUtblMp; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso1042213e0c.3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jul 2024 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722237352; x=1722842152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2YSWphPCvGnEmlzik6OXCXoqaN+MuPJe2FoNYV83qkY=;
        b=JeUtblMpqZjd1SFVSlduZvJVpTmYuTJzNu53Yv4shvfuhjKHI/U5hoIvcBweuofulM
         oq0UIr1X2gr4G8JaPRTEXy4lwIEFqmv/7UOoKxG2FSeEe6pF7Y1SjdDh8TfGSNpK13SJ
         4AZvIkiNAHLQRu+YY6vEm4sc3nqYu+6sLupXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722237352; x=1722842152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YSWphPCvGnEmlzik6OXCXoqaN+MuPJe2FoNYV83qkY=;
        b=boCUm31CpH/EPfxf87VPYN3SMtLaaGXhU3QsFKvw2v3QXKZLQUKJR65yI+fgPkZzHW
         OH8CwGcQBKY6ptL+xXUMUQvOtKcR9ejdEjK5FMMZtCTlxe/r/92roSvYtB+WYKVsLI+t
         o6NpKJrWdbM00VOEtNJg8rjKsoWsk1cRdUbwRerqnWtcTcUPzvUV8n46edvXRVC0oCXj
         aT5gSIbumPFzqOr1K2M69J6mDBU9nhvbmfqu3JwZ30YROI1ioh1G42EUtndx6uufZglq
         uWi38rF7YdkTHclZZIBl7Jl1UkVjY+Xj+ypnezQOq4uwv55WQpzsK/umI5GvU9dnntfm
         OCIg==
X-Forwarded-Encrypted: i=1; AJvYcCWXAnBC/JGECMW4j57kmU2dDCl2mjEAcXxekPE0YBAYwjX1XB44t/Y9yDKfIC9vjRPFeN9qR9ALsmSIimi/VM8tvihD2UovABX1CQ==
X-Gm-Message-State: AOJu0YyeYxma0ASgMkStSSKgp1jrV9EXZd0otD1edrtAhIMxuKKiZTuQ
	FezcdsqYQBWGQ6UF9or7kaNCd4BuGieZlFNrWSKZAeAENVCj8wyHFDvsNcKSQ6BMVGC3RDwRgUG
	TrxCoREIfGEp1Ajbhu8Uca7NJ52EVeyxbGyxEkn7mFjXQnG0HUw==
X-Google-Smtp-Source: AGHT+IGIYXkoU68pWZ4uS0kwZP06kPC3eDNfZ6NG4Cb7mBDP4XQAGiA4rKKG25EUvZBXRRGzF3Taa4zsYdqckhJ98tQ=
X-Received: by 2002:a05:6122:d0f:b0:4f6:adb5:aee1 with SMTP id
 71dfb90a1353d-4f6e69aa016mr6708520e0c.13.1722237351714; Mon, 29 Jul 2024
 00:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>
 <20240728073811.GA4296@unreal> <CAKDTOZAjQ12UB3tqkTv-yXgR+in-k7SdYnWk3XjpwrhbWng58Q@mail.gmail.com>
 <20240729061018.GA5669@unreal> <CAKDTOZDfxPCfS=5oOu56cfd+TPicr24ARXY3ed3iLS5qU-o_Qw@mail.gmail.com>
 <20240729065751.GB5669@unreal>
In-Reply-To: <20240729065751.GB5669@unreal>
From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Date: Mon, 29 Jul 2024 12:45:40 +0530
Message-ID: <CAKDTOZBiLd9WkzNfX=dp-=tN38J0Up191s5Wy6QDO32w5Rsz4w@mail.gmail.com>
Subject: Re: [PATCH for-rc] rdma-core/mad: Improve handling of timed out WRs
 of mad agent
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009809ab061e5da16c"

--0000000000009809ab061e5da16c
Content-Type: multipart/alternative; boundary="000000000000918949061e5da1ba"

--000000000000918949061e5da1ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:27=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Mon, Jul 29, 2024 at 12:08:52PM +0530, Saravanan Vajravel wrote:
> > On Mon, Jul 29, 2024 at 11:40=E2=80=AFAM Leon Romanovsky <leon@kernel.o=
rg>
wrote:
> > >
> > > On Mon, Jul 29, 2024 at 09:27:35AM +0530, Saravanan Vajravel wrote:
> > > > On Sun, Jul 28, 2024 at 1:08=E2=80=AFPM Leon Romanovsky <leon@kerne=
l.org>
wrote:
> > > > >
> > > > > On Mon, Jul 22, 2024 at 04:33:25PM +0530, Saravanan Vajravel
wrote:
> > > > > > Current timeout handler of mad agent aquires/releases
mad_agent_priv
> > > > > > lock for every timed out WRs. This causes heavy locking
contention
> > > > > > when higher no. of WRs are to be handled inside timeout handler=
.
> > > > > >
> > > > > > This leads to softlockup with below trace in some use cases
where
> > > > > > rdma-cm path is used to establish connection between peer nodes
> > > > > >
> > > > > > Trace:
> > > > > > -----
> > > > > >  BUG: soft lockup - CPU#4 stuck for 26s! [kworker/u128:3:19767]
> > > > > >  CPU: 4 PID: 19767 Comm: kworker/u128:3 Kdump: loaded Tainted:
G OE
> > > > > >      -------  ---  5.14.0-427.13.1.el9_4.x86_64 #1
> > > > > >  Hardware name: Dell Inc. PowerEdge R740/01YM03, BIOS 2.4.8
11/26/2019
> > > > > >  Workqueue: ib_mad1 timeout_sends [ib_core]
> > > > > >  RIP: 0010:__do_softirq+0x78/0x2ac
> > > > > >  RSP: 0018:ffffb253449e4f98 EFLAGS: 00000246
> > > > > >  RAX: 00000000ffffffff RBX: 0000000000000000 RCX:
000000000000001f
> > > > > >  RDX: 000000000000001d RSI: 000000003d1879ab RDI:
fff363b66fd3a86b
> > > > > >  RBP: ffffb253604cbcd8 R08: 0000009065635f3b R09:
0000000000000000
> > > > > >  R10: 0000000000000040 R11: ffffb253449e4ff8 R12:
0000000000000000
> > > > > >  R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000040
> > > > > >  FS:  0000000000000000(0000) GS:ffff8caa1fc80000(0000)
knlGS:0000000000000000
> > > > > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > >  CR2: 00007fd9ec9db900 CR3: 0000000891934006 CR4:
00000000007706e0
> > > > > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
> > > > > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
> > > > > >  PKRU: 55555554
> > > > > >  Call Trace:
> > > > > >   <IRQ>
> > > > > >   ? show_trace_log_lvl+0x1c4/0x2df
> > > > > >   ? show_trace_log_lvl+0x1c4/0x2df
> > > > > >   ? __irq_exit_rcu+0xa1/0xc0
> > > > > >   ? watchdog_timer_fn+0x1b2/0x210
> > > > > >   ? __pfx_watchdog_timer_fn+0x10/0x10
> > > > > >   ? __hrtimer_run_queues+0x127/0x2c0
> > > > > >   ? hrtimer_interrupt+0xfc/0x210
> > > > > >   ? __sysvec_apic_timer_interrupt+0x5c/0x110
> > > > > >   ? sysvec_apic_timer_interrupt+0x37/0x90
> > > > > >   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > > >   ? __do_softirq+0x78/0x2ac
> > > > > >   ? __do_softirq+0x60/0x2ac
> > > > > >   __irq_exit_rcu+0xa1/0xc0
> > > > > >   sysvec_call_function_single+0x72/0x90
> > > > > >   </IRQ>
> > > > > >   <TASK>
> > > > > >   asm_sysvec_call_function_single+0x16/0x20
> > > > > >  RIP: 0010:_raw_spin_unlock_irq+0x14/0x30
> > > > > >  RSP: 0018:ffffb253604cbd88 EFLAGS: 00000247
> > > > > >  RAX: 000000000001960d RBX: 0000000000000002 RCX:
ffff8cad2a064800
> > > > > >  RDX: 000000008020001b RSI: 0000000000000001 RDI:
ffff8cad5d39f66c
> > > > > >  RBP: ffff8cad5d39f600 R08: 0000000000000001 R09:
0000000000000000
> > > > > >  R10: ffff8caa443e0c00 R11: ffffb253604cbcd8 R12:
ffff8cacb8682538
> > > > > >  R13: 0000000000000005 R14: ffffb253604cbd90 R15:
ffff8cad5d39f66c
> > > > > >   cm_process_send_error+0x122/0x1d0 [ib_cm]
> > > > > >   timeout_sends+0x1dd/0x270 [ib_core]
> > > > > >   process_one_work+0x1e2/0x3b0
> > > > > >   ? __pfx_worker_thread+0x10/0x10
> > > > > >   worker_thread+0x50/0x3a0
> > > > > >   ? __pfx_worker_thread+0x10/0x10
> > > > > >   kthread+0xdd/0x100
> > > > > >   ? __pfx_kthread+0x10/0x10
> > > > > >   ret_from_fork+0x29/0x50
> > > > > >   </TASK>
> > > > > >
> > > > > > Simplified timeout handler by creating local list of timed out
WRs
> > > > > > and invoke send handler post creating the list. The new method
acquires/
> > > > > > releases lock once to fetch the list and hence helps to reduce
locking
> > > > > > contetiong when processing higher no. of WRs
> > > > > >
> > > > > > Signed-off-by: Saravanan Vajravel <
saravanan.vajravel@broadcom.com>
> > > > > > ---
> > > > > >  drivers/infiniband/core/mad.c | 14 ++++++++------
> > > > > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/core/mad.c
b/drivers/infiniband/core/mad.c
> > > > > > index 674344eb8e2f..58befbaaf0ad 100644
> > > > > > --- a/drivers/infiniband/core/mad.c
> > > > > > +++ b/drivers/infiniband/core/mad.c
> > > > > > @@ -2616,14 +2616,16 @@ static int retry_send(struct
ib_mad_send_wr_private *mad_send_wr)
> > > > > >
> > > > > >  static void timeout_sends(struct work_struct *work)
> > > > > >  {
> > > > > > +     struct ib_mad_send_wr_private *mad_send_wr, *n;
> > > > > >       struct ib_mad_agent_private *mad_agent_priv;
> > > > > > -     struct ib_mad_send_wr_private *mad_send_wr;
> > > > > >       struct ib_mad_send_wc mad_send_wc;
> > > > > > +     struct list_head local_list;
> > > > > >       unsigned long flags, delay;
> > > > > >
> > > > > >       mad_agent_priv =3D container_of(work, struct
ib_mad_agent_private,
> > > > > >                                     timed_work.work);
> > > > > >       mad_send_wc.vendor_err =3D 0;
> > > > > > +     INIT_LIST_HEAD(&local_list);
> > > > > >
> > > > > >       spin_lock_irqsave(&mad_agent_priv->lock, flags);
> > > > > >       while (!list_empty(&mad_agent_priv->wait_list)) {
> > > > > > @@ -2641,13 +2643,16 @@ static void timeout_sends(struct
work_struct *work)
> > > > > >                       break;
> > > > > >               }
> > > > > >
> > > > > > -             list_del(&mad_send_wr->agent_list);
> > > > > > +             list_del_init(&mad_send_wr->agent_list);
> > > > > >               if (mad_send_wr->status =3D=3D IB_WC_SUCCESS &&
> > > > > >                   !retry_send(mad_send_wr))
> > > > > >                       continue;
> > > > > >
> > > > > > -             spin_unlock_irqrestore(&mad_agent_priv->lock,
flags);
> > > > > > +             list_add_tail(&mad_send_wr->agent_list,
&local_list);
> > > > > > +     }
> > > > > > +     spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> > > > > >
> > > > > > +     list_for_each_entry_safe(mad_send_wr, n, &local_list,
agent_list) {
> > > > > >               if (mad_send_wr->status =3D=3D IB_WC_SUCCESS)
> > > > > >                       mad_send_wc.status =3D
IB_WC_RESP_TIMEOUT_ERR;
> > > > > >               else
> > > > > > @@ -2655,11 +2660,8 @@ static void timeout_sends(struct
work_struct *work)
> > > > > >               mad_send_wc.send_buf =3D &mad_send_wr->send_buf;
> > > > > >
mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
> > > > > >                                                  &mad_send_wc);
> > > > >
> > > > > I understand the problem, but I'm not sure that this is safe to
do. How
> > > > > can we be sure that this is safe to call the send_handler on
entry in
> > > > > wait_list without the locking?
> > > > >
> > > > > Thanks
> > > >
> > > > Per existing implementation, the send_handler is invoked without
locking.
> > > > I didn't change that design. Existing implementation was acquiring
and
> > > > releasing the lock for every Work Request (WR) that it handles
inside
> > > > timeout_handler.
> > > > I improved it in such a way that once lock is acquired to fetch lis=
t
> > > > of WR to be handled
> > > > and process all fetched WRs outside the scope of lock. In both
implementations,
> > > > send_handler is always called without lock. This patch aims to
reduce locking
> > > > contention
> > >
> > > Indeed send_handler is called without lock, but not on the wait_list.
> > > I've asked explicitly about operations on the wait_list.
> > >
> > > Thanks
> >
> > The entry in wait_list is removed under the scope of
mad_agent_priv->lock.
> > It is then added to local_list declared inside timeout_sends() handler
> > under the same
> > lock. Once all such entries are removed and added to the local_list,
> > this timeout_handler
> > processes each entry from the local_list and it invokes send_handler.
> > This local_list
> > doesn't need any locking as there is no possibility of race condition.
> >
> > Existing implementation also removed entry from wait_list and invoked
> > send_handler.
>
> Yes, and what is the difference between the current and proposed code?
>   2649                 spin_unlock_irqrestore(&mad_agent_priv->lock,
flags);  <----- unlock
>   2650

>   2651                 if (mad_send_wr->status =3D=3D IB_WC_SUCCESS)

>   2652                         mad_send_wc.status =3D
IB_WC_RESP_TIMEOUT_ERR;
>   2653                 else
>   2654                         mad_send_wc.status =3D mad_send_wr->status=
;
>   2655                 mad_send_wc.send_buf =3D &mad_send_wr->send_buf;
>   2656
mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,  <-- performed
without lock
>   2657                                                    &mad_send_wc);

>   2658

>   2659                 deref_mad_agent(mad_agent_priv);

>   2660                 spin_lock_irqsave(&mad_agent_priv->lock, flags);
    <---   ## lock() again
>   2661         }

>   2662         spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
<-- ## unlock.
>
> > So operation on the wait_list should not change in the new patch
> >
> > Thanks,

Please check your snippet of code above. I corrected it with ## tag.
It is acquiring / releasing / again acquiring / again releasing the lock
for handling one WR. So the existing implementation has heavy locking
contention. It will  be surfacing as an issue only when higher no. of WRs
are handled inside time_out handler().

Thanks.

> >
> > > > >
> > > > > > -
> > > > > >               deref_mad_agent(mad_agent_priv);
> > > > > > -             spin_lock_irqsave(&mad_agent_priv->lock, flags);
> > > > > >       }
> > > > > > -     spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > --
> > > > > > 2.39.3
> > > > > >
> > >
> > >
>
>

--000000000000918949061e5da1ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Jul 29, 2024 at 12:27=E2=80=AFPM Leon Roma=
novsky &lt;<a href=3D"mailto:leon@kernel.org">leon@kernel.org</a>&gt; wrote=
:<br>&gt;<br>&gt; On Mon, Jul 29, 2024 at 12:08:52PM +0530, Saravanan Vajra=
vel wrote:<br>&gt; &gt; On Mon, Jul 29, 2024 at 11:40=E2=80=AFAM Leon Roman=
ovsky &lt;<a href=3D"mailto:leon@kernel.org">leon@kernel.org</a>&gt; wrote:=
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; On Mon, Jul 29, 2024 at 09:27:35AM +05=
30, Saravanan Vajravel wrote:<br>&gt; &gt; &gt; &gt; On Sun, Jul 28, 2024 a=
t 1:08=E2=80=AFPM Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.org">le=
on@kernel.org</a>&gt; wrote:<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; =
&gt; &gt; On Mon, Jul 22, 2024 at 04:33:25PM +0530, Saravanan Vajravel wrot=
e:<br>&gt; &gt; &gt; &gt; &gt; &gt; Current timeout handler of mad agent aq=
uires/releases mad_agent_priv<br>&gt; &gt; &gt; &gt; &gt; &gt; lock for eve=
ry timed out WRs. This causes heavy locking contention<br>&gt; &gt; &gt; &g=
t; &gt; &gt; when higher no. of WRs are to be handled inside timeout handle=
r.<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; This l=
eads to softlockup with below trace in some use cases where<br>&gt; &gt; &g=
t; &gt; &gt; &gt; rdma-cm path is used to establish connection between peer=
 nodes<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; Tr=
ace:<br>&gt; &gt; &gt; &gt; &gt; &gt; -----<br>&gt; &gt; &gt; &gt; &gt; &gt=
; =C2=A0BUG: soft lockup - CPU#4 stuck for 26s! [kworker/u128:3:19767]<br>&=
gt; &gt; &gt; &gt; &gt; &gt; =C2=A0CPU: 4 PID: 19767 Comm: kworker/u128:3 K=
dump: loaded Tainted: G OE<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =
=C2=A0------- =C2=A0--- =C2=A05.14.0-427.13.1.el9_4.x86_64 #1<br>&gt; &gt; =
&gt; &gt; &gt; &gt; =C2=A0Hardware name: Dell Inc. PowerEdge R740/01YM03, B=
IOS 2.4.8 11/26/2019<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0Workqueue: ib_m=
ad1 timeout_sends [ib_core]<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0RIP: 001=
0:__do_softirq+0x78/0x2ac<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0RSP: 0018:=
ffffb253449e4f98 EFLAGS: 00000246<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0RA=
X: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000000001f<br>&gt; &gt=
; &gt; &gt; &gt; &gt; =C2=A0RDX: 000000000000001d RSI: 000000003d1879ab RDI=
: fff363b66fd3a86b<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0RBP: ffffb253604c=
bcd8 R08: 0000009065635f3b R09: 0000000000000000<br>&gt; &gt; &gt; &gt; &gt=
; &gt; =C2=A0R10: 0000000000000040 R11: ffffb253449e4ff8 R12: 0000000000000=
000<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0R13: 0000000000000000 R14: 00000=
00000000000 R15: 0000000000000040<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0FS=
: =C2=A00000000000000000(0000) GS:ffff8caa1fc80000(0000) knlGS:000000000000=
0000<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0CS: =C2=A00010 DS: 0000 ES: 000=
0 CR0: 0000000080050033<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0CR2: 00007fd=
9ec9db900 CR3: 0000000891934006 CR4: 00000000007706e0<br>&gt; &gt; &gt; &gt=
; &gt; &gt; =C2=A0DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=
=A0PKRU: 55555554<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0Call Trace:<br>&gt=
; &gt; &gt; &gt; &gt; &gt; =C2=A0 &lt;IRQ&gt;<br>&gt; &gt; &gt; &gt; &gt; &=
gt; =C2=A0 ? show_trace_log_lvl+0x1c4/0x2df<br>&gt; &gt; &gt; &gt; &gt; &gt=
; =C2=A0 ? show_trace_log_lvl+0x1c4/0x2df<br>&gt; &gt; &gt; &gt; &gt; &gt; =
=C2=A0 ? __irq_exit_rcu+0xa1/0xc0<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 ?=
 watchdog_timer_fn+0x1b2/0x210<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 ? __=
pfx_watchdog_timer_fn+0x10/0x10<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 ? _=
_hrtimer_run_queues+0x127/0x2c0<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 ? h=
rtimer_interrupt+0xfc/0x210<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 ? __sys=
vec_apic_timer_interrupt+0x5c/0x110<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0=
 ? sysvec_apic_timer_interrupt+0x37/0x90<br>&gt; &gt; &gt; &gt; &gt; &gt; =
=C2=A0 ? asm_sysvec_apic_timer_interrupt+0x16/0x20<br>&gt; &gt; &gt; &gt; &=
gt; &gt; =C2=A0 ? __do_softirq+0x78/0x2ac<br>&gt; &gt; &gt; &gt; &gt; &gt; =
=C2=A0 ? __do_softirq+0x60/0x2ac<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 __=
irq_exit_rcu+0xa1/0xc0<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 sysvec_call_=
function_single+0x72/0x90<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 &lt;/IRQ&=
gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 &lt;TASK&gt;<br>&gt; &gt; &gt; =
&gt; &gt; &gt; =C2=A0 asm_sysvec_call_function_single+0x16/0x20<br>&gt; &gt=
; &gt; &gt; &gt; &gt; =C2=A0RIP: 0010:_raw_spin_unlock_irq+0x14/0x30<br>&gt=
; &gt; &gt; &gt; &gt; &gt; =C2=A0RSP: 0018:ffffb253604cbd88 EFLAGS: 0000024=
7<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0RAX: 000000000001960d RBX: 0000000=
000000002 RCX: ffff8cad2a064800<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0RDX:=
 000000008020001b RSI: 0000000000000001 RDI: ffff8cad5d39f66c<br>&gt; &gt; =
&gt; &gt; &gt; &gt; =C2=A0RBP: ffff8cad5d39f600 R08: 0000000000000001 R09: =
0000000000000000<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0R10: ffff8caa443e0c=
00 R11: ffffb253604cbcd8 R12: ffff8cacb8682538<br>&gt; &gt; &gt; &gt; &gt; =
&gt; =C2=A0R13: 0000000000000005 R14: ffffb253604cbd90 R15: ffff8cad5d39f66=
c<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 cm_process_send_error+0x122/0x1d0=
 [ib_cm]<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 timeout_sends+0x1dd/0x270 =
[ib_core]<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 process_one_work+0x1e2/0x=
3b0<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 ? __pfx_worker_thread+0x10/0x10=
<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 worker_thread+0x50/0x3a0<br>&gt; &=
gt; &gt; &gt; &gt; &gt; =C2=A0 ? __pfx_worker_thread+0x10/0x10<br>&gt; &gt;=
 &gt; &gt; &gt; &gt; =C2=A0 kthread+0xdd/0x100<br>&gt; &gt; &gt; &gt; &gt; =
&gt; =C2=A0 ? __pfx_kthread+0x10/0x10<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=
=A0 ret_from_fork+0x29/0x50<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 &lt;/TA=
SK&gt;<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; Si=
mplified timeout handler by creating local list of timed out WRs<br>&gt; &g=
t; &gt; &gt; &gt; &gt; and invoke send handler post creating the list. The =
new method acquires/<br>&gt; &gt; &gt; &gt; &gt; &gt; releases lock once to=
 fetch the list and hence helps to reduce locking<br>&gt; &gt; &gt; &gt; &g=
t; &gt; contetiong when processing higher no. of WRs<br>&gt; &gt; &gt; &gt;=
 &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; Signed-off-by: Saravanan Vajrav=
el &lt;<a href=3D"mailto:saravanan.vajravel@broadcom.com">saravanan.vajrave=
l@broadcom.com</a>&gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; ---<br>&gt; &gt; &g=
t; &gt; &gt; &gt; =C2=A0drivers/infiniband/core/mad.c | 14 ++++++++------<b=
r>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A01 file changed, 8 insertions(+), 6 de=
letions(-)<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt=
; diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.=
c<br>&gt; &gt; &gt; &gt; &gt; &gt; index 674344eb8e2f..58befbaaf0ad 100644<=
br>&gt; &gt; &gt; &gt; &gt; &gt; --- a/drivers/infiniband/core/mad.c<br>&gt=
; &gt; &gt; &gt; &gt; &gt; +++ b/drivers/infiniband/core/mad.c<br>&gt; &gt;=
 &gt; &gt; &gt; &gt; @@ -2616,14 +2616,16 @@ static int retry_send(struct i=
b_mad_send_wr_private *mad_send_wr)<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt=
; &gt; &gt; &gt; &gt; &gt; =C2=A0static void timeout_sends(struct work_stru=
ct *work)<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0{<br>&gt; &gt; &gt; &gt; &=
gt; &gt; + =C2=A0 =C2=A0 struct ib_mad_send_wr_private *mad_send_wr, *n;<br=
>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 struct ib_mad_agent_pri=
vate *mad_agent_priv;<br>&gt; &gt; &gt; &gt; &gt; &gt; - =C2=A0 =C2=A0 stru=
ct ib_mad_send_wr_private *mad_send_wr;<br>&gt; &gt; &gt; &gt; &gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 struct ib_mad_send_wc mad_send_wc;<br>&gt; &gt; &gt; &=
gt; &gt; &gt; + =C2=A0 =C2=A0 struct list_head local_list;<br>&gt; &gt; &gt=
; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 unsigned long flags, delay;<br>&gt; &=
gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 mad_agent_priv =3D container_of(work, struct ib_mad_agent_private,<br>&=
gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://timed_work.work">timed_work.work</a>);<br>&gt; &gt=
; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 mad_send_wc.vendor_err =3D 0;<br=
>&gt; &gt; &gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 INIT_LIST_HEAD(&amp;local_li=
st);<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;mad_agent_priv-&gt;lock, flags);<b=
r>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 while (!list_empty(&am=
p;mad_agent_priv-&gt;wait_list)) {<br>&gt; &gt; &gt; &gt; &gt; &gt; @@ -264=
1,13 +2643,16 @@ static void timeout_sends(struct work_struct *work)<br>&gt=
; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; &gt; &gt; &gt; &g=
t;<br>&gt; &gt; &gt; &gt; &gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 list_del(&amp;mad_send_wr-&gt;agent_list);<br>&gt; &gt; &gt; &gt; &g=
t; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del_init(&amp;mad_=
send_wr-&gt;agent_list);<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mad_send_wr-&gt;status =3D=3D IB_WC_SUC=
CESS &amp;&amp;<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !retry_send(mad_send_wr))<br>&gt; &g=
t; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt;=
 &gt; &gt; &gt; &gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_=
unlock_irqrestore(&amp;mad_agent_priv-&gt;lock, flags);<br>&gt; &gt; &gt; &=
gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add_tail(&am=
p;mad_send_wr-&gt;agent_list, &amp;local_list);<br>&gt; &gt; &gt; &gt; &gt;=
 &gt; + =C2=A0 =C2=A0 }<br>&gt; &gt; &gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 sp=
in_unlock_irqrestore(&amp;mad_agent_priv-&gt;lock, flags);<br>&gt; &gt; &gt=
; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 list_for_=
each_entry_safe(mad_send_wr, n, &amp;local_list, agent_list) {<br>&gt; &gt;=
 &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (m=
ad_send_wr-&gt;status =3D=3D IB_WC_SUCCESS)<br>&gt; &gt; &gt; &gt; &gt; &gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mad_send_wc.status =3D IB_WC_RESP_TIMEOUT_ERR;<br>&gt; &gt; &gt; &gt; &=
gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>&gt; &gt;=
 &gt; &gt; &gt; &gt; @@ -2655,11 +2660,8 @@ static void timeout_sends(struc=
t work_struct *work)<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mad_send_wc.send_buf =3D &amp;mad_send_wr-&gt;s=
end_buf;<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mad_agent_priv-&gt;agent.send_handler(&amp;mad_agent_priv=
-&gt;agent,<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;mad_send_wc);<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; I =
understand the problem, but I&#39;m not sure that this is safe to do. How<b=
r>&gt; &gt; &gt; &gt; &gt; can we be sure that this is safe to call the sen=
d_handler on entry in<br>&gt; &gt; &gt; &gt; &gt; wait_list without the loc=
king?<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; Thanks<br>&gt=
; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; Per existing implementation, the se=
nd_handler is invoked without locking.<br>&gt; &gt; &gt; &gt; I didn&#39;t =
change that design. Existing implementation was acquiring and<br>&gt; &gt; =
&gt; &gt; releasing the lock for every Work Request (WR) that it handles in=
side<br>&gt; &gt; &gt; &gt; timeout_handler.<br>&gt; &gt; &gt; &gt; I impro=
ved it in such a way that once lock is acquired to fetch list<br>&gt; &gt; =
&gt; &gt; of WR to be handled<br>&gt; &gt; &gt; &gt; and process all fetche=
d WRs outside the scope of lock. In both implementations,<br>&gt; &gt; &gt;=
 &gt; send_handler is always called without lock. This patch aims to reduce=
 locking<br>&gt; &gt; &gt; &gt; contention<br>&gt; &gt; &gt;<br>&gt; &gt; &=
gt; Indeed send_handler is called without lock, but not on the wait_list.<b=
r>&gt; &gt; &gt; I&#39;ve asked explicitly about operations on the wait_lis=
t.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Thanks<br>&gt; &gt;<br>&gt; &gt; The=
 entry in wait_list is removed under the scope of mad_agent_priv-&gt;lock.<=
br>&gt; &gt; It is then added to local_list declared inside timeout_sends()=
 handler<br>&gt; &gt; under the same<br>&gt; &gt; lock. Once all such entri=
es are removed and added to the local_list,<br>&gt; &gt; this timeout_handl=
er<br>&gt; &gt; processes each entry from the local_list and it invokes sen=
d_handler.<br>&gt; &gt; This local_list<br>&gt; &gt; doesn&#39;t need any l=
ocking as there is no possibility of race condition.<br>&gt; &gt;<br>&gt; &=
gt; Existing implementation also removed entry from wait_list and invoked<b=
r>&gt; &gt; send_handler.<br>&gt;<br>&gt; Yes, and what is the difference b=
etween the current and proposed code?<br>&gt; =C2=A0 2649 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;mad_agen=
t_priv-&gt;lock, flags); =C2=A0&lt;----- unlock<br>&gt; =C2=A0 2650 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <br>&gt; =C2=A0 2651 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (mad_send_wr-&gt;status =3D=3D IB_WC_SUCCESS) =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>&gt; =C2=A0 2652 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mad_send_wc.=
status =3D IB_WC_RESP_TIMEOUT_ERR;<br>&gt; =C2=A0 2653 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>&gt; =C2=A0 2654 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mad_send_wc.status =3D mad_send_wr-&gt;status;<br>&gt; =C2=A0 26=
55 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mad_send_wc.send=
_buf =3D &amp;mad_send_wr-&gt;send_buf; =C2=A0 <br>&gt; =C2=A0 2656 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mad_agent_priv-&gt;agent.s=
end_handler(&amp;mad_agent_priv-&gt;agent, =C2=A0&lt;-- performed without l=
ock<br>&gt; =C2=A0 2657 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;mad_send_wc=
); =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>&gt; =C2=A0 2658 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>&gt; =C2=A0 2659 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 deref_mad_agent(mad_agent_priv); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>&gt; =C2=A0 2660 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp=
;mad_agent_priv-&gt;lock, flags);=C2=A0 =C2=A0 =C2=A0 &lt;---=C2=A0 =C2=A0#=
# lock() again<br>&gt; =C2=A0 2661 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>&gt; =C2=A0 2662 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;mad_agent_priv-&gt;=
lock, flags); =C2=A0 =C2=A0 &lt;-- ## unlock.<br>&gt;<br>&gt; &gt; So opera=
tion on the wait_list should not change in the new patch<br>&gt; &gt;<br>&g=
t; &gt; Thanks,<div><br></div><div>Please check your snippet of code above.=
 I corrected it with ## tag.</div><div>It is acquiring / releasing / again =
acquiring=C2=A0/ again releasing the lock=C2=A0</div><div>for handling one =
WR. So the existing implementation has heavy locking</div><div>contention. =
It will=C2=A0 be surfacing as an issue only when higher no. of WRs</div><di=
v>are handled inside time_out handler().</div><div><br></div><div>Thanks.</=
div><div></div><div><br>&gt; &gt;<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; =
&gt; &gt; &gt; &gt; -<br>&gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deref_mad_agent(mad_agent_priv);<br>&gt; &gt; =
&gt; &gt; &gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_i=
rqsave(&amp;mad_agent_priv-&gt;lock, flags);<br>&gt; &gt; &gt; &gt; &gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 }<br>&gt; &gt; &gt; &gt; &gt; &gt; - =C2=A0 =C2=A0 =
spin_unlock_irqrestore(&amp;mad_agent_priv-&gt;lock, flags);<br>&gt; &gt; &=
gt; &gt; &gt; &gt; =C2=A0}<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &g=
t; &gt; &gt; &gt; =C2=A0/*<br>&gt; &gt; &gt; &gt; &gt; &gt; --<br>&gt; &gt;=
 &gt; &gt; &gt; &gt; 2.39.3<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &=
gt;<br>&gt; &gt; &gt;<br>&gt;<br>&gt;<br></div></div>

--000000000000918949061e5da1ba--

--0000000000009809ab061e5da16c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBV4wggRGoAMCAQICDDPW1cVntFGljCZAOzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTE0NTZaFw0yNTA5MTAwOTE0NTZaMIGa
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGzAZBgNVBAMTElNhcmF2YW5hbiBWYWpyYXZlbDEuMCwGCSqG
SIb3DQEJARYfc2FyYXZhbmFuLnZhanJhdmVsQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOWUDY8+1Pq6qzzsf5oTzGO7etyb0HT08NkGz7Ymb6gL2BcSxf00xj2f
fgOR3x1R5vZCQL+NXGnk27IMYe6P1jT2e49wq24CtJxpjbdCgiY+wM0iowrqj+xHJyGEyFK7BEOB
1cEV+/7fNvlT+wzsiB6LI7YO2jnJoqRyxiuCXWXQteLT5u5dJd79gUxenL2sOdzc9QDElI3VQMfh
lU2WOYSpsHwmuzI2n56f4qqAd0KTzesYpT4jUkHrpARqokmK62nwak/mVjpP1xxKkerBRTDplTRj
PPaP6wQe1OY7fOWrqgKUrMkQ8uzH68KFHiA/+zIzyFmYwY+S3kdoi+SvK08CAwEAAaOCAeAwggHc
MA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
dDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFs
c2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+
oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcmwwKgYDVR0RBCMwIYEfc2FyYXZhbmFuLnZhanJhdmVsQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
0Bq3qvsz+PB5FAu5iL1KRdtSBTgwDQYJKoZIhvcNAQELBQADggEBAHXOk8r6/lLV2Fb8uE3tUP2E
MFD67H9X0roxhLywKzY+SM6abiUqsRxlcBwNgp0r/SwFG1o+frLlj7gynwfkzfsRzLRf//DYTUOF
qs8Os28DFCa/KvX0e56+c7xOOP9cwgHO3Tl2ri3MAGpxEB5r4PcgmWd4f9zmlmBGE9oNyoyntToB
pb/Gi74xj8wc5zCrVpXS1UNVJ8B6Jib+vas1cAtL6RFi0RDtFbUXe9U4wB07Ker1yMtBA6QzfZW2
d0VRyjqv9NL22cjJ4ffotr8ZKbiSVEHbnDRxAgeuMxkkpjQQk/y1S1fk0wDOYNfV0zIkWtVMNBzY
Ttmt2pp+/hwLYVAxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO4jkcnJ
3mYHooy4I2z/4acyBpO+b7iGJ0GhJOA5xvEbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MDcyOTA3MTU1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDW96iUvYU4osqTVghas3fLvZlY
kbuOqigWWtxd5MUAoQ16zbCxcJYpdcbG7iNa/TJtnhK7gUg1TV6VENHhnagO83n+0Xj4U69X19Jq
rd1eDh9CCcvK2oEPNPmlg90bdP3jCnJGoV/uoocD8vm1W29aVtguM7yxG48kEtJsO1pzeKS+1vir
AIxyGT8o0DN6LrGE8MEbgFHBI3elsdJt7XCyRidlv4yE2u49Jos8ty1PjzJs3nNFiS/6IT7YgRrG
Pqz00jxt77pkw/BOwCTR9m8ewpvBPKHpGnq6w3fgNKocTp0H6TqXyuC67eRLCbZvrF6t28AsEgTi
74Ufi3VW1ij9
--0000000000009809ab061e5da16c--

