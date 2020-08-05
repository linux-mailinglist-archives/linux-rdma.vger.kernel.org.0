Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDF23D07A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 21:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgHETtH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 15:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgHEQzj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 12:55:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C0C001FC0
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 08:28:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i6so7208424edy.5
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYiMx4NDk9rUEN2qZQ+kRohy/PC1z2KSSP3bVJVxU9s=;
        b=E5wWzIkHoW0anDqePC3nznI476lD2X5Mf8NMhkLLuTyKFgwIOIqvSgs9E3X/rvG/X7
         SjERqBXaVRUOqURXs2R9peh8wZxjml/GCaTcRfq+JU3B+riadgpFtVkv8/K9O8kcmVix
         ZBKTIjCTIRruktlGCMLATyrZSzQVYsaaI8ubq4d8OJNI0fvhk5KaZ/l9V/0I/TuXjPNC
         PtJ528AzVjPLq/PY0lTb25wfEvmitMGyIeR5DUgQVS8NJ4oXPIV/1cvbLWyGHcXAr7xI
         T/7AUoWyv0nPapdkPlPHmoAWXoH0U5SqHVQD6zLtsH26qNTw2J3gHjSklsHEaYAEz/sW
         v3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYiMx4NDk9rUEN2qZQ+kRohy/PC1z2KSSP3bVJVxU9s=;
        b=nv2gYZW892cFHZqV+I0TqO/BMdtKEracjIEId10exFrPbhwlkrvfBD5Q2O4/JiA5Lg
         HQt0/amSCEvniRn0HdgalY+Si2cnuSjbIWsdZbO88kwzaLYc+o2I6LATrVfCpkduZqHc
         o9/CyesDIx+GI67gNrwyWLUUx7ZIXdhsVZbx0RTnuBnRwIwX+aK6w3zxfWaiddxurT3z
         y5ck5HlV+4ZJEvNXPmhrtobJdZI4QreYH6sshVEbMKdL6KoOjZlg2xET5VOe1BdY/fIu
         rz0yzxarIJhQUfoMIk+3D1jivlvTK7vj/++V6PXxpZ6he4FWRsgRFa30IY9dIqQ0lf8p
         qnSQ==
X-Gm-Message-State: AOAM532grG+rYk1iUDWkvi2hm6JDWniT0FMJEuxHgCN2f6wA8dBMJoT/
        PLnomvNhvuxuCp9nYVYs9KG4k/o193vDOq8WQzALqw==
X-Google-Smtp-Source: ABdhPJwmdZ2+8mfdQhJ9PSx0ahjU+7qJsdI6SdPaOrAiHhlQselIbsOFe1x+72L7IGCw/ETCNE2nW/NNtNjBlbFyg30=
X-Received: by 2002:a50:e848:: with SMTP id k8mr3402190edn.192.1596641289809;
 Wed, 05 Aug 2020 08:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200623172321.GC6578@ziepe.ca> <20200804133759.377950-1-haris.iqbal@cloud.ionos.com>
 <20200805055712.GE4432@unreal> <CAJpMwygZym8sSiDUdEW3PQTmwsfNdO5bQG7_LWtKmE-tY_mrmg@mail.gmail.com>
 <20200805090435.GF4432@unreal> <CAJpMwyg8ZQTgGvxCpJMwDnhPTey1+aA56VLh3aKLtJZnk3OSMg@mail.gmail.com>
 <20200805131239.GI4432@unreal> <CAJpMwyinOtCXXsjQ_JjMeE+haji6m-tegVxuc=nbVyb4-kUAHw@mail.gmail.com>
 <20200805145528.GK4432@unreal>
In-Reply-To: <20200805145528.GK4432@unreal>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Wed, 5 Aug 2020 20:57:59 +0530
Message-ID: <CAJpMwyjBuadmSJnJ-aDK6SPnePFvXXy+8UBzO++LwbSaTxaGNA@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-block@vger.kernel.org,
        dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 5, 2020 at 8:25 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Aug 05, 2020 at 07:23:58PM +0530, Haris Iqbal wrote:
> > On Wed, Aug 5, 2020 at 6:42 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Aug 05, 2020 at 04:39:16PM +0530, Haris Iqbal wrote:
> > > > On Wed, Aug 5, 2020 at 2:34 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Wed, Aug 05, 2020 at 01:20:09PM +0530, Haris Iqbal wrote:
> > > > > > On Wed, Aug 5, 2020 at 11:27 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 04, 2020 at 07:07:58PM +0530, Md Haris Iqbal wrote:
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
> > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 77 +++++++++++++++++++++++++-
> > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  7 +++
> > > > > > > >  2 files changed, 81 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > Please don't send vX patches as reply-to in "git send-email" command.
> > > > > > >
> > > > > > > >
> > > > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > index 0d9241f5d9e6..916f99464d09 100644
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
> > > > > > > > @@ -2033,6 +2035,62 @@ static void free_srv_ctx(struct rtrs_srv_ctx *ctx)
> > > > > > > >       kfree(ctx);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int rtrs_srv_add_one(struct ib_device *device)
> > > > > > > > +{
> > > > > > > > +     struct rtrs_srv_ctx *ctx;
> > > > > > > > +     int ret;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * Keep a track on the number of ib devices added
> > > > > > > > +      */
> > > > > > > > +     ib_ctx.ib_dev_count++;
> > > > > > > > +
> > > > > > > > +     if (!ib_ctx.rdma_init) {
> > > > > > > > +             /*
> > > > > > > > +              * Since our CM IDs are NOT bound to any ib device we will create them
> > > > > > > > +              * only once
> > > > > > > > +              */
> > > > > > > > +             ctx = ib_ctx.srv_ctx;
> > > > > > > > +             ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > > > > > > > +             if (ret) {
> > > > > > > > +                     /*
> > > > > > > > +                      * We errored out here.
> > > > > > > > +                      * According to the ib code, if we encounter an error here then the
> > > > > > > > +                      * error code is ignored, and no more calls to our ops are made.
> > > > > > > > +                      */
> > > > > > > > +                     pr_err("Failed to initialize RDMA connection");
> > > > > > > > +                     return ret;
> > > > > > > > +             }
> > > > > > > > +             ib_ctx.rdma_init = true;
> > > > > > >
> > > > > > > This rdma_init == false is equal to ib_ctx.ib_dev_count == 0 and the
> > > > > > > logic can be simplified.
> > > > > >
> > > > > > Yes, this was the first logic in my head. But I have few thoughts,
> > > > > > The below suggestions uses "ib_ctx.ib_dev_count" as a marker for
> > > > > > successful execution of rtrs_srv_rdma_init() and not really an IB
> > > > > > device count. Meaning if we have multiple calls to add, due to
> > > > > > multiple devices, our count would stay 1. And while removal we might
> > > > > > end up calling rdma_destroy_id() on our first remove call even though
> > > > > > another device is still remaining.
> > > > > >
> > > > > > If we increment "ib_ctx.ib_dev_count" every time add is called, even
> > > > > > before we call rtrs_srv_rdma_init() and irrespective of whether
> > > > > > rtrs_srv_rdma_init() succeeds or not, then we are keeping a count of
> > > > > > IB devices added. However, when remove is called, we now know the
> > > > > > number of devices added, but not whether rtrs_srv_rdma_init() was
> > > > > > successful or not. We may end up calling rdma_destroy_id() on NULL
> > > > > > cm_ids
> > > > > >
> > > > > > Does this make sense or am I missing something?
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > if (ib_ctx.ib_dev_count)
> > > > > > >         return 0;
> > > >
> > > > My understanding is, with the above 2 lines, after one add in which
> > > > rtrs_srv_rdma_init() succeeds, we won't even go below this, and hence
> > > > subsequent increments will not happen.
> > >
> > > Is it better?
> > >
> > > if (ib_ctx.ib_dev_count)
> > >   goto out;
> > >
> > > ....
> > >
> > > out:
> > >   ib_ctx.ib_dev_count++;
> > >   return 0;
> > >
> > > You don't need to take the code proposed in the ML as is.
> >
> > Yes, hence I posted a theoretical scenario which discussed 2 possible scenarios.
> >
> > case 1, single variable tracking only number of devices added.
> > when remove is called, we now know the
> > number of devices added, but not whether rtrs_srv_rdma_init() was
> > successful or not. We may end up calling rdma_destroy_id() on NULL
> > cm_ids
>
> If rtrs_srv_rdma_init() fails to initialize on first attempt, why do you
> want to continue to load rtrs?

This does make sense; for the current design in which
add_client_context() would stop calling add on this client if the
first add fails.
The reliance on this is what concerned me to add another explicit
variable for rdma_init.

Also, I am unsure how simple the logic becomes in this case (see
below) which was the aim of this discussion in the first place.

>
> >
> > case 2, single variable tracking success of rtrs_srv_rdma_init()
> > If we have multiple IB devices added, while removal we won't know when
> > to call rdma_destroy_id(),
>
> Your code doesn't know it either, it calls to destroy on last ib_dev.

It calls destroy on the last ib_dev only if the rdma_init is true,
meaning rtrs_srv_rdma_init() had succeeded.

+       ib_ctx.ib_dev_count--;
+
+       if (!ib_ctx.ib_dev_count && ib_ctx.rdma_init) {

>
> >
> > >
> > > >
> > > > > > >
> > > > > > > ctx = ib_ctx.srv_ctx;
> > > > > > > ret = rtrs_srv_rdma_init(ctx, ib_ctx.port);
> > > > > > > if (ret)
> > > > > > >         return ret;
> > > >
> > > > Also here, when rtrs_srv_rdma_init() fails, we return without
> > > > incrementing. IMHO, in this logic, we are not using
> > > > "ib_ctx.ib_dev_count" to track the number of devices, but to mark
> > > > successful execution of rtrs_srv_rdma_init()
> > >
> > > Of course, you should increment in success only.
> >
> > I am confused again. What exactly are you suggesting we track with
> > "ib_ctx.ib_dev_count"?
> > According to my understanding, we can't possibly track both "number of
> > devices added" and "success of rtrs_srv_rdma_init()".
>
> Why don't you ask your colleagues? They will guide you.

(from above)
"ib_ctx.ib_dev_count" is basically tracking the number of IB devices
added, IF the first call to add succeeds.


>
> Thanks



-- 

Regards
-Haris
