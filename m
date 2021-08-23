Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA793F44AD
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 07:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhHWFnk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 01:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhHWFnk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 01:43:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC9C061575
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 22:42:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso1718253otv.12
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNurZM7tQoUP5Z0R6iy+85j73ENG7B+xbf1mWOVhuX4=;
        b=EW98uQsCu5tzkA/cK853OvlGcEzEczZWW0KF/zHByHEqT33BAeldS9jwbaUuUpze2D
         n99iTQKKHC/97/olgHukIERE//jjdbURQ9umwHlwLI8M/UG34SVBiZSAfNCh3zbiA8x6
         sI12dWhUuKfbVPe3Q8kS8P9ktWhejvmYacTEaXWn7tuXumrHHI4FUp2qlsgxJgyVqwu/
         GvTRmgXve9i883J7+zMz2ucCrHHapv0deQSnnFQ9D6mrTuEbbjp2pcNnltroI7xMdUAs
         pkUvVlSOWz16pNreb/pRSAGYU6H3HzgllmrxzkDdHJpdEuFhcrjIegDeMyZ3qMZ0ohL7
         Ve0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNurZM7tQoUP5Z0R6iy+85j73ENG7B+xbf1mWOVhuX4=;
        b=lpINXVSGNGt7vr569iD0ODGy4sY1N+urBrli/8hEj260ljXg6SSD9JKJFmMPgbksOz
         k4XZgRzzY/jTR6tRotNm1Vs3OFa4thOqhRNaSObyUV0VSfMTdcLUUgVHl92YoExvGWcb
         Phn2xhqfj9uNFblQCdq2pdcXmB3isxTeAqUQzjb4wna0Zwlo7IypfCxqwMpdbUimJS0D
         YWoSiwlq2hF6CRLrMbIuYE28oTq3BWpozHpGvKlpwOxHOydoe/SjzIer1Y9G5mpDKUi6
         ldYd/+oLZGnlazX8kcOLVp3a7B59/2p0EDXpApzbrIWgZMy1ZiofZORE3cdvdBUDp6YP
         V4SA==
X-Gm-Message-State: AOAM532vWD8XytcZhAMUprgd3jz5Kl+jpWX1L5LSynxBmn0OnqUSSFxf
        6ijgzSvhUUaIbC0algY+4+3Uq265aLZqDzwqXeI=
X-Google-Smtp-Source: ABdhPJww3OWYfIJU6v0mddn2ZTUIC7CWIBRFJV1ouicPafc72lyOVgv4GxSWkleGy3hJq2mg0+7ls0KOh4FVqkWjlGQ=
X-Received: by 2002:aca:2814:: with SMTP id 20mr10232633oix.89.1629697378118;
 Sun, 22 Aug 2021 22:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111509.172500-1-yangx.jy@fujitsu.com> <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
 <61232609.7020500@fujitsu.com>
In-Reply-To: <61232609.7020500@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 23 Aug 2021 13:42:46 +0800
Message-ID: <CAD=hENcMv9d-gTdEpXtgUwSm45d89LwWsHJiUALUUmhsEiU+Cg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 12:37 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/21 15:21, Zhu Yanjun wrote:
> > On Fri, Aug 20, 2021 at 6:44 PM Xiao Yang<yangx.jy@fujitsu.com>  wrote:
> >> 1) New index member of struct rxe_queue is introduced but not zeroed
> >>     so the initial value of index may be random.
> >> 2) Current index is not masked off to index_mask.
> >> In such case, producer_addr() and consumer_addr() will get an invalid
> >> address by the random index and then accessing the invalid address
> >> triggers the following panic:
> >> "BUG: unable to handle page fault for address: ffff9ae2c07a1414"
> >>
> >> Fix the issue by using kzalloc() to zero out index member.
> >>
> >> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> >> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> >> index 85b812586ed4..72d95398e604 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> >> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
> >>          if (*num_elem<  0)
> >>                  goto err1;
> >>
> >> -       q = kmalloc(sizeof(*q), GFP_KERNEL);
> >> +       q = kzalloc(sizeof(*q), GFP_KERNEL);
> > Perhaps this is why I can not reproduce this problem in the local host.
> Hi Yanjun,
>
> I forgot to say that I reproduced the issue on my local vm.

Which OS are you using to reproduce this problem?

Zhu Yanjun

>
> Best Regards,
> Xiao Yang
> > Zhu Yanjun
> >
> >>          if (!q)
> >>                  goto err1;
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >>
