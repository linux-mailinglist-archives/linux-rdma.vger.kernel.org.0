Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1294203406
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgFVJwr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgFVJwr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 05:52:47 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFDDC061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:52:47 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so15046010oic.9
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adyaQWQ1IVBfLmp3HaAQB36joAft4jFM0NT56mFjcZA=;
        b=MyG+ZgEJemjtI8OsYNuByrCyukzDciJFhWGSF7U1/YrUs5BPo+jw4UqdlikUa2TrJT
         mPgWNLTdKhPc7Gl/t9QXDhHKx8RZDxkvxWFmSEWwFOCqb9npHHarHtQwBOKEYCOviGyB
         2IQiD+vQVAXYakmLul/IOr/QpPAGVtwaGjHsNerGHWwg63O38DoPe1k0n4rfkrw7EyOC
         qibVehThWkqRSY/olqtlc4yTHA0Ii7gctV2MSgzS2tV2UdVKxksfO2Upz/suISdHgj6j
         xsnrGTl7Hrw0VdGkCldGKppJePVy1Zi4POHuzWoyJPHSc4GaEDe42h8tNa1z6HWTQLH+
         6xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adyaQWQ1IVBfLmp3HaAQB36joAft4jFM0NT56mFjcZA=;
        b=WLue5ExdA+8NYjZbFdtdVwq6Iwkqs6xTrSzM73bMVVL2W50S5A7/JNK3nGJXeldQXO
         6UoN4rvjTjp9+jrcQ6tehpaQwwSxzco8h3LHIA37QoIhrcVbqTcAEVVSH81I4VwLjVpx
         cF6pouWKutI2u6Q3STHL6b/0sPCJGbjgSkSaXbNxuJ05SxsI13k5IxvRgVOLkHB4KYlQ
         ba2aab5U45fuTBtzT2nitPw5w20JdGJhbixbs4lccYAFnPmrrhB7OVaNS8NN6cwzsXP7
         OYBPGEBL/KxnIekV/FsnUnukYVM4zOROD38PErS5iE4qq6ejgR9/1/49Ju/WQsEstLiT
         yyPA==
X-Gm-Message-State: AOAM5305q/GHxtb1hu/geieR2LHRXINUfvNDLH3XSyMb/YoASFCXmyuV
        vXUpowVvBZTVfZSOzIIxwgep0ff74CfkKJ6l/7iYe0sd
X-Google-Smtp-Source: ABdhPJyFQwISU4v7ybxUUuPvmbuviM3qR94TyekV9Snuv+86KGK6vb7rVBSzsDWmYgC8XzkbKvL0MIByx2k+RMFY6e8=
X-Received: by 2002:aca:5e06:: with SMTP id s6mr12170503oib.89.1592819566840;
 Mon, 22 Jun 2020 02:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200622093131.9238-1-kamalheib1@gmail.com>
In-Reply-To: <20200622093131.9238-1-kamalheib1@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 22 Jun 2020 17:52:35 +0800
Message-ID: <CAD=hENe62hemUGm6m_ecp_RH5qMYua5d8F=1Lxuh6mob8xe5Pg@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove unused rxe_mem_map_pages
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Zhu Yanjun <yanjunz@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 5:32 PM Kamal Heib <kamalheib1@gmail.com> wrote:
>
> This function is not in use - delete it.
>
Add:

Fixes: 8700e3e7c485 ("Soft RoCE driver")

Is it better?

Zhu Yanjun

> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  3 --
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 44 -----------------------------
>  2 files changed, 47 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 775c23becaec..238d6a357aac 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -132,9 +132,6 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
>
>  int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length);
>
> -int rxe_mem_map_pages(struct rxe_dev *rxe, struct rxe_mem *mem,
> -                     u64 *page, int num_pages, u64 iova);
> -
>  void rxe_mem_cleanup(struct rxe_pool_entry *arg);
>
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index e83c7b518bfa..a63cb5fac01f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -587,47 +587,3 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
>
>         return mem;
>  }
> -
> -int rxe_mem_map_pages(struct rxe_dev *rxe, struct rxe_mem *mem,
> -                     u64 *page, int num_pages, u64 iova)
> -{
> -       int i;
> -       int num_buf;
> -       int err;
> -       struct rxe_map **map;
> -       struct rxe_phys_buf *buf;
> -       int page_size;
> -
> -       if (num_pages > mem->max_buf) {
> -               err = -EINVAL;
> -               goto err1;
> -       }
> -
> -       num_buf         = 0;
> -       page_size       = 1 << mem->page_shift;
> -       map             = mem->map;
> -       buf             = map[0]->buf;
> -
> -       for (i = 0; i < num_pages; i++) {
> -               buf->addr = *page++;
> -               buf->size = page_size;
> -               buf++;
> -               num_buf++;
> -
> -               if (num_buf == RXE_BUF_PER_MAP) {
> -                       map++;
> -                       buf = map[0]->buf;
> -                       num_buf = 0;
> -               }
> -       }
> -
> -       mem->iova       = iova;
> -       mem->va         = iova;
> -       mem->length     = num_pages << mem->page_shift;
> -       mem->state      = RXE_MEM_STATE_VALID;
> -
> -       return 0;
> -
> -err1:
> -       return err;
> -}
> --
> 2.25.4
>
