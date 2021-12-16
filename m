Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085BC476CC6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 10:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhLPJDm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhLPJDm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 04:03:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBEC061574;
        Thu, 16 Dec 2021 01:03:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi37so48380418lfb.5;
        Thu, 16 Dec 2021 01:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reejmhj/RBsUDGHKYWtj6F9tw1tgxgbqUjGFxD1T7RA=;
        b=Z76q/WULhkaQHUcTfJ2DZa6aXSSd8tBjqZ9SoDh9OndGUhEgEtF4zNVW2v7Sfd/CBC
         d3/dAlHf7tUBywQjfvHzLACYbb6O0gmW5czIT5wsCj/OrPG6A9k5B/YRN8+V0O9yIRVP
         YkLOYlznN+npKMnRgVj+gZOqFkRbJVHpvVjWfKxJGrmRd208xl/GjX34D4uzLfawo43h
         ymTakrlBHCCuNG2TGFOg3iDGDl4v2EVXgDxOfuqBHFy+w3NqZSYLKwJeL73QaE8VqUub
         qJApIu3zql4L6vTO203bFuGarcHoNmbzpoiXx/U0n1Z9H0yXrO3DNlwEngF6z4UIlOxH
         qtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reejmhj/RBsUDGHKYWtj6F9tw1tgxgbqUjGFxD1T7RA=;
        b=I457zvfpvQYT6YA3IHEYHGkMwwtxU3ngKywrCX1UfGMkU8CneIhrtEtRS956s1mG9J
         ghCSoNN81y4alEv7IzKWh1yxd3P9QBkZ/jFEBMDxMQCoy/Dm7Ab51JDAeF83gniZkfl8
         Asf6FOLBDQ1yWzMV400FHZ7Vd6opsQ/Llmpn2toEFYXwuaTlFfitg2FHdyISbuXor3Xk
         OKSpBzP0ymV795DPKAY8tn+4s8EBXZeuJ4VQ1iRu20335Y0ySvus+Spx4/2la3bMtuAk
         FiUxQQHgxiHmiYBc+8wcV3+U8u7HBs7Jc8zTBYX4/HEjIvQf1SJ2HU1Mr6GAM6aRbbOf
         64wQ==
X-Gm-Message-State: AOAM533w552OPrPg/u8wOdpGqhLQzodsBdNBZhBMMrhCf+CsU+36ZSPU
        q6PFxTdbFyft81h7WI9LcuAYmmMbx/QZpQ2G9uHrrdmE
X-Google-Smtp-Source: ABdhPJygVx8k/8dvOL+Bswn5BZD1UY7U/VdF0ysFlKKDFgwxAuuXeyLxiLrLgnqwfS2AGyl8F1F2QTgKTRuyPgiZzbo=
X-Received: by 2002:a05:6512:3b11:: with SMTP id f17mr14073320lfv.374.1639645419957;
 Thu, 16 Dec 2021 01:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20211215060625.442082-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211215060625.442082-1-chi.minghao@zte.com.cn>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 16 Dec 2021 17:03:28 +0800
Message-ID: <CAD=hENcZ7miByq3UzUggM-yHn8=AbrU0hecUYDKzzxEPnN=LZQ@mail.gmail.com>
Subject: Re: [PATCH infiniband-next] drivers/infiniband: remove redundant err variable
To:     cgel.zte@gmail.com
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 2:06 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value directly instead of taking this
> in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2cb810cb890a..f557150bd59a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -22,24 +22,20 @@ static struct rxe_recv_sockets recv_sockets;
>
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
> -       int err;
>         unsigned char ll_addr[ETH_ALEN];
>
>         ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> -       err = dev_mc_add(rxe->ndev, ll_addr);
>
> -       return err;
> +       return dev_mc_add(rxe->ndev, ll_addr);
>  }
>
>  int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
>  {
> -       int err;
>         unsigned char ll_addr[ETH_ALEN];
>
>         ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
> -       err = dev_mc_del(rxe->ndev, ll_addr);
>
> -       return err;
> +       return dev_mc_del(rxe->ndev, ll_addr);
>  }
>
>  static struct dst_entry *rxe_find_route4(struct net_device *ndev,
> --
> 2.25.1
>
