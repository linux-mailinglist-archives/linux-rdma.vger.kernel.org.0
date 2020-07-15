Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB54220A43
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgGOKkV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 06:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbgGOKkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 06:40:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AC5C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 03:40:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so1984017wrw.12
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFK6db4p7zkuzq1fMUQxZKvxRP5VlbtsMG4/ktNPtYs=;
        b=YblIjQL8HmaQKrNEsD8sUNOTZaNEFDtelWBkv8TxzmEyH3z9v7Oxefr2kDEppQygSQ
         iaO6ylhvJnTdM+IXrj3qYMoIbJtIvaphaTV/6QD387oqeo748ksH+7QJwJvEFU3zOckp
         RkI8Q1L9a6qgX5FIWmW+mqJ/b1e/o/AMoOnAsdCX/wk1V33FjAaSV3VltZW0/4dzkoZm
         6ROVX1XhtNlAgYvyj8YUGmVslrLT3mEyRMp8LFmLWb3feLRH4RZMD3ga2DIJAIhvD2Dm
         lz1YQXaCFYdEt3Yt19iGGUK2LKaRZyBdC2em1T5SEoMvrmX/XgfPGLkOIWYw9tsPbqRm
         qHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFK6db4p7zkuzq1fMUQxZKvxRP5VlbtsMG4/ktNPtYs=;
        b=rXWM0in2HhfRgaRU22zjV8rzrNqvokXPNzZZqHJYOj7cm/P14Z9pzKe/M/biwNQMA+
         fDflwzMVFfzJFdNW1JXaEd12MPk2QG/PYbVEbkIztrtvZmb3khTigvCM4AuxhUMxVVXh
         7p89g295FDvB3WzXDkKPW3aGgpy4+hJktuKWNsZg+eM+eoaQtsz1d9BNbF2c9e+2GwrE
         LItwv3TMgAUbNU+iJnjlFPXgx/y/1YjwYC8avnevYI/pGXznF109rzdJUfBLww34plXn
         6IXan7jrITx0a2TJ9N/iob7WoXtvvKIR+mJTK41FT7h3Fh+68vo42TgUFnp4kWRwD4Kd
         XNYw==
X-Gm-Message-State: AOAM531KoExeC4v5xCxWsgRe/wpm/nQPH/wNOg/JnvKgteJ2lljiW8Jg
        AYwCpfDdSDlovbj77PpLpn3s98ZAcR8=
X-Google-Smtp-Source: ABdhPJyf5I1MNBVUsHfVuIJp06mIQ9dpgrg8E8XUDhuNhRUGnASzfWxHSoZao0nR0Lxt7160OiJ65g==
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr10770872wrx.352.1594809618809;
        Wed, 15 Jul 2020 03:40:18 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 133sm3059110wme.5.2020.07.15.03.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:40:18 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:40:15 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Yanjun Zhu <yanjunz@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow
Message-ID: <20200715104015.GB122431@kheib-workstation>
References: <20200603101738.159637-1-kamalheib1@gmail.com>
 <AM6PR05MB6263D5C7548FFA67E4BCD29ED8810@AM6PR05MB6263.eurprd05.prod.outlook.com>
 <CAD=hENd+gmZbeE-Y_4PffRYoZZhbh+qFeNbn5QkFNkPncCeaBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENd+gmZbeE-Y_4PffRYoZZhbh+qFeNbn5QkFNkPncCeaBA@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 12, 2020 at 04:32:51PM +0800, Zhu Yanjun wrote:
> On Fri, Jun 12, 2020 at 4:31 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
> >
> >
> >
> > -----Original Message-----
> > From: Kamal Heib <kamalheib1@gmail.com>
> > Sent: Wednesday, June 3, 2020 6:18 PM
> > To: linux-rdma@vger.kernel.org
> > Cc: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Yanjun Zhu <yanjunz@mellanox.com>; Kamal Heib <kamalheib1@gmail.com>
> > Subject: [PATCH for-rc] RDMA/rxe: Fix QP cleanup flow
> >
> > Avoid releasing the socket associated with each QP in rxe_qp_cleanup() which can sleep and move it to rxe_destroy_qp() instead, after doing this there is no need for the execute_work that used to avoid calling
> > rxe_qp_cleanup() directly. also check that the socket is valid in
> > rxe_skb_tx_dtor() to avoid use-after-free.
> >
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Fixes: bb3ffb7ad48a ("RDMA/rxe: Fix rxe_qp_cleanup()")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_net.c   | 14 ++++++++++++--
> >  drivers/infiniband/sw/rxe/rxe_qp.c    | 22 ++++++----------------
> >  drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ---
> >  3 files changed, 18 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 312c2fc961c0..298ccd3fd3e2 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -411,8 +411,18 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc)  static void rxe_skb_tx_dtor(struct sk_buff *skb)  {
> >         struct sock *sk = skb->sk;
> > -       struct rxe_qp *qp = sk->sk_user_data;
> > -       int skb_out = atomic_dec_return(&qp->skb_out);
> > +       struct rxe_qp *qp;
> > +       int skb_out;
> > +
> > +       if (!sk)
> 
> When does sk become NULL?
>
Looks like the sk isn't set to NULL when it gets released..., This change
will require more work, please drop this patch.

Thanks,
Kamal

> > +               return;
> > +
> > +       qp = sk->sk_user_data;
> > +
> > +       if (!qp)
> 
> When does qp become NULL?
> 
> > +               return;
> > +
> > +       skb_out = atomic_dec_return(&qp->skb_out);
> >
> >         if (unlikely(qp->need_req_skb &&
> >                      skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)) diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > index 6c11c3aeeca6..89dac6c1111c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > @@ -787,6 +787,7 @@ void rxe_qp_destroy(struct rxe_qp *qp)
> >         if (qp_type(qp) == IB_QPT_RC) {
> >                 del_timer_sync(&qp->retrans_timer);
> >                 del_timer_sync(&qp->rnr_nak_timer);
> > +               sk_dst_reset(qp->sk->sk);
> >         }
> >
> >         rxe_cleanup_task(&qp->req.task);
> > @@ -798,12 +799,15 @@ void rxe_qp_destroy(struct rxe_qp *qp)
> >                 __rxe_do_task(&qp->comp.task);
> >                 __rxe_do_task(&qp->req.task);
> >         }
> > +
> > +       kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> > +       sock_release(qp->sk);
> >  }
> >
> >  /* called when the last reference to the qp is dropped */ -static void rxe_qp_do_cleanup(struct work_struct *work)
> > +void rxe_qp_cleanup(struct rxe_pool_entry *arg)
> >  {
> > -       struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
> > +       struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
> >
> >         rxe_drop_all_mcast_groups(qp);
> >
> > @@ -828,19 +832,5 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
> >                 qp->resp.mr = NULL;
> >         }
> >
> > -       if (qp_type(qp) == IB_QPT_RC)
> > -               sk_dst_reset(qp->sk->sk);
> > -
> >         free_rd_atomic_resources(qp);
> > -
> > -       kernel_sock_shutdown(qp->sk, SHUT_RDWR);
> > -       sock_release(qp->sk);
> > -}
> > -
> > -/* called when the last reference to the qp is dropped */ -void rxe_qp_cleanup(struct rxe_pool_entry *arg) -{
> > -       struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
> > -
> > -       execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
> >  }
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > index 92de39c4a7c1..339debaf095f 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> > @@ -35,7 +35,6 @@
> >  #define RXE_VERBS_H
> >
> >  #include <linux/interrupt.h>
> > -#include <linux/workqueue.h>
> >  #include <rdma/rdma_user_rxe.h>
> >  #include "rxe_pool.h"
> >  #include "rxe_task.h"
> > @@ -285,8 +284,6 @@ struct rxe_qp {
> >         struct timer_list rnr_nak_timer;
> >
> >         spinlock_t              state_lock; /* guard requester and completer */
> > -
> > -       struct execute_work     cleanup_work;
> >  };
> >
> >  enum rxe_mem_state {
> > --
> > 2.25.4
> >
