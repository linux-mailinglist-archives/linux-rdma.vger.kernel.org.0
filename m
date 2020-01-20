Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0066142989
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 12:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgATLcM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 06:32:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44728 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgATLcM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 06:32:12 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so33274460iof.11
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2020 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvhdpSXRpfe3Tetzh+0PU81W5rIzDVJF+3Q3HmAYESs=;
        b=UouYXcfEWnBprE0lR++rj9du4ce1toRprvXq1ADbbVZhrgdT8jpYX8VY1tozxhNdzl
         PkU7UrY/JPzeerqL+BReo9axFdXeh946JeRIWOmrW2/QftRIN0e2N2QUj0gQoZYQ4rO3
         ZKNz/oYFi3erTpe1agW3bZfCbXyaIMRtQYU154D9PEUlfc7aJWzt4OSzgwGo5opVM20J
         wI7HP8xkVQ8QAaQ7sUa11wXuXzPILpNpbDGbzJGSecf3sr1GIZvsHHX2TSLMqGF/pfVA
         9/aJ2pYetajFsMuuvaOfDXV0a/nyonG7TbkIqy/pThCRnFa0NXh347ekwMMxlYhaTJCB
         K4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvhdpSXRpfe3Tetzh+0PU81W5rIzDVJF+3Q3HmAYESs=;
        b=S8cE/8OkalNVNkOftu0RHsSpJ84EfHiFWkvEwo5LeMGKIGsnoHsA4nMs5/mwg9XxWI
         TG5SzoDXF/wUUFbfDStciqmz599tCYcrRE6H8TlAi8tVqbC3aeFT5rhdA4fzzuwTYf2G
         DV69kzNA4CTu3xsbVHMusSOyG1wYAPN8IPWX/HXLX9gYtq0xdqCUZLYtR1WDw2MoYaSd
         IyK5grRjJ14IdO608Uj3M4aY0ZkC9j4DMYINmmNsrIWLltZXLcX+ISfFgozbuuxcbYyC
         N8SlHKKzWVu+ms89zZ5EHFtVCQt4ryeEqbOdtH8cTczbZ8n/edCg2fWDI+t9FOgtoRWP
         dTmA==
X-Gm-Message-State: APjAAAUonLByjZ/AVNOOmwlb8GIhBxiuTnhhUVZU98f5gNZjcjRkiiqy
        c9e/b5Uag92XxTf7ngvxTWkNwAetMJTzV+KarLJeE9RGupA=
X-Google-Smtp-Source: APXvYqyuJjvG8S6U/YyjaUlduhHUrOekfeqV6sXGo2GygPj8RDxcaw8Bv2EvuVbFnctQGuOvuDMVmOVZw1aAeT6M65Q=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr42320440ioh.22.1579519931617;
 Mon, 20 Jan 2020 03:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-5-jinpuwang@gmail.com>
 <20200119144837.GE51881@unreal>
In-Reply-To: <20200119144837.GE51881@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Jan 2020 12:32:00 +0100
Message-ID: <CAMGffEn-_hbuXBSp=xV+uZa3ZJ21PNvCuedVLHKUPLf+QxbL7w@mail.gmail.com>
Subject: Re: [PATCH v7 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 19, 2020 at 3:48 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 16, 2020 at 01:58:54PM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This is a set of library functions existing as a rtrs-core module,
> > used by client and server modules.
> >
> > Mainly these functions wrap IB and RDMA calls and provide a bit higher
> > abstraction for implementing of RTRS protocol on client or server
> > sides.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs.c | 597 +++++++++++++++++++++++++++++
> >  1 file changed, 597 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> > new file mode 100644
> > index 000000000000..7b84d76e2a67
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > @@ -0,0 +1,597 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * RDMA Transport Layer
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + *
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + *
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/inet.h>
> > +
> > +#include "rtrs-pri.h"
> > +#include "rtrs-log.h"
> > +
> > +MODULE_DESCRIPTION("RDMA Transport Core");
> > +MODULE_LICENSE("GPL");
> > +
> > +struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
> > +                           struct ib_device *dma_dev,
> > +                           enum dma_data_direction dir,
> > +                           void (*done)(struct ib_cq *cq, struct ib_wc *wc))
> > +{
> > +     struct rtrs_iu *ius, *iu;
> > +     int i;
> > +
> > +     WARN_ON(!queue_size);
> > +     ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
> > +     if (unlikely(!ius))
> > +             return NULL;
>
> Let's do not add useless WARN_ON() and unlikely to every error path.
I can remove the WARN_ON, but the unlikey for error case seems normal to use,
small size memory allocation is unlikely to fail.

> > +int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu)
> > +{
> > +     struct rtrs_sess *sess = con->sess;
> > +     struct ib_recv_wr wr;
> > +     struct ib_sge list;
> > +
> > +     list.addr   = iu->dma_addr;
> > +     list.length = iu->size;
> > +     list.lkey   = sess->dev->ib_pd->local_dma_lkey;
> > +
> > +     if (WARN_ON(list.length == 0)) {
> > +             rtrs_wrn(con->sess,
> > +                       "Posting receive work request failed, sg list is empty\n");
>
> Both WARN_ON and warning message?
Will remove the WARN_ON.

Thanks Leon.
