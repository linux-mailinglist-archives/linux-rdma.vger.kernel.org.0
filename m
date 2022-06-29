Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66F5604AA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiF2PbU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiF2PbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 11:31:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730EE3B2BA
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 08:31:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u14so6039551ljh.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9pfRTbMAdE0piymsiC/DAW6FxHpMriX4rR2o9IzMjQ=;
        b=D+bcrJmTBC0cNQdl6AUnTqJVzVvLKLyRyYvwzMrG9whNBNhPc6mnYarrdt46oNHTdB
         n/kbkWCohSefqEVAlvDGecVW0FXaWEq4Wo0B/fx6dKxMWCna4xcGOjqkAB16eLYmsH5S
         mNeyjhSw0LReeydlXhS1wEqSeSjwpwavavDixSj66FRN3vwWVCDj1wEjr4cjCOIRqzH+
         2qYtS/274KYqchZySABEeVKTRqMVCippB+hu2brl4AClL6zFd0Rpz4i26er7MiONL/My
         oBFo1kzkoawjvBySinpzSbpJDLP9YzSg+34VoQ5zKVDpQpTtHrriPkHpWBuVfhPh3TX+
         7kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9pfRTbMAdE0piymsiC/DAW6FxHpMriX4rR2o9IzMjQ=;
        b=F2DpyqZVx0qytU5TJKydtawEIKydkPYF0wFZ5329AnYiNi1I5QZCsEleydaKhmowjY
         E8ShTzASsHvkX4PFzNQ+Lqs1UnUaBWZpej+OmhixmQmJ+56foRrSQEOxaBElK7iE6D2w
         MYMO+jyaPLZdUDZgAfYk58qVESfzTCTHV8/FRUxuE5u+gegrsMYhM1SHrinf08RGHROV
         RQfe0D/7ZcSHirr5G3Vm5VlMEJuSGlyYXfqWiwqwW9A+IsDQyoIXOphdc4uIqgGvNBjB
         dR/XgfUmKQjsMWYm/020hDRt4ZG+ai/KDdfZbZw+zRefNtaY/3eefJS46KEptjUUuTd5
         OW6Q==
X-Gm-Message-State: AJIora9qyJP2SNJ4Ge++wKx6WqaH6wEm8Vo+O45RYRkSeYq5XDDB4M8/
        7v9ZNYQ+KyiB/IHod/ffQOy1mtVIIx2Z0YYk/Ss=
X-Google-Smtp-Source: AGRyM1spYDT897E+eeXRnykQ5ZesYX4fSYRDu+Aqtq0jum8Uyuv/3xtH+Au9CvwNle8xrjoqooQE1TgfIokxbQN8Gi8=
X-Received: by 2002:a2e:7c07:0:b0:25a:73a0:4373 with SMTP id
 x7-20020a2e7c07000000b0025a73a04373mr2145097ljc.409.1656516666594; Wed, 29
 Jun 2022 08:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120322.144315-1-haris.phnx@gmail.com> <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca> <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
 <20220628163446.GQ23621@ziepe.ca> <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
 <20220628165047.GR23621@ziepe.ca> <CAE_WKMw9+XuRUyYhAwVVUv1exJQc13_7Vmnm0vQOX2FdCG1M8w@mail.gmail.com>
 <fa0da24c-2cbf-6251-d0c6-9a7ac3add9ed@gmail.com> <CAE_WKMyL=xc8L23o5t9K5XQVTY=V3ueQnAfdCoOe8cs6YCi0Mw@mail.gmail.com>
 <MW4PR84MB2307B3D35907B1B6DBE58C1FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB2307B3D35907B1B6DBE58C1FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Wed, 29 Jun 2022 17:30:40 +0200
Message-ID: <CAE_WKMwQ22otVUtAKfKsUQVDr9m=J+0ESotn1zfGSg1AQQ0O=Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 29, 2022 at 5:04 PM Pearson, Robert B
<robert.pearson2@hpe.com> wrote:
>
>
>
> -----Original Message-----
> From: haris iqbal <haris.phnx@gmail.com>
> Sent: Wednesday, June 29, 2022 7:57 AM
> To: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; lizhijian@fujitsu.com; linux-rdma@vger.kernel.org; bvanassche@acm.org; leon@kernel.org; haris.iqbal@ionos.com; jinpu.wang@ionos.com; aleksei.marov@ionos.com
> Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
>
> On Tue, Jun 28, 2022 at 10:04 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > On 6/28/22 12:05, haris iqbal wrote:
> > > On Tue, Jun 28, 2022 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >>
> > >> On Tue, Jun 28, 2022 at 06:46:39PM +0200, haris iqbal wrote:
> > >>> On Tue, Jun 28, 2022 at 6:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >>>>
> > >>>> On Tue, Jun 28, 2022 at 06:21:09PM +0200, haris iqbal wrote:
> > >>>>
> > >>>>>> Yes, no driver in Linux suports a disjoint key space.
> > >>>>>
> > >>>>> If disjoint key space is not supported in Linux; does this mean
> > >>>>> irrespective of whether an MR is registered (IB_WR_REG_MR) for
> > >>>>> LOCAL or REMOTE access, both rkey and lkey should be set?
> > >>>>
> > >>>> No.. It means given any key the driver can always tell if it is a
> > >>>> rkey or a lkey. There is never any aliasing of key values. Thus
> > >>>> the API often doesn't have a away to tell if the given key is an rkey or lkey.
> > >>>>
> > >>>>> PS: This discussion started in the following thread,
> > >>>>> https://marc.info/?l=linux-rdma&m=165390868832428&w=2
> > >>>>
> > >>>> rxe is incorrect to not accept the lkey presented on the
> > >>>> invalidate_rkey input. invalidate_rkey is misnamed.
> > >>>
> > >>>
> > >>> Understood. So a better fix for rxe (as compared to the one I
> > >>> sent) would be one of the following (if I understand correctly).
> > >>>
> > >>> 1) The key sent in INV, is compared with lkey or rkey based on
> > >>> which one is set (non-zero).
> > >>
> > >> This one seems to match the spec
> > >>
> > >> However, it requires that keys don't alias, I don't know if rxe has
> > >> done this.
> > >
> > > Rxe seems to be NOT aliasing for fast reg. Unsure about other cases.
> > >
> > > Maybe Bob or Zhu can shed some light?
> > >
> > >>
> > >>> OR,
> > >>> 2) The key sent in INV, is compared with lkey if the MR has only
> > >>> LOCAL access, and rkey if the MR has REMOTE access.
> > >>
> > >> That might make more sense if rxe has aliasing keys and you need to
> > >> be specific about r/l
> > >>
> > >> Jason
> >
> > rxe always has lkey=rkey if rkey is asked for else rkey=0 and lkey is always set.
>
> When you say "rkey is asked for", you mean the access permissions
> (LOCAL/REMOTE) asked for that MR right?
>
> Correct.

Thanks. I will send a patch with the discussed changes for invalidate.

>
> If so, then for RXE to decide which key to compare with while invalidating, it's better to decide based on the access of the MR (basically fix number 2 from my older email).
>
> >
> > Bob
