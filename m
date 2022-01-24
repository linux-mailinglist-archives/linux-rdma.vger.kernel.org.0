Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3949A6AF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 03:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3420080AbiAYCWr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 21:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2371204AbiAYAHM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 19:07:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F3C07E281
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jan 2022 13:55:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m4so25338931ejb.9
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jan 2022 13:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JglsQ3W34SQt+Zy15lDmZEtS86vNJAWteLE8JfqzCY=;
        b=hJdcGaxX5zLwcZWO9P4J/Z3YeyEZajM3SkYma/3FhrfBxH1yhxSc8FR8Ulv/DEAqFn
         YfEboSOk9cHH39+r4aqv5owMQQqvlWVh7N1I39oBOMRlRbkD4tGJELv7OFn4qKcET1tw
         yLnAgDdj4tiobUHbQ1vvMutXyKsuqXLt3P8uNCBEGjbnmX9pOfnI2+sYoqzF4tQXcUIA
         +vx2IPIwXeNGkYkhut166sHkwZ9bDEvrSizR9qGaE286i8cI5UKo/3KSpYvRwkArZcib
         vGhY37yIYAXfcr4OAeWSbtHOX4bDGuCYz4D2iy1vIZBkC2MqK0dOObJizhmdJttTEail
         XV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JglsQ3W34SQt+Zy15lDmZEtS86vNJAWteLE8JfqzCY=;
        b=I9cqxrBs/dEwDhFGDH/ge+c+dd97UMFP7bhAy+cEPITv5UJ9Cr6EponwIwgz7jj3Y2
         0k/GkDqg5hy4/VtSg3QxMuN9lM6ojMX+zyEebvsBkl4C5TO7JVcaVKlDYs3aXen21GXy
         9Ugo1bPKQ0k+rEMc+/7ubXNwAXv+o7BrpvHQHKjx6CsQ9WfcKG3h8jRe0OsMqQ96Icg/
         YeFQCAvdT/wI//FCwYvFouIZ+88dXNJV7jGpKSPq2PKyu9TBIJd6Ay8ZonO/QsKtDh6j
         pAiES4cXAP0Ljk8lEjQbYzvvEEKdh0nbRXsT0xAu/gi86OZLkJXM4NM4eRhzEdbQTARh
         597w==
X-Gm-Message-State: AOAM533ly2DIklVmsMg222eRfvGQ29i846s3lKq3iiYRohaenXSinQ9m
        tmQxNM+2xpPn5tWNkKZHky6zFNGm2DC87KUw/69OeA==
X-Google-Smtp-Source: ABdhPJwR6aHFyfik9X6q8xwr/txRv41f0oUETt/cE6olQXPJisyNFVqlzYtfWfqkxDEfUQxdLIBA67c7O2wIgboUKU0=
X-Received: by 2002:a17:906:c110:: with SMTP id do16mr13831897ejc.441.1643061311513;
 Mon, 24 Jan 2022 13:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20220124122135.5745-1-linmq006@gmail.com>
In-Reply-To: <20220124122135.5745-1-linmq006@gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 24 Jan 2022 22:55:00 +0100
Message-ID: <CAMGffEm3tVDP2ir2spX4Xum96Kf=d9zSVnngfQcj_9YZFmV4ew@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs: Fix double free in alloc_clt
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 24, 2022 at 1:21 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Callback function rtrs_clt_dev_release() in put_device()
> calls kfree(clt); to free memory. We shouldn't call kfree(clt) again.
>
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Hi Miaoqian,
this is the complete fix.
https://lore.kernel.org/linux-rdma/Ye00cQ+VUkzh8JCH@unreal/T/#t

Thanks!
> ---
> Changes in v2:
> - call free_percpu() before put_device() to avoid UAF.
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 7c3f98e57889..aff04f566304 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -2739,10 +2739,8 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>          */
>         dev_set_uevent_suppress(&clt->dev, true);
>         err = device_register(&clt->dev);
> -       if (err) {
> -               put_device(&clt->dev);
> -               goto err;
> -       }
> +       if (err)
> +               goto err_register;
>
>         clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
>         if (!clt->kobj_paths) {
> @@ -2764,6 +2762,11 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
>  err:
>         free_percpu(clt->pcpu_path);
>         kfree(clt);
> +       goto ret;
> +err_register:
> +       free_percpu(clt->pcpu_path);
> +       put_device(&clt->dev);
> +ret:
>         return ERR_PTR(err);
>  }
>
> --
> 2.17.1
>
