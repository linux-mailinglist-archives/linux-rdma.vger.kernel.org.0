Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E608C23C8AD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHEJJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgHEJJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 05:09:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB8C06174A
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 02:09:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so34853811wrs.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gIuoz/WMxbhVg8svooySeNXqd1nOMBCzPaYnalniCA=;
        b=H7x2XxOoNBWlRR/QNIt3KHaCYy0/Sez/plbm3JbhtBwN6esqx1sKDG9fpMkgUESZy8
         dKrGlkX/UE85ohBEP4sI4R0EA0iHzlJ6HbyKLkEfjTW36/p6b/28L1pZFcrBQdD/6KlZ
         1Y6XmZvLxrjlSiKASQQlICPQ/IiEe2xMNAcYuMTs8ztcd+qC95YucOrq+yYS11NHz3zl
         FwQGpeU5dMZayyJLRMweBInIWbe3XSV9EppWxyiQZ5JITSrRn4vnW2ckBnQor8ZNAhNL
         dQlTLAC3hJgSyzKBIvXVdIqDdPBBYDoFK25fG8LKtGpEQ+29S0gIpC4DSYWLf3AyxU2k
         TAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gIuoz/WMxbhVg8svooySeNXqd1nOMBCzPaYnalniCA=;
        b=g6u6mTgZLEQqFBvUOTL7sCtwWk9S0J7VbyT26kBZy91hvTtsq0dCg86+kzkaG1KuYA
         ZvXgczD9QMQPch6sVpn5fA2jcUqQkxnTosRInBjECG8TO/PQ9nst3WQeen7+cFtN/mFJ
         iejyTfYdb+Wv3BVygNMJyCMm4EH8ngUooKqOKMo6bBMErrJM6230UVoumUpKDltOmZGz
         0LceldMHcjKDZea1QRHaNg0kawdSzqLqENh1vu9wNG+7v/5gsqpcpyFy0XoP/LF9GcIN
         QqffE/6qUqsRUC/6Z9eFVkMTmQ5T4QZLQc20A+2fl9+kPcxsPf9JK9ZfRxo4FClXZrJW
         7MqA==
X-Gm-Message-State: AOAM533LfGiw5yniKhOFWM0qHA9fwva7ETqlrCfj8dl8dOfKbDhboSqw
        1fomJSGWDuZTBgOlMAB1sJ9LaXCLBPx1jNZQ/REM
X-Google-Smtp-Source: ABdhPJxhjb0VZDK5fxfNwFfc3Dnra9SEbFypH7RYXTaQrPiVlwCOd/+IjuwLu2UQ2TxCKUguspu/L46XCaw0abgYK7o=
X-Received: by 2002:adf:9526:: with SMTP id 35mr2033886wrs.326.1596618551488;
 Wed, 05 Aug 2020 02:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200623172321.GC6578@ziepe.ca> <20200804133759.377950-1-haris.iqbal@cloud.ionos.com>
 <20200805055712.GE4432@unreal>
In-Reply-To: <20200805055712.GE4432@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 5 Aug 2020 11:09:00 +0200
Message-ID: <CAHg0HuzmfrKqy_SfwEqRh33Ymx8j6DhkLC0=11T7Djrc7z-SWQ@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Chen, Rong A" <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

On Wed, Aug 5, 2020 at 7:57 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 07:07:58PM +0530, Md Haris Iqbal wrote:
> > The rnbd_server module's communication manager (cm) initialization depends
> > on the registration of the "network namespace subsystem" of the RDMA CM
> > agent module. As such, when the kernel is configured to load the
> > rnbd_server and the RDMA cma module during initialization; and if the
> > rnbd_server module is initialized before RDMA cma module, a null ptr
> > dereference occurs during the RDMA bind operation.
> >
> > Call trace below,
> >
> > [    1.904782] Call Trace:
> > [    1.904782]  ? xas_load+0xd/0x80
> > [    1.904782]  xa_load+0x47/0x80
> > [    1.904782]  cma_ps_find+0x44/0x70
> > [    1.904782]  rdma_bind_addr+0x782/0x8b0
> > [    1.904782]  ? get_random_bytes+0x35/0x40
> > [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> > [    1.904782]  rtrs_srv_open+0x102/0x180
> > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > [    1.904782]  rnbd_srv_init_module+0x34/0x84
> > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > [    1.904782]  do_one_initcall+0x4a/0x200
> > [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> > [    1.904782]  ? rest_init+0xb0/0xb0
> > [    1.904782]  kernel_init+0xe/0x100
> > [    1.904782]  ret_from_fork+0x22/0x30
> > [    1.904782] Modules linked in:
> > [    1.904782] CR2: 0000000000000015
> > [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> >
> > All this happens cause the cm init is in the call chain of the module init,
> > which is not a preferred practice.
> >
> > So remove the call to rdma_create_id() from the module init call chain.
> > Instead register rtrs-srv as an ib client, which makes sure that the
> > rdma_create_id() is called only when an ib device is added.
> >
> > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
> >  2 files changed, 81 insertions(+), 3 deletions(-)
>
> Please don't send vX patches as reply-to in "git send-email" command.

I thought vX + in-reply-to makes it clear that a new version of a
patch is proposed in response to a mail reporting a problem in the
first version. Why is that a bad idea?

Thank you,
Best,
Danil.

>
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 0d9241f5d9e6..916f99464d09 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -16,6 +16,7 @@
> >  #include "rtrs-srv.h"
> >  #include "rtrs-log.h"
> >  #include <rdma/ib_cm.h>
> > +#include <rdma/ib_verbs.h>
> >
> >  MODULE_DESCRIPTION("RDMA Transport Server");
> >  MODULE_LICENSE("GPL");
> > @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
> >  static struct rtrs_rdma_dev_pd dev_pd;
> >  static mempool_t *chunk_pool;
> >  struct class *rtrs_dev_class;
> > +static struct rtrs_srv_ib_ctx ib_ctx;
> >
> >  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> >  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > @@ -2033,6 +2035,62 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> >       kfree(ctx);
> >  }
> >
> > +static int rtrs_srv_add_one(struct ib_device *device)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +     int ret;
> > +
> > +     /*
> > +      * Keep a track on the number of ib devices added
> > +      */
> > +     ib_ctx.ib_dev_count++;
> > +
> > +     if (!ib_ctx.rdma_init) {
> > +             /*
> > +              * Since our CM IDs are NOT bound to any ib device we will create them
> > +              * only once
> > +              */
> > +             ctx = ib_ctx.srv_ctx;
> > +             ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > +             if (ret) {
> > +                     /*
> > +                      * We errored out here.
> > +                      * According to the ib code, if we encounter an error here then the
> > +                      * error code is ignored, and no more calls to our ops are made.
> > +                      */
> > +                     pr_err("Failed to initialize RDMA connection");
> > +                     return ret;
> > +             }
> > +             ib_ctx.rdma_init = true;
>
> This rdma_init == false is equal to ib_ctx.ib_dev_count == 0 and the
> logic can be simplified.
>
> if (ib_ctx.ib_dev_count)
>         return 0;
>
> ctx = ib_ctx.srv_ctx;
> ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> if (ret)
>         return ret;
> ib_ctx.ib_dev_count++;
> return 0;
>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +
> > +     ib_ctx.ib_dev_count--;
> > +
> > +     if (!ib_ctx.ib_dev_count && ib_ctx.rdma_init) {
>
> It is not kernel coding style.
> if (ib_ctx.ib_dev_count)
>         return;
>
> ctx = ib_ctx.srv_ctx;
> rdma_destroy_id(ctx->cm_id_ip);
> rdma_destroy_id(ctx->cm_id_ib);
>
> Thanks
>
> > +             /*
> > +              * Since our CM IDs are NOT bound to any ib device we will remove them
> > +              * only once, when the last device is removed
> > +              */
> > +             ctx = ib_ctx.srv_ctx;
> > +             rdma_destroy_id(ctx->cm_id_ip);
> > +             rdma_destroy_id(ctx->cm_id_ib);
> > +             ib_ctx.rdma_init = false;
> > +     }
> > +}
> > +
> > +static struct ib_client rtrs_srv_client = {
> > +     .name   = "rtrs_server",
> > +     .add    = rtrs_srv_add_one,
> > +     .remove = rtrs_srv_remove_one
> > +};
> > +
> >  /**
> >   * rtrs_srv_open() - open RTRS server context
> >   * @ops:             callback functions
> > @@ -2051,12 +2109,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> >       if (!ctx)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     err = rtrs_srv_rdma_init(ctx, port);
> > +     ib_ctx = (struct rtrs_srv_ib_ctx) {
> > +             .srv_ctx        = ctx,
> > +             .port           = port,
> > +     };
> > +
> > +     err = ib_register_client(&rtrs_srv_client);
> >       if (err) {
> >               free_srv_ctx(ctx);
> >               return ERR_PTR(err);
> >       }
> >
> > +     /*
> > +      * Since ib_register_client does not propagate the device add error
> > +      * we check if the RDMA connection init was successful or not
> > +      */
> > +     if (!ib_ctx.rdma_init) {
> > +             free_srv_ctx(ctx);
> > +             return NULL;
> > +     }
> > +
> >       return ctx;
> >  }
> >  EXPORT_SYMBOL(rtrs_srv_open);
> > @@ -2090,8 +2162,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
> >   */
> >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> >  {
> > -     rdma_destroy_id(ctx->cm_id_ip);
> > -     rdma_destroy_id(ctx->cm_id_ib);
> > +     ib_unregister_client(&rtrs_srv_client);
> >       close_ctx(ctx);
> >       free_srv_ctx(ctx);
> >  }
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > index dc95b0932f0d..6e9d9000cd8d 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > @@ -118,6 +118,13 @@ struct rtrs_srv_ctx {
> >       struct list_head srv_list;
> >  };
> >
> > +struct rtrs_srv_ib_ctx {
> > +     struct rtrs_srv_ctx     *srv_ctx;
> > +     u16                     port;
> > +     int                     ib_dev_count;
> > +     bool                    rdma_init;
> > +};
> > +
> >  extern struct class *rtrs_dev_class;
> >
> >  void close_sess(struct rtrs_srv_sess *sess);
> > --
> > 2.25.1
> >
