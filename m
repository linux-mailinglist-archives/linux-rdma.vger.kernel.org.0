Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78464FB236
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 05:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiDKDRq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 23:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiDKDR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 23:17:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70019031;
        Sun, 10 Apr 2022 20:15:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so11501109lfb.3;
        Sun, 10 Apr 2022 20:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiJlMxN9e31Gfkx3BH9sWCrJmMETcfxJmZoA5+VyDYI=;
        b=HhAuT1EsW6vdgnb2QcYm74FyLZJrsn0jpBT36KDnoS9UU9qDguyEL1v0Qtr2kxqTyV
         0VttOYrdX4Xyu5e/0oZ72e5M3usstOfOfr97z0E2C3KqigQAnpZNotDto/YzdN6+IpVs
         sYO3ChRl3MBEreobFIryR9r5KuD4sJ1Xi39EEv8/emESshcYeM2Xi6knFBu1dAo2IpGf
         OqWRWRtaoFunDPOS4mU4fGGuvTILhdB9a1MwnCNR684T6CiRo9obSVFZNwLOe7lwhv+y
         4CqNlJoNfDDwddMUqHyPzEE+7k6qGuFU+gUoNfAV47gsR0WVBr6J5ey4xnm6NCgzCzJE
         cCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiJlMxN9e31Gfkx3BH9sWCrJmMETcfxJmZoA5+VyDYI=;
        b=PefUeoBwgvFrj1nu3YxdAl/5hqE9dXtgK978FQkKYPYnAHczthkUcMsAhkvHYgYlds
         5UgsJeD7x/vxuT742sBxj+taL8NJeMeALs80Zs18IiF1IViL1MrmJJOSuz2NltaaWEdC
         EGoBfnlB66kC10kNYa0nWeU1+wFQr7VpM1NpDZQmwFJY0yxwVCHa2QEMwVWI1hz29fJO
         8QQjnzReNZuFWXIqeHJ3HTkPIWbvw4vJnwY9g+zLM+Etrff1CceJ8LyeBvhUu/jUkgqG
         fdAg1mM/mil/GFGRlV3HYnr+wfM/Mjmm08kqmVy2ZF5AiZjuPBsVGWkG2B2WGYyeSGsv
         owIg==
X-Gm-Message-State: AOAM530lUTmpu13Hy1n/woDA8ZKCvZkP8qgMKy7P5Z/kEXYmnos7Vi/F
        DahBZ++IVu/oMp1PlcwX5gzU3KgBDSdHcuXXKdiliZ6d
X-Google-Smtp-Source: ABdhPJyD2/FtAuG7FXcLlNM+ARnBeoDLzh4Q5hkG1/P4O9T8Mcjd9iRXAK1xf0nWcNo8aZWK7MoMD6vUjCkMAZqOit8=
X-Received: by 2002:a05:6512:2608:b0:448:35c4:bc9f with SMTP id
 bt8-20020a056512260800b0044835c4bc9fmr19303381lfb.666.1649646914808; Sun, 10
 Apr 2022 20:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220410223939.3769-1-rpearsonhpe@gmail.com> <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
In-Reply-To: <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 11 Apr 2022 11:15:03 +0800
Message-ID: <CAD=hENdbxCtqWppW-Xfi6GsjdbS4OLnzkd1JxmE2-NGfA9p8aw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by xarrays"
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-scsi@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 11, 2022 at 11:06 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/10/22 15:39, Bob Pearson wrote:
> > Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
>                                                               ^^^^^^^
>                                                               xarrays?
>
> > @@ -138,8 +140,10 @@ void *rxe_alloc(struct rxe_pool *pool)
> >       elem->obj = obj;
> >       kref_init(&elem->ref_cnt);
> >
> > -     err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > +     xa_lock_irqsave(xa, flags);
> > +     err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> >                             &pool->next, GFP_KERNEL);
> > +     xa_unlock_irqrestore(xa, flags);
>
> Please take a look at the xas_unlock_type() and xas_lock_type() calls in
> __xas_nomem(). I think that the above change will trigger a GFP_KERNEL
> allocation with interrupts disabled. My understanding is that GFP_KERNEL
> allocations may sleep and hence that the above code may cause
> __xas_nomem() to sleep with interrupts disabled. I don't think that is
> allowed.

Thanks. I will send V2.

Zhu Yanjun

>
> Thanks,
>
> Bart.
