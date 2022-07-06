Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D6567C9B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 05:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGFDli (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 23:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGFDlh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 23:41:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E971D321
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 20:41:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q8so4413999ljj.10
        for <linux-rdma@vger.kernel.org>; Tue, 05 Jul 2022 20:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gvgUrxB5UQ9dvst8igDU/5Z0zJPgTCdiqPOfHTuycFQ=;
        b=LX4hMAI+lKKMzZip8pSwPhELONiiDQ5a5xYPAzf4uempk7/bHuL4T4e3N6CyPFe8hB
         iLvcfJFkU7VB7xTxu+4JkpwXeq1xLZtQFnDSsSG0PKZWIIC6+QBTiClnmLoczx9ZYYmW
         8I/fcQwUve1NfOYi4gzOh1mTea0+MfTV1JpO68l5yJq98tTz8byTJq714Krv8rPmObJi
         nQO0KBz+beQnF2/wyiTsuSMQrgkcT93yLe/2VUgHSdYzOmGzi+KCAWZFF/mzZ3KWXS5a
         0UH/UTsAsQqaysHFE0MaCK7j0u5hp4P3Qrnkg/VqlKuOuATf3WeY3ERD8dBAjaRLVllv
         C2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gvgUrxB5UQ9dvst8igDU/5Z0zJPgTCdiqPOfHTuycFQ=;
        b=h3R6eqTi0q9IR4x0J/vGjPFxsiMo2mVBOoiDwLDGIkzYea6ExwLEi9vPchN618jvT/
         +y0gioqVVvUtBVMcBhgE2Hl+5zJe+AvOYa7fJVCOr798HTziFEsFD0H8Fs0YLUhhsqEl
         LMpDg/SDj6q6Ne0Q8fPzd+s1UfrnFkluHSnD+gqTjoOoPLzvd+Z/h9Ew65QOaiXtlVaJ
         NugShtdHJL3lROZDazOAECEzhuJBCTbr4QdSCDdmGRQareAzlAknx66vwCh+72kFc7df
         V0lifaU4YdXKhKiFkwJSM3R+snM1jt2XAMD9n1Yi9jGdJ0Zd72PWudNzf/PcxjVu+Xna
         +LlA==
X-Gm-Message-State: AJIora813DKlDl67sS2C7j+Ed5f8eJNLg3HbwlFkNWbum4uPluxr1XMY
        8MVrGPPgtDMGVrELctpQHjJRrvEayQ9QysipE4Y=
X-Google-Smtp-Source: AGRyM1sA2Cz0VmfLXgZBLSCLwF87cJatQTLjtQEyX/Zsl5SnmX1H60LdZuMLBPmLbmrcqLvofqv1zNBFKA0xMD6SfBY=
X-Received: by 2002:a2e:7c07:0:b0:25a:73a0:4373 with SMTP id
 x7-20020a2e7c07000000b0025a73a04373mr21698041ljc.409.1657078894656; Tue, 05
 Jul 2022 20:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220629164946.521293-1-haris.phnx@gmail.com> <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <20220629184432.GW23621@ziepe.ca> <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <CAE_WKMzMi7A5qYp71ez=4E1BxcUNYCDeYq4DmFjxWMoHYRusAA@mail.gmail.com> <20220705135959.GG23621@ziepe.ca>
In-Reply-To: <20220705135959.GG23621@ziepe.ca>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Wed, 6 Jul 2022 05:41:08 +0200
Message-ID: <CAE_WKMxGZqa-GDxLQ1fG9icCjGyXK=cvu8xtrLym2oxPuo559Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR access
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 5, 2022 at 4:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 05, 2022 at 11:28:59AM +0200, haris iqbal wrote:
> > On Wed, Jun 29, 2022 at 8:48 PM Pearson, Robert B
> > <robert.pearson2@hpe.com> wrote:
> > >
> > > > > > If the rkey's and lkeys are always the same why do we store the=
m twice in the mr ?
> > > > >
> > > > > They are not always the same currently. If you request remote acc=
ess they are the same if you don't rkey is set to zero.
> > > > > You could, of course, check both the keys and the access bits but=
 that is not the way it is written currently.
> > >
> > > > Storing the rkey instead of checking the flags seems like a weird o=
bfuscation to me..
> > >
> > > > Jason
> > >
> > > One always has the choice to always just use the lkey and check the f=
lags. But referring the rkey just uses one memory reference =F0=9F=98=8A
> >
> > Have we reached a consensus here as to how to solve this?
> >
> > This (and the issue created by dual map) has basically caused a
> > regression in RTRS since the 5.15. And we would appreciate it a lot if
> > the fix goes in and is backported.
>
> I think your patch is close, it should just be tweaked a bit.

I couldn't conclude from the conversation above what that tweak should
be, if a conclusion has been reached. If not, then I'll wait.

>
> Jason
