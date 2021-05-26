Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D7391033
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhEZFzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 01:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhEZFzU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 01:55:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A87BC061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 22:53:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so20390182oty.7
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDNfVXkMmHDiOmiQ9i7umGi4hmfkorDqHYN38CK7HxY=;
        b=hxmx3luqgMTqEMgvQpQEjLxaSGoMHp2oNVlE/jNm7fV32cYLq43j3MEJP3uw/twI4m
         ie+GYChYHreWJnJjOP0fAw4un5oYNWEn01CdRo5mzBJocsX2DFdJsXUzJysbn92s+Gby
         dwxpai+68oK7e1ca8vwgz+vQVSd4NSFtw53PwjciI3vF3B5KQi/u0wAiK2BEjBzXLPuG
         e59ae9lZTGmkZcOqEDfxWhY1dpKLT2C6lo0f6a1IsWRWPHIVmZ1b6IRlrHk9ifmZYndx
         WuOB9Iy1Ft/rafdDyPwZ1w4BIGQhlH2zdfhLNq/oOy2aDm2eDq9PtzA26t1+sCzBLWvn
         +ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDNfVXkMmHDiOmiQ9i7umGi4hmfkorDqHYN38CK7HxY=;
        b=mkreeIQ1iidyjOSl+R/OB8D63rPOdjpldrUkhxY4fOcYHX00xWi4m7rv4U+DxmbN1K
         gauZWTzj5wQENJ1YqoPWpZHKw5qOL43Y8z2jxu5p5vrmDfknTUoExqx1WyiBVzdaoJnI
         xwUgENzNiyLDZhcv3IfbVxej3Rets7HeN1kaFPXpD/I6o+8rnNXsVExwcSbdg13XFT6q
         KsTSIzag1JXB8/6FurRyvVZcycyjxwIVAxKb6gazW0exOdxJFjp1SqP1dZxoB+bLoCHm
         Wzsd9/kn3bz2GWrJK14soqStPCsXMOadJGTOXok9ZrmUo4ltJCs6SMCegIiKJMLrKD9R
         wjWA==
X-Gm-Message-State: AOAM5307mxGqorM1iBzunAbFfetwaa1KPJq7SDoJaQhfWRwJk3Lzh8sD
        D7iNW8/ZX29RWJwRUbcWNCaGMRSD8/iSGVIgcBs=
X-Google-Smtp-Source: ABdhPJyrphSiuEEFn1yj3QxBj6jrRpfkMuutacppMM59XP1rr5m3zDq4WL1eisOTIvXHFIOPHNlJHPapzurY5gPKCa8=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr1082698otk.59.1622008428922;
 Tue, 25 May 2021 22:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
In-Reply-To: <20210525201111.623970-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 26 May 2021 13:53:37 +0800
Message-ID: <CAD=hENdFca7919P37UGKt0bsph7TMTBomytJ93coivdpELhAJA@mail.gmail.com>
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

% is different from &. Not sure it is correct to use % instead of & in
the original source code.

Zhu Yanjun

> +
> +       return count;
>  }
>
>  static inline void *queue_head(struct rxe_queue *q)
> --
> 2.30.2
>
