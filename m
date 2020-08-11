Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD0241AFD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Aug 2020 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHKMcx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Aug 2020 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHKMcw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Aug 2020 08:32:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF74C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 05:32:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so11309618wrs.8
        for <linux-rdma@vger.kernel.org>; Tue, 11 Aug 2020 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wa/a1drLqFKpEm+Bzse/71SXQcqSmvPoaHW6iUCFomg=;
        b=TEspZqhpkgpPo598qOpnzfGrGDfp5vsMxmDNEKkATKBxH34kJ1f7kGzzMrZO4MRhKk
         go37hx0MaAy3/uTsTPclcsn5qDDKmqeFFf6UZPi7FA2WiejOTstB4p24qZ/wDRCW/LJH
         pI92vumpM6JQegH2eLU2ZSjZW5zVNj3b+Ehstc7/TRElNV+/f0eFOjlytZjShNu8ga48
         wFK6IjXJE6w6EtUlvPfQOpSrAcT7lwDKFkjYB+dxT2B0JrB2iBg/ijCj/gY1p12MtCe3
         gO2tU6hRzTuFzJVXTN0y9zLM2p3xajbkRVNAOvlAl2FpPrlifDRKGG7GVuy6EPqhh1Ep
         RYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wa/a1drLqFKpEm+Bzse/71SXQcqSmvPoaHW6iUCFomg=;
        b=OPn8Rp26LDqkKJmt12j/swKCdeofuEp0HtTwql4qFdyol82pt1HRzwLhOrtXR9ZNps
         ON+TK7wyGEpmyeT0vCwjNdeISpVi3SMDKLLbYkCA+KFo0hjeL0V1AvxZJUMzTXFZRh+n
         xg6VT96RN58jeJuc2fsaCGdWR7Ig15l7KBmya8kjdE4qYD8CgXSfxl8hmSTqsP6maAeu
         NG+K/n1v2O/GdNlCUjqeTOm2ZYFAu9UAbnukdqq5eKVVC0e3rikrCmQQqJnqr+aC/iBM
         hKjkJURNRnGUnUON0rTns1gw+cs0ZpnnTI3w4U7svhYavKhcEduHGkErnv0Vqhc3kklP
         q9Qg==
X-Gm-Message-State: AOAM532JtEp4E6wJTLilAFnjzPtIvWp9gLGqpdjdkKVjl9FaE5TD2ahM
        T4RZvRk5u+PTclN6RwsgotRo4doBfzLBG9il4EMT
X-Google-Smtp-Source: ABdhPJw5SRb+6nwTuHXQuII5ahDdRlBCwR429p1VQqjnZHJVUtZjSgjGaC2vfgTpoM0dOIz45SuzCKUJL6XIe9CZ7aE=
X-Received: by 2002:adf:9526:: with SMTP id 35mr30910174wrs.326.1597149169834;
 Tue, 11 Aug 2020 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
 <20200811084544.GB634816@unreal> <CAJpMwyjC+CuSoXD_XEaHS4njnFaHCbegMX+qucMfg-fXVqFD+Q@mail.gmail.com>
 <20200811104711.GC634816@unreal> <CAJpMwygFuhq-aiiVHz1w=jAjav1ZN-5yMuos67S2=2UX-wb85Q@mail.gmail.com>
 <CAMGffE=NSGsJAFJe5_n8_xfJ=6-kp5rYY3LK5wdcQCDdt6+CkQ@mail.gmail.com>
 <CAHg0HuxhZsedZFKCNwxMrH83CvSaqUrzHteb_O69-eWA30D4yw@mail.gmail.com> <20200811120732.GE634816@unreal>
In-Reply-To: <20200811120732.GE634816@unreal>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 14:32:38 +0200
Message-ID: <CAHg0HuybaHz+vJwnTsOxqEgsSkuA6YHPYgdfk6VsQmtw43UYtw@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 2:07 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Aug 11, 2020 at 01:44:58PM +0200, Danil Kipnis wrote:
> > On Tue, Aug 11, 2020 at 1:13 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 12:53 PM Haris Iqbal
> > > <haris.iqbal@cloud.ionos.com> wrote:
> > > >
> > > > On Tue, Aug 11, 2020 at 4:17 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Tue, Aug 11, 2020 at 02:27:12PM +0530, Haris Iqbal wrote:
> > > > > > On Tue, Aug 11, 2020 at 2:15 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 10, 2020 at 05:20:49PM +0530, Md Haris Iqbal wrote:
> > > > > > > > The rnbd_server module's communication manager (cm) initialization depends
> > > > > > > > on the registration of the "network namespace subsystem" of the RDMA CM
> > > > > > > > agent module. As such, when the kernel is configured to load the
> > > > > > > > rnbd_server and the RDMA cma module during initialization; and if the
> > > > > > > > rnbd_server module is initialized before RDMA cma module, a null ptr
> > > > > > > > dereference occurs during the RDMA bind operation.
> > > > > > > >
> > > > > > > > Call trace below,
> > > > > > > >
> > > > > > > > [    1.904782] Call Trace:
> > > > > > > > [    1.904782]  ? xas_load+0xd/0x80
> > > > > > > > [    1.904782]  xa_load+0x47/0x80
> > > > > > > > [    1.904782]  cma_ps_find+0x44/0x70
> > > > > > > > [    1.904782]  rdma_bind_addr+0x782/0x8b0
> > > > > > > > [    1.904782]  ? get_random_bytes+0x35/0x40
> > > > > > > > [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> > > > > > > > [    1.904782]  rtrs_srv_open+0x102/0x180
> > > > > > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > > > > > [    1.904782]  rnbd_srv_init_module+0x34/0x84
> > > > > > > > [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> > > > > > > > [    1.904782]  do_one_initcall+0x4a/0x200
> > > > > > > > [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> > > > > > > > [    1.904782]  ? rest_init+0xb0/0xb0
> > > > > > > > [    1.904782]  kernel_init+0xe/0x100
> > > > > > > > [    1.904782]  ret_from_fork+0x22/0x30
> > > > > > > > [    1.904782] Modules linked in:
> > > > > > > > [    1.904782] CR2: 0000000000000015
> > > > > > > > [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
> > > > > > > >
> > > > > > > > All this happens cause the cm init is in the call chain of the module init,
> > > > > > > > which is not a preferred practice.
> > > > > > > >
> > > > > > > > So remove the call to rdma_create_id() from the module init call chain.
> > > > > > > > Instead register rtrs-srv as an ib client, which makes sure that the
> > > > > > > > rdma_create_id() is called only when an ib device is added.
> > > > > > > >
> > > > > > > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > > > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > > > > > ---
> > > > > > > > Change in v2:
> > > > > > > >         Use only single variable to track number of IB devices and failure
> > > > > > > >         Change according to kernel coding style
> > > > > > > >
> > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 79 +++++++++++++++++++++++++-
> > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  6 ++
> > > > > > > >  2 files changed, 82 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > index 0d9241f5d9e6..69a37ce73b0c 100644
> > > > > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > @@ -16,6 +16,7 @@
> > > > > > > >  #include "rtrs-srv.h"
> > > > > > > >  #include "rtrs-log.h"
> > > > > > > >  #include <rdma/ib_cm.h>
> > > > > > > > +#include <rdma/ib_verbs.h>
> > > > > > > >
> > > > > > > >  MODULE_DESCRIPTION("RDMA Transport Server");
> > > > > > > >  MODULE_LICENSE("GPL");
> > > > > > > > @@ -31,6 +32,7 @@ MODULE_LICENSE("GPL");
> > > > > > > >  static struct rtrs_rdma_dev_pd dev_pd;
> > > > > > > >  static mempool_t *chunk_pool;
> > > > > > > >  struct class *rtrs_dev_class;
> > > > > > > > +static struct rtrs_srv_ib_ctx ib_ctx;
> > > > > > > >
> > > > > > > >  static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> > > > > > > >  static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > > > > > > > @@ -2033,6 +2035,64 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> > > > > > > >       kfree(ctx);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int rtrs_srv_add_one(struct ib_device *device)
> > > > > > > > +{
> > > > > > > > +     struct rtrs_srv_ctx *ctx;
> > > > > > > > +     int ret;
> > > > > > > > +
> > > > > > > > +     if (ib_ctx.ib_dev_count)
> > > > > > > > +             goto out;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * Since our CM IDs are NOT bound to any ib device we will create them
> > > > > > > > +      * only once
> > > > > > > > +      */
> > > > > > > > +     ctx = ib_ctx.srv_ctx;
> > > > > > > > +     ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > > > > > > > +     if (ret) {
> > > > > > > > +             /*
> > > > > > > > +              * We errored out here.
> > > > > > > > +              * According to the ib code, if we encounter an error here then the
> > > > > > > > +              * error code is ignored, and no more calls to our ops are made.
> > > > > > > > +              */
> > > > > > > > +             pr_err("Failed to initialize RDMA connection");
> > > > > > > > +             ib_ctx.ib_dev_count = -1;
> > > > > > > > +             return ret;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +out:
> > > > > > > > +     /*
> > > > > > > > +      * Keep a track on the number of ib devices added
> > > > > > > > +      */
> > > > > > > > +     ib_ctx.ib_dev_count++;
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void rtrs_srv_remove_one(struct ib_device *device, void *client_data)
> > > > > > > > +{
> > > > > > > > +     struct rtrs_srv_ctx *ctx;
> > > > > > > > +
> > > > > > > > +     ib_ctx.ib_dev_count--;
> > > > > > > > +
> > > > > > > > +     if (ib_ctx.ib_dev_count)
> > > > > > > > +             return;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * Since our CM IDs are NOT bound to any ib device we will remove them
> > > > > > > > +      * only once, when the last device is removed
> > > > > > > > +      */
> > > > > > > > +     ctx = ib_ctx.srv_ctx;
> > > > > > > > +     rdma_destroy_id(ctx->cm_id_ip);
> > > > > > > > +     rdma_destroy_id(ctx->cm_id_ib);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct ib_client rtrs_srv_client = {
> > > > > > > > +     .name   = "rtrs_server",
> > > > > > > > +     .add    = rtrs_srv_add_one,
> > > > > > > > +     .remove = rtrs_srv_remove_one
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  /**
> > > > > > > >   * rtrs_srv_open() - open RTRS server context
> > > > > > > >   * @ops:             callback functions
> > > > > > > > @@ -2051,12 +2111,26 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> > > > > > > >       if (!ctx)
> > > > > > > >               return ERR_PTR(-ENOMEM);
> > > > > > > >
> > > > > > > > -     err = rtrs_srv_rdma_init(ctx, port);
> > > > > > > > +     ib_ctx = (struct rtrs_srv_ib_ctx) {
> > > > > > > > +             .srv_ctx        = ctx,
> > > > > > > > +             .port           = port,
> > > > > > > > +     };
> > > > > > > > +
> > > > > > > > +     err = ib_register_client(&rtrs_srv_client);
> > > > > > > >       if (err) {
> > > > > > > >               free_srv_ctx(ctx);
> > > > > > > >               return ERR_PTR(err);
> > > > > > > >       }
> > > > > > > >
> > > > > > > > +     /*
> > > > > > > > +      * Since ib_register_client does not propagate the device add error
> > > > > > > > +      * we check if .add was called and the RDMA connection init failed
> > > > > > > > +      */
> > > > > > > > +     if (ib_ctx.ib_dev_count < 0) {
> > > > > > > > +             free_srv_ctx(ctx);
> > > > > > > > +             return ERR_PTR(-ENODEV);
> > > > > > > > +     }
> > > > > > >
> > > > > > > I afraid that you overcomplicated here, ib_register_client() doesn't
> > > > > > > return error if ->add() for specific device failed, it doesn't mean
> > > > > > > that ->add won't be called again for another device.
> > > > > > >
> > > > > > > So you don't need to use ib_dev_count == -1, just keep it to be 0 and
> > > > > > > leave to  rtrs_srv_close() to free srv_ctx.
> > > > > >
> > > > > > Leaving it 0 when there is an error is not gonna work. Since when the
> > > > > > modules are all built-in, a call to ib_register_client() will not
> > > > > > result in a call to ->add() then and there. So ib_register_client()
> > > > > > will return after registering the client, but without calling ->add().
> > > > > > Which means, ib_dev_count would be 0.
> > > > >
> > > > > If ib_dev_count == 0 => rtrs_srv_rdma_init() didn't success => nothing
> > > > > to release.
> > > >
> > > > True, but we have to send a failure back to the caller of
> > > > "rtrs_srv_open()" (and user of this ulp); which in our case is
> > > > rnbd-srv's function rnbd_srv_init_module().
> > > > In our case, the rnbd-drv module init would fail if "rtrs_srv_open()"
> > > > fails, meaning rtrs_srv_rdma_init() had failed.
> > > >
> > > > Even if we are talking in generic terms, any module calling the
> > > > "rtrs_srv_open()" of the rtrs ulp, would want to know if the server
> > > > open failed or succeeded right?
> > > I think Leon is right, any success of call to ->add, we have something
> > > to rtrs_srv_rdma_init,
> > > we can consider rtrs_srv_open is success instead of an error.
> >
> > I don't think Leon is right. In case when all modules are built in,
> > add is not called in place when ib_client_register is called (cause
> > there are no registered devices and add_client_context will be called
> > at some later point in time from enable_device_and_get instead). So we
> > have two cases: built in and not built in. Then there is a possibility
> > that rtrs_srv_rdma_init fails (create_id, bind_addr, etc.) or doesn't
> > fail. Particularly we need to separate the case where add hasn't been
> > called at all yet (i.e. modules are built in, we just need to wait
> > until add gets called and then can start listening) and the case where
> > it did get called but failed (i.e. modules are not built in it got
> > called but failed - in that case we need to refuse to load module and
> > return error since we can't start listening).
> > The latter case is indicated by ib_dev_count = -1. I think it would
> > make code easier to read if instead of setting ib_dev_count to -1 and
> > explicitly checking whether it's below 0, one would introduce an
> > additional variable for the error code returned by rtrs_srv_rdma_init
> > and check it instead.
>
> Sorry, but it is very hard to read this block without indentations.

Do you mean like empty lines between text paragraphs?

>
> Anyway, as I said there should be no difference in behaviour between no
> devices and first device failed to initialize.

If we load the server module and fail to initialize the device, we
return an error to the user (insmod fails). We could just log
something into dmesg and stay there doing nothing. Is that what you
suggest? Then one would also probably want to have a way to say to the
server it should try to init again (currently one just tries insmod
again)...

Thank you,
Danil

>
> Thanks
>
> >
> > >
> > > Thanks Leon for catching this.
> > >
> > > Regards!
