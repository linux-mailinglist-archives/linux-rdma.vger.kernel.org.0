Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9C758D42
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGSFjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 01:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGSFjK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 01:39:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A561BF5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 22:39:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9936b3d0286so908071666b.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689745148; x=1692337148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2sOWHwI8U36GcqDt1C0siDxHCn/TpLevvKEECR6Gxo=;
        b=THD97FPQcSxVUv8XBKcJcqQXy2OH5z24H0HCKbq7UepEmuc5cf9BNe03CmbbKfd7r/
         ADcffu4EwKtW5Qv9L2fFtXSxQY0ZxnpCZ9+9niKx8/B+dM33WqGjRQbrDFaAMwi9nsyp
         euUaKXUL99dfI+r4EpaS/oaIDc6pP+/cYh0uD/A3XvmNLdgpFzkcQt6h4uHp9KQf6DCA
         50j+D7OuChyNB29vzcDxjeOQRBX5KxHvXRhclNyQoIFOuSWE8c44SC3s6AbVf6uVjq4T
         TyKu21CqBwHbadWiFA/osi6VGEDzB7qgjzqlu20LTs0Y3gKVY0zc0OeacTWmK61LRIJl
         P+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689745148; x=1692337148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2sOWHwI8U36GcqDt1C0siDxHCn/TpLevvKEECR6Gxo=;
        b=Gg2G5IlBPkZ5malx6A/ikhw8yLzWSO5CdMDmYqt1sh1TP8l7JhHzJC3s5HLd9uJI18
         3pEXWXVAVJ2M9/Q8vpbZ8Q/fziQpVz4SsH7xUILHgoCdsOukqa3/VYDViXtCgp25NiaR
         7p23I0mMqgjWuvB6351jH0wnpJb6J/McHAWqgVkN/vVvjemnVUu9nVd87PPVHhTVn5+L
         TmqZC6jb5ohaCTSQpv6sQcMGs+JYojtgKM2OEQQGmujlolHwyHiO2CqhBW47V3N4+2Z0
         h0TDxk0lkYCcjoXKIPblH+D2Wr7aKntT0neKD7gt4sMZrDHClfzLC+tZUsdmjjSoZnSQ
         UGsQ==
X-Gm-Message-State: ABy/qLZvqbtoOHIXqsvOe8qlNtyjV4HgIbCWfK+m2O8XgRYw4aCq7K2j
        1IZFfiLrvrKZj1kF3zcaF0zxT09lKNBHQKWqKoE=
X-Google-Smtp-Source: APBJJlFgfPs+qR8YBjYeFrUmC3b8NBdKG8xjrgZjRYxoB3PdX44d988dCjXMIdtAQlm7C2Ca3XUqqIuI3aAcrshOdZs=
X-Received: by 2002:a17:906:3150:b0:988:6526:beaa with SMTP id
 e16-20020a170906315000b009886526beaamr1454894eje.40.1689745147903; Tue, 18
 Jul 2023 22:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230718175943.16734-1-rpearsonhpe@gmail.com> <20230718175943.16734-3-rpearsonhpe@gmail.com>
In-Reply-To: <20230718175943.16734-3-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 19 Jul 2023 13:38:55 +0800
Message-ID: <CAD=hENcA5aUJQ0H_ufqpeHp=4KHBae=5K5GnaNDPSz+eFxk__w@mail.gmail.com>
Subject: Re: [PATCH for-next 2/2] RDMA/rxe: Enable rcu locking of indexed objects
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jhack@hpe.com
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

On Wed, Jul 19, 2023 at 2:00=E2=80=AFAM Bob Pearson <rpearsonhpe@gmail.com>=
 wrote:
>
> Make rcu_read locking of critical sections with the indexed
> verbs objects be protected from early freeing of those objects.
> The AH, QP, MR and MW objects are looked up from their indices
> contained in received packets or WQEs during I/O processing.
> Make these objects be freed using kfree_rcu to avoid races.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.h  | 1 +
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw=
/rxe/rxe_pool.h
> index b42e26427a70..ef2f6f88e254 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -25,6 +25,7 @@ struct rxe_pool_elem {
>         struct kref             ref_cnt;
>         struct list_head        list;
>         struct completion       complete;
> +       struct rcu_head         rcu;
>         u32                     index;
>  };
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/s=
w/rxe/rxe_verbs.c
> index 903f0b71447e..b899924b81eb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1395,7 +1395,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct =
ib_udata *udata)
>         if (cleanup_err)
>                 rxe_err_mr(mr, "cleanup failed, err =3D %d", cleanup_err)=
;
>
> -       kfree_rcu_mightsleep(mr);
> +       kfree_rcu(mr, elem.rcu);
>         return 0;
>
>  err_out:
> @@ -1494,6 +1494,10 @@ static const struct ib_device_ops rxe_dev_ops =3D =
{
>         INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>         INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>         INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
> +
> +       .rcu_offset_ah =3D offsetof(struct rxe_ah, elem.rcu),
> +       .rcu_offset_qp =3D offsetof(struct rxe_qp, elem.rcu),
> +       .rcu_offset_mw =3D offsetof(struct rxe_mw, elem.rcu),

In your commits, you mentioned that ah, qp, mw and mr will be
protected. But here, only ah, qp and mw are set.
Not sure if mr is also protected and set in other place.
Except that, I am fine with it.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

>  };
>
>  int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
> --
> 2.39.2
>
