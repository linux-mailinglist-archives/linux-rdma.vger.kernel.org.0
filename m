Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E6390DF0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 03:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhEZBeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 21:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhEZBeF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 21:34:05 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC834C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 18:32:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so30498089otp.11
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfdiZ93BG58n5CzI6bSgc1ga89mMSO6SMO50r1nHvmA=;
        b=cfd26SiiOiFNZkiHNMD/T2lrxHqdM4I6eek4Yk6SymqF/Woe2zEMhbgyL7G8/K6/dY
         AqsV0Sz60kE9QPrz36y7EhCdDjKc6xMQH30H5Isoz+5RIgXOSYyojdU31V3jdr47WvmA
         NMOvJfT6GUI4lmiy0mwKbCv33jZZWyoEe2pRqed6yJM2KKhJK8POHHBAhNYmGs+smhPg
         eRLK+qVdvXD0gQSsCnyDyWJtcxHSOlkvikFlw0rcsgEDP9+5x8WGMwchxpZAIA9xX20U
         73cjb7E2/W7nkzG9Wn4W49ftQleEnbg1tH3eeiqYJkq/fZyxV3BQfmEkcUZtXnhfDDF8
         UZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfdiZ93BG58n5CzI6bSgc1ga89mMSO6SMO50r1nHvmA=;
        b=gm/BztaMvE2LnQjGL3Dtn+uJhfC/SI+UKe7C67tqdHATVDYReWU42ECdbpAvWJRbtv
         BJx+BKcgLqNtvWWZcYTjTE+FiyGkFVPwJjdh6OzWAkKW0WskeuaoILeCRAf50mmOxNBm
         4IAGUu/CrNZbbY6jJ8KtukFFes4cqRRCeoFSWUshmICc0IIZI9wzc/J7o9YrycIoTCyC
         b/tV9K5Th23CgoApTl9YRxI5W8AKdwQzZAznlpEGlgSkgq4bYfSqGyvKoimrfhPIzgt2
         pVoETIJC/97Yb2wmCLTWg6JSwicBz/+doufWmgE4qSHv3faf2xmjGGFob6MKdRkO8+mi
         MX/g==
X-Gm-Message-State: AOAM531hN+954jxzipdHUX07WOqO9Ey6/qZixkWoA2oy9GEEATQ59Kki
        midCpWfBx72ErXUsuscWzQxI6r4id6VHb4gZQNs=
X-Google-Smtp-Source: ABdhPJxS4FKGEFOSthJcjN7WKdf7KGdaGClPBGD00zQCUx48WFfadhl+M1Nw1ghVC1TLFcSxOgdUJsmAaKCu9f2Q/zg=
X-Received: by 2002:a05:6830:1388:: with SMTP id d8mr387378otq.53.1621992753171;
 Tue, 25 May 2021 18:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210525201111.623970-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 26 May 2021 09:32:22 +0800
Message-ID: <CAD=hENfzcxizAuVK3KZRZNCtzaHxW+QHR9D7aBD4-SMk4oiuWQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for resize cq
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, zyj2020@gmail.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 6:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> The rxe driver has recently begun exhibiting failures in the python
> tests that are due to stale values read from the completion queue
> producer or consumer indices. Unlike the other loads of these shared
> indices those in queue_count() were not protected by smp_load_acquire().
>
> This patch replaces loads by smp_load_acquire() in queue_count().
> The observed errors no longer occur.
>
> Reported-by: Zhu Yanjun <zyj2020@gmail.com>

My email address is wrong. It should be zyjzyj2000@gmail.com

Zhu Yanjun

> Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index 2902ca7b288c..5cb142282fa6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -161,8 +161,22 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
>
>  static inline unsigned int queue_count(const struct rxe_queue *q)
>  {
> -       return (q->buf->producer_index - q->buf->consumer_index)
> -               & q->index_mask;
> +       u32 prod;
> +       u32 cons;
> +       u32 count;
> +
> +       /* make sure all changes to queue complete before
> +        * changing producer index
> +        */
> +       prod = smp_load_acquire(&q->buf->producer_index);
> +
> +       /* make sure all changes to queue complete before
> +        * changing consumer index
> +        */
> +       cons = smp_load_acquire(&q->buf->consumer_index);
> +       count = (prod - cons) % q->index_mask;
> +
> +       return count;
>  }
>
>  static inline void *queue_head(struct rxe_queue *q)
> --
> 2.30.2
>
