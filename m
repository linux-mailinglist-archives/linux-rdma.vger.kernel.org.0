Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCD241A30
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 13:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHKLNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgHKLNf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 07:13:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C5C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 04:13:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so12651380ejb.4
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pvkhc8EL8Oqn15OnpFCb9EjXnlFjjhQYHA6dVhmn4a0=;
        b=FiXwgcRYK13Iys62qQ0tZa5sMHLeMufYECDH/tCSlNYDit1L+fFqpssu6HAF1DeL1m
         ruLmhWE+rp8IThdyAb2koYgoX7KzIY8UmqDynZw2MPV9EaftikVuAnBJtBZktOYfimxT
         VisZuEPDkqlGAAMTqgD9HXZ/UE+E5AqJxrpdRM9Qwe8hFuw4PyE1WUw4QuCiDJvmiIuW
         B9MDs1ECU9W4Zswmx0P0IX/5sArBB+ZGXvJwh+SOInclS7kX6rwwIB19Zt9WE47IE2Om
         wsezmWtzorRf/r7dpc6Iiq6k6AFg7spcTTXoKuBE5Md/zgzdgqawzavfVnOA7PjJ2aYL
         HA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pvkhc8EL8Oqn15OnpFCb9EjXnlFjjhQYHA6dVhmn4a0=;
        b=MLOb4Ih/VnEx0pmXKQvLYwRnDPEsjjOUf26a0ReIQ3aKJ4rMsktt133R1bbve2r9j+
         KU9W88Hop6lIBdE0vDL7amMWXDDvOc0thjEX3g16jzypZh2KO+R/aY8Y3K04abzn2VQ1
         4JLK7VPkuLR59cMH11jIL8s8IMHi4I+K3/qHa88ebv2x2NQRbo6z8EVDUVGYWXWK0NDE
         xWv/+P+6yE/47v6OiBHqkeaHTdUsd+l137R52KCMndHUgccY+qnulLkAwFkaDVh61ed3
         VWhPrDYsuzvfqWA12OObqirzZnLyRcKMYpSUcu+w4jr0+RXMJZdoU2ezNPdu1B+bUNQc
         mFNQ==
X-Gm-Message-State: AOAM533MosrSilIpESsXk77HIDkvKFOvjG5vrTiOLj/pEiHjzT+W6655
        xymya6O0wrKPFlvuzzTTEHBCrY9HjSakSIHB1hRRzw==
X-Google-Smtp-Source: ABdhPJx8+HLFOdZn/Ao79hX8dDxNCqu0EsPSYH0DlJArsRYvNSVvaAhBa9vpHFHr8Cw6OdUppcoPvHEKUXxfMn/8SWI=
X-Received: by 2002:a17:906:ca5a:: with SMTP id jx26mr24835367ejb.62.1597144413230;
 Tue, 11 Aug 2020 04:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
 <20200811084544.GB634816@unreal> <CAJpMwyjC+CuSoXD_XEaHS4njnFaHCbegMX+qucMfg-fXVqFD+Q@mail.gmail.com>
 <20200811104711.GC634816@unreal> <CAJpMwygFuhq-aiiVHz1w=jAjav1ZN-5yMuos67S2=2UX-wb85Q@mail.gmail.com>
In-Reply-To: <CAJpMwygFuhq-aiiVHz1w=jAjav1ZN-5yMuos67S2=2UX-wb85Q@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 13:13:22 +0200
Message-ID: <CAMGffE=NSGsJAFJe5_n8_xfJ=6-kp5rYY3LK5wdcQCDdt6+CkQ@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 12:53 PM Haris Iqbal
<haris.iqbal@cloud.ionos.com> wrote:
>
> On Tue, Aug 11, 2020 at 4:17 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Aug 11, 2020 at 02:27:12PM +0530, Haris Iqbal wrote:
> > > On Tue, Aug 11, 2020 at 2:15 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 10, 2020 at 05:20:49PM +0530, Md Haris Iqbal wrote:
> > > > > The rnbd_server module's communication manager (cm) initialization depends
> > > > > on the registration of the "network namespace subsystem" of the RDMA CM
> > > > > agent module. As such, when the kernel is configured to load the
> > > > > rnbd_server and the RDMA cma module during initialization; and if the
> > > > > rnbd_server module is initialized before RDMA cma module, a null ptr
> > > > > dereference occurs during the RDMA bind operation.
> > > > >
> > > > > Call trace below,
> > > > >
> > > > > [    1.904782] Call Trace:
> > > > > [    1.904782]  ? xas_load+0xd/0x80
> > > > > [    1.904782]  xa_load+0x47/0x80
> > > > > [    1.904782]  cma_ps_find+0x44/0x70
> > > > > [    1.904782]  rdma_bind_addr+0x782/0x8b0
> > > > > [    1.904782]  ? get_random_bytes+0x35/0x40
> > > > > [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> > > > > [    1.904782]  rtrs_srv_open+0x102/0x180
> > > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > > [    1.904782]  rnbd_srv_init_module+0x34/0x84
> > > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > > [    1.904782]  do_one_initcall+0x4a/0x200
> > > > > [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> > > > > [    1.904782]  ? rest_init+0xb0/0xb0
> > > > > [    1.904782]  kernel_init+0xe/0x100
> > > > > [    1.904782]  ret_from_fork+0x22/0x30
> > > > > [    1.904782] Modules linked in:
> > > > > [    1.904782] CR2: 0000000000000015
> > > > > [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> > > > >
> > > > > All this happens cause the cm init is in the call chain of the module init,
> > > > > which is not a preferred practice.
> > > > >
> > > > > So remove the call to rdma_create_id() from the module init call chain.
> > > > > Instead register rtrs-srv as an ib client, which makes sure that the
> > > > > rdma_create_id() is called only when an ib device is added.
> > > > >
> > > > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > > ---
> > > > > Change in v2:
> > > > >         Use only single variable to track number of IB devices and failure
> > > > >         Change according to kernel coding style
> > > > >
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 79 +++++++++++++++++++++++++-
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 ++
> > > > >  2 files changed, 82 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > index 0d9241f5d9e6..69a37ce73b0c 100644
> > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include "rtrs-srv.h"
> > > > >  #include "rtrs-log.h"
> > > > >  #include <rdma/ib_cm.h>
> > > > > +#include <rdma/ib_verbs.h>
> > > > >
> > > > >  MODULE_DESCRIPTION("RDMA Transport Server");
> > > > >  MODULE_LICENSE("GPL");
> > > > > @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
> > > > >  static struct rtrs_rdma_dev_pd dev_pd;
> > > > >  static mempool_t *chunk_pool;
> > > > >  struct class *rtrs_dev_class;
> > > > > +static struct rtrs_srv_ib_ctx ib_ctx;
> > > > >
> > > > >  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> > > > >  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > > > > @@ -2033,6 +2035,64 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> > > > >       kfree(ctx);
> > > > >  }
> > > > >
> > > > > +static int rtrs_srv_add_one(struct ib_device *device)
> > > > > +{
> > > > > +     struct rtrs_srv_ctx *ctx;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (ib_ctx.ib_dev_count)
> > > > > +             goto out;
> > > > > +
> > > > > +     /*
> > > > > +      * Since our CM IDs are NOT bound to any ib device we will create them
> > > > > +      * only once
> > > > > +      */
> > > > > +     ctx = ib_ctx.srv_ctx;
> > > > > +     ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > > > > +     if (ret) {
> > > > > +             /*
> > > > > +              * We errored out here.
> > > > > +              * According to the ib code, if we encounter an error here then the
> > > > > +              * error code is ignored, and no more calls to our ops are made.
> > > > > +              */
> > > > > +             pr_err("Failed to initialize RDMA connection");
> > > > > +             ib_ctx.ib_dev_count = -1;
> > > > > +             return ret;
> > > > > +     }
> > > > > +
> > > > > +out:
> > > > > +     /*
> > > > > +      * Keep a track on the number of ib devices added
> > > > > +      */
> > > > > +     ib_ctx.ib_dev_count++;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> > > > > +{
> > > > > +     struct rtrs_srv_ctx *ctx;
> > > > > +
> > > > > +     ib_ctx.ib_dev_count--;
> > > > > +
> > > > > +     if (ib_ctx.ib_dev_count)
> > > > > +             return;
> > > > > +
> > > > > +     /*
> > > > > +      * Since our CM IDs are NOT bound to any ib device we will remove them
> > > > > +      * only once, when the last device is removed
> > > > > +      */
> > > > > +     ctx = ib_ctx.srv_ctx;
> > > > > +     rdma_destroy_id(ctx->cm_id_ip);
> > > > > +     rdma_destroy_id(ctx->cm_id_ib);
> > > > > +}
> > > > > +
> > > > > +static struct ib_client rtrs_srv_client = {
> > > > > +     .name   = "rtrs_server",
> > > > > +     .add    = rtrs_srv_add_one,
> > > > > +     .remove = rtrs_srv_remove_one
> > > > > +};
> > > > > +
> > > > >  /**
> > > > >   * rtrs_srv_open() - open RTRS server context
> > > > >   * @ops:             callback functions
> > > > > @@ -2051,12 +2111,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> > > > >       if (!ctx)
> > > > >               return ERR_PTR(-ENOMEM);
> > > > >
> > > > > -     err = rtrs_srv_rdma_init(ctx, port);
> > > > > +     ib_ctx = (struct rtrs_srv_ib_ctx) {
> > > > > +             .srv_ctx        = ctx,
> > > > > +             .port           = port,
> > > > > +     };
> > > > > +
> > > > > +     err = ib_register_client(&rtrs_srv_client);
> > > > >       if (err) {
> > > > >               free_srv_ctx(ctx);
> > > > >               return ERR_PTR(err);
> > > > >       }
> > > > >
> > > > > +     /*
> > > > > +      * Since ib_register_client does not propagate the device add error
> > > > > +      * we check if .add was called and the RDMA connection init failed
> > > > > +      */
> > > > > +     if (ib_ctx.ib_dev_count < 0) {
> > > > > +             free_srv_ctx(ctx);
> > > > > +             return ERR_PTR(-ENODEV);
> > > > > +     }
> > > >
> > > > I afraid that you overcomplicated here, ib_register_client() doesn't
> > > > return error if ->add() for specific device failed, it doesn't mean
> > > > that ->add won't be called again for another device.
> > > >
> > > > So you don't need to use ib_dev_count == -1, just keep it to be 0 and
> > > > leave to  rtrs_srv_close() to free srv_ctx.
> > >
> > > Leaving it 0 when there is an error is not gonna work. Since when the
> > > modules are all built-in, a call to ib_register_client() will not
> > > result in a call to ->add() then and there. So ib_register_client()
> > > will return after registering the client, but without calling ->add().
> > > Which means, ib_dev_count would be 0.
> >
> > If ib_dev_count == 0 => rtrs_srv_rdma_init() didn't success => nothing
> > to release.
>
> True, but we have to send a failure back to the caller of
> "rtrs_srv_open()" (and user of this ulp); which in our case is
> rnbd-srv's function rnbd_srv_init_module().
> In our case, the rnbd-drv module init would fail if "rtrs_srv_open()"
> fails, meaning rtrs_srv_rdma_init() had failed.
>
> Even if we are talking in generic terms, any module calling the
> "rtrs_srv_open()" of the rtrs ulp, would want to know if the server
> open failed or succeeded right?
I think Leon is right, any success of call to ->add, we have something
to rtrs_srv_rdma_init,
we can consider rtrs_srv_open is success instead of an error.

Thanks Leon for catching this.

Regards!
