Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574BD484FF0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiAEJWG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 04:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiAEJWE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 04:22:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2211FC061761;
        Wed,  5 Jan 2022 01:22:04 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x7so87785991lfu.8;
        Wed, 05 Jan 2022 01:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ozC4RD18d/zif83qMqcvR6d7LdWDgofUUYf79hzP2U=;
        b=nYnG47QkqvBatR/LxnstzAup+OV9M7AyBihXYLHYRk5berLON22Y0+hk+247cJ4Wv9
         LDKWfyhMHVRc7vnniFWc7jPTFUyCEDG9yh9tvrihLKDrlxvkjUHdfMNGf3X3RcseCJNJ
         OlE2VLo4wVoW7Hf9wE+vjZ7eNYLZU1eXTa9jM4cAS21Gtcsg1MpBqhxQlcUIUlFjQrV3
         5a4f6Gw0ShOyC/bOHMGa71goRk8glhpYmQdzn9yyYxKKmqg1lvQH/V9oB3xneu47ZE+N
         gycvGzXaI42RSHKJ7dMz0MIZsIJLG69yOSFFWY4gDChrWJLC0wSfSX/LJyjJQKmIZBhs
         iKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ozC4RD18d/zif83qMqcvR6d7LdWDgofUUYf79hzP2U=;
        b=LDqmUtep7vtnmj1yeqhlE2CP79x76Q91JEWGwXdzfZYwhEB+Jwft24TOKVrevisk5o
         cWzA3Eb/e0Sx3UAyWpkBy/EwKWhTQwm+OQ+r0aJq75RyMu/asBIREL/4U0hV1kyC80gJ
         Gg5l49UVAn4GKRza5csB7y7HFID0ircCwqWqONB12ipc/xP47Qs8na0VNj4FP96JmbIK
         tfL1WBVV8L3K1/hWuL/gCDp2W0q5OwDGCEL9RSzkNxLtzYRRKgrUJ99nlYdGf1MW5m+l
         zdLUMiOrft81+5cnBJ5gFgudpcMNeg3ejgBlp9D8KhmVFLjU/97q1+bJUFwjyZ4AIvf1
         620Q==
X-Gm-Message-State: AOAM533n7bXknpfIrZRTkoRCoIjJ0TMj376h5Q45MhoCY6NKaJ02JMG6
        WScFu2VMgh0CdeP6Rjuj5ur815whGS8bMNOvTegnv9NR
X-Google-Smtp-Source: ABdhPJzDAihaOzZJykOAgCItMBTv1n1k0+RApyjdwUUT3PqoTKKHoYFnTHew2UlUKR0/aqPCAKmOjM/0+T2+CHL0lTg=
X-Received: by 2002:a05:6512:374f:: with SMTP id a15mr44500514lfs.571.1641374522417;
 Wed, 05 Jan 2022 01:22:02 -0800 (PST)
MIME-Version: 1.0
References: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
 <CAD=hENesikgUsZ8-DLxNJMR7Wg17WcfXxnvArpa9o6B6bw9Phw@mail.gmail.com> <YdVgpRUsI9CIwTLw@unreal>
In-Reply-To: <YdVgpRUsI9CIwTLw@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 5 Jan 2022 17:21:51 +0800
Message-ID: <CAD=hENcsZykNLws-Swrsub6C-thoZJNYkfHqFr0Vn6pSKv8dbQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Delete deprecated module parameters interface
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 5, 2022 at 5:11 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jan 05, 2022 at 04:55:23PM +0800, Zhu Yanjun wrote:
> > On Wed, Jan 5, 2022 at 4:50 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > Starting from the commit 66920e1b2586 ("rdma_rxe: Use netlink messages
> > > to add/delete links") from the 2019, the RXE modules parameters are marked
> > > as deprecated in favour of rdmatool. So remove the kernel code too.
> >
> > Do you mean that rxe_cfg tool can not be used again?
>
> That tool was removed from the rdma-core a long time ago.

Got it. Thanks.

Zhu Yanjun

>
> Thanks
