Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5F41DC82
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350965AbhI3Olv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349735AbhI3Olu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 10:41:50 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE85C06176A;
        Thu, 30 Sep 2021 07:40:08 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so7608415otu.0;
        Thu, 30 Sep 2021 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfNuIE13rp6z3b7uF6jThydpTcuxttUW3ys5+lgpqPo=;
        b=gV7o4AFdt1RodSQAGVag/GYyWfCSyJgmiLleyx4GzHYzqtsyBOD/Kq0iyY4Z5T41M2
         NHRAEuYA+EbVKf0qbntik82QtiDd/SQgqeHZKhAVNBMp6aDKo0BV9cZCZM4w2G+c7O9+
         6270u3l+SsO0LhLrBsiOOU+3s7KoSO9M2SF9j8a/9435DLOnOYct2vnuYJR9QE+MaL4K
         wbhRO/oUARGSD8ekKuhWK5twG4QCzylQwkVcJAuIS9iZYHiCQHG0eCYzWKQ59bkq8S8i
         tbExTq9etBkE1E11JT7mY8FuYT1OXRXZLZdB1K8A9gdhKu6LKDPkzBRKanl/ImT4r7FL
         8Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfNuIE13rp6z3b7uF6jThydpTcuxttUW3ys5+lgpqPo=;
        b=fyptCAecTO1tzv8pQC+11B5N03UZI2iuwXH+X+Aw+0mnyvjYeW2VgP7rpcTJ75F+VF
         wB1woKeCFgAzzTEHS1AJoGdxa0TZmHiFPylWY/Onyl0azgAY+V0JIGcQYIGsYtt8UDm8
         5hZ/sH5eYIz67JNg1cS91iJv9smjSkRpibo+Aw3WNDkh+ppQEr2pZihSxtIxnety6MSo
         ksS4X18bEK4Dh+V+r4OXdv5BzrILXL+Tp2fZ1SdMJPHgfnKEXMzebqaso4YSDWMCs95U
         uPa2qOl/Ac1afprPfnI90L+yMvcWCbwhLPoLic2fcaVS92/8lC/x30zZIAAGmfn0j90n
         59Zw==
X-Gm-Message-State: AOAM5334hiQPiK0ViS45VqwoERGmp9SwEnCZIa8lfjX2axVg0BJrakk8
        X09KyPg/4xBiGR1tvrXHi142d9+FJGRJ9i8V9u/0lz/OhRg=
X-Google-Smtp-Source: ABdhPJwxPwxuaPZrNznZ2yZIstQTbncfMK+o2gabhB1vBkk2haAb2o5/Ihza/qp5DQcKRLSsvg80TEjpB2+QSPoSlBg=
X-Received: by 2002:a9d:4e91:: with SMTP id v17mr5603250otk.297.1633012807777;
 Thu, 30 Sep 2021 07:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210930113527.49659-1-mie@igel.co.jp>
In-Reply-To: <20210930113527.49659-1-mie@igel.co.jp>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 30 Sep 2021 22:39:56 +0800
Message-ID: <CAD=hENdLYFGUaYWHbbwPd9kte5pHY6Vs8zjiDn0P8_AeeovCkA@mail.gmail.com>
Subject: Re: [PATCH] Provider/rxe: Allocate rxe/ib objs by calloc
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 7:35 PM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> Some rxe/ib objects are allocated by malloc() and initialize manually
> respectively. To prevent a bug caused by memory uninitialization, this
> patch change to use calloc().

Thanks a lot.

Zhu Yanjun

>
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  providers/rxe/rxe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index 3533a325..788a1bbd 100644
> --- a/providers/rxe/rxe.c
> +++ b/providers/rxe/rxe.c
> @@ -104,7 +104,7 @@ static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
>         struct ib_uverbs_alloc_pd_resp resp;
>         struct ibv_pd *pd;
>
> -       pd = malloc(sizeof(*pd));
> +       pd = calloc(1, sizeof(*pd));
>         if (!pd)
>                 return NULL;
>
> @@ -225,7 +225,7 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
>         struct ib_uverbs_reg_mr_resp resp;
>         int ret;
>
> -       vmr = malloc(sizeof(*vmr));
> +       vmr = calloc(1, sizeof(*vmr));
>         if (!vmr)
>                 return NULL;
>
> @@ -382,7 +382,7 @@ static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
>         struct urxe_create_cq_resp resp = {};
>         int ret;
>
> -       cq = malloc(sizeof(*cq));
> +       cq = calloc(1, sizeof(*cq));
>         if (!cq)
>                 return NULL;
>
> @@ -594,7 +594,7 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
>         struct urxe_create_srq_resp resp;
>         int ret;
>
> -       srq = malloc(sizeof(*srq));
> +       srq = calloc(1, sizeof(*srq));
>         if (srq == NULL)
>                 return NULL;
>
> @@ -1167,7 +1167,7 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *ibpd,
>         struct rxe_qp *qp;
>         int ret;
>
> -       qp = malloc(sizeof(*qp));
> +       qp = calloc(1, sizeof(*qp));
>         if (!qp)
>                 goto err;
>
> @@ -1659,7 +1659,7 @@ static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
>                 return NULL;
>         }
>
> -       ah = malloc(sizeof(*ah));
> +       ah = calloc(1, sizeof(*ah));
>         if (ah == NULL)
>                 return NULL;
>
> --
> 2.17.1
>
