Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C380D2E93E8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jan 2021 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbhADLFs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jan 2021 06:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbhADLFs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jan 2021 06:05:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E230CC061574
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jan 2021 03:05:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ga15so4130852ejb.4
        for <linux-rdma@vger.kernel.org>; Mon, 04 Jan 2021 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+LCVb9mrmkJnV/x6dGSS9KfZeAe7azmVtI2C8SEWebA=;
        b=e1UDFr6jTXJQd2tKp5RY25VLtYh4OlJebG3S7Pk6qGmlvOJaYNyhR4bqJYr8s4snju
         usBrVv4s7DGETyIiCawBNB92/j0D/vz/UmfxpM5SfXWwkRS4e8aDTs2kyASVSULNShy0
         64Wdh0RZugCqkqTPLb9j28HjgV2y3jGBTi9izOtCKcq6fX9y3S42384NwIzA0EOrIbTd
         vqo+TcBJk1gOEkfjGXgOE4eRe7CJQep8985SXMe1aytqJDAHd8KAzd3OKnw+OWdmNwFY
         IV06SzzCw/RLyrK7QtQM4Me9n5jxcno9pooK9kLWy2z/IiAGOp1Egj+e8aE98QMlz8OY
         /Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+LCVb9mrmkJnV/x6dGSS9KfZeAe7azmVtI2C8SEWebA=;
        b=V6elia8aIVCT0nHZIbVxnB+SazEaYiTb5xx8tT2XQ425w128UhrlcwEOTKvpDJ1ShI
         vSsYjXjO5Dwjyny5yF/dXec+xOSOwhzAqavcH5XABsH8txmXAcm+6ZLBB+GgpSnlcGWR
         pmbznEcHFrJOWSE3X7F78FnwPs9Cm7jlgpxwLfKREIatDXG11a6z83AflvvfAmb125i5
         H5vN73XPiWHLHv27Snegnu0MYlYP5GrCgA5gKRXp0l/v590gn4xyJnInmm4roX/MUCEc
         wjFH6n0fY7qGjVrPIzlS2t3mUf1tOwx3VObOzIZF3R3fD56RqDWl89qGk1f/FC8b8xuK
         evxw==
X-Gm-Message-State: AOAM530Avf02vJ//45+0G4bN5ERzwvcr6ZnczbJMVx7ZSiJVS7fGmEWL
        fz6QX7Uk+3GYoi7EdZ/fHQNP49TM4+OuzCV7kFNCiA==
X-Google-Smtp-Source: ABdhPJwtz/OHtEf9lQ9a6fr6R0BpoJ8D6iATBNQ8ufJm2mX7zNW6ANxDmyz2jCkNF/etpSEtfi7PedeFLcyf4c/bTcY=
X-Received: by 2002:a17:906:94ca:: with SMTP id d10mr63181096ejy.62.1609758306608;
 Mon, 04 Jan 2021 03:05:06 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
 <20201211072600.GA192848@unreal> <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
 <CAMGffEnuNHacxqqdZsF0JMk3kTUqT9KdzNK_QzBF_FWjPWLN8Q@mail.gmail.com>
 <20201211134543.GB5487@ziepe.ca> <CAD+HZHXso=S5c=MqgrmDMZpWi10FbPTinWPfLMTkMCCiosihCQ@mail.gmail.com>
 <20201211162900.GC5487@ziepe.ca> <CAMGffEm22sP-oKK0D9=vOw77nbS05iwG7MC3DTVB0CyzVFhtXg@mail.gmail.com>
 <20201227090118.GG4457@unreal> <CAMGffEm8R8uU=-qKN62gKiUJ1s+obhR6rA+_AWjSP=N55_STTw@mail.gmail.com>
 <20210104082541.GF31158@unreal>
In-Reply-To: <20210104082541.GF31158@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 4 Jan 2021 12:04:55 +0100
Message-ID: <CAMGffEngzF6eWHhzOARYqGbWJELM4p15AiPsB0g1mT=qdTVZJg@mail.gmail.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jack Wang <xjtuwjp@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 4, 2021 at 9:25 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jan 04, 2021 at 09:06:13AM +0100, Jinpu Wang wrote:
> > On Sun, Dec 27, 2020 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrot=
e:
> > >
> > > On Wed, Dec 16, 2020 at 05:42:17PM +0100, Jinpu Wang wrote:
> > > > On Fri, Dec 11, 2020 at 5:29 PM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> > > > >
> > > > > On Fri, Dec 11, 2020 at 05:17:36PM +0100, Jack Wang wrote:
> > > > > >    En, the lockdep was complaining about the new conn_id, I wil=
l
> > > > > >    post the full log if needed next week.  let=E2=80=99s skip t=
his patch for
> > > > > >    now, will double check!
> > > > >
> > > > > That is even more worrysome as the new conn_id already has a diff=
erent
> > > > > lock class.
> > > > >
> > > > > Jason
> > > > This is the dmesg of the LOCKDEP warning, it's on kernel 5.4.77, bu=
t
> > > > the latest 5.10 behaves the same.
> > > >
> > > > [  500.071552] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [  500.071648] WARNING: possible circular locking dependency detect=
ed
> > > > [  500.071869] 5.4.77-storage+ #35 Tainted: G           O
> > > > [  500.071959] ----------------------------------------------------=
--
> > > > [  500.072054] kworker/1:1/28 is trying to acquire lock:
> > > > [  500.072200] ffff99653a624390 (&id_priv->handler_mutex){+.+.}, at=
:
> > > > rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.072837]
> > > >                but task is already holding lock:
> > > > [  500.072938] ffff9d18800f7e80
> > > > ((work_completion)(&sess->close_work)){+.+.}, at:
> > > > process_one_work+0x223/0x600
> > > > [  500.075642]
> > > >                which lock already depends on the new lock.
> > > >
> > > > [  500.075759]
> > > >                the existing dependency chain (in reverse order) is:
> > > > [  500.075880]
> > > >                -> #3 ((work_completion)(&sess->close_work)){+.+.}:
> > > > [  500.076062]        process_one_work+0x278/0x600
> > > > [  500.076154]        worker_thread+0x2d/0x3d0
> > > > [  500.076225]        kthread+0x111/0x130
> > > > [  500.076290]        ret_from_fork+0x24/0x30
> > > > [  500.076370]
> > > >                -> #2 ((wq_completion)rtrs_server_wq){+.+.}:
> > > > [  500.076482]        flush_workqueue+0xab/0x4b0
> > > > [  500.076565]        rtrs_srv_rdma_cm_handler+0x71d/0x1500 [rtrs_s=
erver]
> > > > [  500.076674]        cma_ib_req_handler+0x8c4/0x14f0 [rdma_cm]
> > > > [  500.076770]        cm_process_work+0x22/0x140 [ib_cm]
> > > > [  500.076857]        cm_req_handler+0x900/0xde0 [ib_cm]
> > > > [  500.076944]        cm_work_handler+0x136/0x1af2 [ib_cm]
> > > > [  500.077025]        process_one_work+0x29f/0x600
> > > > [  500.077097]        worker_thread+0x2d/0x3d0
> > > > [  500.077164]        kthread+0x111/0x130
> > > > [  500.077224]        ret_from_fork+0x24/0x30
> > > > [  500.077294]
> > > >                -> #1 (&id_priv->handler_mutex/1){+.+.}:
> > > > [  500.077409]        __mutex_lock+0x7e/0x950
> > > > [  500.077488]        cma_ib_req_handler+0x787/0x14f0 [rdma_cm]
> > > > [  500.077582]        cm_process_work+0x22/0x140 [ib_cm]
> > > > [  500.077669]        cm_req_handler+0x900/0xde0 [ib_cm]
> > > > [  500.077755]        cm_work_handler+0x136/0x1af2 [ib_cm]
> > > > [  500.077835]        process_one_work+0x29f/0x600
> > > > [  500.077907]        worker_thread+0x2d/0x3d0
> > > > [  500.077973]        kthread+0x111/0x130
> > > > [  500.078034]        ret_from_fork+0x24/0x30
> > > > [  500.078095]
> > > >                -> #0 (&id_priv->handler_mutex){+.+.}:
> > > > [  500.078196]        __lock_acquire+0x1166/0x1440
> > > > [  500.078267]        lock_acquire+0x90/0x170
> > > > [  500.078335]        __mutex_lock+0x7e/0x950
> > > > [  500.078410]        rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.078498]        rtrs_srv_close_work+0xf2/0x2d0 [rtrs_server]
> > > > [  500.078586]        process_one_work+0x29f/0x600
> > > > [  500.078662]        worker_thread+0x2d/0x3d0
> > > > [  500.078732]        kthread+0x111/0x130
> > > > [  500.078793]        ret_from_fork+0x24/0x30
> > > > [  500.078859]
> > > >                other info that might help us debug this:
> > > >
> > > > [  500.078984] Chain exists of:
> > > >                  &id_priv->handler_mutex -->
> > > > (wq_completion)rtrs_server_wq --> (work_completion)(&sess->close_wo=
rk)
> > > >
> > > > [  500.079207]  Possible unsafe locking scenario:
> > > >
> > > > [  500.079293]        CPU0                    CPU1
> > > > [  500.079358]        ----                    ----
> > > > [  500.079358]   lock((work_completion)(&sess->close_work));
> > > > [  500.079358]
> > > > lock((wq_completion)rtrs_server_wq);
> > > > [  500.079358]
> > > > lock((work_completion)(&sess->close_work));
> > > > [  500.079358]   lock(&id_priv->handler_mutex);
> > > > [  500.079358]
> > > >                 *** DEADLOCK ***
> > > >
> > > > [  500.079358] 2 locks held by kworker/1:1/28:
> > > > [  500.079358]  #0: ffff99652d281f28
> > > > ((wq_completion)rtrs_server_wq){+.+.}, at:
> > > > process_one_work+0x223/0x600
> > > > [  500.079358]  #1: ffff9d18800f7e80
> > > > ((work_completion)(&sess->close_work)){+.+.}, at:
> > > > process_one_work+0x223/0x600
> > > > [  500.079358]
> > > >                stack backtrace:
> > > > [  500.079358] CPU: 1 PID: 28 Comm: kworker/1:1 Tainted: G         =
  O
> > > >      5.4.77-storage+ #35
> > > > [  500.079358] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
),
> > > > BIOS 1.10.2-1ubuntu1 04/01/2014
> > > > [  500.079358] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_=
server]
> > > > [  500.079358] Call Trace:
> > > > [  500.079358]  dump_stack+0x71/0x9b
> > > > [  500.079358]  check_noncircular+0x17d/0x1a0
> > > > [  500.079358]  ? __lock_acquire+0x1166/0x1440
> > > > [  500.079358]  __lock_acquire+0x1166/0x1440
> > > > [  500.079358]  lock_acquire+0x90/0x170
> > > > [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.079358]  __mutex_lock+0x7e/0x950
> > > > [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.079358]  ? find_held_lock+0x2d/0x90
> > > > [  500.079358]  ? mark_held_locks+0x49/0x70
> > > > [  500.079358]  ? rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.079358]  rdma_destroy_id+0x55/0x230 [rdma_cm]
> > > > [  500.079358]  rtrs_srv_close_work+0xf2/0x2d0 [rtrs_server]
> > > > [  500.079358]  process_one_work+0x29f/0x600
> > > > [  500.079358]  worker_thread+0x2d/0x3d0
> > > > [  500.079358]  ? process_one_work+0x600/0x600
> > > > [  500.079358]  kthread+0x111/0x130
> > > > [  500.079358]  ? kthread_park+0x90/0x90
> > > > [  500.079358]  ret_from_fork+0x24/0x30
> > > >
> > > > According to my understanding
> > > > in cma_ib_req_handler, the conn_id is newly created in
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/c=
ore/cma.c#L2222.
> > > > And the rdma_cm_id associated with conn_id is passed to
> > > > rtrs_srv_rdma_cm_handler->rtrs_rdma_connect.
> > > >
> > > > In rtrs_rdma_connect, we do flush_workqueue will only flush close_w=
ork
> > > > for any other cm_id, but
> > > > not the newly created one conn_id, it has not associated with anyth=
ing yet.
> > >
> > > How did you come to this conclusion that rtrs handler was called befo=
re
> > > cma_cm_event_handler()? I'm not so sure about that and it will explai=
n
> > > the lockdep.
> > >
> > > Thanks
> > Hi Leon,
> > I never said that, the call chain here is:
> > cma_ib_req_handler->cma_cm_event_handler->rtrs_srv_rdma_cm_handler->rtr=
s_rdma_connect.
> > Repeat myself in last email:
> > in cma_ib_req_handler, the conn_id is newly created in
> >  https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core=
/cma.c#L2222.
> > And the rdma_cm_id associated with conn_id is passed to
> > rtrs_rdma_connect.
> >
> > In rtrs_rdma_connect, we do flush_workqueue will only flush close_work
> > for any other cm_id, but
> > not the newly created one conn_id, the rdma_cm_id passed in
> > rtrs_rdma_connect has not associated with anything yet.
>
> This is exactly why I'm not so sure, after rdma_cm_id returns from
> RDMA/core, it will be in that flush_workqueue queue.

In rtrs_rdma_connect,  we do  flush_workqueue(rtrs_wq) in the
beginning before we associate rdma_cm_id (conn_id) to rtrs_srv_con in
by rtrs_srv_rdma_cm_handler -> rtrs_rdma_connect -> create_con ->
con->c.cm_id =3D cm_id. And in rtrs_srv_close_work we do
rdma_destroy_id(con->c.cm_id);

so the rdma_cm_id is not in the flush_workqueue queue yet.

Thanks!
>
> >
> > Hope this is now clear.
> >
> > Happy New Year!
>
> Happy New Year too :)
