Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265693BB5E4
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGEDpN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Jul 2021 23:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhGEDpM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Jul 2021 23:45:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079CC0613DB
        for <linux-rdma@vger.kernel.org>; Sun,  4 Jul 2021 20:42:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o13-20020a9d404d0000b0290466630039caso16983276oti.6
        for <linux-rdma@vger.kernel.org>; Sun, 04 Jul 2021 20:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHrMJSUvlER4o+TDJ/tbeN/9SG92jGzk1oAzzwfNx+g=;
        b=cTeFO+NkzvuZ3PAimF7eVWjOt32W8wGP6lVkuN+iKJ29T7dqbH2XxGleWsfS3yic9W
         DWDbnjV9P8/lz2fYYHWWGbbVIynOl4ygN0E4EtOjLmkuLpRBdJ+3pNdgjazf27CUp7WM
         sxnDSUnOnxqs9fJ5mHYzgfZsM3urRFh2oIoG3ZaAfl20AjPOHdMYKCi+5MnnYzraReIY
         jXm6QBxKKjXv6ymfL7hCMMhx0d3WQ4r8AqYp/M6vbHgnnmwB0Is2VQ1J+M/cosCpDU1M
         7XEpE8txVZMqbd4g8Xya45bnGvH8foqxz4xM4RAbJgcJHCz4Oljk6sXz2h6jcyWGHmTw
         6bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHrMJSUvlER4o+TDJ/tbeN/9SG92jGzk1oAzzwfNx+g=;
        b=paBSShxJdnIfAYsVmXcTGVtE77mwqghFavxhdcQeYeFOWfcEU8ZBkNwfzc2r3DdXoE
         H2ZifFb0Kn6ngWSQkk5vVW2uVvHiXxMNyvhIKibATg5PY0lwCTrM4isbFotbiFK9rDCI
         U0h3DSntiy1N7pM1Em/S5RlinzPqms5k/GbOJh9qyYh1WaY+eT47Oag/4KQNe50xsUM9
         kZ2Dnnmyf5rzO2p8K6yOK7A7Ha4hv4mTtIfhVFGzZqZfz7sPf3oVe0/m/idUUiOBGH8Z
         n58ZmRdPf3CNSu5hdQITeDstwd/MCKNV2tzRo6E2yW0yM9n1VugaJk5GU0jcvVZTp2h7
         qy+A==
X-Gm-Message-State: AOAM532Nev1UnU3A/8o/sEr//Pn0DiRMt/MAJry8n6iiIhaY+7L3eBV4
        PgI7SXb4/M33y1iEwFHDZuMnJ3I4NjL+gWmwiUw=
X-Google-Smtp-Source: ABdhPJzLOqGOiR0tu9fCJ3RLebC8pdJqjhnMH1P45QlUfC1U2u1xxpSnI7jrXujDNckaR1BUd8991wF9YGm/hI/H4aY=
X-Received: by 2002:a9d:469e:: with SMTP id z30mr9275455ote.53.1625456552303;
 Sun, 04 Jul 2021 20:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210704223506.12795-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210704223506.12795-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 5 Jul 2021 11:42:21 +0800
Message-ID: <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        haakon.brugge@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 5, 2021 at 6:37 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> In rxe_mr_init_user() in rxe_mr.c at the third error the driver fails to
> free the memory at mr->map. This patch adds code to do that.
> This error only occurs if page_address() fails to return a non zero address
> which should never happen for 64 bit architectures.

If this will never happen for 64 bit architectures, is it possible to
exclude 64 bit architecture with some MACROs or others?

Thanks,

Zhu Yanjun

>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported by: Haakon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 41 +++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 6aabcb4de235..f49baff9ca3d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -106,20 +106,21 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>                      int access, struct rxe_mr *mr)
>  {
> -       struct rxe_map          **map;
> -       struct rxe_phys_buf     *buf = NULL;
> -       struct ib_umem          *umem;
> -       struct sg_page_iter     sg_iter;
> -       int                     num_buf;
> -       void                    *vaddr;
> +       struct rxe_map **map;
> +       struct rxe_phys_buf *buf = NULL;
> +       struct ib_umem *umem;
> +       struct sg_page_iter sg_iter;
> +       int num_buf;
> +       void *vaddr;
>         int err;
> +       int i;
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
> @@ -129,15 +130,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
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
>         mr->page_mask = PAGE_SIZE - 1;
>
> -       num_buf                 = 0;
> +       num_buf = 0;
>         map = mr->map;
>         if (length > 0) {
>                 buf = map[0]->buf;
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
