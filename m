Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9D6CDC9B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 16:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjC2OeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 10:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjC2OeJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 10:34:09 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E70A266
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:29:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536af432ee5so296932677b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680100099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3djInWaUtEWPhLVpy4iK06nvHmU5DHgZ4gtyh/VJwc=;
        b=mI3V70UvgWaRYY9oiPFKFWbodcY/wX9VsrYJuuCTrwbiLww8hqIVraYm2a0TUxk7Fj
         5ayO/CEDT+1WUd56CXqfHCYn82y6PyTaB325G6nTnEPXOj0pg3CVEdo9SurKwV4U9AbI
         WI1nP2GFTbEDWpXgOrTXuzm1DzlkwcldDyfwIQYy+jv4qREbMU/Y6MvjHxsT6TZ5tYmk
         XZv/1qrNrViGvjJJuzvSSx7WikJQJ4pLswSctiPD+sgaq5DLIcdYyeakJrJqTpP34CeC
         yyG0gHlIxff63ZwhJWXtPN7CkdrbXSMH8tlw8AHd5td4ZnptqJbodTI71oqZ9AGpsfOs
         YwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3djInWaUtEWPhLVpy4iK06nvHmU5DHgZ4gtyh/VJwc=;
        b=Ur/C6gfUkUFz/p0+blU2cWY3m9Ed7lX+yJDn1fA22KN8wDY4VLgf0QuWGzoIbP06iy
         sxsybjhNmhOkaTyaS74ZtmLVhC/n/o+pvqi7B4Xx8j24DcBzHeUpnXWpqy6Iu9X0a+UA
         16OEp0vxQiGXF5FX1J5tlbrwJCivex10IxtCKakuaxSOD8HA/I+0HqFVwXLMkvWrA+KV
         Qq8UaPd10n9nWsuIU/vBVJtXxlg0dMQV5R8Y4O34r6Z5mkxNl8ns0bzSX7us9urwB0fM
         r/YgtZ9DmeSr8MllKkP85Azx1HtodIaHahi+l61A1GU61tcEI35uRRf1Vm2pqD2aBkGB
         vybg==
X-Gm-Message-State: AAQBX9ds1tNaHeJ3cXBFj3EbIymXJuoL4+vSXbIczHOSvtuNpcTh/JLA
        ZK2g2knj3e5MGiKWFaCEGBiVPP/hTtkUwjtvbm9e1Q==
X-Google-Smtp-Source: AKy350aqh0eEYrYXlwPbOZOhGzoroZsq14N6X2PLd49EdAWFnIMdbVbc4Hdav/GRReSbNjQR3OCf2W2qkxW/YdPwmsE=
X-Received: by 2002:a81:d007:0:b0:546:81f:a89e with SMTP id
 v7-20020a81d007000000b00546081fa89emr3792403ywi.9.1680100099427; Wed, 29 Mar
 2023 07:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230324103252.712107-1-linus.walleij@linaro.org> <ZB2s3GeaN/FBpR5K@nvidia.com>
In-Reply-To: <ZB2s3GeaN/FBpR5K@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 16:28:08 +0200
Message-ID: <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 24, 2023 at 3:00=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> On Fri, Mar 24, 2023 at 11:32:52AM +0100, Linus Walleij wrote:
> > Like the other calls in this function virt_to_page() expects
> > a pointer, not an integer.
> >
> > However since many architectures implement virt_to_pfn() as
> > a macro, this function becomes polymorphic and accepts both a
> > (unsigned long) and a (void *).
> >
> > Fix this up with an explicit cast.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_mr.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw=
/rxe/rxe_mr.c
> > index b10aa1580a64..5c90d83002f0 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -213,7 +213,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *=
mr)
> >  static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
> >  {
>
> All these functions have the wrong names, they are kva not IOVA.

This escalated quickly. :D

I'm trying to do the right thing, I try to fix the technical issues first,
and I can follow up with a rename patch if you want.

> > @@ -288,7 +288,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 =
iova, void *addr,
> >       u8 *va;
>
> >       while (length) {
> > -             page =3D virt_to_page(iova & mr->page_mask);
> > +             page =3D virt_to_page((void *)(iova & mr->page_mask));
> >               bytes =3D min_t(unsigned int, length,
> >                               PAGE_SIZE - page_offset);
>
> This is actually a bug, this function is only called on IB_MR_TYPE_DMA
> and in that case 'iova' is actually a phys addr
>
> So iova should be called phys and the above should be:
>
>                 page =3D pfn_to_page(phys >> PAGE_SHIFT);

I tried to make a patch fixing all of these up and prepended to v2 of this
patch (which also needed adjustments).

This is a bit tricky so bear with me, also I have no idea how to test this
so hoping for some help there.

I'm a bit puzzled: could the above code (which exist in
three instances in the driver) even work as it is? Or is it not used?
Or is there some failover from DMA to something else that is constantly
happening?

Yours,
Linus Walleij
