Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7877555EA2A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiF1Qut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbiF1QtV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 12:49:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE7F3A
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:47:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j21so23371834lfe.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BP7FK/Z/M6cRbx9khzTj03CJxUcFpqRzmvXQdLom5/M=;
        b=evQGOKPz52NtPkoykLzMVPnhrYLhAnzV+6tSuAWVsM0FaC6YVIAHmrlkIUEHKDSnhD
         JQkMO6soCITiUq+/EfIyCvz0wUxUwhbiaDtl6B7nmy3ytSITilXL36KLMeH4v6PTKgSI
         6IV4X4i3dMSSv3qnUxTVpCASgkgbnh+z/1wHnBmTaqbiI8T0OMewp/Arh76ShhkIsdfd
         WmBkRxo3s5ZQVJ9z/OfBuGXxGGQFwWpzl/Dnhzv2Hu5poD3oUebP1K7HxPqkuMw0ULDa
         M+tECzLjQHgZpoZkgC6qDUvEcB7bsRnWqIBFlLtKnzL8IlOrlOtQYjcvJ9dKqoWc+D0+
         sIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BP7FK/Z/M6cRbx9khzTj03CJxUcFpqRzmvXQdLom5/M=;
        b=tP2lEcOiNWUkvo3REgQ2OUhYGb8X+Cc5x3BEDLUeDzgLYQ0VjetnZExQFsfQzLzkhp
         QZsAEwUdmtFszdwxMc3CIfQc2Fmpf2F23HMKFr/RydN55jMOuI8QY6GrO9+nU/vZt71P
         Fw/3AOzxYwfXQwLcjmNBdRtckGOeEOZdoFROq5zC43X1Q0QlDnthkJAIfHvAASOxsWdN
         lj3Zi6/q0DMDv5GdgdqYEW0737xv8qlR/FwhUIFgewwiNsX76FioRiigWQ7lXFc6OWta
         Es/n7SZ9SDO+5z2Qo+kaRHWexnLloYUngEUo6FJK3LXd4o3Qrr9N4RC4mx6jJB/ABdjG
         S0pQ==
X-Gm-Message-State: AJIora+xP2foKiSLFWapA/eVVdGBwygK25MEnKaWr2uo25yumjm9Fri7
        O1XnnX0Z3fCx17iahh10ctbcFQLMNleOx4eb/yk=
X-Google-Smtp-Source: AGRyM1vQWss1lzTCRb9acZcQqkfvPah+sexzh51X5erhCLue532ZJk6uwkzSShr68V+GPxJ2cauVEV27Si7KMrdFUXY=
X-Received: by 2002:a05:6512:6d1:b0:47f:6471:cfb7 with SMTP id
 u17-20020a05651206d100b0047f6471cfb7mr11975389lff.337.1656434825999; Tue, 28
 Jun 2022 09:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120322.144315-1-haris.phnx@gmail.com> <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca> <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
 <20220628163446.GQ23621@ziepe.ca>
In-Reply-To: <20220628163446.GQ23621@ziepe.ca>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Tue, 28 Jun 2022 18:46:39 +0200
Message-ID: <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
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

On Tue, Jun 28, 2022 at 6:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 28, 2022 at 06:21:09PM +0200, haris iqbal wrote:
>
> > > Yes, no driver in Linux suports a disjoint key space.
> >
> > If disjoint key space is not supported in Linux; does this mean
> > irrespective of whether an MR is registered (IB_WR_REG_MR) for LOCAL
> > or REMOTE access, both rkey and lkey should be set?
>
> No.. It means given any key the driver can always tell if it is a rkey
> or a lkey. There is never any aliasing of key values. Thus the API
> often doesn't have a away to tell if the given key is an rkey or lkey.
>
> > PS: This discussion started in the following thread,
> > https://marc.info/?l=linux-rdma&m=165390868832428&w=2
>
> rxe is incorrect to not accept the lkey presented on the
> invalidate_rkey input. invalidate_rkey is misnamed.


Understood. So a better fix for rxe (as compared to the one I sent)
would be one of the following (if I understand correctly).

1) The key sent in INV, is compared with lkey or rkey based on which
one is set (non-zero).
OR,
2) The key sent in INV, is compared with lkey if the MR has only LOCAL
access, and rkey if the MR has REMOTE access.

>
> Jason
