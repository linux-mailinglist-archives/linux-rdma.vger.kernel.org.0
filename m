Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3E2419FB
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHKKyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgHKKyA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 06:54:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57EC061787
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 03:53:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v22so8721792edy.0
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fitHttOqT+9ucSJyOs3cXkrbq6XQxqYHrZv+3s3p3Pk=;
        b=CL3hIrFaX85NHgEFY6hwhUt0bkWR45Mad4CePVRO1uX0zdlUBbr9rs8V/LIAP/GLkx
         JU0DMBD1DnAUp5uKOL81eWYyGZGMqkGh4P77GpEbHDQkws2GckuFGis9xaOQ2+dVNTaK
         P7whIY3eC52DM6zdoOd3WxSk3KlfJajQeFrfsF1jUSEfzlhHDeIO9SnUMRbHg729iLuI
         iLmGqlWtQTqieHxgt79p/9gn9uJMtc3X0HUgpNscd9jnuYayLjzPT/9tenx/w5C6kXkZ
         v1/mw4nrdxUFHE9bayS/5adxTzTsq1/lae+b8hUWOCId1EfPeuqPwlLuDXTi/Tjmdh2J
         /D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fitHttOqT+9ucSJyOs3cXkrbq6XQxqYHrZv+3s3p3Pk=;
        b=LhdpP71Q0WXrH2UAdjhC8Zhv1nouvwwVkERG1x/W0JFaQogIhUoA779Lrqd58QsSTU
         A0B6YdA4wpbJuUC/deo9ubyYWIk/xJEmPOlUhlaYUfOpzQBtUNr3f8SpzvatQqb2HFBN
         Iieh/iuS5kHScY9k3GYx3b2MQdVqGfb9YgtkEtEXXw/gBTbLRB7E5Hwl9IdGOkBY+F0w
         ypRJvej8kAjWj+iCUZuC8f/p87udmUWqGxRT5egEvaLjmGZO+GP1tsNyezHkmnk12PEw
         e21YPU/ci65O0+XmnOPQFOVL+pyHLb9VzUWSksIoQC337rJweh7M2C3lRsxthPInX/uS
         gE3A==
X-Gm-Message-State: AOAM531EaH+4RWuor55o1OBILiIPiN3P6oLQFfbutj2+8u6NwqHTE8ur
        U4ac83t6PVW+K1CkMUJZgsixwsf66MMObMCy4tmgaA==
X-Google-Smtp-Source: ABdhPJyZXFM1Qt3PZD/visNc1s2O6m6m7s6XezFuFuqe/+JbL51Fdv/MOyvkdutfB32xE5nt0ka1p/ugwSWikSNNH8o=
X-Received: by 2002:a50:9fe6:: with SMTP id c93mr24633178edf.286.1597143238430;
 Tue, 11 Aug 2020 03:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
 <20200811084544.GB634816@unreal> <CAJpMwyjC+CuSoXD_XEaHS4njnFaHCbegMX+qucMfg-fXVqFD+Q@mail.gmail.com>
 <20200811104711.GC634816@unreal>
In-Reply-To: <20200811104711.GC634816@unreal>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 16:23:46 +0530
Message-ID: <CAJpMwygFuhq-aiiVHz1w=jAjav1ZN-5yMuos67S2=2UX-wb85Q@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 4:17 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Aug 11, 2020 at 02:27:12PM +0530, Haris Iqbal wrote:
> > On Tue, Aug 11, 2020 at 2:15 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, Aug 10, 2020 at 05:20:49PM +0530, Md Haris Iqbal wrote:
> > > > The rnbd_server module's communication manager (cm) initialization depends
> > > > on the registration of the "network namespace subsystem" of the RDMA CM
> > > > agent module. As such, when the kernel is configured to load the
> > > > rnbd_server and the RDMA cma module during initialization; and if the
> > > > rnbd_server module is initialized before RDMA cma module, a null ptr
> > > > dereference occurs during the RDMA bind operation.
> > > >
> > > > Call trace below,
> > > >
> > > > [    1.904782] Call Trace:
> > > > [    1.904782]  ? xas_load+0xd/0x80
> > > > [    1.904782]  xa_load+0x47/0x80
> > > > [    1.904782]  cma_ps_find+0x44/0x70
> > > > [    1.904782]  rdma_bind_addr+0x782/0x8b0
> > > > [    1.904782]  ? get_random_bytes+0x35/0x40
> > > > [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> > > > [    1.904782]  rtrs_srv_open+0x102/0x180
> > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > [    1.904782]  rnbd_srv_init_module+0x34/0x84
> > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > [    1.904782]  do_one_initcall+0x4a/0x200
> > > > [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> > > > [    1.904782]  ? rest_init+0xb0/0xb0
> > > > [    1.904782]  kernel_init+0xe/0x100
> > > > [    1.904782]  ret_from_fork+0x22/0x30
> > > > [    1.904782] Modules linked in:
> > > > [    1.904782] CR2: 0000000000000015
> > > > [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> > > >
> > > > All this happens cause the cm init is in the call chain of the module init,
> > > > which is not a preferred practice.
> > > >
> > > > So remove the call to rdma_create_id() from the module init call chain.
> > > > Instead register rtrs-srv as an ib client, which makes sure that the
> > > > rdma_create_id() is called only when an ib device is added.
> > > >
> > > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > ---
> > > > Change in v2:
> > > >         Use only single variable to track number of IB devices and failure
> > > >         Change according to kernel coding style
> > > >
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 79 +++++++++++++++++++++++++-
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 ++
> > > >  2 files changed, 82 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > index 0d9241f5d9e6..69a37ce73b0c 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include "rtrs-srv.h"
> > > >  #include "rtrs-log.h"
> > > >  #include <rdma/ib_cm.h>
> > > > +#include <rdma/ib_verbs.h>
> > > >
> > > >  MODULE_DESCRIPTION("RDMA Transport Server");
> > > >  MODULE_LICENSE("GPL");
> > > > @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
> > > >  static struct rtrs_rdma_dev_pd dev_pd;
> > > >  static mempool_t *chunk_pool;
> > > >  struct class *rtrs_dev_class;
> > > > +static struct rtrs_srv_ib_ctx ib_ctx;
> > > >
> > > >  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> > > >  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > > > @@ -2033,6 +2035,64 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> > > >       kfree(ctx);
> > > >  }
> > > >
> > > > +static int rtrs_srv_add_one(struct ib_device *device)
> > > > +{
> > > > +     struct rtrs_srv_ctx *ctx;
> > > > +     int ret;
> > > > +
> > > > +     if (ib_ctx.ib_dev_count)
> > > > +             goto out;
> > > > +
> > > > +     /*
> > > > +      * Since our CM IDs are NOT bound to any ib device we will create them
> > > > +      * only once
> > > > +      */
> > > > +     ctx = ib_ctx.srv_ctx;
> > > > +     ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > > > +     if (ret) {
> > > > +             /*
> > > > +              * We errored out here.
> > > > +              * According to the ib code, if we encounter an error here then the
> > > > +              * error code is ignored, and no more calls to our ops are made.
> > > > +              */
> > > > +             pr_err("Failed to initialize RDMA connection");
> > > > +             ib_ctx.ib_dev_count = -1;
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +out:
> > > > +     /*
> > > > +      * Keep a track on the number of ib devices added
> > > > +      */
> > > > +     ib_ctx.ib_dev_count++;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> > > > +{
> > > > +     struct rtrs_srv_ctx *ctx;
> > > > +
> > > > +     ib_ctx.ib_dev_count--;
> > > > +
> > > > +     if (ib_ctx.ib_dev_count)
> > > > +             return;
> > > > +
> > > > +     /*
> > > > +      * Since our CM IDs are NOT bound to any ib device we will remove them
> > > > +      * only once, when the last device is removed
> > > > +      */
> > > > +     ctx = ib_ctx.srv_ctx;
> > > > +     rdma_destroy_id(ctx->cm_id_ip);
> > > > +     rdma_destroy_id(ctx->cm_id_ib);
> > > > +}
> > > > +
> > > > +static struct ib_client rtrs_srv_client = {
> > > > +     .name   = "rtrs_server",
> > > > +     .add    = rtrs_srv_add_one,
> > > > +     .remove = rtrs_srv_remove_one
> > > > +};
> > > > +
> > > >  /**
> > > >   * rtrs_srv_open() - open RTRS server context
> > > >   * @ops:             callback functions
> > > > @@ -2051,12 +2111,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> > > >       if (!ctx)
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > -     err = rtrs_srv_rdma_init(ctx, port);
> > > > +     ib_ctx = (struct rtrs_srv_ib_ctx) {
> > > > +             .srv_ctx        = ctx,
> > > > +             .port           = port,
> > > > +     };
> > > > +
> > > > +     err = ib_register_client(&rtrs_srv_client);
> > > >       if (err) {
> > > >               free_srv_ctx(ctx);
> > > >               return ERR_PTR(err);
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Since ib_register_client does not propagate the device add error
> > > > +      * we check if .add was called and the RDMA connection init failed
> > > > +      */
> > > > +     if (ib_ctx.ib_dev_count < 0) {
> > > > +             free_srv_ctx(ctx);
> > > > +             return ERR_PTR(-ENODEV);
> > > > +     }
> > >
> > > I afraid that you overcomplicated here, ib_register_client() doesn't
> > > return error if ->add() for specific device failed, it doesn't mean
> > > that ->add won't be called again for another device.
> > >
> > > So you don't need to use ib_dev_count == -1, just keep it to be 0 and
> > > leave to  rtrs_srv_close() to free srv_ctx.
> >
> > Leaving it 0 when there is an error is not gonna work. Since when the
> > modules are all built-in, a call to ib_register_client() will not
> > result in a call to ->add() then and there. So ib_register_client()
> > will return after registering the client, but without calling ->add().
> > Which means, ib_dev_count would be 0.
>
> If ib_dev_count == 0 => rtrs_srv_rdma_init() didn't success => nothing
> to release.

True, but we have to send a failure back to the caller of
"rtrs_srv_open()" (and user of this ulp); which in our case is
rnbd-srv's function rnbd_srv_init_module().
In our case, the rnbd-drv module init would fail if "rtrs_srv_open()"
fails, meaning rtrs_srv_rdma_init() had failed.

Even if we are talking in generic terms, any module calling the
"rtrs_srv_open()" of the rtrs ulp, would want to know if the server
open failed or succeeded right?

>
> Thanks
>
> >
> > >
> > > Failure to call ->add shouldn't be any different from no-ib-devices situation.
> > >
> > > Thanks
> > >
> > > > +
> > > >       return ctx;
> > > >  }
> > > >  EXPORT_SYMBOL(rtrs_srv_open);
> > > > @@ -2090,8 +2164,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
> > > >   */
> > > >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> > > >  {
> > > > -     rdma_destroy_id(ctx->cm_id_ip);
> > > > -     rdma_destroy_id(ctx->cm_id_ib);
> > > > +     ib_unregister_client(&rtrs_srv_client);
> > > >       close_ctx(ctx);
> > > >       free_srv_ctx(ctx);
> > > >  }
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > index dc95b0932f0d..e8f7e99a9a6e 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > > @@ -118,6 +118,12 @@ struct rtrs_srv_ctx {
> > > >       struct list_head srv_list;
> > > >  };
> > > >
> > > > +struct rtrs_srv_ib_ctx {
> > > > +     struct rtrs_srv_ctx     *srv_ctx;
> > > > +     u16                     port;
> > > > +     int                     ib_dev_count;
> > > > +};
> > > > +
> > > >  extern struct class *rtrs_dev_class;
> > > >
> > > >  void close_sess(struct rtrs_srv_sess *sess);
> > > > --
> > > > 2.25.1
> > > >
> >
> >
> >
> > --
> >
> > Regards
> > -Haris



-- 

Regards
-Haris
