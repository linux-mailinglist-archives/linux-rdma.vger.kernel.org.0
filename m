Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD13BC631
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhGFFvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 01:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhGFFvr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 01:51:47 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75476C061574
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 22:49:09 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 68-20020a4a00470000b0290258a7ff4058so844695ooh.10
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EO8nGBwuKQPwkmWPeUBksrBy0jOgAFAs3yAJdlke6ms=;
        b=flHtozjLG9NLnaBikWOAaF+bhAgWStvuxC/H70ZPzZ8pgBFmllDUeMKJx0MCpUW8Wt
         skAtK3E19VUCZ0qi+f6rwu0KUG8yyEP3Xc0D8RyRWz2wbUJ6Tghq9oezmO6GZI3YZ7iM
         uTZmkUgkOXZnnCg/CSV3fSuZXcF1ECY/kjyCAol7LcWL7m6GflI4SWRVzZljjkf0ASFw
         yos7gceiaDg7z2nVpepd7Xe4RUZH/98yp+ojCK1PR7MxysjkUw58cQVrGT2wIrIymtYh
         ZNt5d0Mn8VvsdYUasXMdCKPsl1DhjoxNNvCRkdBXOakJkvcd8lt4djSICR4BZw9neGXr
         1dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EO8nGBwuKQPwkmWPeUBksrBy0jOgAFAs3yAJdlke6ms=;
        b=PfBNwNp7snedzCVWIIdO3qUE9/KIhZ9+Q8AP88DqmtcOS1roHYB5CgpqImHMwOJLZS
         Kni5Lo6lRSd/2W/mTDvhywjYt/Sc7GKI8jpdV7IhTGNcUiDWnclCrJ7Bx33iyRidkL+e
         tqf2v79unCWeGnsel6x7jYfn/dBxnLKfz0VRNfZAfISjBwbFUix4ZPJFM8v2HxDgA558
         aCzWkZXpZdoQxKRdDeruxJDtfoL/LVJxS2BlObz5GoA6q7SVeHZEbgEJyDNH8XrtRKWB
         Ukp601dnKaEHF1TL8ajgYWs8K5GXDD/1sjOPqvvLH48zECkGcOTEcfnduqthtIOJ0OdH
         xMEA==
X-Gm-Message-State: AOAM53218mJrO/DTvGU2zS8T0jALZA4vFbe50E5WtJDZeFJK538YJYrM
        d4F2lLKPMBM+yPBV/4DCfzkI1xskvmladcNh8zc=
X-Google-Smtp-Source: ABdhPJwXcfpcsWV6ZVPR54K8rb47xwpa5dkpbX1fCJK6L0M17pRZ7ZBaJzDleivI7NrYyYUH0DuSZ61z4sOGOYDOLho=
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr12539272ooi.49.1625550547891;
 Mon, 05 Jul 2021 22:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210705164153.17652-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210705164153.17652-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 6 Jul 2021 13:48:57 +0800
Message-ID: <CAD=hENd3cggRC6R1r19d=+ustA8gwHinPAzg0UnmyteuA24OhA@mail.gmail.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix memory leak in error path code
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        haakon.brugge@oracle.com, yang.jy@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 6, 2021 at 12:42 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> In rxe_mr_init_user() in rxe_mr.c at the third error the driver fails to
> free the memory at mr->map. This patch adds code to do that.
> This error only occurs if page_address() fails to return a non zero address
> which should never happen for 64 bit architectures.
>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported by: Haakon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Thanks a lot.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun

> ---
> v2:
>   Left out white space changes.
>
>  drivers/infiniband/sw/rxe/rxe_mr.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 6aabcb4de235..be4bcb420fab 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -113,13 +113,14 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>         int                     num_buf;
>         void                    *vaddr;
>         int err;
> +       int i;

Thanks.

>
>         umem = ib_umem_get(pd->ibpd.device, start, length, access);
>         if (IS_ERR(umem)) {
> -               pr_warn("err %d from rxe_umem_get\n",
> -                       (int)PTR_ERR(umem));
> +               pr_warn("%s: Unable to pin memory region err = %d\n",
> +                       __func__, (int)PTR_ERR(umem));
>                 err = PTR_ERR(umem);
> -               goto err1;
> +               goto err_out;
>         }
>
>         mr->umem = umem;
> @@ -129,9 +130,9 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>
>         err = rxe_mr_alloc(mr, num_buf);
>         if (err) {
> -               pr_warn("err %d from rxe_mr_alloc\n", err);
> -               ib_umem_release(umem);
> -               goto err1;
> +               pr_warn("%s: Unable to allocate memory for map\n",
> +                               __func__);
> +               goto err_release_umem;
>         }
>
>         mr->page_shift = PAGE_SHIFT;
> @@ -151,10 +152,10 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>
>                         vaddr = page_address(sg_page_iter_page(&sg_iter));
>                         if (!vaddr) {
> -                               pr_warn("null vaddr\n");
> -                               ib_umem_release(umem);
> +                               pr_warn("%s: Unable to get virtual address\n",
> +                                               __func__);
>                                 err = -ENOMEM;
> -                               goto err1;
> +                               goto err_cleanup_map;
>                         }
>
>                         buf->addr = (uintptr_t)vaddr;
> @@ -177,7 +178,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>
>         return 0;
>
> -err1:
> +err_cleanup_map:
> +       for (i = 0; i < mr->num_map; i++)
> +               kfree(mr->map[i]);
> +       kfree(mr->map);
> +err_release_umem:
> +       ib_umem_release(umem);
> +err_out:
>         return err;
>  }
>
> --
> 2.30.2
>
