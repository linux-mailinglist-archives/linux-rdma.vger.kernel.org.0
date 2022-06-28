Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202055E9B6
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiF1QaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348469AbiF1Q3v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 12:29:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680D43B011
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:21:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so23187864lfg.7
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l3ZPW1BHCylpPqNcTyQYujQUy2XdJuHX89YFSz8wbPY=;
        b=ooEcR0eohYJtoSSm6Cx0/8FsDvlALHSI9t/0aumi4IfgiWaNMxU1ZTjA/LgT4akStD
         MxMvFtuwEK1PLSQPna/pgVNI+RIcZmLbh6mEQ0Nvnnfn2Kp8aUQXZG0fsibpAdWJ50Xb
         TBG0PB7j803Nj3Ca3STt2EhX56gx4EmOiReokWaZJH8UZC9yzdTNahpy5ZwOUCXx6D18
         FHpVsWvXJfHhIV/yJ4FwflxA9mbYpVwUa849nc1ZrCfQ5kQvkQ8+rxat7oPfaRw4lddc
         nlYgZxqb/qF7rEryT6GW+9gvQFMRmbZqGuCTtxRZhBPHdDukoNTNkeJv368Z3gdg36db
         9RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l3ZPW1BHCylpPqNcTyQYujQUy2XdJuHX89YFSz8wbPY=;
        b=MAgWQSOupn2rBsrLIcYiI8VEi2n3FEikdilYVz4yQDGxkTC+B4G5o8sBRX/GMoeCi6
         +icpc7a6Y0Ork20oPXgPood8ybccAZKJ9wmYjXbyp2jD39rRxNtD4L1xn679oHMr+h4q
         zH3F+p5TTFD3lpJgzyYbRP1O+jm6A/Fp+5h4ULZ51LRxR4S56u7LYLCSuiy+MKg4L1Dh
         Hb5XRTGvQS/S8d9QMJFFX6EEgcrhf1kAV/egTcKkaVhPynQWTpIcMSX1qWccINfz4JB8
         dKyprsmXVmoi3cFGUIUybd1qNmeNGcvrddIUvxGlbOMENWEYomaCtn5OoBWnLiygUw+T
         Krmg==
X-Gm-Message-State: AJIora8ob8nlsmFbkbk9Vw5/o3Mwz7J9mAJ/F/UYL/mVXGb0+vttiwKa
        NonS7Qrswr/T8nqWlwXILwa6P5d0eNSWzYMR8/wMepCwh5I0w9dQNqE=
X-Google-Smtp-Source: AGRyM1umL2R6AxjemUSXqTIAsRu1U69pvaVPKEVgsbHjU7rzKb8BRsQQXeGFUeFKnVlSWafhFTw5eMeSy3Y9UzZ7rPc=
X-Received: by 2002:a05:6512:1107:b0:481:18af:26e9 with SMTP id
 l7-20020a056512110700b0048118af26e9mr8047128lfg.83.1656433295331; Tue, 28 Jun
 2022 09:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120322.144315-1-haris.phnx@gmail.com> <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com> <20220624232745.GF23621@ziepe.ca>
In-Reply-To: <20220624232745.GF23621@ziepe.ca>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Tue, 28 Jun 2022 18:21:09 +0200
Message-ID: <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
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

On Sat, Jun 25, 2022 at 1:27 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jun 13, 2022 at 04:20:36PM +0200, haris iqbal wrote:
> > > On 09/06/2022 20:03, Md Haris Iqbal wrote:
> > > > Currently rxe_invalidate_mr does invalidate for both local ops, and=
 remote
> > > > ones. This means that MR being invalidated is compared with rkey fo=
r both,
> > > > which is incorrect. For local invalidate, comparison should happen =
with
> > > > lkey,
> > > Just checked that IBTA SPEC =E2=80=9D10.6.5=E2=80=9C says that consum=
er *must* L_Key, R_Key ...
> > > Not sure whether we should concern these.
>
> I agree, 10.6.5 is quite clear that the ULP must present all of the
> three options and the HCA can choose any of them.
>
> So, rxe cannot have a bug if it always uses the rkey ?
>
> > There are multiple things to consider here.. Since the wr for
> > invalidate can have only one invalidate_rkey, there is probably no way
> > to send lkey and rkey both as mentioned in the spec.
>
> In general what this reflects is that in Linux that we don't really
> completely support the optional idea in IBA that the HCA can have a
> different key space for l and r keys.
>
> > One way to make this work (mlx does this maybe?) is to always make
> > rkey and lkey same and NOT make this dependent on access. Whether an
> > MR is open for RDMA operations or not can be checked through the
> > access permissions. I am guessing this is how it was working before.
>
> Yes, no driver in Linux suports a disjoint key space.

If disjoint key space is not supported in Linux; does this mean
irrespective of whether an MR is registered (IB_WR_REG_MR) for LOCAL
or REMOTE access, both rkey and lkey should be set?

PS: This discussion started in the following thread,
https://marc.info/?l=3Dlinux-rdma&m=3D165390868832428&w=3D2

>
> So, I'm revoking my 'this makes sense to me' - the commit message does
> not explain how the IBA requires the use of a lkey for a local
> invalidate.
>
> Jason
