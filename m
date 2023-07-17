Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043DB75708B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 01:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGQXfc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 19:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGQXfb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 19:35:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF410B;
        Mon, 17 Jul 2023 16:34:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992b66e5affso704174566b.3;
        Mon, 17 Jul 2023 16:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689636780; x=1692228780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUDr0WJ36nzGg+x0m6xG86uy/+jSOmIe2ZQC2dKU+JY=;
        b=R72h7HqH8exWkKdBGuHmTn/A6yXVCx/MQxMlWukO2c9mf0bQu7HeyztJLnYzun3qUI
         CPubk0fYrugSrzwwHJa6WuMyVEv7jAqlCxZ6Ha1zyjPOInzg8uu+1Dg11qNhmpWUXCyy
         FnKmOrzNTcdUIq6NzCnXXFgkMr3Cx4GageF7idZk2wz5rSEiqnlp6SyKLHKbHnjdYfU2
         j6QMS3ugtyHUXlGvH983eK2DS4EQI62/d+0LTaiDWUNNdG/HxFi+5vh5RjedFNHVdryP
         MnAaWvLpheISDoE0GquVbuPi7DNKbFnoE9TO2wkkaOCItUf5+59K6lQvRCNepNU27ktN
         Em9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689636780; x=1692228780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUDr0WJ36nzGg+x0m6xG86uy/+jSOmIe2ZQC2dKU+JY=;
        b=LyG0NPrH26ewEBaMEyiukPEArnD1SiHXozJBWucCWZmJsFMRJoLcv8Xjm8YucZfzNG
         p9CF0nWCQd0v7gac5tA6si0/mOPFOIXnGNHsRxw8Jo3lbRpXHRDz0Njy7GPfkXOCHqnu
         1ty++lg4hSxEVpiYPUAhQEI4ME5nvK5oq/M4tSswkVk3QluxmMKBYfi0YKP+ESXF1sie
         7iP/A8NHGlT2c8vFdUnDZdOlQo/zTbbx8+8BE1niYnmHA+UPEJmx2se0x8rwiURNxEGY
         2QalXAo5JWUcSK1Hst6VIEzITPIF8hgyGI3zddi60IFu80O1/lzlIlbT3/H/54ub3a4U
         N+dg==
X-Gm-Message-State: ABy/qLZfq20xUh2QketLE4xymAiSFvvjwYX9AMuPeoZ+Nu+DDq0E9QXW
        zpvwUe72Olqu3KJ1qTHZkytMRwYJTDVKxparc/fhEPi9760=
X-Google-Smtp-Source: APBJJlE1VufSgLLzwZ0wh5XIZlg806W1ISKFqvU35SLDRo3m8iBCXl2XRyjXOwehO1xfQV/AeH9gU+mb7fdtFJSw7xI=
X-Received: by 2002:a05:651c:105b:b0:2b8:67ce:4ad7 with SMTP id
 x27-20020a05651c105b00b002b867ce4ad7mr5740002ljm.6.1689636061093; Mon, 17 Jul
 2023 16:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <43698d8a3ed4e720899eadac887427f73d7ec2eb.1689623735.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <43698d8a3ed4e720899eadac887427f73d7ec2eb.1689623735.git.christophe.jaillet@wanadoo.fr>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 18 Jul 2023 07:20:48 +0800
Message-ID: <CAD=hENdpVxzE+Mvre7kdU-Z1Cr0z=6DFwhEh17-bNf-2Z0haJw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix an error handling path in rxe_bind_mw()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 18, 2023 at 3:55=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> All errors go to the error handling path, except this one. Be consistent
> and also branch to it.
>
> Fixes: 02ed253770fb ("RDMA/rxe: Introduce rxe access supported flags")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\ Speculative /!\
>
>    This patch is based on analysis of the surrounding code and should be
>    reviewed with care !
>
> /!\ Speculative /!\
> ---
>  drivers/infiniband/sw/rxe/rxe_mw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/r=
xe/rxe_mw.c
> index d8a43d87de93..d9312b5c9d20 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -199,7 +199,8 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wq=
e *wqe)
>
>         if (access & ~RXE_ACCESS_SUPPORTED_MW) {
>                 rxe_err_mw(mw, "access %#x not supported", access);

https://www.kernel.org/doc/Documentation/core-api/printk-formats.rst
What is "%#x"? No such definition in the above link.
Except that, I am fine with it.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Zhu Yanjun

> -               return -EOPNOTSUPP;
> +               ret =3D -EOPNOTSUPP;
> +               goto err_drop_mr;
>         }
>
>         spin_lock_bh(&mw->lock);
> --
> 2.34.1
>
