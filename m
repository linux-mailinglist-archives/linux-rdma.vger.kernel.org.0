Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD47477F3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGDRmr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDRmp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 13:42:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0DE3;
        Tue,  4 Jul 2023 10:42:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3141c8a6f30so6132569f8f.1;
        Tue, 04 Jul 2023 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688492563; x=1691084563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlQNkrnXvKOdXSTaMQ5YoM2TC4Y9wQAKvg84V3h8rFY=;
        b=fQdLCrElvkIdxvhaBGFMrIZeGFHP2Sc/gmw99Sk3Qwnu4LMm0LGIeateRTUqNUwtTQ
         LMxjr/fDrvwI+Aui3uKtpgMHzYdWsP8pP16voZqBF6tfqzwo6WxHgLbgN28oAaDWMQX7
         YjZqdNBGsqNWljhjQx0kVK9LnKdt1ZyRdLNhTn+r8IvdwD/DiF6osf324C2lfdBJeLq4
         3yBnCiqLxeMsf8DyRH9i/P2llP6yuOk4zG1GSLq8pII0LVAd0GK/dWC0iTqdPG+xfIyS
         dSRvLMG6mSWJQMIfa7iNWLayPnjqaCwp7TklCc/3v0jeuQ9SMMLpivnqBgRJo+nt9eAi
         +MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688492563; x=1691084563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlQNkrnXvKOdXSTaMQ5YoM2TC4Y9wQAKvg84V3h8rFY=;
        b=U/8WeZuWLiSVtWGz5mMvR1KwDnSvzYETU3aadFfMrRwXf91gDA4tNcO0H4A1l+D+G9
         7AHgxqOh3lZs0E/RzPx6iSFm5o7Vpf4CMSzXc1TY3d0V9IkXgr+QSYNUXiNLfLayBP+3
         buZl3wDKYDW1Oc/4UjCOE94zFex7RDsMKyC9J6KRCnt27KEPot5SOQFzCZZmNt87j4WA
         25R9AZjeuxraWmrynueChaoLY4c8Am3SVHN04NxFryfcPhS3lauZr9hYJvjzDwP1vWQW
         TLhHtRCI4SemnowD5jQ/fXbILgMCO77F/2lMycHCuoH44TzDtpICo9LSrk/5A/N2Zsn6
         Q7Hg==
X-Gm-Message-State: ABy/qLZ8UX/gqc4xuPCkebEHl4FsRlLXNj0tTUINbeTvu1NmyFxKVj56
        2j9kKBoMgb7/QZhidDzQtACHxDvVBCkOHZgsd4tRvQJmBDZ8/Zjx
X-Google-Smtp-Source: APBJJlFM5S8DXJT0nqjGrnPf/gknweqVFoLwZI01s1xTWcaJKijrjK/wO/2fd09QJz8m9tiFCwKWxbdiSCSisKZ2B54=
X-Received: by 2002:adf:de0b:0:b0:314:32b6:af3 with SMTP id
 b11-20020adfde0b000000b0031432b60af3mr7207411wrm.5.1688492562750; Tue, 04 Jul
 2023 10:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230628045925.5261-1-dg573847474@gmail.com> <20230704114849.GA6455@unreal>
In-Reply-To: <20230704114849.GA6455@unreal>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 01:42:31 +0800
Message-ID: <CAAo+4rXkMM87OJzim=8dACdV=kWK_1yXeD=W5GZzHoJ2Gz6rtw@mail.gmail.com>
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &sde->flushlist_lock
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Plus, we already in context where interrupts are stopped.

Indeed they can be called from .ndo_start_xmit callback and
the document said it is with bh disabled.

But I found some call chain from the user process that seems could
be called from irq disabled context. For sdma_send_txlist(),
there is a call chain.

-> hfi1_write_iter()  (.write_iter callback)
-> hfi1_user_sdma_process_request()
-> user_sdma_send_pkts()
-> sdma_send_txlist()

The .write_iter seems not to disable irq by default, as mentioned by
https://www.kernel.org/doc/Documentation/filesystems/vfs.txt
And I didn't find any explicit disabling or bh or irq along the call path,
and also see several  copy_from_usr() which cannot be invoked under
irq context.


For sdma_send_txreq(), there is a call chain.

-> qp_priv_alloc()
-> iowait_init() (register _hfi1_do_tid_send() as a work queue)
-> _hfi1_do_tid_send() (workqueue)
-> hfi1_do_tid_send()
-> hfi1_verbs_send()
-> sr(qp, ps, 0) (sr could points to hfi1_verbs_send_dm())
-> hfi1_verbs_send_dma()
-> sdma_send_txreq()

_hfi1_do_tid_send() is a work queue without irq disabled by default,
I also check the remaining call path and also found that there is no explic=
it
irq disable, instead the call site of hfi1_verbs_send() is exactly after
spin_lock_irq_restore(), seems like a hint that it is probably called withi=
rq
enable.

Another hint is that the lock acquisition of
spin_lock_irqsave(&sde->tail_lock, flags);
just before my patch in the same function also disable irq, seems like anot=
her
hint that this function could be called with interrupt disable,
otherwise the lock/unlock
for sde->tail_lock does not need to disable irq?

Would be appreciated if you could further check with this.


> It can't work as exactly after "ret =3D -ECOMM;" line, there is "goto unl=
ock"
> and there hfi1 calls to spin_unlock_irqrestore(..) with same "flags".

Yeah, that's my negligence, and sorry for this. Once you confirm that
there should
be some fixes, I would like to provide with v2 patch with the correct fix.

Best Regards,
Chengfeng


Leon Romanovsky <leon@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=8C 19:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 28, 2023 at 04:59:25AM +0000, Chengfeng Ye wrote:
> > As &sde->flushlist_lock is acquired by timer sdma_err_progress_check()
> > through layer of calls under softirq context, other process
> > context code acquiring the lock should disable irq.
> >
> > Possible deadlock scenario
> > sdma_send_txreq()
> >     -> spin_lock(&sde->flushlist_lock)
> >         <timer interrupt>
> >         -> sdma_err_progress_check()
> >         -> __sdma_process_event()
> >         -> sdma_set_state()
> >         -> sdma_flush()
> >         -> spin_lock_irqsave(&sde->flushlist_lock, flags) (deadlock her=
e)
> >
> > This flaw was found using an experimental static analysis tool we are
> > developing for irq-related deadlock.
> >
> > The tentative patch fix the potential deadlock by spin_lock_irqsave().
> >
> > Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> > ---
> >  drivers/infiniband/hw/hfi1/sdma.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/=
hfi1/sdma.c
> > index bb2552dd29c1..0431f575c861 100644
> > --- a/drivers/infiniband/hw/hfi1/sdma.c
> > +++ b/drivers/infiniband/hw/hfi1/sdma.c
> > @@ -2371,9 +2371,9 @@ int sdma_send_txreq(struct sdma_engine *sde,
> >       tx->sn =3D sde->tail_sn++;
> >       trace_hfi1_sdma_in_sn(sde, tx->sn);
> >  #endif
> > -     spin_lock(&sde->flushlist_lock);
> > +     spin_lock_irqsave(&sde->flushlist_lock, flags);
> >       list_add_tail(&tx->list, &sde->flushlist);
> > -     spin_unlock(&sde->flushlist_lock);
> > +     spin_unlock_irqrestore(&sde->flushlist_lock, flags);
> >       iowait_inc_wait_count(wait, tx->num_desc);
> >       queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
> >       ret =3D -ECOMM;
>
> It can't work as exactly after "ret =3D -ECOMM;" line, there is "goto unl=
ock"
> and there hfi1 calls to spin_unlock_irqrestore(..) with same "flags".
>
> Plus, we already in context where interrupts are stopped.
>
> Thanks
>
> > @@ -2459,7 +2459,7 @@ int sdma_send_txlist(struct sdma_engine *sde, str=
uct iowait_work *wait,
> >       *count_out =3D total_count;
> >       return ret;
> >  unlock_noconn:
> > -     spin_lock(&sde->flushlist_lock);
> > +     spin_lock_irqsave(&sde->flushlist_lock, flags);
> >       list_for_each_entry_safe(tx, tx_next, tx_list, list) {
> >               tx->wait =3D iowait_ioww_to_iow(wait);
> >               list_del_init(&tx->list);
> > @@ -2472,7 +2472,7 @@ int sdma_send_txlist(struct sdma_engine *sde, str=
uct iowait_work *wait,
> >               flush_count++;
> >               iowait_inc_wait_count(wait, tx->num_desc);
> >       }
> > -     spin_unlock(&sde->flushlist_lock);
> > +     spin_unlock_irqrestore(&sde->flushlist_lock, flags);
> >       queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
> >       ret =3D -ECOMM;
> >       goto update_tail;
> > --
> > 2.17.1
> >
