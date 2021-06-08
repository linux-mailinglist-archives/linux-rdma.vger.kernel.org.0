Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5439EB8E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 03:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFHBls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 21:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFHBlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 21:41:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95071C061574
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 18:39:41 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so14343306oth.9
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTQ+mOwhiBLCm0AEDL3uOE9Dod3EyAjLLQ684oYciKY=;
        b=CJLqizsSR7p5vtw53qO+2UcKTJ0YcAasO/sp4o6I3h+dXipDqHHHMWO3ahI7qwqM7C
         aUMar3PN/mFwRn81uXxLe5pJN+odBgSPjwu4vHAyL2Nw8w4P94+fRtFFhR494RMP94Vk
         XInvxf5OlRU4ZS+7bp1t3mPlZcmTOBh96noRiKU3yng9SxYEL0b56dF1OK4pd1Yeqxbl
         bgH1Kuh8rHuZpe2OM65GO36DpzBtCd6i2HeRjtlklb9kWsMCp39iilgEGC+gDLXur+5X
         m8BvOi9go1Jn0Fjp0/aTX72Tbt/37HmAr//OrHl6SPiV/F6dU3I1Jo55mvNP09cB7Yvr
         /N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTQ+mOwhiBLCm0AEDL3uOE9Dod3EyAjLLQ684oYciKY=;
        b=ojvgUgfEa1R/NnfjP+GnRDJ7NS5fsQPFwqEiQPqFPJlhieLxFFdYiCkeJAmLvKrJEW
         YUqLH2fpPzBKk03uml7CisuZiWGlMr/tB7jMlkLHUbHKXS7UCQprXSyQuapKP1XW5Llr
         422eNZEQIEQyIaIY9zAqextpiiCL0T3Z5hSUdc6YQzAC4JApqycxVNYbMtu2LRHiHiMB
         mZGFua6AOFgAPcgVhqhPSXE476l3QhwlgHmVd+wAokuTHkZFhCsw6uTz+rF+hiIeOxT2
         ZbhnxZ5aSFD0GM22z1gPPgtcVrcuj0gBnfkGMURdVn2JwvF1EkOJbAV3nLqxEyHzmGUA
         QtAw==
X-Gm-Message-State: AOAM5301jtMelP3P3k02SOHIRSETTQigyscPQbf09JonOJUb/Jo5LxKT
        dKoL81xP/rPeHhJQwkoYI9y0kwFz/ibF+FocYYk=
X-Google-Smtp-Source: ABdhPJwD75a9QPr/2eRg0ZaWLWdFEVAxKpgGAuk/1OHDv5npqG5EPN+Q1mWSgXfX9tUCtq9Evvs+O2yZXeUAykmDTfk=
X-Received: by 2002:a9d:3e8:: with SMTP id f95mr9593560otf.53.1623116380957;
 Mon, 07 Jun 2021 18:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210604230558.4812-1-rpearsonhpe@gmail.com> <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
 <YL389Dqd8+akhb1i@unreal> <CAD=hENd6J=1eTPn3u8M5rvym1xP_A30DnreKOCvi+hLTh0iuNw@mail.gmail.com>
 <e0be8fe4-dcda-ddbe-faa4-104d36442b96@gmail.com>
In-Reply-To: <e0be8fe4-dcda-ddbe-faa4-104d36442b96@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 8 Jun 2021 09:39:29 +0800
Message-ID: <CAD=hENeoK7971B4koPPaJ+u_DL=VSgL8zoF3GZXexozSHuK8pA@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic ops
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 8, 2021 at 12:14 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
>
>
> On 6/7/2021 6:12 AM, Zhu Yanjun wrote:
> > On Mon, Jun 7, 2021 at 7:03 PM Leon Romanovsky <leon@kernel.org> wrote:
> >> On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
> >>> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>> Currently the rdma_rxe driver attempts to protect atomic responder
> >>>> resources by taking a reference to the qp which is only freed when the
> >>>> resource is recycled for a new read or atomic operation. This means that
> >>>> in normal circumstances there is almost always an extra qp reference
> >>>> once an atomic operation has been executed which prevents cleaning up
> >>>> the qp and associated pd and cqs when the qp is destroyed.
> >>>>
> >>>> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> >>>> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> >>> Not sure if it is a good way to fix this problem by removing the call
> >>> to rxe_add_ref.
> >>> Because taking a reference to the qp is to protect atomic responder resources.
> >>>
> >>> Removing rxe_add_ref is to decrease the protection of the atomic
> >>> responder resources.
> >> All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.
> >>
> > I made tests with this commit. After this commit is applied, this
> > problem disappeared.
> You were testing MW when you saw this bug. Does that mean that now MW is
> working for you?

Your MW patches are huge. After these patches are applied, I found 2
problems in my test environment.
So IMO, can you send the test cases about MW to rdma-core? So we can
verify these MW patches with them.

In previous mails, you mentioned these MW test cases.

Thanks a lot.
Zhu Yanjun

> >
> > Zhu Yanjun
> >
> >> Thanks
