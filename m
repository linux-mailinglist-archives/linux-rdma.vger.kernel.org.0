Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4991424B158
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHTIve (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgHTIvS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 04:51:18 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DCDC061384
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 01:51:18 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ba10so969575edb.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IaZk/CUV5GOY5SJ996RgpsjuP8tpOKZcDU3F8iy4Jk=;
        b=Km2TFHHqpqq/xedi5cg/eVqnoA1xP1i1X7BYu9b/lrnvTCpJukmMNCbzQscSaKessh
         dISan5/gC9suTbQSAtDfJUZsf9XEeb91ws9P9NAAKZEVD9X0Rg8KgR/9XAR9kBrAucre
         Px4i3pk7oqQSAHufSG6IExd0hbusL6eQxRQmmNOukcQiueezvXrD5y+mm4qLvV+r1PKV
         3Em3lkWoVzsa1lcOq5CD+PFBurtNv0WTevz2VT0asnXG140RT9HK4ajX7GRNCGrdiK6i
         R7lhrWzyj7jkRkGSIdk/kbnSUVBmNeespmaEFge54FPWDyQN7sR1K/5MMeyLO/8cjA5F
         yWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IaZk/CUV5GOY5SJ996RgpsjuP8tpOKZcDU3F8iy4Jk=;
        b=cIT+S3KbezNTtVi2n4VlM0XnAe2YTPip0AqzGMsrdaeyFkROcnLNM3VQ5mb90+Xg5k
         LpU6L8ayKZWTSPymQvbb2o3Ya/7uXQcFbqgi/hPmwNyT8UNtCx6n7vXlMZgxQWFZCUdI
         aw4LGlHizRm6u58IDKV/MNnrg4dxFnDdN1DUGvkGmuF5VglM+/tYwzyngmpc36PxtD1S
         JtaoVtASY6UsKslGH2y1pylbK/KJpLtBoA+4USQxSV2tPtXnQAo0m1piNZYBmTINistV
         msd1LAaaO5eIFiWPTZIdeQ47JJyKS3pz6oN8SuOaxKm/S6t5EHrjOX/Rth5NMU9eZfhH
         hONw==
X-Gm-Message-State: AOAM532a0WAhYGF8v6r/omb5Z+Ow0wFLeFrkprnVabCJgxsYtdaImGWS
        J/iW9ei9RMqLyGm4ixqGUiWIMElbFHb6yt3YzI7Xbg==
X-Google-Smtp-Source: ABdhPJwY41zbAY1hdb6f5eT+nivWxfgSs3LL8LtUdunK1NURe8dFwJzMfOvtIdgVQVx1baDqNcDGn7/l3C4qGbH2gnw=
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr1922706edb.89.1597913476915;
 Thu, 20 Aug 2020 01:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200820034152.1660135-1-haris.iqbal@cloud.ionos.com> <20200820072644.GY7555@unreal>
In-Reply-To: <20200820072644.GY7555@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 20 Aug 2020 10:51:06 +0200
Message-ID: <CAMGffE=3q30ubjyiHyjfM4fFrYqf5iQ+GQeghsRN-RO2Tbct0g@mail.gmail.com>
Subject: Re: [PATCH v3] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

On Thu, Aug 20, 2020 at 9:26 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Aug 20, 2020 at 09:11:52AM +0530, Md Haris Iqbal wrote:
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
> > Change in v3:
> >       Removed RDMA init error check while rtrs server open
> >       Removed -1 assignment for ib_dev_count on RDMA init error
> > Change in v2:
> >         Use only single variable to track number of IB devices and failure
> >         Change according to kernel coding style
> >
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 69 ++++++++++++++++++++++++--
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 +++
> >  2 files changed, 72 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index a219bd1bdbc2..febc1478b96f 100644
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
> > @@ -2033,6 +2035,63 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> >       kfree(ctx);
> >  }
> >
> > +static int rtrs_srv_add_one(struct ib_device *device)
> > +{
> > +     struct rtrs_srv_ctx *ctx;
> > +     int ret;
> > +
> > +     if (ib_ctx.ib_dev_count)
> > +             goto out;
> > +
> > +     /*
> > +      * Since our CM IDs are NOT bound to any ib device we will create them
> > +      * only once
> > +      */
> > +     ctx = ib_ctx.srv_ctx;
> > +     ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > +     if (ret) {
> > +             /*
> > +              * We errored out here.
> > +              * According to the ib code, if we encounter an error here then the
> > +              * error code is ignored, and no more calls to our ops are made.
> > +              */
> > +             pr_err("Failed to initialize RDMA connection");
> > +             return ret;
> > +     }
> > +
> > +out:
> > +     /*
> > +      * Keep a track on the number of ib devices added
> > +      */
> > +     ib_ctx.ib_dev_count++;
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
> > +     if (ib_ctx.ib_dev_count)
> > +             return;
> > +
> > +     /*
> > +      * Since our CM IDs are NOT bound to any ib device we will remove them
> > +      * only once, when the last device is removed
> > +      */
> > +     ctx = ib_ctx.srv_ctx;
> > +     rdma_destroy_id(ctx->cm_id_ip);
> > +     rdma_destroy_id(ctx->cm_id_ib);
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
> > @@ -2051,7 +2110,12 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> >       if (!ctx)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     err = rtrs_srv_rdma_init(ctx, port);
> > +     ib_ctx = (struct rtrs_srv_ib_ctx) {
> > +             .srv_ctx        = ctx,
> > +             .port           = port,
> > +     };
>
> It can be my personal issue, but I prefer to see this type of assignment in variable declarations only.
> In the code, the better style will be to use direct assignment, e.g. "ib.ctx.port = port;"
> It will simplify future refactoring.
>
> Thanks

Thanks for your suggestion, but we have a few other place using the
same style, eg
https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/ulp/rtrs/rtrs-srv.c#L1545

It's more consistent to keep it as it is, IMO.

Regards!
