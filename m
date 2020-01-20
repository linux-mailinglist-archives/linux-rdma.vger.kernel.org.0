Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B3142C13
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATNaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 08:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgATNaL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 08:30:11 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FDC21835;
        Mon, 20 Jan 2020 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579527010;
        bh=6dnPLM8mNQSGiS/EjQyZOON1MxnO1ZCcpX5QnQbw6YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wx2UcaasQHgZBWELEmnGYbwZ3GNliteogm9+qeDJrAfM/Pzdu6AHJpOSptyE5CBIS
         bc5Q4dchas/yFzl4eA3ExGkNXtTt+Luid93rPKphFwEujtE1enYEdTpq8cgLR9Omgj
         sMStJH5uouN+fSPZhEzHn/YhsCXp1OEoAtwf8OuQ=
Date:   Mon, 20 Jan 2020 15:30:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
Message-ID: <20200120133006.GG51881@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-5-jinpuwang@gmail.com>
 <20200119144837.GE51881@unreal>
 <CAMGffEn-_hbuXBSp=xV+uZa3ZJ21PNvCuedVLHKUPLf+QxbL7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEn-_hbuXBSp=xV+uZa3ZJ21PNvCuedVLHKUPLf+QxbL7w@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 20, 2020 at 12:32:00PM +0100, Jinpu Wang wrote:
> On Sun, Jan 19, 2020 at 3:48 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jan 16, 2020 at 01:58:54PM +0100, Jack Wang wrote:
> > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >
> > > This is a set of library functions existing as a rtrs-core module,
> > > used by client and server modules.
> > >
> > > Mainly these functions wrap IB and RDMA calls and provide a bit higher
> > > abstraction for implementing of RTRS protocol on client or server
> > > sides.
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs.c | 597 +++++++++++++++++++++++++++++
> > >  1 file changed, 597 insertions(+)
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > new file mode 100644
> > > index 000000000000..7b84d76e2a67
> > > --- /dev/null
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > @@ -0,0 +1,597 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * RDMA Transport Layer
> > > + *
> > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > + *
> > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > + *
> > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > + */
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/inet.h>
> > > +
> > > +#include "rtrs-pri.h"
> > > +#include "rtrs-log.h"
> > > +
> > > +MODULE_DESCRIPTION("RDMA Transport Core");
> > > +MODULE_LICENSE("GPL");
> > > +
> > > +struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
> > > +                           struct ib_device *dma_dev,
> > > +                           enum dma_data_direction dir,
> > > +                           void (*done)(struct ib_cq *cq, struct ib_wc *wc))
> > > +{
> > > +     struct rtrs_iu *ius, *iu;
> > > +     int i;
> > > +
> > > +     WARN_ON(!queue_size);
> > > +     ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
> > > +     if (unlikely(!ius))
> > > +             return NULL;
> >
> > Let's do not add useless WARN_ON() and unlikely to every error path.
> I can remove the WARN_ON, but the unlikey for error case seems normal to use,
> small size memory allocation is unlikely to fail.

The unlikely() makes sense in data-path only and mostly it doesn't give
any performance advantage, kcalloc() in this function means that this
function is not performance oriented.

As general note, as long as this code will leave impression of
not-stable enough, we will have hard time to accept it. The overuse of
WARN_ON(), debug prints and micro-optimizations add to such feeling.

Thanks
