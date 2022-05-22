Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDC5306C1
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiEVX7a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 May 2022 19:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiEVX7a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 May 2022 19:59:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5F377F3
        for <linux-rdma@vger.kernel.org>; Sun, 22 May 2022 16:59:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e4so14821012ljb.13
        for <linux-rdma@vger.kernel.org>; Sun, 22 May 2022 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/RiysncINdPzFdC2WqFJpsJqxw7jJNom6HnsqzluYs=;
        b=Tz9r/jKzbGn23jiP1hywaUgsJrEXGwFHI0NunmIC0h5CkZ5uAxbhQCQIyf8a2D2YSl
         cYPA6yvdllXI0i9Zc3VQAhASDTUFXDsnSsBauJz8tv35iUndWy3xxPMtVox6QWuW9e4X
         l4DauKCdy5qsQ8zTWd54gfRXyCm6sKAHuSxVD6iKzDVoSYWcJiWHAPZx/UCU/A8bMZ0q
         oDWSUFNsQF8G1DCAVOvW+28ak+pxyThUd4XrGaiBLYuzHNuMxbuxRq2//O9oGdJrmyEI
         rTOKEXL39lCpT/WNFNjFiM9Jo4mS1RuX5/EwMDAdPsKDEUHO9oq0yvSHXZx2iCd5Ep5B
         b92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/RiysncINdPzFdC2WqFJpsJqxw7jJNom6HnsqzluYs=;
        b=JcfXbHklhqdxsEwb50PTbkWBTd7f3vkOLWGBcKSKQjQHT79T9K5g6vXa2i4ITKabga
         xAKc+lxrgPpUZtsyfx7ZJJA9WJXsKj+2nrrw1F7/uE2BjMr6URqGn0RjE7JRCW6ksMAQ
         xGj38+c1p1qznwbucPSQZwJmreDWEG9MX0XjYJ0IcOHjW4g/MNQ8XUC/iIh5cxEXUuT1
         XrULmkRGEdK3qzON6XZE2yH7qLZ7YApCMV55DAARvvcbCj+wjggTN79hmUtpCoS9vO3q
         oPmnHrkGLwCM7cz7MFSZaraedAppWQ9EXQ5lAE9qIWq0K2jDyyjYiuvrAkoFtJ8MwGAp
         U5ig==
X-Gm-Message-State: AOAM531vIQfljd7Lxd2RaH5xIQCU8CoRTlRhONV6mI+BucYOqEDnyY0t
        hW/gXt7UhjWdF946RjYADUmMJ1Dunvbc3HXY4q1RJg==
X-Google-Smtp-Source: ABdhPJyiFLZipDKPV0u+bIkpOkr0MB/yoSaN9zWWsqpZ0a9jgPZysMcQuRibk0wnhZnlpetco7nESTCrFz9knNBJCRI=
X-Received: by 2002:a2e:9ccb:0:b0:253:df97:ebd with SMTP id
 g11-20020a2e9ccb000000b00253df970ebdmr6950836ljj.280.1653263967092; Sun, 22
 May 2022 16:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220522223345.9889-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220522223345.9889-1-rpearsonhpe@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 23 May 2022 01:59:15 +0200
Message-ID: <CAJpMwyjjbZtG152GAZZV_t6sn8bw6J0tSGaaY_9LTdw0Ve7gEg@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect fencing
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        frank.zago@hpe.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 23, 2022 at 12:36 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Currently the rxe driver checks if any previous operation
> is not complete to determine if a fence wait is required.
> This is not correct. For a regular fence only previous
> read or atomic operations must be complete while for a local
> invalidate fence all previous operations must be complete.
> This patch corrects this behavior.
>
> Fixes: 8700e3e7c4857 ("Soft RoCE (RXE) - The software RoCE driver")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 42 ++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index ae5fbc79dd5c..f36263855a45 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -163,16 +163,41 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
>                      (wqe->state != wqe_state_processing)))
>                 return NULL;
>
> -       if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
> -                                                    (index != cons))) {
> -               qp->req.wait_fence = 1;
> -               return NULL;
> -       }
> -
>         wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
>         return wqe;
>  }
>
> +/**
> + * rxe_wqe_is_fenced - check if next wqe is fenced
> + * @qp: the queue pair
> + * @wqe: the next wqe
> + *
> + * Returns: 1 if wqe is fenced (needs to wait)
> + *         0 if wqe is good to go
> + */
> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> +{
> +       unsigned int cons;
> +
> +       if (!(wqe->wr.send_flags & IB_SEND_FENCE))
> +               return 0;
> +
> +       cons = queue_get_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
> +
> +       /* Local invalidate fence (LIF) see IBA 10.6.5.1
> +        * Requires ALL previous operations on the send queue
> +        * are complete.
> +        */
> +       if (wqe->wr.opcode == IB_WR_LOCAL_INV)
> +               return qp->req.wqe_index != cons;


Do I understand correctly that according to this code a wr with opcode
IB_WR_LOCAL_INV needs to have the IB_SEND_FENCE also set for this to
work?

If that is the desired behaviour, can you point out where in spec this
is mentioned.

Thanks.


> +
> +       /* Fence see IBA 10.8.3.3
> +        * Requires that all previous read and atomic operations
> +        * are complete.
> +        */
> +       return atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
> +}
> +
>  static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
>  {
>         switch (opcode) {
> @@ -636,6 +661,11 @@ int rxe_requester(void *arg)
>         if (unlikely(!wqe))
>                 goto exit;
>
> +       if (rxe_wqe_is_fenced(qp, wqe)) {
> +               qp->req.wait_fence = 1;
> +               goto exit;
> +       }
> +
>         if (wqe->mask & WR_LOCAL_OP_MASK) {
>                 ret = rxe_do_local_ops(qp, wqe);
>                 if (unlikely(ret))
>
> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> --
> 2.34.1
>
