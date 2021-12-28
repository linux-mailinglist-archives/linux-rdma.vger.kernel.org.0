Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCA480797
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 10:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhL1JLN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 04:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhL1JLN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 04:11:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3CC061574;
        Tue, 28 Dec 2021 01:11:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp20so40117162lfb.6;
        Tue, 28 Dec 2021 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Esb4RQCmzV19Vk4jQHTbkcEgZYhQS+PRME2DZcUrRQ=;
        b=YgkD6YYxlWXxi/6frdyqKvgMRfxPAcPGjfXUwZxsPGMMRFWuBZoRw3FGch6pONMCy/
         1WNvVwcGxsdWIw7OQTO/0g9jMWHlxDDqioSBoblmdfwT08UtqAlgR8gz05bmyNivWvC0
         zwJjFrX8Mgit6b15OMI3I+wiUvl51yb3bD06AnAsw61vWKlUIMu+RSuKOVdf0PmhxLJy
         JPA8iSQVXBSwjp7H6LOKL9f+8oqgqB6Wdp/dl0/RNNgdEKRGy9waCCmJ44l8pJn+EaBa
         yK4uD3MEHndMkxl03kKlaTzatXrnZFjeKwpNzoULjPKmC2jxH06+RPrJh+HVawLMbt2D
         Ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Esb4RQCmzV19Vk4jQHTbkcEgZYhQS+PRME2DZcUrRQ=;
        b=k9dV/Gq3utDOgtnrU4l22I7YVzl8ynsbp2NCDYmccJVNBar0G0noDNwm1GfGDw+Enh
         5jfw0L1nMwqdCoqy552jpcQlVE0UbXq9f03ndNcOUQ0xyhPP8QjrHVTO0TJwyT9YwoLz
         hBoXPK13OwzRG/5SKPHxI4DyC4YeF0rjyiNd/KSWrokDAzCbDVEAO5nciGJ7trpb1jyD
         J7cAXING62PbJwsDBGFMOzUttm3QxZw6w+8zhqRMOgQvorzpUmUJ+LcJwa4so3yH7OrH
         wDPH8CKU4oz6cEUZ9FmFeTKawz8E6ZZgUGQ07UpK5fEiAEIojR87V53f0vlR/yj9ueCl
         /Zqg==
X-Gm-Message-State: AOAM532UBaPBRDsbdH1b3GD/f0jYpWbdYMKEhqNtO3TIjt/3xiW8xx8/
        LKTsAy8lwOndGK8ASCDstMjGjCQVm2zF+PQwM+GcB8dN
X-Google-Smtp-Source: ABdhPJyby7vWCGjMAalqCs/cTkBqD4jw9g81mlTxfgOYM/2xqjJSAiixawtilRZV+VmDPcbm2b2t01MehVM3TWsREPQ=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr19082553lfu.266.1640682670952;
 Tue, 28 Dec 2021 01:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20211228014406.1033444-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20211228014406.1033444-1-lizhijian@cn.fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 28 Dec 2021 17:10:59 +0800
Message-ID: <CAD=hENfpbsOW6R7o1TnVVSarBefPVWJpXDXP58Wh32cmnpo5Mg@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Prevent from double freeing rxe_map_set
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yanjun.zhu@linux.dev,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 28, 2021 at 9:39 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> a same rxe_map_set could be freed twice:
> rxe_reg_user_mr()
>   -> rxe_mr_init_user()
>     -> rxe_mr_free_map_set() # 1st
>   -> rxe_drop_ref()
>    ...
>     -> rxe_mr_cleanup()
>       -> rxe_mr_free_map_set() # 2nd
>
> By convention, we should cleanup/free resources in the error path in the
> same function where the resources are alloted in. So rxe_mr_init_user()
> doesn't need to free the map_set directly.
>
> In addition, we have to reset map_set to NULL inside rxe_mr_alloc() if needed
> to prevent from map_set being double freed in rxe_mr_cleanup().
>
> CC: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Thanks.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun
> ---
> V2: Fix it by a simpler way by following suggestion from Bob,
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 25c78aade822..7c4cd19a9db2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -141,6 +141,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
>                 ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
>                 if (ret) {
>                         rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
> +                       mr->cur_map_set = NULL;
>                         goto err_out;
>                 }
>         }
> @@ -214,7 +215,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>                                 pr_warn("%s: Unable to get virtual address\n",
>                                                 __func__);
>                                 err = -ENOMEM;
> -                               goto err_cleanup_map;
> +                               goto err_release_umem;
>                         }
>
>                         buf->addr = (uintptr_t)vaddr;
> @@ -237,8 +238,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>
>         return 0;
>
> -err_cleanup_map:
> -       rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
>  err_release_umem:
>         ib_umem_release(umem);
>  err_out:
> --
> 2.31.1
>
>
>
