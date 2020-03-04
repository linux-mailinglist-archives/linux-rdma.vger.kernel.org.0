Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC49178F33
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgCDLDo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 06:03:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35570 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387772AbgCDLDo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 06:03:44 -0500
Received: by mail-io1-f66.google.com with SMTP id h8so1936990iob.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 03:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0MNUugxNOB9PNZNnFXJRnN79OSV2TqgeUFSgJz6T10=;
        b=WpK3G4QKaz2Am0sHfilC2HnOPlllxn5TFzlitbR5g8sXe0WK3/i0FwvTcLsa0BXPPc
         kkZjX+og6wYXVy4P5psMUhF8QyUtKUQHRtd+L9Qc5C7alUPzjOH0Nvf5Y6f+OQPCrzcB
         D5fCK371R7XObq1bj6FhhXmCkPCOzSt3MckefTXeyA4p+4PxT6Y76NMxmwwdfbPGaxzj
         NUmeGMym2GaWTbM6ykLsk8Fme3vZq7bBu+vWZ4TQv81bYsff0YOqEv0zQfhJQw/iUyP/
         LFisWKg5W4/h11xEHHioHXvCNu24xQHlDSempv0Xb4LJS9eMLFL06aAwiKWZNUSVQgWr
         0iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0MNUugxNOB9PNZNnFXJRnN79OSV2TqgeUFSgJz6T10=;
        b=ne1T1cf6a6XDdwR5g8ngX1F94QGDWMDAkfCUPDgfLUKg5tDZ7syjKZxA5DG0IBntWH
         RabrqHjH+1oTt2g1wb1UZ3I8Z8E7WNXBNwZtKrSGnPmnzxfmA3LuSqM1Ga8/dml9lTU6
         IX0zf9tMZr5bqKALsSYje5jYMntjgRQggjXjHlDjElMulBdbXsuPJ6hQTAtRgWx35D3Y
         GPwJNGHkVmx/+YC4ws1fV1IC+yOYZtLMwirV69+1PVhI2mPLcdy0jks0P2v18DzWjwkC
         tjNCclaqndK3PiE4HS8sLZpncKxtAcv6VJEQb2aheB9ZKzvUJjJmk78yvcVVk8QOqY+m
         kVRQ==
X-Gm-Message-State: ANhLgQ0Xe0NcIsTau+g9eSBahcPP+b5qzlrCbaLWRecg8OdZqrDerERR
        g2ajklMSp8FQi4XPrBOcQckve5KTzz+Of00/FSietg==
X-Google-Smtp-Source: ADFU+vsbS9cxjs/JjZOgEB8mC4yLiaZdNxcUXVKkNgXvHKBTWiphajRHf7urDUhrXldgWHliP1tpFAICTcZwCNPnxmE=
X-Received: by 2002:a05:6602:1508:: with SMTP id g8mr1748973iow.22.1583319823331;
 Wed, 04 Mar 2020 03:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-11-jinpuwang@gmail.com>
 <20200303113740.GM121803@unreal> <CAMGffEmEeK37QCr8uiABjOrC-48nETTv0fxHWE0S0s=j6bPbGQ@mail.gmail.com>
 <20200303165906.GO121803@unreal>
In-Reply-To: <20200303165906.GO121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 4 Mar 2020 12:03:32 +0100
Message-ID: <CAMGffEk9LSgVQtzmBHiFYdnqgcQPXk_TV5W8pKyU5fy=ap0dTg@mail.gmail.com>
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 5:59 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 05:41:27PM +0100, Jinpu Wang wrote:
> > On Tue, Mar 3, 2020 at 12:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Feb 21, 2020 at 11:47:06AM +0100, Jack Wang wrote:
> > > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > >
> > > > This is main functionality of rtrs-server module, which accepts
> > > > set of RDMA connections (so called rtrs session), creates/destroys
> > > > sysfs entries associated with rtrs session and notifies upper layer
> > > > (user of RTRS API) about RDMA requests or link events.
> > > >
> > > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2164 ++++++++++++++++++++++++
> > > >  1 file changed, 2164 insertions(+)
> > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > new file mode 100644
> > > > index 000000000000..e60ee6dd675d
> > > > --- /dev/null
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -0,0 +1,2164 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * RDMA Transport Layer
> > > > + *
> > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > > + */
> > > > +
> > > > +#undef pr_fmt
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/mempool.h>
> > > > +
> > > > +#include "rtrs-srv.h"
> > > > +#include "rtrs-log.h"
> > > > +
> > > > +MODULE_DESCRIPTION("RDMA Transport Server");
> > > > +MODULE_LICENSE("GPL");
> > > > +
> > > > +/* Must be power of 2, see mask from mr->page_size in ib_sg_to_pages() */
> > > > +#define DEFAULT_MAX_CHUNK_SIZE (128 << 10)
> > > > +#define DEFAULT_SESS_QUEUE_DEPTH 512
> > > > +#define MAX_HDR_SIZE PAGE_SIZE
> > > > +#define MAX_SG_COUNT ((MAX_HDR_SIZE - sizeof(struct rtrs_msg_rdma_read)) \
> > > > +                   / sizeof(struct rtrs_sg_desc))
> > > > +
> > > > +/* We guarantee to serve 10 paths at least */
> > > > +#define CHUNK_POOL_SZ 10
> > > > +
> > > > +static struct rtrs_rdma_dev_pd dev_pd;
> > > > +static mempool_t *chunk_pool;
> > > > +struct class *rtrs_dev_class;
> > > > +
> > > > +static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> > > > +static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > > > +
> > > > +static bool always_invalidate = true;
> > > > +module_param(always_invalidate, bool, 0444);
> > > > +MODULE_PARM_DESC(always_invalidate,
> > > > +              "Invalidate memory registration for contiguous memory regions before accessing.");
> > > > +
> > > > +module_param_named(max_chunk_size, max_chunk_size, int, 0444);
> > > > +MODULE_PARM_DESC(max_chunk_size,
> > > > +              "Max size for each IO request, when change the unit is in byte (default: "
> > > > +              __stringify(DEFAULT_MAX_CHUNK_SIZE) "KB)");
> > > > +
> > > > +module_param_named(sess_queue_depth, sess_queue_depth, int, 0444);
> > > > +MODULE_PARM_DESC(sess_queue_depth,
> > > > +              "Number of buffers for pending I/O requests to allocate per session. Maximum: "
> > > > +              __stringify(MAX_SESS_QUEUE_DEPTH) " (default: "
> > > > +              __stringify(DEFAULT_SESS_QUEUE_DEPTH) ")");
> > >
> > > We don't like module parameters in the RDMA.
> > Hi Leon,
> >
> > These paramters are affecting resouce usage/performance, I think would
> > be good to have them as module parameters,
> > so admin could choose based their needs.
>
> It is premature optimization before second user comes, also it is
> based on the assumption that everyone uses modules, which is not true.
The idea to have module parameters is to cover more use cases, IMHO.

Even you builtin the module to the kernel, you can still change the
module parameters
by passing the "moduls_name.paramters" in kernel command line, eg:
kvm.nx_huge_pages=true
>
> Thanks
Thanks
