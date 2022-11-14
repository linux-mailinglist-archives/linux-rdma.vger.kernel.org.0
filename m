Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45F627681
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 08:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiKNHkK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 02:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNHkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 02:40:07 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C745F183BC
        for <linux-rdma@vger.kernel.org>; Sun, 13 Nov 2022 23:40:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g7so17934649lfv.5
        for <linux-rdma@vger.kernel.org>; Sun, 13 Nov 2022 23:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rtoPZgt4JSJeGH1Zs0kAhm/zibt/1ZTMt2LTLampnxw=;
        b=BcYntpfQ4LWAzJKR59ZNuqpYxFDEEXN4urkCe25Yu75pwQBVD2vKWZwljYH60C2x0M
         V2zExp99NyX1tVKbwKCyDrFvDFSbletu6BeuyBGUTcaYviv/WmKVkY6B5X3k9C1qr1Jk
         f524qzoJR2AZXEhb9jVLxUXA+IsCVAy6N6env1OE0KUx8u/cEno8Za9nDc414z5YCy9J
         HSWulXynW3rponW1Bf+414HUMmtL0Hm9FYzB1Ae0Dfk38RqNRWpoXKOehIkNJEARupj9
         ST/8OBcDhJA0PNxhspPcF1VdiWHjp4XO0LSYmd+F5PnfkhG3wdnyiH7EW5zPX/hJ3RoP
         VHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtoPZgt4JSJeGH1Zs0kAhm/zibt/1ZTMt2LTLampnxw=;
        b=DUaLQPPJG1De9PP4+ZoK5ETspbtyABfBk9383tZSdaAlSLCnJqJemAsxwynnH4RpAZ
         wYZsOpamNeLMtVjg3qdetAmCV+C62jz/STDuBilJy70s4SQbZDRIPjeK6uG42oxrhbHX
         nlsfwKJ1MfyW3Ll4DEoaYDaHVt8+kCvWB68sDMo/UxNBkjogERO8zFMw9B5ETxUN25+0
         wCx2hDzkhdH0Rv6Ex0MZBE+RRq53QGv6NZ+AjEW5xBuOjA9N6XIkSJ8lIMl/Ljbzhy4n
         lZ8EDq4LG8g5IMgbkOe9Q1id3sDdA+GISNgAW9rih2uSrKidD9cjUNSx01sDtq6fK4sz
         6YyA==
X-Gm-Message-State: ANoB5plILhCzzmXrdz7D6bIrJZgYRd+pqIcfnCtjLcWAmtQgH16xmZPH
        WSqvIjt+lviM0VaQOj4Lf8T8WHHerlmRunfs0KzlAE5F5CYX4A==
X-Google-Smtp-Source: AA0mqf4AYdNYQ3r753FtL3ny50kDxG6vhsOnAZpOYNgXSaZK7X3sS5cljsIlAUIEeY9AcxtM6Oe8A01TdOUbY3QDZyA=
X-Received: by 2002:ac2:5ca4:0:b0:494:6b75:2c1b with SMTP id
 e4-20020ac25ca4000000b004946b752c1bmr4240397lfq.478.1668411605089; Sun, 13
 Nov 2022 23:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-2-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-2-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 14 Nov 2022 08:39:54 +0100
Message-ID: <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Guoqing,

Thx for the patch, see comments below.
On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> The ib_dev_count is supposed to track the number of added ib devices
> which is only used in rtrs_srv_{add,remove}_one.
>
> However we only trigger rtrs_srv_add_one from rnbd_srv_init_module
> -> rtrs_srv_open -> ib_register_client -> client->add which should
> happen only once.
client->add is call per ib_device, eg:
jwang@ps404a-1.stg:~$ ls -l /sys/class/infiniband/mlx5_*
lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_0 ->
../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/infiniband/mlx5_0
lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_1 ->
../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.1/infiniband/mlx5_1
rtrs will be call twice for  mlx5_0 and mlx5_1 devices

So this one is NACK

And so is rtrs_srv_close since it is only called
> by unload rnbd-server or failure case when load rnbd-server.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 16 ----------------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 -
>  2 files changed, 17 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 22d7ba05e9fe..79504aaef0cc 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -2097,8 +2097,6 @@ static int rtrs_srv_add_one(struct ib_device *device)
>         int ret = 0;
>
>         mutex_lock(&ib_ctx.ib_dev_mutex);
> -       if (ib_ctx.ib_dev_count)
> -               goto out;
>
>         /*
>          * Since our CM IDs are NOT bound to any ib device we will create them
> @@ -2108,21 +2106,12 @@ static int rtrs_srv_add_one(struct ib_device *device)
>         ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
>         if (ret) {
>                 /*
> -                * We errored out here.
>                  * According to the ib code, if we encounter an error here then the
>                  * error code is ignored, and no more calls to our ops are made.
>                  */
>                 pr_err("Failed to initialize RDMA connection");
> -               goto err_out;
>         }
>
> -out:
> -       /*
> -        * Keep a track on the number of ib devices added
> -        */
> -       ib_ctx.ib_dev_count++;
> -
> -err_out:
>         mutex_unlock(&ib_ctx.ib_dev_mutex);
>         return ret;
>  }
> @@ -2132,10 +2121,6 @@ static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
>         struct rtrs_srv_ctx *ctx;
>
>         mutex_lock(&ib_ctx.ib_dev_mutex);
> -       ib_ctx.ib_dev_count--;
> -
> -       if (ib_ctx.ib_dev_count)
> -               goto out;
>
>         /*
>          * Since our CM IDs are NOT bound to any ib device we will remove them
> @@ -2145,7 +2130,6 @@ static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
>         rdma_destroy_id(ctx->cm_id_ip);
>         rdma_destroy_id(ctx->cm_id_ib);
>
> -out:
>         mutex_unlock(&ib_ctx.ib_dev_mutex);
>  }
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> index 2f8a638e36fa..eccc432b0715 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> @@ -126,7 +126,6 @@ struct rtrs_srv_ib_ctx {
>         struct rtrs_srv_ctx     *srv_ctx;
>         u16                     port;
>         struct mutex            ib_dev_mutex;
> -       int                     ib_dev_count;
>  };
>
>  extern struct class *rtrs_dev_class;
> --
> 2.31.1
>
