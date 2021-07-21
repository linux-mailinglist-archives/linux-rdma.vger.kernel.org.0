Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E23D08B8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhGUFg2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhGUFgZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 01:36:25 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95ABC0613DB
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jul 2021 23:16:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 31-20020a9d0ea20000b02904d360fbc71bso372359otj.10
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jul 2021 23:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMQJVtgkbgPtnvf5YGE76qjT5o/b4nlwgox6KWeyNvs=;
        b=k53D0H3UM814xzyivIhnBq8LcT0FPs6U3KRCzDV0rk8WHsAE1+z2L9Iw6x91snDD21
         SO6bw2HXlIvqoRau0iAWHh20OTc8unIgLR8JGJzAG7GWnR3Elt6WEnKM8KX1QwCHHTks
         R+aGeUioB2NCTTgpzZAi/vdSo7jax9mSrl4FcO2buiXi6ZVpNW4luPAntf2zOxQpd1x2
         tF+txFZbq5i/T7rr9YPGvbnZcSdQuElnzjwfpoUGmfQh/GBEbCiFIgRjkNAm0eOFKAT0
         S1g4GdTuikqcvwu4BR1TqM+EGpHsWl9EOZWd0tkPdu0ejchAo3Yp4AMjUKKJYcSkSOG9
         3Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMQJVtgkbgPtnvf5YGE76qjT5o/b4nlwgox6KWeyNvs=;
        b=uCy98/vdrQxCbRk2NWhn4js+swl7Txe614SaJ+8C0lkpDh1HFPEKqMZpCPary4hvoN
         gBDSEsMSTCqmVji2RUeGMk3mABSWRrdsSAH2pC20JTfWhJvyi0u3ueDqfa597GYdFNk5
         ARDEC4+5iBF8V4LN6HYWMuoM100Tk736zjvQRanwz8XXoLVgNIHidaDFnBskDyT7syJC
         QiaL7jkEqtuoIHVBuwhPLl8PjbNQ1cNH8eIUXoS1bGZMmFnpTpJWz4pVw/zdezpOaA7h
         hjzDVACNB+SfLkqZgnUqviPTGcfICulm/FFDINilcvdNP/U0TgO1I+4vng6FGhL78KQH
         rLSA==
X-Gm-Message-State: AOAM530V01zJEgpqBGpwmPR1MA2pZ8C6Psdq+O0a/AMgMynKDlWlWGRT
        Hjlk66/Yv9ZsnVgSLP+sbSCng8fTebKEDWU2jNM=
X-Google-Smtp-Source: ABdhPJy99OUeMN+zWE6Gt/0JqO4X+vwt6aJXrSOtuJGBWVQCVku1P8IB1+2G2xFE6SiWyEbJDAubCHe2T7m/dYf+IuE=
X-Received: by 2002:a05:6830:4188:: with SMTP id r8mr12644632otu.53.1626848210327;
 Tue, 20 Jul 2021 23:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
 <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com> <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
In-Reply-To: <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 21 Jul 2021 14:16:39 +0800
Message-ID: <CAD=hENfEeHDMO8h09xtUYrn+2zv=xuSxCy6s2LrnWka11NneTg@mail.gmail.com>
Subject: Re: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 5:48 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Tue, Jul 20, 2021 at 2:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > On 7/19/21 10:46 PM, Olga Kornievskaia wrote:
> > > Hello,
> > >
> > > I would like to report that the rxe driver got broken some time
> > > between 5.13 and 5.14-rc1 (so basically the last git pull). It's not
> > > just NFSoRDMA but simple rping doesn't work. I believe I found the
> > > problematic commit: 5bcf5a59c41e19141783c7305d420a5e36c937b2
> > > "RDMA/rxe: Protext kernel index from user space"
> > >
> > > Server side logs: "rdma_rxe: bad ICRC from <>".
> > >
> > Thanks. That is helpful. Will try to find it.
>
> Thank you, I appreciate you looking into it. Actually I'm not 100%
> confident that's the commit for this particular problem "I" was seeing
> in 5.14-rc (which was rping hanging but not crashing. An NFS mount
> also hangs, doesn't crash) . But what git bisect was going thru and
> encountering crashes so can't say what it "found". So I think that's
> the one that cashes kernel oops. I think something else leads to the
> bad ICRC.

Thanks a lot. I will delve into this problem.

Zhu Yanjun

>
> I have a general question. I see that you've been posting a lot of
> work on RDMA/rxe lately. Can this be viewed as somebody (you/your
> company) is now actively supporting rxe driver? It looked like
> previously Mellanox had abandoned support for it. We ran into several
> issues trying to use rxe for NFSoRDMA throughout the years but they
> were not being addressed.
>
> There were a number of commits that lead to crashes. commit
> ec9bf373f2458f4b5f1ece8b93a07e6204081667 "RDMA/core: Use refcount_t
> instead of atomic_t on refcount of ib_uverbs_device" leads to the
> following kernel oops. commit 205be5dc9984b67a3b388cbdaa27a2f2644a4bd6
> "RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"" also leads
> to the kernel oops.
