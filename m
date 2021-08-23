Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC43F453C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhHWGtV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHWGtH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 02:49:07 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BEC061575
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 23:48:22 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so33700812otf.6
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FvoLTH7araNBBj6tzE009qkOqdh4jZ0pDmMwOQ+2Wg=;
        b=TixWsFGNh15iQ01IiwGGTjWe58hwqRlDeYuG9Wn4g3jfKUG9HbqcQusLggNwnmAfON
         XVyKxNmgBLRYKjgDbONjaeVIpL5Rc0IqgtGuPeV73Qz0qjlck1GHbYFBKCFX5GBetCtS
         o/K7IZEdo3HoZH1mAIwjBnPBESTmNWBRYmkE+w6LLiwc4fvz8axuCS/SZnZ+CGgt3Wa2
         xGq9l7ql1etvqxlJPn7Wcsu1rBf6F3YCbjbUyE/TdDN3RYoTLo9Nho3xborbqCDSzUIt
         KVqTanOODwcHWka9H7ZypEB9I00m2aqB4hyHYpfr9wRrUa6765r6IDBbST5JoNXUhggE
         iZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FvoLTH7araNBBj6tzE009qkOqdh4jZ0pDmMwOQ+2Wg=;
        b=gnAgZCZ4pKaHIhFci/kDemgTnf4LSLNZe12nfWzb9znEjRCMW1QBx1evv77q5gdVgp
         x71Fz8WXja9N6L6vEDL/gSJBOhimyEG8Yu4+aAgtYW9dIlLTnZaKe9b4ZyicJOPRp86S
         aiMcr5PkRmAbt85y4/i5YxNXkRdD20OfAWjg7K6N1ExYpIxelD3NiCLc8EtTHvSPFZQ5
         grUGivBU0YFnwrmlinhUoU0L3m5X75bFNYL5GQeqtP7FC78gTI42cYXd6QnMAyMIwcFc
         hH/HcedGgvTUjFn1N83xZYQYsyKL8Hs5+lvAS5kLhfcPo4Ea5foKF8PbcpxDD2zarII0
         uFvw==
X-Gm-Message-State: AOAM531f98UnNbKH7NJv6/L7KTEiB8fmsK/jonDjj8QyqVZhEqMhtYBp
        l0Kis18w0qG+86rLaxU3Y6usEg282hwS2VLf5PI=
X-Google-Smtp-Source: ABdhPJyoemVYB6dF/K9zE1s83XgkSGnQOMZXvrByusK8nE47dQCuHMYJjfahgvJMj/1CBeilWIYHVRPeOROeiuiWG3s=
X-Received: by 2002:aca:2814:: with SMTP id 20mr10333852oix.89.1629701302337;
 Sun, 22 Aug 2021 23:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111509.172500-1-yangx.jy@fujitsu.com> <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
 <61232609.7020500@fujitsu.com> <CAD=hENcMv9d-gTdEpXtgUwSm45d89LwWsHJiUALUUmhsEiU+Cg@mail.gmail.com>
 <61233DA7.7020006@fujitsu.com>
In-Reply-To: <61233DA7.7020006@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 23 Aug 2021 14:48:11 +0800
Message-ID: <CAD=hENcaTYhvive_irxQXtTgRZREYPqi253XVane+Nz2WRHQLA@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 2:18 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/23 13:42, Zhu Yanjun wrote:
> > On Mon, Aug 23, 2021 at 12:37 PM yangx.jy@fujitsu.com
> > <yangx.jy@fujitsu.com>  wrote:
> >> On 2021/8/21 15:21, Zhu Yanjun wrote:
> >>> On Fri, Aug 20, 2021 at 6:44 PM Xiao Yang<yangx.jy@fujitsu.com>   wrote:
> >>>> 1) New index member of struct rxe_queue is introduced but not zeroed
> >>>>      so the initial value of index may be random.
> >>>> 2) Current index is not masked off to index_mask.
> >>>> In such case, producer_addr() and consumer_addr() will get an invalid
> >>>> address by the random index and then accessing the invalid address
> >>>> triggers the following panic:
> >>>> "BUG: unable to handle page fault for address: ffff9ae2c07a1414"
> >>>>
> >>>> Fix the issue by using kzalloc() to zero out index member.
> >>>>
> >>>> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> >>>> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >>>> ---
> >>>>    drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> >>>> index 85b812586ed4..72d95398e604 100644
> >>>> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> >>>> @@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
> >>>>           if (*num_elem<   0)
> >>>>                   goto err1;
> >>>>
> >>>> -       q = kmalloc(sizeof(*q), GFP_KERNEL);
> >>>> +       q = kzalloc(sizeof(*q), GFP_KERNEL);
> >>> Perhaps this is why I can not reproduce this problem in the local host.
> >> Hi Yanjun,
> >>
> >> I forgot to say that I reproduced the issue on my local vm.
> > Which OS are you using to reproduce this problem?
>
> OS is fedora31.

Can you reproduce this problem on Ubuntu 20.04?

Thanks,
Zhu Yanjun

>
> > Zhu Yanjun
> >
> >> Best Regards,
> >> Xiao Yang
> >>> Zhu Yanjun
> >>>
> >>>>           if (!q)
> >>>>                   goto err1;
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>>
