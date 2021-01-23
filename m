Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4946530121B
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 02:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhAWBsG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 20:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbhAWBsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 20:48:01 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1DC0613D6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 17:47:18 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id x71so8178209oia.9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 17:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHo3zVNMenPgDvrJPUJMKFsr1g2YrD6tHgz2MEB+Pho=;
        b=PkDHjKirrw/exCoeVVElJc8LHoG7AiBhVFxlj3/tjfxidZW2kjpo9w6Rd/ovIL6qAR
         mV1sfeVgEReZKOaHmVkTWh9YbYZwdnXpD9rtomS+d2HwawzQUho+StPfoQKEobB4aZnU
         /h+6JqhCApO0Uktbrjmel8hvaP6KzK1gwpMEsEUCXluKmit4WhRJ8tp9YyuQY5PJwn8k
         T0XIf9G2oqh82WRwQ8cRgS3+yPY+wV5gwUPp/5xn5msOG33ivnxq/X1U3hFIMXuvLYJe
         2+ZA5Lrxo/5s66iw2OJv5gNYFpvcqLIikFKQkMhx31GxirM5HmJ4Fd0M+WjZdAkxp4u/
         DKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHo3zVNMenPgDvrJPUJMKFsr1g2YrD6tHgz2MEB+Pho=;
        b=cYH9QxWJCXHhNkbiCXSsScsMhgu0n0vgkieaEtGogBhK3+xrfyhnkgGvWxzocEi776
         HZ7QKx71+9I805+BpaOLeRJYx3b3OopvfPUWa0zHOQr+Clbfd/NOsxc4Rg1un9Tm5nXe
         c/QqXzhF65Qc0se8QbWfRqoBGoY7rMB+/stZbezbUp1wFnb4ifx43NoI7y3o3Lffo6oZ
         HgfSpH8MyIesssTlXEBGQo93PZUsE0QZEij0Oy64Yn6eU5u6ipKbXYDvStNmiWPeOlr+
         h31uIQJuwbkc3FmCIHpO1n+6SiHRGgDlPel4irk3BdK6yLhEERjoYVHBRnhD78W2osnJ
         QeRA==
X-Gm-Message-State: AOAM533mljODIdwlVxmNVUkNJdPulH5sapJTLosHmulQ1UXk7lNDxJwX
        wrssopXJ6bJzm/tzwDDGzuqQcMfFtuHzuGK3OWA=
X-Google-Smtp-Source: ABdhPJz9zCoT4x5AllS6jwFKgxRdz08ZSpLsR4ofBqniYDoB+/prMCMhbJ868RZg639njRDtKoYI21giMW3VyWJE4eU=
X-Received: by 2002:aca:fcc5:: with SMTP id a188mr5147240oii.169.1611366437842;
 Fri, 22 Jan 2021 17:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20210122192943.5538-1-rpearson@hpe.com> <20210122192943.5538-6-rpearson@hpe.com>
In-Reply-To: <20210122192943.5538-6-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 23 Jan 2021 09:47:07 +0800
Message-ID: <CAD=hENcOiB7-o6cmLnRTccTpGSS=KzE-r6YyEdu-YNRVToUqVA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 5/6] RDMA/rxe: Remove unneeded pool->state
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 23, 2021 at 3:30 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> rxe_pool.c uses the field pool->state to mark a pool as invalid
> when it is shut down and checks it in several pool APIs to verify
> that the pool has not been shut dowm.

s/dowm/down

 This is unneeded because the
> pools are not marked invalid unless the entire driver is being
> removed at which point no functional APIs should or could be
> executing. This patch removes this field and associated code.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 38 +---------------------------
>  1 file changed, 1 insertion(+), 37 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 09d8665c5343..7a03d49b263d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -157,24 +157,16 @@ int rxe_pool_init(
>                 pool->key.key_size = rxe_type_info[type].key_size;
>         }
>
> -       pool->state = RXE_POOL_STATE_VALID;
> -
>  out:
>         return err;
>  }
>
>  void rxe_pool_cleanup(struct rxe_pool *pool)
>  {
> -       unsigned long flags;
> -
> -       write_lock_irqsave(&pool->pool_lock, flags);
> -       pool->state = RXE_POOL_STATE_INVALID;
>         if (atomic_read(&pool->num_elem) > 0)
>                 pr_warn("%s pool destroyed with unfree'd elem\n",
>                         pool_name(pool));
> -       write_unlock_irqrestore(&pool->pool_lock, flags);
>
> -       pool->state = RXE_POOL_STATE_INVALID;
>         kfree(pool->index.table);
>  }
>
> @@ -328,9 +320,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
>         struct rxe_pool_entry *elem;
>         u8 *obj;
>
> -       if (pool->state != RXE_POOL_STATE_VALID)
> -               return NULL;
> -
>         if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>                 goto out_cnt;
>
> @@ -352,19 +341,10 @@ void *rxe_alloc__(struct rxe_pool *pool)
>
>  void *rxe_alloc(struct rxe_pool *pool)
>  {
> -       unsigned long flags;
>         struct rxe_type_info *info = &rxe_type_info[pool->type];
>         struct rxe_pool_entry *elem;
>         u8 *obj;
>
> -       read_lock_irqsave(&pool->pool_lock, flags);
> -       if (pool->state != RXE_POOL_STATE_VALID) {
> -               read_unlock_irqrestore(&pool->pool_lock, flags);
> -               return NULL;
> -       }
> -
> -       read_unlock_irqrestore(&pool->pool_lock, flags);
> -
>         if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>                 goto out_cnt;
>
> @@ -386,15 +366,6 @@ void *rxe_alloc(struct rxe_pool *pool)
>
>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
>  {
> -       unsigned long flags;
> -
> -       read_lock_irqsave(&pool->pool_lock, flags);
> -       if (pool->state != RXE_POOL_STATE_VALID) {
> -               read_unlock_irqrestore(&pool->pool_lock, flags);
> -               return -EINVAL;
> -       }
> -       read_unlock_irqrestore(&pool->pool_lock, flags);
> -
>         if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>                 goto out_cnt;
>
> @@ -437,9 +408,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>
>         read_lock_irqsave(&pool->pool_lock, flags);
>
> -       if (pool->state != RXE_POOL_STATE_VALID)
> -               goto out;
> -
>         node = pool->index.tree.rb_node;
>
>         while (node) {
> @@ -460,8 +428,8 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>                 obj = NULL;
>         }
>
> -out:
>         read_unlock_irqrestore(&pool->pool_lock, flags);
> +
>         return obj;
>  }
>
> @@ -473,9 +441,6 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
>         u8 *obj = NULL;
>         int cmp;
>
> -       if (pool->state != RXE_POOL_STATE_VALID)
> -               goto out;
> -
>         node = pool->key.tree.rb_node;
>
>         while (node) {
> @@ -499,7 +464,6 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
>                 obj = NULL;
>         }
>
> -out:
>         return obj;
>  }
>
> --
> 2.27.0
>
