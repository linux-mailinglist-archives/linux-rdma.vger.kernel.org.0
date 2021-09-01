Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB83FD3A6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 08:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbhIAGEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 02:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbhIAGEO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 02:04:14 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1097C061575
        for <linux-rdma@vger.kernel.org>; Tue, 31 Aug 2021 23:03:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id c6so2711301ybm.10
        for <linux-rdma@vger.kernel.org>; Tue, 31 Aug 2021 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+IMTR13wqS342Tx2hQvMP33gVQIZ9nEN9PGpOJ65wk=;
        b=F+KJy67u6CrNTNhF1l8XWj7J65pEUaaumOJPmf/MlTRcR5ABexgcGo3HiiVVjy2cOg
         XFm1XMrLQxbyRYG/nCeZdEUYh68jquHAv5Ks5YO2HNljRy3QdiFuftFylP2Vx+Rfwo4/
         1lXcizU77DLdR/Bd8uILKT9j1zllBPBxGe4cCSnN84oopYArTZDcx0tn8IcPdcq5afG/
         f3vnzs5Beu1iyD0jjS/Uijofqri6Uf64nLsZqZLk+BTOG4gkfVxBA44+AAHBLlpbkZlV
         Q7C07jzXFPZ84yNXTze3gW6gLFDJRJWjBqPDFdueaNGekJ59fb48Y5dRhkq91CKzOHTO
         LqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+IMTR13wqS342Tx2hQvMP33gVQIZ9nEN9PGpOJ65wk=;
        b=TN+7kynwFQblD0yhsDkO5Ibd6GoNEIEhaYdCNtCo9Z00DbnBGRvyM6ejyeUre+mERh
         EpPS0MM9U+lzMQ5Aize5YPgaE+mBCvRnyeElDRN5jqygHEebEP2C5YYrEqxHYttfBRAs
         eupGVI7DiS0UbNnw8XbZHQvWOJh9lfukxf5/UMt7GVmejSUTuSKwPdz0MIVBZuB6ZxOZ
         3GC8c0Jh8c0JDRLsXuTTogtt0ig5I5HHClbDmqmHf67txkHSC4yQgxmolqRbiS2aPJOz
         WGvqLKuTVgeUEgIzvJAVLdNxETxP4LktNiefS8VBJTLh7dSX2hlA8PPnpYlkwTuZm89y
         +iIQ==
X-Gm-Message-State: AOAM530un3Y+uIfLRF8jU0/lIkwTuCPVpPajYbUKNHNescqr3Bk7wm47
        WUB/V5OwvIOhLVtQ76tLQiH4+7vd7cRRKI3DRj0=
X-Google-Smtp-Source: ABdhPJxfrbFCs1RbvBVLFlmCiT/3VLrvx3WtActsplIZ3v51VA8sJ5wFoJMb0i57Ou+tBi+7JxezQ8OgoLYTM6TuEPc=
X-Received: by 2002:a25:ce50:: with SMTP id x77mr36222547ybe.290.1630476196017;
 Tue, 31 Aug 2021 23:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111509.172500-1-yangx.jy@fujitsu.com> <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
 <61232609.7020500@fujitsu.com> <CAD=hENcMv9d-gTdEpXtgUwSm45d89LwWsHJiUALUUmhsEiU+Cg@mail.gmail.com>
 <61233DA7.7020006@fujitsu.com> <CAD=hENcaTYhvive_irxQXtTgRZREYPqi253XVane+Nz2WRHQLA@mail.gmail.com>
 <612F12C8.8080701@fujitsu.com>
In-Reply-To: <612F12C8.8080701@fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 1 Sep 2021 14:03:04 +0800
Message-ID: <CAD=hENdz13G9zp6Esu-iGUws186JgX3aMmMrSiXyMsQJiWMe1Q@mail.gmail.com>
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

On Wed, Sep 1, 2021 at 1:42 PM yangx.jy@fujitsu.com
<yangx.jy@fujitsu.com> wrote:
>
> On 2021/8/23 14:48, Zhu Yanjun wrote:
> > Can you reproduce this problem on Ubuntu 20.04?
> Hi Yanjun,
>
> I cannot reproduce this issue on Ubuntu 20.04 vm for now.
> I think I didn't hit the condition where q->index gets the random value
> after kmalloc().

Sure. Thanks a lot.
I can not reproduce this problem on Ubuntu 20.04.

Zhu Yanjun

> Perhaps only when allocating the memory which has been used and freed
> before.
>
> Best Regards,
> Xiao Yang
> > Thanks,
> > Zhu Yanjun
