Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8805530B4D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiEWIGE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiEWIFv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 04:05:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE8193C3
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 01:05:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a23so16214056ljd.9
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbGuCymWBwngYBmjnflprPc6Cmu5rzLDda6B0k6xuPA=;
        b=aAKs4eZmuyZV00xC/KCECv1xexVaDeQyz3u97GOwuQK8yorj6aXVobhlpvWIKFzBnr
         wC0I7UR4eAZMfHPAcdO471MhXlarYUUvv9Ah/sZnwNgvAgPP/cXmXjBULH0a5VVv2wes
         WhH2GYNAE/7vD0Tvm4ElyGvZYXC615XEj3bqOmyYbs+mga6QD7wBmHAz6N0IBOIpk4q2
         k0r8l8p2nMPf1PQAAyMx71IywdKFEp4cZni09IoZyvJqYBxQQik3mWMYepJOg/uglJcD
         QtkPdI/F8eQeHsfTmHFhC3XPena3RFFD8azS5xPTi2ZwprPWktcXSVTFDAf4Iyc1X76D
         ipjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbGuCymWBwngYBmjnflprPc6Cmu5rzLDda6B0k6xuPA=;
        b=RBDT7lrblg021bvlZB3VzcNkX4aTO5cKNhLPzv6Y4JgewBdupAQFV9yPkCZFwD6FHc
         I7jYWdVGFq4ddkupj7DpRMHej7boUfAuAng/rRyj4YAPCwDIcUrwOXxAYHIPwXZsEkIH
         guBsXVseyhdFJHaLw6vKR/YBiqwKwLaMj4bcnbC+Joehl4+ZOCKyECtM3fKHKPssueMp
         ts0Hr3rD4xJxOipEeX+B3acRUrmenXnFJtH+GsSF3MRMu7bE98R8cYx5PRFI4f/0tvV7
         zmtDqeJ4TSWhjYoaFN7rXFN1h7uSrYV9pfgvtxJOuBR+ZoMUATLmwmG3/WqLr5AhE+Ca
         6t5A==
X-Gm-Message-State: AOAM531rqSsQGG8xKm8OQhRwmQqdje6TW15pS1R4rJlf5B0I1rtKCY3J
        YJ1D4hnk9xoKgxJapRNMinkGHHDCje7tS68MLxhzrg==
X-Google-Smtp-Source: ABdhPJwDJ+KWche9NZ/gifV4XLEoeQJKAiDxcnSIlrM2mRDYXNB6p0VYoiuK8Q290BZ6Y1acu/K4GYIYQARLhJvLjjo=
X-Received: by 2002:a2e:9d8b:0:b0:253:e0f0:cf81 with SMTP id
 c11-20020a2e9d8b000000b00253e0f0cf81mr6570999ljj.148.1653293144309; Mon, 23
 May 2022 01:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220522223345.9889-1-rpearsonhpe@gmail.com> <CAJpMwyjjbZtG152GAZZV_t6sn8bw6J0tSGaaY_9LTdw0Ve7gEg@mail.gmail.com>
 <e81610d6-7896-03d6-91f9-15d68c7b8192@gmail.com>
In-Reply-To: <e81610d6-7896-03d6-91f9-15d68c7b8192@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 23 May 2022 10:05:32 +0200
Message-ID: <CAJpMwyhsf_C6dosUH81_5aD4fd5XHNPD94B3NE=TT+fSBAKW1g@mail.gmail.com>
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

On Mon, May 23, 2022 at 5:51 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 5/22/22 18:59, Haris Iqbal wrote:
> > On Mon, May 23, 2022 at 12:36 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> Currently the rxe driver checks if any previous operation
> >> is not complete to determine if a fence wait is required.
> >> This is not correct. For a regular fence only previous
> >> read or atomic operations must be complete while for a local
> >> invalidate fence all previous operations must be complete.
> >> This patch corrects this behavior.
> >>
> >> Fixes: 8700e3e7c4857 ("Soft RoCE (RXE) - The software RoCE driver")
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_req.c | 42 ++++++++++++++++++++++++-----
> >>  1 file changed, 36 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> >> index ae5fbc79dd5c..f36263855a45 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> >> @@ -163,16 +163,41 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
> >>                      (wqe->state != wqe_state_processing)))
> >>                 return NULL;
> >>
> >> -       if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
> >> -                                                    (index != cons))) {
> >> -               qp->req.wait_fence = 1;
> >> -               return NULL;
> >> -       }
> >> -
> >>         wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
> >>         return wqe;
> >>  }
> >>
> >> +/**
> >> + * rxe_wqe_is_fenced - check if next wqe is fenced
> >> + * @qp: the queue pair
> >> + * @wqe: the next wqe
> >> + *
> >> + * Returns: 1 if wqe is fenced (needs to wait)
> >> + *         0 if wqe is good to go
> >> + */
> >> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> >> +{
> >> +       unsigned int cons;
> >> +
> >> +       if (!(wqe->wr.send_flags & IB_SEND_FENCE))
> >> +               return 0;
> >> +
> >> +       cons = queue_get_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
> >> +
> >> +       /* Local invalidate fence (LIF) see IBA 10.6.5.1
> >> +        * Requires ALL previous operations on the send queue
> >> +        * are complete.
> >> +        */
> >> +       if (wqe->wr.opcode == IB_WR_LOCAL_INV)
> >> +               return qp->req.wqe_index != cons;
> >
> >
> > Do I understand correctly that according to this code a wr with opcode
> > IB_WR_LOCAL_INV needs to have the IB_SEND_FENCE also set for this to
> > work?
> >
> > If that is the desired behaviour, can you point out where in spec this
> > is mentioned.
>
> According to IBA "Local invalidate fence" (LIF) and regular Fence behave
> differently. (See the referenced sections in the IBA.) For a local invalidate
> operation the fence bit fences all previous operations. That was the old behavior
> which made no distinction between local invalidate and other operations.
> The change here are the other operations with a regular fence which should only
> requires read and atomic operations to be fenced.
>
> Not sure what you mean by 'also'. Per the IBA if the LIF is set then you have
> strict invalidate ordering if not then you have relaxed ordering. The kernel verbs
> API only has one fence bit and does not have a separate LIF bit so I am
> interpreting them to share the one bit.

I see. Now I understand. Thanks for the explanation.

I do have a follow-up question. For a IB_WR_LOCAL_INV wr, without the
fence bit means relaxed ordering. This would mean that the completion
for that wr must take place "before any subsequent WQE has begun
execution". From what I understand, multiple rxe_requester instances
can run in parallel and pick up wqes and execute them. How is the
relaxed ordering criteria fulfilled?

>
> Bob
> >
> > Thanks.
> >
> >
> >> +
> >> +       /* Fence see IBA 10.8.3.3
> >> +        * Requires that all previous read and atomic operations
> >> +        * are complete.
> >> +        */
> >> +       return atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
> >> +}
> >> +
> >>  static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
> >>  {
> >>         switch (opcode) {
> >> @@ -636,6 +661,11 @@ int rxe_requester(void *arg)
> >>         if (unlikely(!wqe))
> >>                 goto exit;
> >>
> >> +       if (rxe_wqe_is_fenced(qp, wqe)) {
> >> +               qp->req.wait_fence = 1;
> >> +               goto exit;
> >> +       }
> >> +
> >>         if (wqe->mask & WR_LOCAL_OP_MASK) {
> >>                 ret = rxe_do_local_ops(qp, wqe);
> >>                 if (unlikely(ret))
> >>
> >> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> >> --
> >> 2.34.1
> >>
>
