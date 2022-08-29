Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646E5A423A
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 07:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiH2F1v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 01:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiH2F1u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 01:27:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC94598F
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 22:27:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so13483136ejy.5
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Rl3H3kwhWRRuIV9mnCNIVAy3s7btuOoctkFdruBo/gs=;
        b=QYoZhw2R+dKSGUHL6/g3iTZCg2fFJoYMmPT+Tnniby0tI4ULrhG/bFOu9zP9+aQ9dk
         63s4scAsjmvPnO31UjV3YIEq/Vp2dZIs+cbyXiPRTq3fLULPjftam66LZ8HiOX9lCV6P
         EJ9KptlID85EbmZ6czzjY8SaEuoqml0rqXpXxcP+PGxwFuc+xA2us7/qeVx/llqlCPDW
         ygU1fzYoDKaawxdKGF+HkzNa1folwGqNudPDT21wRkqGfyyla7Xs5wv//wv/7i3UXqiM
         RH+TyrWlFyZLZTW6UMJPfwD2KoHXVqyufdADuDT/KpWdk4BZvAjUONCtIRHcvHCwtO3I
         Erfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Rl3H3kwhWRRuIV9mnCNIVAy3s7btuOoctkFdruBo/gs=;
        b=Jxativ+KTumbJkDPGFUWk898ulYkgS81N9EwqLSd806W9Btr0HMq5XIbNDAPi04cj7
         LYe9zirTtiseOcaHidnvgXCDksqcOL3FZruQmD/TUoffDzzS79PZKLKW80t11GOPC69h
         qNdsx/8CNcu2eWeDWdFqqNPG0xIRM4/MmjIvqbQ8tVy9YiCi8zp8S7t9BsikfuB7qFXK
         saEdZsKuuSkb5t1uFVd2C9juVa+PA/lfACbjQOMnFZTc10YWzQHUKilyH0IHOUyetL76
         ELPhdBNQWcY6zalKPlKRq+BgY5uglxASJOiVQqxiq9TOgiBuAojFUX+6uLa2Rqn3odaq
         ogbA==
X-Gm-Message-State: ACgBeo1hbKph/XAENOXrekYDVnWAzzlEzkGwCLQwbluR0qCV01ueEu+O
        g7hLVCTzrll3jfhe/pR5kGqJLSxzDvLfojbBi2caxQ==
X-Google-Smtp-Source: AA6agR7cPPJa1sKgkh6/MbfaeUh3WlrXGuwxWXehUisqM5f40Y++fv9Irl9n5l6HE90qgIxVV7Oinz8hTxi1fhykU2U=
X-Received: by 2002:a17:907:6285:b0:738:e862:a1b with SMTP id
 nd5-20020a170907628500b00738e8620a1bmr12847279ejc.70.1661750865893; Sun, 28
 Aug 2022 22:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220826095615.74328-1-jinpu.wang@ionos.com> <20220826095615.74328-2-jinpu.wang@ionos.com>
 <Yws+/FLRudJE08Xk@unreal>
In-Reply-To: <Yws+/FLRudJE08Xk@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 29 Aug 2022 07:27:35 +0200
Message-ID: <CAMGffEnoHHeWLE=_WKT96YErXmBK-8mpvRz6=6CRaicaPi+9hg@mail.gmail.com>
Subject: Re: [PATCH 1/2] infiniband/mthca: Fix dma_map_sg error check
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 28, 2022 at 12:10 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Aug 26, 2022 at 11:56:14AM +0200, Jack Wang wrote:
> > dma_map_sg return 0 on error, in case of error set
> > EIO as return code.
> >
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: "H=C3=A5kon Bugge" <haakon.bugge@oracle.com>
> > Cc: linux-rdma@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Fixes: 56483ec1b702 ("[PATCH] IB uverbs: add mthca user doorbell record=
 support")
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/infiniband/hw/mthca/mthca_memfree.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Same answer as was here
> https://lore.kernel.org/all/YwIbI3ktmEiLsy6s@unreal
>
> Thanks
ok, I see you are firm on this, we can skip the patch
