Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677B824189E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 10:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHKI50 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgHKI50 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 04:57:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E03C061787
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 01:57:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l4so12216124ejd.13
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZsDu2D3AQWNCQ2ZG6MtjjJo26r+xt9w714U+QGZebA=;
        b=PBbjMQ4OlIMtg2zLUb33wr678iDedyaYGyu8ASuVzIfcfWPnROJG2ej69TAPCNWTC/
         2NFaMu62rNtnDlpke+1bKde8gRMietC8B/Ud54qoNLNMO9KYzDjCWBl38FgoT2MvaU3x
         qjOFlzXxW3wPYCnuFh6Fz3Rv85YIyONfBT7C5z62sz2WSMrj6Sak6dYcWKU6W9DdpQ6V
         +R4Jruu3lJH6uyPzYde9PdZTLbYumGrbIOib3KK1CaiZtdwa0jiqLN7MTtlQ09HDn9LE
         evd6vKHnRFOx3sS0o899Fnc6OE92wuU4bqDD0aLgEGzo8S6LW+DuoU3jHJJLacwLWGUE
         IXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZsDu2D3AQWNCQ2ZG6MtjjJo26r+xt9w714U+QGZebA=;
        b=WxV8OWbysCKK/G3vrx62iM38GKGO9aS/xzEhgc1xeevlOU5yeh6V/FDRGvIMc1kLGY
         zWCeFVqFJZofav5URYft2xtjkOnafDNGpI0JNKqmlWHMdW/LPPeRyXdbR0wHG3RhLNae
         pbzBeJ65/wSeSiItgSX2ToJ6J/Bn+6HEWxrsaSgSZ1W3cjsMsvsFzHy6RPFvzrjBOIM6
         4OE/0reoknMAhET44OFFLLTGKq8pAtguoSqfEvlCGQb567/tOEmtPbA3BEq6zqIFP+US
         eQoWrAmMEAFQCblSjWrV5Z3E1ZDJH5ZvWXGF0vFNDh2oDWsDQfHBBvGkFp2CB4xrO90f
         FRzg==
X-Gm-Message-State: AOAM532971tmiZA7PvtXqNn5l5w2c3PBO3DQx1ovfPT87mZvln0ZYFLw
        L1eKteiBLBAahOyhuyrBdkjBmI8fWiGUd/zWOXG+Taie7Dc=
X-Google-Smtp-Source: ABdhPJxhhS6gqVWckit3IpnTwDDrr0/aHgT9iuANZZscnrbPkzSY/hvHFgywor/lkk7sj31KKHn1ezEwaT6xK+Xiy+M=
X-Received: by 2002:a17:906:f0cc:: with SMTP id dk12mr24293284ejb.97.1597136244226;
 Tue, 11 Aug 2020 01:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com> <20200811084544.GB634816@unreal>
In-Reply-To: <20200811084544.GB634816@unreal>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 14:27:12 +0530
Message-ID: <CAJpMwyjC+CuSoXD_XEaHS4njnFaHCbegMX+qucMfg-fXVqFD+Q@mail.gmail.com>
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

On Tue, Aug 11, 2020 at 2:15 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 10, 2020 at 05:20:49PM +0530, Md Haris Iqbal wrote:
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
> > Change in v2:
> >         Use only single variable to track number of IB devices and failure
> >         Change according to kernel coding style
> >
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 79 +++++++++++++++++++++++++-
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 ++
> >  2 files changed, 82 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 0d9241f5d9e6..69a37ce73b0c 100644
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
> > @@ -2033,6 +2035,64 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
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
> > +             ib_ctx.ib_dev_count = -1;
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
> > @@ -2051,12 +2111,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
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
> > +      * we check if .add was called and the RDMA connection init failed
> > +      */
> > +     if (ib_ctx.ib_dev_count < 0) {
> > +             free_srv_ctx(ctx);
> > +             return ERR_PTR(-ENODEV);
> > +     }
>
> I afraid that you overcomplicated here, ib_register_client() doesn't
> return error if ->add() for specific device failed, it doesn't mean
> that ->add won't be called again for another device.
>
> So you don't need to use ib_dev_count == -1, just keep it to be 0 and
> leave to  rtrs_srv_close() to free srv_ctx.

Leaving it 0 when there is an error is not gonna work. Since when the
modules are all built-in, a call to ib_register_client() will not
result in a call to ->add() then and there. So ib_register_client()
will return after registering the client, but without calling ->add().
Which means, ib_dev_count would be 0.

>
> Failure to call ->add shouldn't be any different from no-ib-devices situation.
>
> Thanks
>
> > +
> >       return ctx;
> >  }
> >  EXPORT_SYMBOL(rtrs_srv_open);
> > @@ -2090,8 +2164,7 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
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
> > index dc95b0932f0d..e8f7e99a9a6e 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > @@ -118,6 +118,12 @@ struct rtrs_srv_ctx {
> >       struct list_head srv_list;
> >  };
> >
> > +struct rtrs_srv_ib_ctx {
> > +     struct rtrs_srv_ctx     *srv_ctx;
> > +     u16                     port;
> > +     int                     ib_dev_count;
> > +};
> > +
> >  extern struct class *rtrs_dev_class;
> >
> >  void close_sess(struct rtrs_srv_sess *sess);
> > --
> > 2.25.1
> >



-- 

Regards
-Haris
