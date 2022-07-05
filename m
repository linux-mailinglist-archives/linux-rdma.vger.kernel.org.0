Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0C56662A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiGEJaK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiGEJ3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 05:29:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD7811143
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 02:29:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a11so13772185ljb.5
        for <linux-rdma@vger.kernel.org>; Tue, 05 Jul 2022 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R//HU7C+165KJTyX+ItPsS4149nMZnC2T5iv7NY8pnk=;
        b=NuQ0qf0LyVbbFBVOJ2Y8JxuPcZV00/xiTDL3ZxyoZpTXvq1qfsKxqOM9iXghqY/mRp
         mNLjyI0exy/xs88kDSmuHAZcfKbnvdbogAd1tH6qZ0W1mQxVpk5c/pnlQm0Sem+t6/Pr
         i6A48FooY4Sbge3nbshjZg0naCY3D2jwfhU9UGhTYudPX/VeFPNtrQ/qb37cX+8NAd1U
         Y/seJfbMMrSdtztnWN3sSLi2ULVNL4gavOrZcp+0TQlwheL2AZLNzlTHWZxZ5JqLLMnw
         T4oRrYOrpPJhHt57CsMsfKnYWIwVuUn5fRdkT2QpCkmxk9zSZxoihZAZaPfa6nu7Kwtf
         9jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R//HU7C+165KJTyX+ItPsS4149nMZnC2T5iv7NY8pnk=;
        b=7uaxrzhhpGdpH57SCuB9eJMKP1vuRUle4teoaJHtejY8aXoFNCgU3hixvqznHxvC21
         APbzDRYkrFgGCcHQZhMb2uO138aW/yqmWenKF1h6zHOHGrUtMZSWJ1RLVFzZytnD2n3m
         IDyDKJYcTnkjTLk8L3LpCLbBC4fxMn2qqYKyC4SsU0gJau97b04ohCm8hiclNDYs/zR/
         WnOOlu9jFUZzw67Lc6p5xuxtm3vouPv0leJjQxZ6LgthNqOXMR+R89lDfOTcEXAb878N
         sNBA8wgfKH5FhvFJBVr6agL7SD6F8aVDDfowW6P7eCHMaXjY9KOvH1Uo8BQpjn0yYXi6
         hbXw==
X-Gm-Message-State: AJIora/1bKwxj7hOkO1YGMGk5mDQ3yElIWvdGH6+RqFu3DZDWjNk7R/2
        94WstQYRCobM4hYPhsyRoESrJveDWhdF0namY2Q=
X-Google-Smtp-Source: AGRyM1to7PSzB+eIu9/zgYMq6KFMTER5kB3TruzL5fFsTo3spSZHDr3r2Bqe62MmcOtUEibeGNAMxy9Ahd1or9CAnO8=
X-Received: by 2002:a2e:7c07:0:b0:25a:73a0:4373 with SMTP id
 x7-20020a2e7c07000000b0025a73a04373mr18983473ljc.409.1657013365300; Tue, 05
 Jul 2022 02:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220629164946.521293-1-haris.phnx@gmail.com> <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <20220629184432.GW23621@ziepe.ca> <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Tue, 5 Jul 2022 11:28:59 +0200
Message-ID: <CAE_WKMzMi7A5qYp71ez=4E1BxcUNYCDeYq4DmFjxWMoHYRusAA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR access
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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

On Wed, Jun 29, 2022 at 8:48 PM Pearson, Robert B
<robert.pearson2@hpe.com> wrote:
>
> > > > If the rkey's and lkeys are always the same why do we store them tw=
ice in the mr ?
> > >
> > > They are not always the same currently. If you request remote access =
they are the same if you don't rkey is set to zero.
> > > You could, of course, check both the keys and the access bits but tha=
t is not the way it is written currently.
>
> > Storing the rkey instead of checking the flags seems like a weird obfus=
cation to me..
>
> > Jason
>
> One always has the choice to always just use the lkey and check the flags=
. But referring the rkey just uses one memory reference =F0=9F=98=8A

Have we reached a consensus here as to how to solve this?

This (and the issue created by dual map) has basically caused a
regression in RTRS since the 5.15. And we would appreciate it a lot if
the fix goes in and is backported.
