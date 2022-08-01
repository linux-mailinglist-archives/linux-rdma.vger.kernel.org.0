Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C252F5865DE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiHAHvv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHAHvu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 03:51:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FF175BE;
        Mon,  1 Aug 2022 00:51:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso14350636pjo.1;
        Mon, 01 Aug 2022 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRXzgwGRnew18hle991+x/+veduQBDsHn97K7ipnoI8=;
        b=QGvyo5U21pMGcC8K4Tt4H3R8NtfXjYfOymD+xHmuur3W3o+ChrBY+ph/RrliSwamOf
         M88sV3RDFrt9W4h6IvzTMLGL+DgOffIUBmmWiRfZqsUS63SM7Po/158sKyrP9nJLS+Vv
         ONclQ8kGtr6n0+TqNrGDdWnACkbkm2pmY8v+eyZPz/tpwAlq9aEbDNZ9FJARldR7J4uN
         vwNggmaX66kiXU4Oz0BWGZdKXJlF9nABRyfOiH5ZqIRINHidST6Zll0PzAE4pTdE0lLp
         JIEViNv0pmOPzpMDbJDLXBGmfgTjUN53TYOpVzAicv22zX2+s1Jup52PB19Az59S3Pn+
         26hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRXzgwGRnew18hle991+x/+veduQBDsHn97K7ipnoI8=;
        b=NXR67l8U1NhjEKS8hXtZbPGpmIE1UG1S2xl77o6+Vn10TvE+xil+pxUfnBfz6MU6nB
         2VS2aSC2SRJGXM6CRHrnfUxkpu6beuHrKj5tbX4H+G9JTO/WYEmV7oy7QdfenA0nyoC0
         In386u4egbvnBCWArStDL94M8S4JXc4ht5FIxHn2+rIv79HeD160Kuo8WLcWN9Ym+JLA
         czxxqt73NWlM9lY0tRR2Zf8iD7IOY04cRcBkto04lSk6VL9dXshu0zhtSw3/apBbKuRd
         oh+GAAwhV8r/G0XsTpBiAxY5spSRk9WEWiHSB7w/zv460fX0qzWWCfYT7M45hcCYJHYa
         Llaw==
X-Gm-Message-State: ACgBeo2B2upFO8c7En4uumkRL021ZD7ZCx/zGLVM5lOry2V3bx8T04vp
        wT2ALKnq7PWAcb3MSGj20kcoPIFbRW+dCdGLX4E=
X-Google-Smtp-Source: AA6agR7DaOt3eS03tKH/EJCP9zIGQcn2b7s4o8XetUgsrErHqOcCV5uSwSjPWYWjRP1D10/H1b0MhaAq/OYzh5s0Hvg=
X-Received: by 2002:a17:902:7796:b0:16d:41b2:dd36 with SMTP id
 o22-20020a170902779600b0016d41b2dd36mr14979702pll.137.1659340309590; Mon, 01
 Aug 2022 00:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220801073850.841628-1-william.kucharski@oracle.com>
In-Reply-To: <20220801073850.841628-1-william.kucharski@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 1 Aug 2022 15:51:38 +0800
Message-ID: <CAD=hENc28hpeFsM841ON_N0E17FRLWe8PZhZ6kQLpg4rr1GSnw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Correct error handling in routines allocating
 xarray entries
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 1, 2022 at 3:39 PM William Kucharski
<william.kucharski@oracle.com> wrote:
>
> The current code will report an error if xa_alloc_cyclic() returns
> non-zero, but it will return 1 if it wrapped indices before successfully
> allocating an entry.
>
> An error should only be reported if the call actually failed (denoted by
> a return value < 0.)
>
> Fixes: 3225717f6dfa2 ("RDMA/rxe: Replace red-black trees by xarrays")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Please check commit in
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

commit 1a685940e6200e9def6e34bbaa19dd31dc5aeaf8
Author: Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu Jun 9 15:06:56 2022 +0800

    RDMA/rxe: fix xa_alloc_cycle() error return value check again

    Currently rxe_alloc checks ret to indicate error, but 1 is also a valid
    return and just indicates that the allocation succeeded with a wrap.

    Fix this by modifying the check to be < 0.

    Link: https://lore.kernel.org/r/20220609070656.1446121-1-dzm91@hust.edu.cn
    Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
    Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
    Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
    Signed-off-by: Leon Romanovsky <leon@kernel.org>

Thanks and Regards,
Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 19b14826385b..e9f3bbd8d605 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -139,7 +139,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>
>         err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>                               &pool->next, GFP_KERNEL);
> -       if (err)
> +       if (err < 0)
>                 goto err_free;
>
>         return obj;
> @@ -167,7 +167,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>
>         err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>                               &pool->next, GFP_KERNEL);
> -       if (err)
> +       if (err < 0)
>                 goto err_cnt;
>
>         return 0;
> --
> 2.37.1
>
