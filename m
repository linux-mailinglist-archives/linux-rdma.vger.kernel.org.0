Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282A417A558
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgCEMfO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 07:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCEMfN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 07:35:13 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC4732072A;
        Thu,  5 Mar 2020 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583411712;
        bh=YYyo1EzoHeoXh6f+bt6ZQlnhTcHUsLiRhq2DN+gwLo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWOvsyCePK4OFDuaIO3GE/vj8Lw2rXXEhIzmNq4MVmhVo4yfzTskYCP3wsYxU3mJd
         4nK2d3+VyxACB+hQFuIxtEauPBZU1ZbZqsaJuUSo0NS3JvOB/ZRqChRUg9osryx3Fo
         Kc3am4Zte4RyqEGp2mcE9vceT6PRmHgE6ybN98so=
Date:   Thu, 5 Mar 2020 14:35:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
Message-ID: <20200305123509.GF184088@unreal>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-11-jinpuwang@gmail.com>
 <20200303113740.GM121803@unreal>
 <CAMGffEmEeK37QCr8uiABjOrC-48nETTv0fxHWE0S0s=j6bPbGQ@mail.gmail.com>
 <20200303165906.GO121803@unreal>
 <CAMGffEk9LSgVQtzmBHiFYdnqgcQPXk_TV5W8pKyU5fy=ap0dTg@mail.gmail.com>
 <20200305080019.GB184088@unreal>
 <CAHg0Huyc=pn1=WSKGLjm+c8AcchyQ8q7JS-0ToQyiBRgpGG=jA@mail.gmail.com>
 <20200305121628.GD184088@unreal>
 <CAMGffEmQSwY8a4XJHAoyrPjb-1O1qvBkjd_OD7BPMFwss__jzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmQSwY8a4XJHAoyrPjb-1O1qvBkjd_OD7BPMFwss__jzQ@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 01:28:39PM +0100, Jinpu Wang wrote:
> On Thu, Mar 5, 2020 at 1:16 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Mar 05, 2020 at 01:01:08PM +0100, Danil Kipnis wrote:
> > > On Thu, 5 Mar 2020, 09:00 Leon Romanovsky, <leon@kernel.org> wrote:
> > >
> > > > On Wed, Mar 04, 2020 at 12:03:32PM +0100, Jinpu Wang wrote:
> > > > > On Tue, Mar 3, 2020 at 5:59 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Mar 03, 2020 at 05:41:27PM +0100, Jinpu Wang wrote:
> > > > > > > On Tue, Mar 3, 2020 at 12:37 PM Leon Romanovsky <leon@kernel.org>
> > > > wrote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2020 at 11:47:06AM +0100, Jack Wang wrote:
> > > > > > > > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > > > > > >
> > > > > > > > > This is main functionality of rtrs-server module, which accepts
> > > > > > > > > set of RDMA connections (so called rtrs session),
> > > > creates/destroys
> > > > > > > > > sysfs entries associated with rtrs session and notifies upper
> > > > layer
> > > > > > > > > (user of RTRS API) about RDMA requests or link events.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > > > > > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2164
> > > > ++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 2164 insertions(+)
> > > > > > > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..e60ee6dd675d
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > > > > > @@ -0,0 +1,2164 @@
> > > > > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > +/*
> > > > > > > > > + * RDMA Transport Layer
> > > > > > > > > + *
> > > > > > > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights
> > > > reserved.
> > > > > > > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights
> > > > reserved.
> > > > > > > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +#undef pr_fmt
> > > > > > > > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__)
> > > > ": " fmt
> > > > > > > > > +
> > > > > > > > > +#include <linux/module.h>
> > > > > > > > > +#include <linux/mempool.h>
> > > > > > > > > +
> > > > > > > > > +#include "rtrs-srv.h"
> > > > > > > > > +#include "rtrs-log.h"
> > > > > > > > > +
> > > > > > > > > +MODULE_DESCRIPTION("RDMA Transport Server");
> > > > > > > > > +MODULE_LICENSE("GPL");
> > > > > > > > > +
> > > > > > > > > +/* Must be power of 2, see mask from mr->page_size in
> > > > ib_sg_to_pages() */
> > > > > > > > > +#define DEFAULT_MAX_CHUNK_SIZE (128 << 10)
> > > > > > > > > +#define DEFAULT_SESS_QUEUE_DEPTH 512
> > > > > > > > > +#define MAX_HDR_SIZE PAGE_SIZE
> > > > > > > > > +#define MAX_SG_COUNT ((MAX_HDR_SIZE - sizeof(struct
> > > > rtrs_msg_rdma_read)) \
> > > > > > > > > +                   / sizeof(struct rtrs_sg_desc))
> > > > > > > > > +
> > > > > > > > > +/* We guarantee to serve 10 paths at least */
> > > > > > > > > +#define CHUNK_POOL_SZ 10
> > > > > > > > > +
> > > > > > > > > +static struct rtrs_rdma_dev_pd dev_pd;
> > > > > > > > > +static mempool_t *chunk_pool;
> > > > > > > > > +struct class *rtrs_dev_class;
> > > > > > > > > +
> > > > > > > > > +static int __read_mostly max_chunk_size =
> > > > DEFAULT_MAX_CHUNK_SIZE;
> > > > > > > > > +static int __read_mostly sess_queue_depth =
> > > > DEFAULT_SESS_QUEUE_DEPTH;
> > > > > > > > > +
> > > > > > > > > +static bool always_invalidate = true;
> > > > > > > > > +module_param(always_invalidate, bool, 0444);
> > > > > > > > > +MODULE_PARM_DESC(always_invalidate,
> > > > > > > > > +              "Invalidate memory registration for contiguous
> > > > memory regions before accessing.");
> > > > > > > > > +
> > > > > > > > > +module_param_named(max_chunk_size, max_chunk_size, int, 0444);
> > > > > > > > > +MODULE_PARM_DESC(max_chunk_size,
> > > > > > > > > +              "Max size for each IO request, when change the
> > > > unit is in byte (default: "
> > > > > > > > > +              __stringify(DEFAULT_MAX_CHUNK_SIZE) "KB)");
> > > > > > > > > +
> > > > > > > > > +module_param_named(sess_queue_depth, sess_queue_depth, int,
> > > > 0444);
> > > > > > > > > +MODULE_PARM_DESC(sess_queue_depth,
> > > > > > > > > +              "Number of buffers for pending I/O requests to
> > > > allocate per session. Maximum: "
> > > > > > > > > +              __stringify(MAX_SESS_QUEUE_DEPTH) " (default: "
> > > > > > > > > +              __stringify(DEFAULT_SESS_QUEUE_DEPTH) ")");
> > > > > > > >
> > > > > > > > We don't like module parameters in the RDMA.
> > > > > > > Hi Leon,
> > > > > > >
> > > > > > > These paramters are affecting resouce usage/performance, I think
> > > > would
> > > > > > > be good to have them as module parameters,
> > > > > > > so admin could choose based their needs.
> > > > > >
> > > > > > It is premature optimization before second user comes, also it is
> > > > > > based on the assumption that everyone uses modules, which is not true.
> > > > > The idea to have module parameters is to cover more use cases, IMHO.
> > > > >
> > > > > Even you builtin the module to the kernel, you can still change the
> > > > > module parameters
> > > > > by passing the "moduls_name.paramters" in kernel command line, eg:
> > > > > kvm.nx_huge_pages=true
> > > >
> > > > I know about that, but it doesn't make them helpful.
> > > >
> > > > Thanks
> > > >
> > > Hi Leon,
> > >
> > > Queue_depth and max_chunksize parameters control the tradeoff between
> > > throuput performance and memory consumption. We do use them to set
> > > different values for storages equipped with SSDs (fast) and on storages
> > > equipped with HDDs (slow). The last parameter always_invaldate enforces the
> > > invalidation of an rdma buffer before its hand over to the block layer. We
> > > set it to no in our datacenters, since they are closed and malicious
> > > clients are not a threat in our scenario. In general case it defaults to
> > > yes, as requested by Jason. Our admins need to have control over those
> > > control knobs somehow... We could make sysfs entries out of them or
> > > something, but would it really make sense?
> >
> > blk_queue_nonrot() inside your code?
> It's exported function, and also used by other drivers like
> md/dm/target core, right?

I have no clue.

Thanks

>
> Thanks
