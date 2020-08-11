Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D02416CF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgHKHBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 03:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgHKHBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 03:01:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ED0C061756
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 00:01:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so10411264wrh.3
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hC9Uv7PZsyBbtJgIFihvP+qg0LBcvIpmxkdd9nP0HiE=;
        b=fkA4zkR72ccJ30GL+d0/3j8glCh3hNGXVbdrw/WbP2/6OpMCmL53KnhYXOZeKn84ub
         s9yxuwXyZUSIf9Copor0cClJnmP1oB1HO2ALRI97alfGXoxAoSmQiYWDvW6k9HBxo4e3
         p7Oa8xcA0kY9H30ptQp/WARBjX+RDAnTGPuRUBHkpMsrNkSumP5dvGIhKRRrFCTgGDb1
         XOtskkp9ldxOhrwjs9ILqtmwZbUNzopX175OZbasWFAdHWGIlc9VDDmnQi2HKwc45pcb
         LRohK+Ocs9CdcrO+9T82pc6IhfDZOYr6lc7NtZDd+X89xcJJ8Jq5Q/3SEraA5c+DTc9h
         2lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hC9Uv7PZsyBbtJgIFihvP+qg0LBcvIpmxkdd9nP0HiE=;
        b=WYSNRBXnnuGOzAGdRB+0wRzxNonbJTHNjdYW+wk6+Dv8IHYGh3zX1XQqd0H4otx8Jr
         kVi74ozcsEAdbw8zrx3PB5MuytoPkdlHOhHNpB9Gv4Hjysmc0x2edHlmT25u6hO6sCi2
         GZvxFdFV/7T+YuKo43j0TrrXIe2DWRGDjCwzHHxmQLyhsg7LGSNsqV0Ng+kS5mu/9Haf
         xiOod4Upjdd7LWcJNu5J8RiIaGG97tIsu1wVpKbNQOezcL4IUj/AyWtdZvLry3CieFhp
         mWCQp09lLZ3uQPZaOl7IhNmKeRTJFXAdMDbTM9DumuPV0qKiOWABVZ10fUfJsivIkvIy
         3Ipg==
X-Gm-Message-State: AOAM532ruLH8qX35LtMFsRrE0ygnw5xSeMww5frFvhc3hLM6gLSp1oCr
        pehmwcYewwpcZb25h+BYXrpczTACmsy5EyiLMrsr
X-Google-Smtp-Source: ABdhPJwad8Snfi3pzdZL65BCt9AnUUEbgGnFqgmp9Wnkj1W6qlpoznWFkehe9Z5eWdLPiyMgvcupldAjpDBkdS1d/SE=
X-Received: by 2002:a5d:43c4:: with SMTP id v4mr29166502wrr.426.1597129301575;
 Tue, 11 Aug 2020 00:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
In-Reply-To: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 09:01:30 +0200
Message-ID: <CAHg0HuwV5mPW3=3LYkrXiwhOG4iEkFkt5Oq+zffbcg2jPp005g@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 10, 2020 at 1:51 PM Md Haris Iqbal
<haris.iqbal@cloud.ionos.com> wrote:
>
> The rnbd_server module's communication manager (cm) initialization depends
> on the registration of the "network namespace subsystem" of the RDMA CM
> agent module. As such, when the kernel is configured to load the
> rnbd_server and the RDMA cma module during initialization; and if the
> rnbd_server module is initialized before RDMA cma module, a null ptr
> dereference occurs during the RDMA bind operation.
>
> Call trace below,
>
> [    1.904782] Call Trace:
> [    1.904782]  ? xas_load+0xd/0x80
> [    1.904782]  xa_load+0x47/0x80
> [    1.904782]  cma_ps_find+0x44/0x70
> [    1.904782]  rdma_bind_addr+0x782/0x8b0
> [    1.904782]  ? get_random_bytes+0x35/0x40
> [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> [    1.904782]  rtrs_srv_open+0x102/0x180
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  rnbd_srv_init_module+0x34/0x84
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  do_one_initcall+0x4a/0x200
> [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> [    1.904782]  ? rest_init+0xb0/0xb0
> [    1.904782]  kernel_init+0xe/0x100
> [    1.904782]  ret_from_fork+0x22/0x30
> [    1.904782] Modules linked in:
> [    1.904782] CR2: 0000000000000015
> [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
>
> All this happens cause the cm init is in the call chain of the module init,
> which is not a preferred practice.
>
> So remove the call to rdma_create_id() from the module init call chain.
> Instead register rtrs-srv as an ib client, which makes sure that the
> rdma_create_id() is called only when an ib device is added.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> ---
> Change in v2:
>         Use only single variable to track number of IB devices and failure
>         Change according to kernel coding style
>
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 79 +++++++++++++++++++++++++-
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 ++
>  2 files changed, 82 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 0d9241f5d9e6..69a37ce73b0c 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -16,6 +16,7 @@
>  #include "rtrs-srv.h"
>  #include "rtrs-log.h"
>  #include <rdma/ib_cm.h>
> +#include <rdma/ib_verbs.h>
>
>  MODULE_DESCRIPTION("RDMA Transport Server");
>  MODULE_LICENSE("GPL");
> @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
>  static struct rtrs_rdma_dev_pd dev_pd;
>  static mempool_t *chunk_pool;
>  struct class *rtrs_dev_class;
> +static struct rtrs_srv_ib_ctx ib_ctx;
>
>  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
>  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> @@ -2033,6 +2035,64 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
>         kfree(ctx);
>  }
>
> +static int rtrs_srv_add_one(struct ib_device *device)
> +{
> +       struct rtrs_srv_ctx *ctx;
> +       int ret;
> +
> +       if (ib_ctx.ib_dev_count)
> +               goto out;
> +
> +       /*
> +        * Since our CM IDs are NOT bound to any ib device we will create them
> +        * only once
> +        */
> +       ctx = ib_ctx.srv_ctx;
> +       ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> +       if (ret) {
> +               /*
> +                * We errored out here.
> +                * According to the ib code, if we encounter an error here then the
> +                * error code is ignored, and no more calls to our ops are made.
> +                */
> +               pr_err("Failed to initialize RDMA connection");
> +               ib_ctx.ib_dev_count = -1;
> +               return ret;
> +       }
> +
> +out:
> +       /*
> +        * Keep a track on the number of ib devices added
> +        */
> +       ib_ctx.ib_dev_count++;
> +
> +       return 0;
> +}
> +
> +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> +{
> +       struct rtrs_srv_ctx *ctx;
> +
> +       ib_ctx.ib_dev_count--;
> +
> +       if (ib_ctx.ib_dev_count)
> +               return;
> +
> +       /*
> +        * Since our CM IDs are NOT bound to any ib device we will remove them
> +        * only once, when the last device is removed
> +        */
> +       ctx = ib_ctx.srv_ctx;
> +       rdma_destroy_id(ctx->cm_id_ip);
> +       rdma_destroy_id(ctx->cm_id_ib);
> +}
> +
> +static struct ib_client rtrs_srv_client = {
> +       .name   = "rtrs_server",
> +       .add    = rtrs_srv_add_one,
> +       .remove = rtrs_srv_remove_one
> +};
> +
>  /**
>   * rtrs_srv_open() - open RTRS server context
>   * @ops:               callback functions
> @@ -2051,12 +2111,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
>         if (!ctx)
>                 return ERR_PTR(-ENOMEM);
>
> -       err = rtrs_srv_rdma_init(ctx, port);
> +       ib_ctx = (struct rtrs_srv_ib_ctx) {
> +               .srv_ctx        = ctx,
> +               .port           = port,
> +       };
> +
> +       err = ib_register_client(&rtrs_srv_client);
>         if (err) {
>                 free_srv_ctx(ctx);
>                 return ERR_PTR(err);
>         }
>
> +       /*
> +        * Since ib_register_client does not propagate the device add error
> +        * we check if .add was called and the RDMA connection init failed
> +        */
> +       if (ib_ctx.ib_dev_count < 0) {
> +               free_srv_ctx(ctx);
> +               return ERR_PTR(-ENODEV);
> +       }
> +
>         return ctx;
>  }
>  EXPORT_SYMBOL(rtrs_srv_open);
> @@ -2090,8 +2164,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
>   */
>  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
>  {
> -       rdma_destroy_id(ctx->cm_id_ip);
> -       rdma_destroy_id(ctx->cm_id_ib);
> +       ib_unregister_client(&rtrs_srv_client);
>         close_ctx(ctx);
>         free_srv_ctx(ctx);
>  }
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> index dc95b0932f0d..e8f7e99a9a6e 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> @@ -118,6 +118,12 @@ struct rtrs_srv_ctx {
>         struct list_head srv_list;
>  };
>
> +struct rtrs_srv_ib_ctx {
> +       struct rtrs_srv_ctx     *srv_ctx;
> +       u16                     port;
> +       int                     ib_dev_count;
> +};
> +
>  extern struct class *rtrs_dev_class;
>
>  void close_sess(struct rtrs_srv_sess *sess);
> --
> 2.25.1
>

This patch goes all the way registering an ib client in order to call
rdma_bind_addr only after the first device is added instead of calling
it from module_init directly.
I think the original one line fix
https://www.spinics.net/lists/linux-rdma/msg93267.html was good enough
to close a bug triggered only when all modules are build-in.
Since the convention appears to be to call ib_client_register, this
also looks good to me.
Thanks you!

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
