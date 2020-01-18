Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3068E1416F3
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2020 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgARKM7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Jan 2020 05:12:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgARKM6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 Jan 2020 05:12:58 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BA22468D;
        Sat, 18 Jan 2020 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579342377;
        bh=4+p0RpTBf/CqkAd+QcbI39wlKRhtgNYi1+XUFSDAZYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6GGYLF91Fy5Y6lJf1+vAPdCN3yylWBqIGhzV7MAhvDR1jlgalQRO6VqaDsMkpqTU
         dAOQWKbDGyo04vPEjZUMKDDBmcefwFax0xTk4vyXR/4i0U0gkY3GT+ShD86qIeIcnR
         GTYjHs6BRedyPl4Afbd3yZG1uFW/pgWU0xsvZuB0=
Date:   Sat, 18 Jan 2020 12:12:54 +0200
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
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200118101254.GD18467@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal>
 <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
 <20200116155800.GA18467@unreal>
 <CAMGffEkLHNPJ3feWhX0vnjr3hasVp3=+Z76wO3-07s9+Te=7Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkLHNPJ3feWhX0vnjr3hasVp3=+Z76wO3-07s9+Te=7Pw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 05:24:16PM +0100, Jinpu Wang wrote:
> On Thu, Jan 16, 2020 at 4:58 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jan 16, 2020 at 04:43:41PM +0100, Jinpu Wang wrote:
> > > On Thu, Jan 16, 2020 at 3:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 16, 2020 at 01:58:56PM +0100, Jack Wang wrote:
> > > > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > >
> > > > > This is main functionality of rtrs-client module, which manages
> > > > > set of RDMA connections for each rtrs session, does multipathing,
> > > > > load balancing and failover of RDMA requests.
> > > > >
> > > > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > > ---
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2967 ++++++++++++++++++++++++
> > > > >  1 file changed, 2967 insertions(+)
> > > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > >
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > new file mode 100644
> > > > > index 000000000000..717d19d4d930
> > > > > --- /dev/null
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > @@ -0,0 +1,2967 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * RDMA Transport Layer
> > > > > + *
> > > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > > > + *
> > > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > > > + *
> > > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > >
> > > > Please no extra lines between Copyright lines.
> > > I checked in kernel tree, seems most of Copyright indeed contain no
> > > extra line in between
> > >
> > > >
> > > > > + */
> > > > > +
> > > > > +#undef pr_fmt
> > > > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > > >
> > > > I never understood this pr_fmt() thing, do we really need it?
> > > you can custorm the format for print, include modue name and line
> > > number in this case, it's quite useful for debugging.
> >
> > The idea that messages are needed to be unique and don't rely on line
> > numbers.
> Then you have to check all other message in order to be unique, that
> is too much :)
> >
> > > >
> > > > > +
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/rculist.h>
> > > > > +#include <linux/blkdev.h> /* for BLK_MAX_SEGMENT_SIZE */
> > > > > +
> > > > > +#include "rtrs-clt.h"
> > > > > +#include "rtrs-log.h"
> > > > > +
> > > > > +#define RTRS_CONNECT_TIMEOUT_MS 30000
> > > > > +
> > > > > +MODULE_DESCRIPTION("RDMA Transport Client");
> > > > > +MODULE_LICENSE("GPL");
> > > > > +
> > > > > +static ushort nr_cons_per_session;
> > > > > +module_param(nr_cons_per_session, ushort, 0444);
> > > > > +MODULE_PARM_DESC(nr_cons_per_session,
> > > > > +              "Number of connections per session. (default: nr_cpu_ids)");
> > > > > +
> > > > > +static int retry_cnt = 7;
> > > > > +module_param_named(retry_cnt, retry_cnt, int, 0644);
> > > > > +MODULE_PARM_DESC(retry_cnt,
> > > > > +              "Number of times to send the message if the remote side didn't respond with Ack or Nack (default: 7, min: "
> > > > > +              __stringify(MIN_RTR_CNT) ", max: "
> > > > > +              __stringify(MAX_RTR_CNT) ")");
> > > > > +
> > > > > +static int __read_mostly noreg_cnt;
> > > > > +module_param_named(noreg_cnt, noreg_cnt, int, 0444);
> > > > > +MODULE_PARM_DESC(noreg_cnt,
> > > > > +              "Max number of SG entries when MR registration does not happen (default: 0)");
> > > >
> > > > We don't like modules in new code.
> > > could you elaberate a bit, no module paramters? which one? all?
> >
> > All of them.
> Ok
>
>
>
> snip
> > > > > +static bool __rtrs_clt_change_state(struct rtrs_clt_sess *sess,
> > > > > +                                  enum rtrs_clt_state new_state)
> > > > > +{
> > > > > +     enum rtrs_clt_state old_state;
> > > > > +     bool changed = false;
> > > > > +
> > > > > +     lockdep_assert_held(&sess->state_wq.lock);
> > > > > +
> > > > > +     old_state = sess->state;
> > > > > +     switch (new_state) {
> > > > > +     case RTRS_CLT_CONNECTING:
> > > > > +             switch (old_state) {
> > > >
> > > > Double switch is better to be avoided.
> > > what's the better way to do it?
> >
> > Rewrite function to be more readable.
> Frankly I think it's easy to read, depends on old_state change to new state.
> see also scsi_device_set_state

If you so in favor of switch inside switch, at lest do it properly.

The scsi_device_set_state() function implements success-oriented
approach and has very clear state machine without distraction and
extra variables like changed/not_changed. You have completely
opposite implementation to scsi_device_set_state().

Thanks

>
> Thanks
