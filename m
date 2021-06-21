Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62583AE552
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFUIz6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUIz6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 04:55:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA36C061574
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 01:53:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so10350898oij.11
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWRRAzxlIpr1S2+Wg1zexgX/+EjWbkDZ4d1RSz9K360=;
        b=akj57s64Ky6CL0eDL7cpcEJwTSkij9+MtE+sDsp4oy0hj1/j0yu1uzx/9S5vx38sww
         9EF81ss6jNSTFdsHp27ChcSPILDHz3SG4bZ0fqsSHqs764zWyr2leIUV9avugaqqLDZB
         kP2CtfShRHd5GpfWYlLvoYxHiXdbpHmSGG7uhEcqXsOsbtCnwk4AC3P38mZBqyi6SXRo
         +M5v11TsOMPZfdzh+U3Z7zTcJ7pROLi8J2ky0hcTG1ch4UoFjsax0Oz3qVWpbmeheoi2
         phxH/pPH8j74Cc3SkFg6vXqYG7a+9u1N5k65Egktl0E73D4HBVxAUQnPF5upDu5poPsd
         jV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWRRAzxlIpr1S2+Wg1zexgX/+EjWbkDZ4d1RSz9K360=;
        b=umBMgCwFe/ApdBl9+8Af07PEvYsQNh6Z9Du/9zmtJeJN28JVW4ocXNOhmqQCIzVFjv
         CusmwhnRTtuUTzEf5eQMxacDRUAue77aGeqnVzMlIyEaJ5aBeGwMqtWaUDdYGLvM0rE/
         JzH2KMpXGlj25iLQbRIOuzai2cKYhHxe3W4dAJNyijCFp4ZDGOzRk7IZcn/k2k8F/I6h
         gAxQ3RHYsfQokaARB+WXydY9gsdF9lZwRe5DBk7TgHhjcKNqZkr3aH9hWJLL3IQAGZCE
         isksoJftc0Pwz1xHsx/ITs5og7U/IuobBOv0IaBl9MflR7Gpq5Ij1pR5Uj5FvKFgZVmX
         JclQ==
X-Gm-Message-State: AOAM532m3ndvlyfcdi0fP2UECpoVTfASuEhFRqfEmNLjT18eWeV+SFOB
        AxSTQWYudUSeT5lo3ESs486kkHzYHZtjAL6QOTs=
X-Google-Smtp-Source: ABdhPJxKmdmHOkiDs4PeLekhzSieC5WrMp9VTzuiAJ2h48nL5gjbA0fypncYi4nae4eWwLjlKlKDRUGC4w0xk4yUWgY=
X-Received: by 2002:a54:400c:: with SMTP id x12mr22951597oie.89.1624265622990;
 Mon, 21 Jun 2021 01:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210621071456.4259-1-ice_yangxiao@163.com>
In-Reply-To: <20210621071456.4259-1-ice_yangxiao@163.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 21 Jun 2021 16:53:32 +0800
Message-ID: <CAD=hENf2NR+mOmUPw5dg726_OO9BkfALNfTJphrM=rP+Y-RAwQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] RDMA/rxe: Don't overwrite errno from ib_umem_get()
To:     ice_yangxiao@163.com
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 3:15 PM <ice_yangxiao@163.com> wrote:
>
> From: Xiao Yang <yangx.jy@fujitsu.com>
>
> rxe_mr_init_user() always returns the fixed -EINVAL when ib_umem_get()
> fails so it's hard for user to know which actual error happens in
> ib_umem_get(). For example, ib_umem_get() will return -EOPNOTSUPP
> when trying to pin pages on a DAX file.
>
> Return actual error as mlx4/mlx5 does.
>
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 9f63947bab12..fe2b7d223183 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -135,7 +135,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>         if (IS_ERR(umem)) {
>                 pr_warn("err %d from rxe_umem_get\n",
>                         (int)PTR_ERR(umem));
> -               err = -EINVAL;
> +               err = PTR_ERR(umem);

Thanks. I am fine with this.

Zhu Yanjun

>                 goto err1;
>         }
>
> --
> 2.26.2
>
