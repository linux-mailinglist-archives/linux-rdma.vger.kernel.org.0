Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED903914C3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 12:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhEZKVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhEZKVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 06:21:02 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170CC061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 03:19:30 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b25so1014555oic.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o82ZPHgpu/4ZcxA2/72hcelwOSnuWmw6fRBPC/sEUcM=;
        b=pg87yWW+VvsXPpBUCpbwZE6MrrWGOxTCMwHU33gkSDbr8AxEYFoCIM0sklaqtee05G
         1d9Y9gjQIme67HLP8c7gFUQlLTvssPz6mufsElAmFoYSSJweXzfHgDD5q2MBmBZTBQLn
         zf8p87GOv8AjavoWsGZOFqL3SKPJ2Hamfr1Mk9bWqyTKtDuimMZADV6rA31JeXSelBJd
         HKXKzL6RgS82/cEPPG2FobH6OtBpjYCRHZS+Wvgpeai6Wmane3PQQa2AFVJ5lplFYqlY
         GdqRfQ0qLI4rP4x+LhPLb18WvnoAy0Tdzt+l3aZUV2qjQckS8KrxvalkP6Va/j1mr9TA
         aj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o82ZPHgpu/4ZcxA2/72hcelwOSnuWmw6fRBPC/sEUcM=;
        b=ZJ8D7Vd37QdamoelDUkC4E+cqL/TOrkYXDzHV/AcZjMiMSAssXVaxhn+I2npNb3nRk
         IZBd9EYNb6fhUfo4BHIG4xT8H3pcbf7V1tGhO8tJHqPwGui2JhDSkWwkzriwynJg5Yr2
         q6HAL9qmJCIl9+E0qhJTrNVdXcCFZ+HsBZopmYNda0+5zDd6bRdJwoCPIgJmTKJZczdk
         BzQjRO6LbTlkFAfdaYuieGhOQcPbT9e8DxsU6MnWu9D5p7A0o7sRu6ngow4vN6eMfzm6
         90SnvlWvm6W0fSEQDcuPOUqPLLaGI+Ajw2UaRqZRwXpIdKRHqiYdJs6wh1gNadUGTJ9C
         sruA==
X-Gm-Message-State: AOAM533WyurqPXKVD5Jxzyw8TLEWG/raRZ6h7o8uEAhfEDssFM4JUM3l
        Py+zqN14DJiYyExep6NqEQQvf/D0gxrtefxKe2Y=
X-Google-Smtp-Source: ABdhPJxa5/n4ETR/rRdIEXNcGafdjaOCyhRv7w/0WeO3KYYLbQiTrXUFR81xlx9vhENdYgm7KC222/qDQARm7xuFu1s=
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr1231419oib.163.1622024369852;
 Wed, 26 May 2021 03:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210526045139.634978-1-rpearsonhpe@gmail.com> <20210526045139.634978-3-rpearsonhpe@gmail.com>
In-Reply-To: <20210526045139.634978-3-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 26 May 2021 18:19:18 +0800
Message-ID: <CAD=hENfw3vbiKpBeRuTukQMMoiDBuyOJ2M-0CobN=ozjP9X_8A@mail.gmail.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Protect user space index loads/stores
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 12:52 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Modify the queue APIs to protect all user space index loads
> with smp_load_acquire() and all user space index stores with
> smp_store_release(). Base this on the types of the queues which
> can be one of ..KERNEL, ..FROM_USER, ..TO_USER. Kernel space
> indices are protected by locks which also provide memory barriers.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2:
>   In v2 use queue type to selectively protect user space indices.
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.h | 168 ++++++++++++++++++--------
>  1 file changed, 117 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index 4512745419f8..6e705e09d357 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -66,12 +66,22 @@ static inline int queue_empty(struct rxe_queue *q)
>         u32 prod;
>         u32 cons;
>
> -       /* make sure all changes to queue complete before
> -        * testing queue empty
> -        */
> -       prod = smp_load_acquire(&q->buf->producer_index);
> -       /* same */
> -       cons = smp_load_acquire(&q->buf->consumer_index);
> +       switch (q->type) {
> +       case QUEUE_TYPE_FROM_USER:
> +               /* protect user space index */
> +               prod = smp_load_acquire(&q->buf->producer_index);
> +               cons = q->buf->consumer_index;
> +               break;
> +       case QUEUE_TYPE_TO_USER:
> +               prod = q->buf->producer_index;
> +               /* protect user space index */
> +               cons = smp_load_acquire(&q->buf->consumer_index);
> +               break;
> +       case QUEUE_TYPE_KERNEL:
> +               prod = q->buf->producer_index;
> +               cons = q->buf->consumer_index;
> +               break;
> +       }
>
>         return ((prod - cons) & q->index_mask) == 0;
>  }
> @@ -81,95 +91,151 @@ static inline int queue_full(struct rxe_queue *q)
>         u32 prod;
>         u32 cons;
>
> -       /* make sure all changes to queue complete before
> -        * testing queue full
> -        */
> -       prod = smp_load_acquire(&q->buf->producer_index);
> -       /* same */
> -       cons = smp_load_acquire(&q->buf->consumer_index);
> +       switch (q->type) {
> +       case QUEUE_TYPE_FROM_USER:
> +               /* protect user space index */
> +               prod = smp_load_acquire(&q->buf->producer_index);
> +               cons = q->buf->consumer_index;
> +               break;
> +       case QUEUE_TYPE_TO_USER:
> +               prod = q->buf->producer_index;
> +               /* protect user space index */
> +               cons = smp_load_acquire(&q->buf->consumer_index);
> +               break;
> +       case QUEUE_TYPE_KERNEL:
> +               prod = q->buf->producer_index;
> +               cons = q->buf->consumer_index;
> +               break;
> +       }
>
>         return ((prod + 1 - cons) & q->index_mask) == 0;
>  }
>
> -static inline void advance_producer(struct rxe_queue *q)
> +static inline unsigned int queue_count(const struct rxe_queue *q)
>  {
>         u32 prod;
> +       u32 cons;
>
> -       prod = (q->buf->producer_index + 1) & q->index_mask;
> +       switch (q->type) {
> +       case QUEUE_TYPE_FROM_USER:
> +               /* protect user space index */
> +               prod = smp_load_acquire(&q->buf->producer_index);
> +               cons = q->buf->consumer_index;
> +               break;
> +       case QUEUE_TYPE_TO_USER:
> +               prod = q->buf->producer_index;
> +               /* protect user space index */
> +               cons = smp_load_acquire(&q->buf->consumer_index);
> +               break;
> +       case QUEUE_TYPE_KERNEL:
> +               prod = q->buf->producer_index;
> +               cons = q->buf->consumer_index;
> +               break;
> +       }

The above source code appears in the functions queue_count, queue_full
and queue_empty.
So is it possible to use a seperate function to implement it?

Thanks
Zhu Yanjun

> +
> +       return (prod - cons) & q->index_mask;
> +}
> +
> +static inline void advance_producer(struct rxe_queue *q)
> +{
> +       u32 prod;
>
> -       /* make sure all changes to queue complete before
> -        * changing producer index
> -        */
> -       smp_store_release(&q->buf->producer_index, prod);
> +       if (q->type == QUEUE_TYPE_FROM_USER) {
> +               /* protect user space index */
> +               prod = smp_load_acquire(&q->buf->producer_index);
> +               prod = (prod + 1) & q->index_mask;
> +               /* same */
> +               smp_store_release(&q->buf->producer_index, prod);
> +       } else {
> +               prod = q->buf->producer_index;
> +               q->buf->producer_index = (prod + 1) & q->index_mask;
> +       }
>  }
>
>  static inline void advance_consumer(struct rxe_queue *q)
>  {
>         u32 cons;
>
> -       cons = (q->buf->consumer_index + 1) & q->index_mask;
> -
> -       /* make sure all changes to queue complete before
> -        * changing consumer index
> -        */
> -       smp_store_release(&q->buf->consumer_index, cons);
> +       if (q->type == QUEUE_TYPE_TO_USER) {
> +               /* protect user space index */
> +               cons = smp_load_acquire(&q->buf->consumer_index);
> +               cons = (cons + 1) & q->index_mask;
> +               /* same */
> +               smp_store_release(&q->buf->consumer_index, cons);
> +       } else {
> +               cons = q->buf->consumer_index;
> +               q->buf->consumer_index = (cons + 1) & q->index_mask;
> +       }
>  }
>
>  static inline void *producer_addr(struct rxe_queue *q)
>  {
> -       return q->buf->data + ((q->buf->producer_index & q->index_mask)
> -                               << q->log2_elem_size);
> +       u32 prod;
> +
> +       if (q->type == QUEUE_TYPE_FROM_USER)
> +               /* protect user space index */
> +               prod = smp_load_acquire(&q->buf->producer_index);
> +       else
> +               prod = q->buf->producer_index;
> +
> +       return q->buf->data + ((prod & q->index_mask) << q->log2_elem_size);
>  }
>
>  static inline void *consumer_addr(struct rxe_queue *q)
>  {
> -       return q->buf->data + ((q->buf->consumer_index & q->index_mask)
> -                               << q->log2_elem_size);
> +       u32 cons;
> +
> +       if (q->type == QUEUE_TYPE_TO_USER)
> +               /* protect user space index */
> +               cons = smp_load_acquire(&q->buf->consumer_index);
> +       else
> +               cons = q->buf->consumer_index;
> +
> +       return q->buf->data + ((cons & q->index_mask) << q->log2_elem_size);
>  }
>
>  static inline unsigned int producer_index(struct rxe_queue *q)
>  {
> -       u32 index;
> +       u32 prod;
> +
> +       if (q->type == QUEUE_TYPE_FROM_USER)
> +               /* protect user space index */
> +               prod = smp_load_acquire(&q->buf->producer_index);
> +       else
> +               prod = q->buf->producer_index;
>
> -       /* make sure all changes to queue
> -        * complete before getting producer index
> -        */
> -       index = smp_load_acquire(&q->buf->producer_index);
> -       index &= q->index_mask;
> +       prod &= q->index_mask;
>
> -       return index;
> +       return prod;
>  }
>
>  static inline unsigned int consumer_index(struct rxe_queue *q)
>  {
> -       u32 index;
> +       u32 cons;
>
> -       /* make sure all changes to queue
> -        * complete before getting consumer index
> -        */
> -       index = smp_load_acquire(&q->buf->consumer_index);
> -       index &= q->index_mask;
> +       if (q->type == QUEUE_TYPE_TO_USER)
> +               /* protect user space index */
> +               cons = smp_load_acquire(&q->buf->consumer_index);
> +       else
> +               cons = q->buf->consumer_index;
>
> -       return index;
> +       cons &= q->index_mask;
> +
> +       return cons;
>  }
>
> -static inline void *addr_from_index(struct rxe_queue *q, unsigned int index)
> +static inline void *addr_from_index(struct rxe_queue *q,
> +                               unsigned int index)
>  {
>         return q->buf->data + ((index & q->index_mask)
>                                 << q->buf->log2_elem_size);
>  }
>
>  static inline unsigned int index_from_addr(const struct rxe_queue *q,
> -                                          const void *addr)
> +                               const void *addr)
>  {
>         return (((u8 *)addr - q->buf->data) >> q->log2_elem_size)
> -               & q->index_mask;
> -}
> -
> -static inline unsigned int queue_count(const struct rxe_queue *q)
> -{
> -       return (q->buf->producer_index - q->buf->consumer_index)
> -               & q->index_mask;
> +                               & q->index_mask;
>  }
>
>  static inline void *queue_head(struct rxe_queue *q)
> --
> 2.30.2
>
