Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC94A533CA8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiEYM32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 08:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiEYM31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 08:29:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0D814AA
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 05:29:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p4so34346777lfg.4
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubOBEZoW1Vva4IZGpsQr+QmHBjlrdJ8X6kVm0tuIzzk=;
        b=THivSHiw9yhjzJ0NzluE8sIMLQ2on+VHAwYxsnsjhrD335Ml4EL+95SONJaQ+qJAOc
         AQw+3DpUPcAfkC58VTXbg8AcTelpnMrl8QQjRNFIrVm93gCjqdhrqFV66lYClgPBXdJ0
         13mjbck3gX0sexuibIBTDl00EBjeJnp6MZ35tpkeFqIszC3ppukM3b8l1olvlkp/B6sn
         oWuTfOxv16ASWLn9NoYtZUkMKyh8Qe8dkZdy8y+nrwP+Sh5u8/epYAP4cRcM1y+oZkNN
         cRpnM6fXDpAQABnP5giHaWrs5fsDFeu14lhU2Bevu9InKqHwlRemh3AaM830huo4YacH
         sx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubOBEZoW1Vva4IZGpsQr+QmHBjlrdJ8X6kVm0tuIzzk=;
        b=D28+bSCsDNd/uOfM+t6UtVQsMmcOxBSVLPRdJoRmjVNuP+fkGG4Ecl2LRAP3irDLWo
         FV0AneJatCHlbPnqS2b0fjiwoe2orcaMEPv4albO/Q9JAk8kg6+ooQIjfSRkv+ySS+gX
         p4TDx1I7GA9pGBDu3pXTwx0BjjzWSf+X7BF+aF3RD8NjqEX4FE+Z61a2j489yorX6N/L
         lvr1miXFH2JjMHriZssPsjNVwbR5edeu3/SntvNPzmsySgT1xEfkNrZ1auYAdx+kYLhT
         YLVQw/wstNzUt4tBeNTw90fXjJbIfffTBz+Rz3iEo0MOq8ge/gqRdt4n65nMALeOsVUm
         ISgQ==
X-Gm-Message-State: AOAM533oaqg73N0A4wvh8fVKQpPhVwMMAvOwGTBrfHljpT1RrxjFLUlg
        Q/DISUEJs8OVRAUBhk+RBqWBoUr6TquGcXP6vzMgUL9VRJve2w==
X-Google-Smtp-Source: ABdhPJycevcffThNO9IG7+jAUfxknThwUMkkT8/R3VaNn2kg1PNx97zjeS0svW3teRNUqyeYGOskPpu9pbD5gYKIRZk=
X-Received: by 2002:a05:6512:224b:b0:478:6e54:a99e with SMTP id
 i11-20020a056512224b00b004786e54a99emr10618148lfu.181.1653481757547; Wed, 25
 May 2022 05:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220526025438.572870-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220526025438.572870-1-yanjun.zhu@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 25 May 2022 14:29:06 +0200
Message-ID: <CAJpMwyhLuygVe3dsg=QkOWwmDSFxpRRjCWNAPr_YknPjub9WNg@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix qp error handler
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
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

On Wed, May 25, 2022 at 12:28 PM <yanjun.zhu@linux.dev> wrote:
>
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Move the qp error handler to be near the rxe_create_qp.
>
> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 14 ++++++++++----
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 22e9b85344c3..f73ca567a8b3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -220,8 +220,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>                            &qp->sq.queue->ip);
>
>         if (err) {
> -               vfree(qp->sq.queue->buf);
> -               kfree(qp->sq.queue);
> +               rxe_queue_cleanup(qp->sq.queue);
>                 qp->sq.queue = NULL;
>                 return err;
>         }
> @@ -277,8 +276,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>                                    qp->rq.queue->buf, qp->rq.queue->buf_size,
>                                    &qp->rq.queue->ip);
>                 if (err) {
> -                       vfree(qp->rq.queue->buf);
> -                       kfree(qp->rq.queue);
> +                       rxe_queue_cleanup(qp->rq.queue);
>                         qp->rq.queue = NULL;
>                         return err;
>                 }
> @@ -341,6 +339,14 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
>         return 0;
>
>  err2:
> +       if (qp_type(qp) == IB_QPT_RC) {
> +               del_timer_sync(&qp->retrans_timer);
> +               del_timer_sync(&qp->rnr_nak_timer);
> +       }
> +
> +       rxe_cleanup_task(&qp->req.task);
> +       rxe_cleanup_task(&qp->comp.task);
> +
>         rxe_queue_cleanup(qp->sq.queue);
>         qp->sq.queue = NULL;
>  err1:
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 9d995854a174..d0bc195b572f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -432,7 +432,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
>         return 0;
>
>  qp_init:
> -       rxe_put(qp);

Does this mean that in case rxe_qp_init_resp fails (rxe_qp_init_req
had succeeded), we will NOT end up calling rxe_qp_do_cleanup? If so,
would we miss shutting down and releasing qp->sk?

>         return err;
>  }
>
> --
> 2.31.1
>
