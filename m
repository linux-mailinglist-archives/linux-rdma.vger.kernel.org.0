Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5D28D020
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgJMOWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 10:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgJMOWq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 10:22:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F3C0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 07:22:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so20614136ljn.13
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9T/DqzuhWkI+ITQJ+V5hn5UCO8/BG1SQRCcjNUUeYA=;
        b=OP99yXVhXgD5uglJULEV3Tb496ouQiLwR2qt2pVAID+S6GOklCZZrkMyAmPFZEDISp
         VS8cqo5WXzE8e/tnB1GgG9wr+2bg7YZO+Dq+p9NI98WRCsyRgSuiip2mPjpkjo6H0+im
         PsDZg27tomIq6slDCS3tthPUW09M9K/CTqUzbuRYCFTZs0ERxsJaodYdFZgtQO90L89m
         MMEBC30TnMMiTiTkKXVW9/2KV2cwNNA4FW+F4uaIP5myuBY1TGHyxmR0rrV9nQTOKMvs
         vUoK4jUvMoUp+N5vfnG/vKXYHwbhZCY3lrK8YOCgKkXlTrd0zEr9OJ8fdOXWtifp9bMF
         c7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9T/DqzuhWkI+ITQJ+V5hn5UCO8/BG1SQRCcjNUUeYA=;
        b=XawExaFfw8s2vllOrZSVjqXhSmWg9eutOIW+23i9f6JUS4Wd52iplMONydttagRg6m
         1FIks6PcwBvzzQbq6QAqt7VNuDd7PgjHDyigiTvyAkSIJ+jZ+38/xEceXGscIeZeVyr4
         hTyBtF33ti3viPUYrY6OSwFMv92DcnSlgfSRZ0JMeDhXPV65jZWi9gyYWarb5GWRQtAL
         R1TLkRy7Qw2UL9VVW9REsqQAuApjRgcWqeWsnUS1XnTa1vt/f3rmYdPBtVpzNg7bCfcL
         Ls4syNnWa7WmyX4/c6we3Lau/Gz2aRt9p5FS7yiPCgwFnU4CfQoZu0Pb/hC0BMyQBXn7
         qAbQ==
X-Gm-Message-State: AOAM530/rVuHjr2ynEPLT+/glRPzD0Du/FcH5o33hE7BWVEohfG3PwIG
        MHWseIijOtK2Iwtbybxr3cGOYzGrmV+5xuXgBdh7I0gXDK0=
X-Google-Smtp-Source: ABdhPJyUMY4mvntaryjGSuAQJ7yBrRGfglgx1sxu7y72kjRnuWLw5E7ajm71hWgBO4nFgCETZF4RVx1m/RlvZrczWWo=
X-Received: by 2002:a05:651c:205a:: with SMTP id t26mr9827769ljo.260.1602598964037;
 Tue, 13 Oct 2020 07:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201012131814.121096-1-jinpu.wang@cloud.ionos.com> <20201012131814.121096-5-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201012131814.121096-5-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 13 Oct 2020 16:22:33 +0200
Message-ID: <CAMGffE=wD-qoNg+-BY8ZpgJNKXS-B4ocgtk8hOMoRwyg=frZ8g@mail.gmail.com>
Subject: Re: [PATCH for-next 04/13] RDMA/rtrs-clt: remove unnecessary dev_ref
 of rtrs_sess
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 3:18 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> dev_ref of rtrs_sess is used for counting connections sharing
> the rtrs_ib_dev object. But rtrs_ib_dev has its own reference counter.
> We can use rtrs_ib_dev_get/put.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Please ignore this one, we found problem during tests, sorry.
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 35 +++++++++++---------------
>  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 -
>  2 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 4677e8ed29ae..b1c0c1400c8a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1523,6 +1523,19 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>         struct rtrs_msg_rkey_rsp *rsp;
>
>         lockdep_assert_held(&con->con_mutex);
> +       /*
> +        * The whole session uses device from user connection.
> +        * Be careful not to close user connection before ib dev
> +        * is gracefully put.
> +        */
> +       sess->s.dev = rtrs_ib_dev_find_or_add(con->c.cm_id->device,
> +                                             &dev_pd);
> +       if (!sess->s.dev) {
> +               rtrs_wrn(sess->clt,
> +                        "rtrs_ib_dev_find_get_or_add(): no memory\n");
> +               return -ENOMEM;
> +       }
> +
>         if (con->c.cid == 0) {
>                 /*
>                  * One completion for each receive and two for each send
> @@ -1531,23 +1544,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>                  * in case qp gets into error state
>                  */
>                 wr_queue_size = SERVICE_CON_QUEUE_DEPTH * 3 + 2;
> -               /* We must be the first here */
> -               if (WARN_ON(sess->s.dev))
> -                       return -EINVAL;
>
> -               /*
> -                * The whole session uses device from user connection.
> -                * Be careful not to close user connection before ib dev
> -                * is gracefully put.
> -                */
> -               sess->s.dev = rtrs_ib_dev_find_or_add(con->c.cm_id->device,
> -                                                      &dev_pd);
> -               if (!sess->s.dev) {
> -                       rtrs_wrn(sess->clt,
> -                                 "rtrs_ib_dev_find_get_or_add(): no memory\n");
> -                       return -ENOMEM;
> -               }
> -               sess->s.dev_ref = 1;
>                 query_fast_reg_mode(sess);
>         } else {
>                 /*
> @@ -1560,8 +1557,6 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
>                 if (WARN_ON(!sess->queue_depth))
>                         return -EINVAL;
>
> -               /* Shared between connections */
> -               sess->s.dev_ref++;
>                 wr_queue_size =
>                         min_t(int, sess->s.dev->ib_dev->attrs.max_qp_wr,
>                               /* QD * (REQ + RSP + FR REGS or INVS) + drain */
> @@ -1604,10 +1599,8 @@ static void destroy_con_cq_qp(struct rtrs_clt_con *con)
>                 con->rsp_ius = NULL;
>                 con->queue_size = 0;
>         }
> -       if (sess->s.dev_ref && !--sess->s.dev_ref) {
> -               rtrs_ib_dev_put(sess->s.dev);
> +       if (rtrs_ib_dev_put(sess->s.dev))
>                 sess->s.dev = NULL;
> -       }
>  }
>
>  static void stop_cm(struct rtrs_clt_con *con)
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> index 0a93c87ef92b..287ff78921c7 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> @@ -103,7 +103,6 @@ struct rtrs_sess {
>         unsigned int            con_num;
>         unsigned int            recon_cnt;
>         struct rtrs_ib_dev      *dev;
> -       int                     dev_ref;
>         struct ib_cqe           *hb_cqe;
>         void                    (*hb_err_handler)(struct rtrs_con *con);
>         struct workqueue_struct *hb_wq;
> --
> 2.25.1
>
