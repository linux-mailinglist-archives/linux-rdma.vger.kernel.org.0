Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80809535E08
	for <lists+linux-rdma@lfdr.de>; Fri, 27 May 2022 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiE0KS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 May 2022 06:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiE0KS4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 May 2022 06:18:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062601269A8
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 03:18:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t13so2053939ljd.6
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ja0trDOj1AHAzQELpHkuCoOvpIRGW0mjd6Tr80A8+E=;
        b=DGx6s9XGykmNgR7kySHzIUs1ndbN2ek3Hp/VQGsziqvuWafL3kLabZaaA0QIk08IXQ
         ufi5CqgSHxijD1o+CsNsiRs3jHDjIqTHdZKp4Zdqhr2RbfNerY1B0ZfkVjrX9w8n5Ncz
         uSp7xXm4vcxc3nc0BCGM45nxvpPE4v/Asr/Csjyrb/cwmFd4hsUpA/q8ivN7gnigqMQt
         cbWfpVTbTH4J98/Iw6rZpPnhmwxguVv9uisb0LT05g3hXsC/X0geHqmnbA8RY9jmhevQ
         pJ1WmO/shGAGmi6eo8KogZ/RLsjBGphZoXN2yNcTyeZYlgT/alQlTErzoSUfN07q5xgM
         /vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ja0trDOj1AHAzQELpHkuCoOvpIRGW0mjd6Tr80A8+E=;
        b=4xrjdR9tpsKF2Q3hAlXPJ+NaGbtD1EuBKKacMFu0ak9z469QLSyIe6YDTdTehpMFpN
         qBF53IspcSLwaMh94mqsBgW87qsF7FFrPs3J3bYpkw3G5VFoQ5aXxQDfmT/gJ4C+Ky7R
         eVOroXQvV5m5660nTZvUJRsJP2BlAsb3z6BEgBPJjJR1k68pd6XkhvnF4bfd6frUl4SQ
         Z/CdTcyRWmmTB6H3lIhZVzrnBPKK0CqZHwWHhhoV/1Akc4NDCQXFvXaBkeoAVpF1vkIO
         y0FkZEXWemDON8s6nLxG0WOenoxY8vQDEAQHcPI4I2QIQ1PW45GDWUfgEFCpMKllWlRv
         7UCA==
X-Gm-Message-State: AOAM533QG+wHit9H6ZtXg7Mvd91lgntIKzLIXCRxFKVDFs4uDrRjjne9
        F9ovZNUxP7aOyf/iLy04nQ5O36h/45Il45xxX1aFjw==
X-Google-Smtp-Source: ABdhPJw7nNZF4Zwhwy1+u45j03gxXkRtFr2ZIMnJYATTXdpjhmfEfZwp1n7XYy1mtrUY1trhC8S5s8InO+auv7Ei+gU=
X-Received: by 2002:a2e:a4b5:0:b0:254:aeb8:d275 with SMTP id
 g21-20020a2ea4b5000000b00254aeb8d275mr3747462ljm.64.1653646733200; Fri, 27
 May 2022 03:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220522223345.9889-1-rpearsonhpe@gmail.com> <CAJpMwyjjbZtG152GAZZV_t6sn8bw6J0tSGaaY_9LTdw0Ve7gEg@mail.gmail.com>
 <e81610d6-7896-03d6-91f9-15d68c7b8192@gmail.com> <CAJpMwyhsf_C6dosUH81_5aD4fd5XHNPD94B3NE=TT+fSBAKW1g@mail.gmail.com>
 <aa01e627-04fe-b331-b367-07cbb8731b8d@gmail.com> <CAJpMwyjNcMd4gAdGQxv3BBPhEdE3sYpcKLQto53B=WO=QUSaLQ@mail.gmail.com>
 <cfc52ebf-1798-0b07-39de-eaa5650f9084@gmail.com>
In-Reply-To: <cfc52ebf-1798-0b07-39de-eaa5650f9084@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Fri, 27 May 2022 12:18:41 +0200
Message-ID: <CAJpMwyimQ8mQ6p7FRFGjQjEYJKiBj8fMpv=bnHfYaPF544Ce3w@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect fencing
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        frank.zago@hpe.com, linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 8:20 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 5/24/22 05:28, Haris Iqbal wrote:
> > On Mon, May 23, 2022 at 8:22 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> On 5/23/22 03:05, Haris Iqbal wrote:
> >>> On Mon, May 23, 2022 at 5:51 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>>
> >>>> On 5/22/22 18:59, Haris Iqbal wrote:
> >>>>> On Mon, May 23, 2022 at 12:36 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>>>>
> >>>>>> Currently the rxe driver checks if any previous operation
> >>>>>> is not complete to determine if a fence wait is required.
> >>>>>> This is not correct. For a regular fence only previous
> >>>>>> read or atomic operations must be complete while for a local
> >>>>>> invalidate fence all previous operations must be complete.
> >>>>>> This patch corrects this behavior.
> >>>>>>
> >>>>>> Fixes: 8700e3e7c4857 ("Soft RoCE (RXE) - The software RoCE driver")
> >>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>>>> ---
> >>>>>>  drivers/infiniband/sw/rxe/rxe_req.c | 42 ++++++++++++++++++++++++-----
> >>>>>>  1 file changed, 36 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> >>>>>> index ae5fbc79dd5c..f36263855a45 100644
> >>>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> >>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> >>>>>> @@ -163,16 +163,41 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
> >>>>>>                      (wqe->state != wqe_state_processing)))
> >>>>>>                 return NULL;
> >>>>>>
> >>>>>> -       if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
> >>>>>> -                                                    (index != cons))) {
> >>>>>> -               qp->req.wait_fence = 1;
> >>>>>> -               return NULL;
> >>>>>> -       }
> >>>>>> -
> >>>>>>         wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
> >>>>>>         return wqe;
> >>>>>>  }
> >>>>>>
> >>>>>> +/**
> >>>>>> + * rxe_wqe_is_fenced - check if next wqe is fenced
> >>>>>> + * @qp: the queue pair
> >>>>>> + * @wqe: the next wqe
> >>>>>> + *
> >>>>>> + * Returns: 1 if wqe is fenced (needs to wait)
> >>>>>> + *         0 if wqe is good to go
> >>>>>> + */
> >>>>>> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> >>>>>> +{
> >>>>>> +       unsigned int cons;
> >>>>>> +
> >>>>>> +       if (!(wqe->wr.send_flags & IB_SEND_FENCE))
> >>>>>> +               return 0;
> >>>>>> +
> >>>>>> +       cons = queue_get_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
> >>>>>> +
> >>>>>> +       /* Local invalidate fence (LIF) see IBA 10.6.5.1
> >>>>>> +        * Requires ALL previous operations on the send queue
> >>>>>> +        * are complete.
> >>>>>> +        */
> >>>>>> +       if (wqe->wr.opcode == IB_WR_LOCAL_INV)
> >>>>>> +               return qp->req.wqe_index != cons;
> >>>>>
> >>>>>
> >>>>> Do I understand correctly that according to this code a wr with opcode
> >>>>> IB_WR_LOCAL_INV needs to have the IB_SEND_FENCE also set for this to
> >>>>> work?
> >>>>>
> >>>>> If that is the desired behaviour, can you point out where in spec this
> >>>>> is mentioned.
> >>>>
> >>>> According to IBA "Local invalidate fence" (LIF) and regular Fence behave
> >>>> differently. (See the referenced sections in the IBA.) For a local invalidate
> >>>> operation the fence bit fences all previous operations. That was the old behavior
> >>>> which made no distinction between local invalidate and other operations.
> >>>> The change here are the other operations with a regular fence which should only
> >>>> requires read and atomic operations to be fenced.
> >>>>
> >>>> Not sure what you mean by 'also'. Per the IBA if the LIF is set then you have
> >>>> strict invalidate ordering if not then you have relaxed ordering. The kernel verbs
> >>>> API only has one fence bit and does not have a separate LIF bit so I am
> >>>> interpreting them to share the one bit.
> >>>
> >>> I see. Now I understand. Thanks for the explanation.
> >>>
> >>> I do have a follow-up question. For a IB_WR_LOCAL_INV wr, without the
> >>> fence bit means relaxed ordering. This would mean that the completion
> >>> for that wr must take place "before any subsequent WQE has begun
> >>> execution". From what I understand, multiple rxe_requester instances
> >>> can run in parallel and pick up wqes and execute them. How is the
> >>> relaxed ordering criteria fulfilled?
> >>
> >> The requester is a tasklet. There is one tasklet instance per QP. Tasklets can only
> >> run on a single cpu so not in parallel. The tasklets for multiple cpus each
> >> execute a single send queue in order.
> >
> > I see. So, according to the function rxe_run_task, it will run the
> > tasklet only if "sched" is set to 1. Otherwise, its is going to run
> > the function rxe_do_task directly, which calls task->func directly.
> >
> > I can see places that its calling rxe_run_task with sched = 0, but
> > they are few. I did not look into all the execution paths through
> > which these can be hit, but was wondering, if there is a way it is
> > being made sure that such calls to rxe_run_task with sched = 0, does
> > not happen in parallel?
>
> It's a little more complicated than that. rxe_run_task(task, sched)
> runs the tasklet task as a tasklet if sched is nonzero. If it is zero
> it runs on the current thread but carefully locks and only runs the
> subroutine if the tasklet is not already running otherwise it marks the
> task as needing to be continued and leaves it running in the tasklet.
> The net effect is that either call to rxe_run_task will cause the
> tasklet code to run. When you schedule a tasket it normally runs on the
> same cpu as the calling code so there isn't a lot of difference between
> sched and non-sched. The sched version leaves two threads able to run
> on the cpu. The non-sched just has the original thread.
>
> __rxe_do_task() is also used and just calls the subroutine directly.
> It can only be used if you know that the tasklet is disabled since
> the tasklet code is non re-entrant and should never be running twice
> at the same time. It is used in rxe_qp.c during setup, reset and
> cleanup of queue pairs.
>
> Bob

I see.. Thanks for the responses.


> >
> >
> >
> >>>
> >>>>
> >>>> Bob
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>>
> >>>>>> +
> >>>>>> +       /* Fence see IBA 10.8.3.3
> >>>>>> +        * Requires that all previous read and atomic operations
> >>>>>> +        * are complete.
> >>>>>> +        */
> >>>>>> +       return atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
> >>>>>> +}
> >>>>>> +
> >>>>>>  static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
> >>>>>>  {
> >>>>>>         switch (opcode) {
> >>>>>> @@ -636,6 +661,11 @@ int rxe_requester(void *arg)
> >>>>>>         if (unlikely(!wqe))
> >>>>>>                 goto exit;
> >>>>>>
> >>>>>> +       if (rxe_wqe_is_fenced(qp, wqe)) {
> >>>>>> +               qp->req.wait_fence = 1;
> >>>>>> +               goto exit;
> >>>>>> +       }
> >>>>>> +
> >>>>>>         if (wqe->mask & WR_LOCAL_OP_MASK) {
> >>>>>>                 ret = rxe_do_local_ops(qp, wqe);
> >>>>>>                 if (unlikely(ret))
> >>>>>>
> >>>>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> >>>>>> --
> >>>>>> 2.34.1
> >>>>>>
> >>>>
> >>
>
