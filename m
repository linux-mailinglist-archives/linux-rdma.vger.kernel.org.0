Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EF5A2616
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbiHZKsP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbiHZKsO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 06:48:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD669BB61
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 03:48:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tl26so1669732ejc.9
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yh+P/7fqmCq67atirw+OwVxTqQTtIbgbmJEQXB5kn1Q=;
        b=N2aEYsvxUROwq8Gll7YOVqZTBg8aQZTZ4mJjuf77s5M1szp8Hnpaq6de5dZ3Cgrw//
         p+Z3SC/X4TOXg70DMUkDjs4UhhpieDcP0xSPNblsZDRBa1FwOOA9DrIr9z7cdZkmO59Y
         qSsT65EZtr5PfF+7WXfN22oqn1D7ev6QfqubfkQ7OCombX9nhg4e1SQ3TEkTz5vwn9B7
         ASJjIPEslkL044JIXDMQ/r73sQCRaO/puvLWpBKwu7gWb5RlJHj1pGhxAiGqcWNfP7JA
         sc+FVSiMi8qZjzjF+E25FU9lUzVUOPJ6AkodRSG/Spu3C7YB8vyzYkkfDKaPUTaE4Zx+
         1GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yh+P/7fqmCq67atirw+OwVxTqQTtIbgbmJEQXB5kn1Q=;
        b=4XgJqCMO2bMp1058uUyIiS+H0PunFmrURAbjffZDvni2X3xXS5yrXbvoY4j823oYfq
         8aE6iZwX0TuuG3GwF5wiMI6UaQSi/CyoaXXiLbGDxpC5DIMxWp7nqGhEzpKaYTgYWl3U
         HBzOdH6RTKfZASbf7/EvP/81gOAZptajdIEXRlt/xDa5G/a2P3x/A5GZEl9GluW6epke
         kPgkBM0wlucOpcT6pPqLCmg1UzHAaZCO309NVKM3U0uZ4mWJp241goBTQc7FRC9eK0Xg
         l7hCSQ0UqC18iQt0CYhbWGQAOF6cKJL5FfYiQXQvKS2Nd6dZONxK/QKO3fiV98AUfiHd
         ZYxA==
X-Gm-Message-State: ACgBeo1wqosqe1EEP2BRR2S9uQWX7H8HpxFiRisKLwFUJGmQKcWTkFo1
        sELkFzFSRwzDYbjDC3Br91IfdnnxmlOZjPd6rTz7bQ==
X-Google-Smtp-Source: AA6agR7Dl7luUVR68isxeYeXpnNlmos4WK5MhCA+FRBXhT/Vl1mA6HrYI3+tste9wI71xHdXoqlvZfIpanJ4wEU5Jmg=
X-Received: by 2002:a17:907:7f02:b0:73d:dffa:57b3 with SMTP id
 qf2-20020a1709077f0200b0073ddffa57b3mr2440129ejc.19.1661510891879; Fri, 26
 Aug 2022 03:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
In-Reply-To: <20220826081117.21687-1-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 26 Aug 2022 12:48:00 +0200
Message-ID: <CAMGffEku8H3RubkQGq1Cjy8pP8B+95coT+b2J6VxSAQx-kKmmg@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, jgg@ziepe.ca,
        leon@kernel.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
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

On Fri, Aug 26, 2022 at 10:11 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Since all callers (process_{read,write}) set id->dir, no need to
> pass 'dir' again.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
>  drivers/block/rnbd/rnbd-srv.h          | 1 +
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
>  4 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 3f6c268e04ef..9600715f1029 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -368,10 +368,9 @@ static int process_msg_sess_info(struct rnbd_srv_session *srv_sess,
>                                  const void *msg, size_t len,
>                                  void *data, size_t datalen);
>
> -static int rnbd_srv_rdma_ev(void *priv,
> -                           struct rtrs_srv_op *id, int dir,
> -                           void *data, size_t datalen, const void *usr,
> -                           size_t usrlen)
> +static int rnbd_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
> +                           void *data, size_t datalen,
> +                           const void *usr, size_t usrlen)
>  {
>         struct rnbd_srv_session *srv_sess = priv;
>         const struct rnbd_msg_hdr *hdr = usr;
> @@ -398,7 +397,7 @@ static int rnbd_srv_rdma_ev(void *priv,
>                 break;
>         default:
>                 pr_warn("Received unexpected message type %d with dir %d from session %s\n",
> -                       type, dir, srv_sess->sessname);
> +                       type, id->dir, srv_sess->sessname);
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> index 081bceaf4ae9..5a0ef6c2b5c7 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -14,6 +14,7 @@
>  #include <linux/kref.h>
>
>  #include <rtrs.h>
> +#include <rtrs-srv.h>
why do we need this?
>  #include "rnbd-proto.h"
>  #include "rnbd-log.h"
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 34c03bde5064..9dc50ff0e1b9 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1024,7 +1024,7 @@ static void process_read(struct rtrs_srv_con *con,
>         usr_len = le16_to_cpu(msg->usr_len);
>         data_len = off - usr_len;
>         data = page_address(srv->chunks[buf_id]);
> -       ret = ctx->ops.rdma_ev(srv->priv, id, READ, data, data_len,
> +       ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
>                            data + data_len, usr_len);
>
>         if (ret) {
> @@ -1077,7 +1077,7 @@ static void process_write(struct rtrs_srv_con *con,
>         usr_len = le16_to_cpu(req->usr_len);
>         data_len = off - usr_len;
>         data = page_address(srv->chunks[buf_id]);
> -       ret = ctx->ops.rdma_ev(srv->priv, id, WRITE, data, data_len,
> +       ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
>                                data + data_len, usr_len);
>         if (ret) {
>                 rtrs_err_rl(s,
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
> index 5e57a7ccc7fb..b48b53a7c143 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs.h
> @@ -139,7 +139,6 @@ struct rtrs_srv_ops {
>
>          *      @priv:          Private data set by rtrs_srv_set_sess_priv()
>          *      @id:            internal RTRS operation id
> -        *      @dir:           READ/WRITE
>          *      @data:          Pointer to (bidirectional) rdma memory area:
>          *                      - in case of %RTRS_SRV_RDMA_EV_RECV contains
>          *                      data sent by the client
> @@ -151,7 +150,7 @@ struct rtrs_srv_ops {
>          *      @usrlen:        Size of the user message
>          */
>         int (*rdma_ev)(void *priv,
> -                      struct rtrs_srv_op *id, int dir,
> +                      struct rtrs_srv_op *id,
>                        void *data, size_t datalen, const void *usr,
>                        size_t usrlen);
>         /**
> --
> 2.31.1
>
