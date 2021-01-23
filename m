Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD2301227
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 02:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhAWB5L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 20:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbhAWB5K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 20:57:10 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9172C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 17:56:29 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id e70so7007275ote.11
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 17:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2blLCH6juiVmdbhJDDMZiQxySH9Sb75QXMXFHdItvI=;
        b=MuDvkXBGSI/utPF+XVKCWXp3ZEPyiNwQDuHHu2MBeY3hRzVoYNSnejWwNoqKfKrTsj
         q0acn42PU2Sm/4aXGnAxxoFYitL/a78kuIrEio6JgY5qUtBDyOF11zR5xLqxpYsMseSc
         jAzuEuT63O+UpLkZXoJFE4fCp3B7Xbee654aSOB+8Qm75ctQfOTmBcmAQ5hh3lcMi+xM
         6nFaemzI7kzZOOI+EsmP7GTwpgVO3NubARHGqduAOGhWmnhYyAkQJeO5BnmpbfmvX1/j
         8X+32cQaIGkDOGA/eHrZvvAzxv3HO9PzsW7Ek9nBXWHoj+eUoVjoV6jL0OUhBi6EfcCk
         WkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2blLCH6juiVmdbhJDDMZiQxySH9Sb75QXMXFHdItvI=;
        b=pvwvwlWOjJlSwcDaDSw7MCsq70bDbTYBYDrR9YVyx4gYNXJPxKfuS8zxVxCPdDEIhU
         fvX0sGiPDD40h20cUJnyiroty4xFS85klLVsvz6/vVpF3BJo03yNWIu0AAfcAgum7/U+
         H4mNNrmmeqc5VlinaCJajaTxCQCAX4IQq1eoC07xevejyCcOe3Q7CcEEw+JffYy35rSe
         8eDriSIEtbIrzTSKAxonqRTJ5MMN6xG1/wfo6sPdobwUtVf4A/CViPNNJY3OWxDaO4Dm
         TxWTV5OFf6fmIMFSdLezO7ooL0cZJMRCdSXxRGgqFzgLNkoqiJKLjcUrCaZdCSgyT5xD
         vIPg==
X-Gm-Message-State: AOAM532wE4dshXTCYQsPJM/3+0NIrMJuJvnrgCRgAeVAIDygwsYbY6Ph
        SNWln+fEvbfR6ccYN1g29oT1dii//GckmH/HH8E3EBQ/agk=
X-Google-Smtp-Source: ABdhPJw1xg4uy2p9kvVg/OapqolRSgIsyNRubOKgIq5XmtEk1Z565RvCvvEjIpNoCo0WBlVsIKiUefeuDevff2fA8Q0=
X-Received: by 2002:a05:6830:19cb:: with SMTP id p11mr4308601otp.53.1611366987421;
 Fri, 22 Jan 2021 17:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20210122192943.5538-1-rpearson@hpe.com> <20210122192943.5538-5-rpearson@hpe.com>
In-Reply-To: <20210122192943.5538-5-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 23 Jan 2021 09:56:15 +0800
Message-ID: <CAD=hENdPTny3Obqc7V+WfhGk=p8SPm21psqXRb8Xn5bU+VwGdA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 4/6] RDMA/rxe: Remove references to ib_device
 and pool
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
> rxe_pool.c takes references to the pool and ib_device structs
> for each object allocated and also keeps an atomic num_elem
> count in each pool. This is more work than is needed. Pool
> allocation is only called from verbs APIs which already have
> references to ib_device and pools are only diasbled when the
> driver is removed so no protection of the pool addresses
> are needed. The elem count is used to warn if elements are
> still present in a pool when it is cleaned up which is useful.
>
> This patch eliminates the references to the ib_device and pool
> structs.
>
> The previous version only removed the ib_device reference.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 42 ++--------------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h |  1 -
>  2 files changed, 2 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 7e68f99558a7..09d8665c5343 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -142,8 +142,6 @@ int rxe_pool_init(
>
>         atomic_set(&pool->num_elem, 0);
>
> -       kref_init(&pool->ref_cnt);

The pool->ref_cnt is useful to the statistics of usage of pool.
Not sure if it is good to remove it.

> -
>         rwlock_init(&pool->pool_lock);
>
>         if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
> @@ -165,19 +163,6 @@ int rxe_pool_init(
>         return err;
>  }
>
> -static void rxe_pool_release(struct kref *kref)
> -{
> -       struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
> -
> -       pool->state = RXE_POOL_STATE_INVALID;
> -       kfree(pool->index.table);
> -}
> -
> -static void rxe_pool_put(struct rxe_pool *pool)
> -{
> -       kref_put(&pool->ref_cnt, rxe_pool_release);
> -}
> -
>  void rxe_pool_cleanup(struct rxe_pool *pool)
>  {
>         unsigned long flags;
> @@ -189,7 +174,8 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>                         pool_name(pool));
>         write_unlock_irqrestore(&pool->pool_lock, flags);
>
> -       rxe_pool_put(pool);
> +       pool->state = RXE_POOL_STATE_INVALID;
> +       kfree(pool->index.table);
>  }
>
>  static u32 alloc_index(struct rxe_pool *pool)
> @@ -345,11 +331,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
>         if (pool->state != RXE_POOL_STATE_VALID)
>                 return NULL;
>
> -       kref_get(&pool->ref_cnt);
> -
> -       if (!ib_device_try_get(&pool->rxe->ib_dev))
> -               goto out_put_pool;
> -
>         if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>                 goto out_cnt;
>
> @@ -366,9 +347,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
>
>  out_cnt:
>         atomic_dec(&pool->num_elem);
> -       ib_device_put(&pool->rxe->ib_dev);
> -out_put_pool:
> -       rxe_pool_put(pool);
>         return NULL;
>  }
>
> @@ -385,12 +363,8 @@ void *rxe_alloc(struct rxe_pool *pool)
>                 return NULL;
>         }
>
> -       kref_get(&pool->ref_cnt);
>         read_unlock_irqrestore(&pool->pool_lock, flags);
>
> -       if (!ib_device_try_get(&pool->rxe->ib_dev))
> -               goto out_put_pool;
> -
>         if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>                 goto out_cnt;
>
> @@ -407,9 +381,6 @@ void *rxe_alloc(struct rxe_pool *pool)
>
>  out_cnt:
>         atomic_dec(&pool->num_elem);
> -       ib_device_put(&pool->rxe->ib_dev);
> -out_put_pool:
> -       rxe_pool_put(pool);
>         return NULL;
>  }
>
> @@ -422,12 +393,8 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
>                 read_unlock_irqrestore(&pool->pool_lock, flags);
>                 return -EINVAL;
>         }
> -       kref_get(&pool->ref_cnt);
>         read_unlock_irqrestore(&pool->pool_lock, flags);
>
> -       if (!ib_device_try_get(&pool->rxe->ib_dev))
> -               goto out_put_pool;
> -
>         if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>                 goto out_cnt;
>
> @@ -438,9 +405,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
>
>  out_cnt:
>         atomic_dec(&pool->num_elem);
> -       ib_device_put(&pool->rxe->ib_dev);
> -out_put_pool:
> -       rxe_pool_put(pool);
>         return -EINVAL;
>  }
>
> @@ -461,8 +425,6 @@ void rxe_elem_release(struct kref *kref)
>         }
>
>         atomic_dec(&pool->num_elem);
> -       ib_device_put(&pool->rxe->ib_dev);
> -       rxe_pool_put(pool);
>  }
>
>  void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index f916ad4d0406..294839d1eed8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -68,7 +68,6 @@ struct rxe_pool {
>         struct rxe_dev          *rxe;
>         rwlock_t                pool_lock; /* protects pool add/del/search */
>         size_t                  elem_size;
> -       struct kref             ref_cnt;
>         void                    (*cleanup)(struct rxe_pool_entry *obj);
>         enum rxe_pool_state     state;
>         enum rxe_pool_flags     flags;
> --
> 2.27.0
>
