Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D831B56FF93
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiGKK5M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGKK45 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 06:56:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7201FFE00
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 03:02:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so7928529eju.10
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGvgUoEpgRoFdw5xB3ByPDZ/Z4C3Oec3OA9m4e/7zr0=;
        b=RSgSJPGfw4G/qutpiBewn0jq3S+XphrS/nSQldk+zB5jc6SNG8BxH9gtyCt31mxMv2
         oFN/E92Iu6kUuYasX4qE1vwxnsrS6rsW9XS9HaKp2j5hSWLKACY+5Y0RnDzYL1vDfZUr
         Y4zo4jJ1CbgQdJCqjgjTo6/1lYCsgeB+9xLhRAL4bWzEBn5tENPcU8udqd3DNZxIJwYP
         MK3PTfEigpvND3GsN13ZGfI4lDjQxQEWHY72T7bXff0JD+5fP+ua4D2MEcPRKBP/HYmX
         m7RAaehwlsir7ffzRR4pswlInHpW6hvYC3ZKdGfzSrXN4ZRu9KmRl4fMxi6g1trSpdNT
         GqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGvgUoEpgRoFdw5xB3ByPDZ/Z4C3Oec3OA9m4e/7zr0=;
        b=EApDHiGWFw/V71Xw1iK0YPdxMa/SCcgDR9/JlwgFRURIYEnySrp806EX2A0QDLhcDN
         j53Pg+Ym3pkb+6QMfMZ6lDluP6W5Lq2gj5lc/qsL2lbFZdtIG3FuFnnWl2NCLsYkKkOP
         wAgVOc1nRzuQpBtxFBQPGxElOgPPevWCxwK9CKUMKshLcZAc4nnqFINWX7aLgKIY+R5x
         Z8PhnbUdBaXDpoQY4qNQaRP7K/H1id4V5QIOpo1j3C5jhNEzM5MjbcnMdi08qHesbfev
         VXTxFxifCMoxN+uM7/0m8G237CUkH8nK8QUwMJyIfkwvUGA1rDmLZNgHvGKg72EXUES3
         +2Eg==
X-Gm-Message-State: AJIora9PqCx9EwkBicks1PKo4k0WpikHnyF5Pdh4PXNpMmgmO1gFrOhS
        ilGzL9x9PYMjEacTKrLVP9WU3Usvoe9ARDb6QrqJaO5ekaY=
X-Google-Smtp-Source: AGRyM1vafSCHUmSjW+hMdfrXxS7hOwpJ9tY3psQHMQaljV4Evx72JF9q90YXl+Rpw/+ZgPbrzliXxhhDryKeNeHi9yQ=
X-Received: by 2002:a17:906:8462:b0:72b:4e05:a8c1 with SMTP id
 hx2-20020a170906846200b0072b4e05a8c1mr6181720ejc.443.1657533723516; Mon, 11
 Jul 2022 03:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 11 Jul 2022 12:01:53 +0200
Message-ID: <CAMGffEk46vD2d-GCR5VPYiAQi3268sz9PiH6Zvuru8zUW03eXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rtrs-clt: Use the bitmap API to allocate bitmaps
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 8, 2022 at 6:47 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>
> It is less verbose and it improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 9809c3883979..06c27a3d83f5 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1403,8 +1403,7 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
>         unsigned int chunk_bits;
>         int err, i;
>
> -       clt->permits_map = kcalloc(BITS_TO_LONGS(clt->queue_depth),
> -                                  sizeof(long), GFP_KERNEL);
> +       clt->permits_map = bitmap_zalloc(clt->queue_depth, GFP_KERNEL);
>         if (!clt->permits_map) {
>                 err = -ENOMEM;
>                 goto out_err;
> @@ -1426,7 +1425,7 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
>         return 0;
>
>  err_map:
> -       kfree(clt->permits_map);
> +       bitmap_free(clt->permits_map);
>         clt->permits_map = NULL;
>  out_err:
>         return err;
> @@ -1440,7 +1439,7 @@ static void free_permits(struct rtrs_clt_sess *clt)
>                 wait_event(clt->permits_wait,
>                            find_first_bit(clt->permits_map, sz) >= sz);
>         }
> -       kfree(clt->permits_map);
> +       bitmap_free(clt->permits_map);
>         clt->permits_map = NULL;
>         kfree(clt->permits);
>         clt->permits = NULL;
> --
> 2.34.1
>
