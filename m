Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625EF55EA99
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiF1RGK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiF1RGH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 13:06:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6A2B24A
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 10:06:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a4so9847212lfm.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3C6lgNVt/Y+xHEk69ZYYlWNlbW8tBfmExUxbwK8KUBg=;
        b=bxTUSrWnKVhG8L+zirctkGHYvaY1hBM3O5Aj9uImIvdujElWSxyjy9ktfPwUwZ8EPE
         5VlIJa2ajZ/OPelB1vfODTTmIGq5twjutkQ0xV8HlyAOTM+eBBB3nc50xKgoVNkc/IWK
         Tb9yaN/G6qNyS0dW5ZUK5cQC0Ee2gZV8YmjsbZeBcYZtfDoG98A24X2P9MeGS5EruGXF
         hu9NtE+zl/hLqcf+Kzq3UnGelNtNwbW5jffsvR9/v5VHMxhCEHEtCIfJT/aikzMxrp9P
         3fGn2ithfIa94Jw/e4GPxxMvk6gF/cSE1T5h1DVE06Q485NzeI72soIvnQpRa7xsHnNT
         ziew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3C6lgNVt/Y+xHEk69ZYYlWNlbW8tBfmExUxbwK8KUBg=;
        b=VpgJaX/e66mDgCxeGRPplAQlmS2gSDgsHk0CPfLu0pNApX6UAuxvlGnmZar1PDu4ai
         Aoq6yKvDMH0KPDaQC3+aXG1Z3TosnVfbnhA8Dq/TSi3scd91ZaZZfWj5DCE9urbpYds6
         sHwKwxTSz2o2X4XkHjD8AzwPBtcwwiSApMFzzhtMl+7lv/4R2DAzpyxIRH/j6pmRlyQU
         nwkQkWeIBSs7/R2F4QV+kEKIDA5P3d+WG64FVk/7xgeS9nj7Lwxlp/sIVujFv6z2Cwgf
         7GJJhsdzAoS/3itQ8Bg2dk20mySQ7QhxmvDjrwcAg18GVmj7SILIxHh/qyPVlwVBVX/8
         yrHw==
X-Gm-Message-State: AJIora82V43SRl1/wOvxlGqvH0cuqd494GkdB2+KJ2oYxijlXv4QDK/C
        oxq6rKXTN5sJ86ymMfddudBeqzSEVv5ZL7kKaXs=
X-Google-Smtp-Source: AGRyM1teMkgB5+FFFAexWJIjBRwf7WKNJA72jvGQbVIhZSW1qkQ7uioOg4mpzx7mCKGQZjOHoeHY8WgOA77B6sJL2Cw=
X-Received: by 2002:a05:6512:39ca:b0:47f:a9e1:e3b8 with SMTP id
 k10-20020a05651239ca00b0047fa9e1e3b8mr11910512lfu.564.1656435963217; Tue, 28
 Jun 2022 10:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120322.144315-1-haris.phnx@gmail.com> <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca> <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
 <20220628163446.GQ23621@ziepe.ca> <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
 <20220628165047.GR23621@ziepe.ca>
In-Reply-To: <20220628165047.GR23621@ziepe.ca>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Tue, 28 Jun 2022 19:05:37 +0200
Message-ID: <CAE_WKMw9+XuRUyYhAwVVUv1exJQc13_7Vmnm0vQOX2FdCG1M8w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
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

On Tue, Jun 28, 2022 at 6:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 28, 2022 at 06:46:39PM +0200, haris iqbal wrote:
> > On Tue, Jun 28, 2022 at 6:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 06:21:09PM +0200, haris iqbal wrote:
> > >
> > > > > Yes, no driver in Linux suports a disjoint key space.
> > > >
> > > > If disjoint key space is not supported in Linux; does this mean
> > > > irrespective of whether an MR is registered (IB_WR_REG_MR) for LOCAL
> > > > or REMOTE access, both rkey and lkey should be set?
> > >
> > > No.. It means given any key the driver can always tell if it is a rkey
> > > or a lkey. There is never any aliasing of key values. Thus the API
> > > often doesn't have a away to tell if the given key is an rkey or lkey.
> > >
> > > > PS: This discussion started in the following thread,
> > > > https://marc.info/?l=linux-rdma&m=165390868832428&w=2
> > >
> > > rxe is incorrect to not accept the lkey presented on the
> > > invalidate_rkey input. invalidate_rkey is misnamed.
> >
> >
> > Understood. So a better fix for rxe (as compared to the one I sent)
> > would be one of the following (if I understand correctly).
> >
> > 1) The key sent in INV, is compared with lkey or rkey based on which
> > one is set (non-zero).
>
> This one seems to match the spec
>
> However, it requires that keys don't alias, I don't know if rxe has
> done this.

Rxe seems to be NOT aliasing for fast reg. Unsure about other cases.

Maybe Bob or Zhu can shed some light?

>
> > OR,
> > 2) The key sent in INV, is compared with lkey if the MR has only LOCAL
> > access, and rkey if the MR has REMOTE access.
>
> That might make more sense if rxe has aliasing keys and you need to be
> specific about r/l
>
> Jason
