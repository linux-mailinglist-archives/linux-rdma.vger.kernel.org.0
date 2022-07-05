Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791D156680F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiGEKft (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiGEKfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 06:35:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8904AE4C
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 03:35:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i17so9194582ljj.12
        for <linux-rdma@vger.kernel.org>; Tue, 05 Jul 2022 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMFYO+rSe8i6sBKJCiHV5WPJjy5uhgrX5h0Rew6vu8Y=;
        b=KpRpndXnsJIDcxlTv3DAhSKyb9HnezuXG9ctNcBfRlxoU5pkooQ5cbGOkBXExhOAvn
         RY3cP5klAUpNyIxF3i4biGXfPcUrSeok/UYASyPHyrFBs4lyctJFDUC4noxEs/GOlsSc
         GbpZQLN5uupEo/4ryP6jnJlixHS4hxuRF+lnEGSNHebqXdst11ZTYLTWX3VPXKxiooPg
         piI8NSAMZSvyWqZ+BsN6fGnZb+txVGmUSeeN7djtLzsCS5blISWEWySfm0x8muItRysQ
         5qlje0HuHpm1i2NBDhfNAJT6rSPcfEPmyeLPaAMLGW2ctANujC41yiSofrLUkWoI8D1D
         IFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMFYO+rSe8i6sBKJCiHV5WPJjy5uhgrX5h0Rew6vu8Y=;
        b=sRD+AT0mIweCOiQ9YrX71Bpcga+8RgXh5G3Jm3JReZyEFfC1JIWP1tGLZLgx3O0cVL
         P7n/rnyhZwm5IsQXZwXUCO6Zd1EmQY7me185vsgeav/vusYo04PhPr7Jv07t81WxG29w
         2dZfwbOe/Tiyqd6JpwrmQXfR7VS+cnjXoMnxUChHg6l6mmkHcReKlHBjK7IpH/G+HE3B
         pPUY2XHjROgM0F1LXZ+3hRQsER42mrNpc3v4ZAcekcIWDZ3F2lxhJsqM4Rjui1TMQ+sO
         QaWffLdEYuMkEeEh2pCFWy2gtRfZsZQamstPTR9kfOMDE90xXEA0KSlxpb0f3wi7tneZ
         NqHg==
X-Gm-Message-State: AJIora/dNReQWgM41dfQyXWHjD9O2VNo8lLnjCCwy+HN2ibEheLjwTN3
        qlGdnob0b07D1mD8lUI1DMPHOwXAiO3cC5b2vBKY0w==
X-Google-Smtp-Source: AGRyM1sH+Sqq2S47uFZMVwuhfkhpVleQQKRkYVPQ8+MuZs4ack0cKrIjTi4CF4C0sfy+I8jS4GFFInQAdqgpOP2KYwE=
X-Received: by 2002:a2e:a484:0:b0:25a:8c94:3763 with SMTP id
 h4-20020a2ea484000000b0025a8c943763mr18929097lji.64.1657017345308; Tue, 05
 Jul 2022 03:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220705225414.315478-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220705225414.315478-1-yanjun.zhu@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 5 Jul 2022 12:35:34 +0200
Message-ID: <CAJpMwyg8YF30W_43oKD=cQ8b9pWaSh-aPON4u50b2VG==WXBwQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup
To:     yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
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

On Tue, Jul 5, 2022 at 8:28 AM <yanjun.zhu@linux.dev> wrote:
>
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> The function rxe_create_qp calls rxe_qp_from_init. If some error
> occurs, the error handler of function rxe_qp_from_init will set
> both scq and rcq to NULL.
>
> Then rxe_create_qp calls rxe_put to handle qp. In the end,
> rxe_qp_do_cleanup is called by rxe_put. rxe_qp_do_cleanup directly
> accesses scq and rcq before checking them. This will cause
> null-ptr-deref error.
>
> The call graph is as below:
>
> rxe_create_qp {
>   ...
>   rxe_qp_from_init {
>     ...
>   err1:
>     ...
>     qp->rcq = NULL;  <---rcq is set to NULL
>     qp->scq = NULL;  <---scq is set to NULL
>     ...
>   }
>
> qp_init:
>   rxe_put{
>     ...
>     rxe_qp_do_cleanup {
>       ...
>       atomic_dec(&qp->scq->num_wq); <--- scq is accessed
>       ...
>       atomic_dec(&qp->rcq->num_wq); <--- rcq is accessed
>     }
> }
>
> Fixes: 4703b4f0d94a ("RDMA/rxe: Enforce IBA C11-17")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Describe the error flows.
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 22e9b85344c3..b79e1b43454e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -804,13 +804,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>         if (qp->rq.queue)
>                 rxe_queue_cleanup(qp->rq.queue);
>
> -       atomic_dec(&qp->scq->num_wq);
> -       if (qp->scq)
> +       if (qp->scq) {
> +               atomic_dec(&qp->scq->num_wq);
>                 rxe_put(qp->scq);
> +       }
>
> -       atomic_dec(&qp->rcq->num_wq);
> -       if (qp->rcq)
> +       if (qp->rcq) {
> +               atomic_dec(&qp->rcq->num_wq);
>                 rxe_put(qp->rcq);
> +       }
>
>         if (qp->pd)
>                 rxe_put(qp->pd);
> --
> 2.34.1

Looks good.

Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Should the check for "rxe_cleanup_task(&qp->comp.task);" also happen
in this commit? or would it be covered in a different one?

>
