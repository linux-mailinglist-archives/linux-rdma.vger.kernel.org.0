Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7613DFFA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAPQY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 11:24:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37024 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgAPQY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 11:24:28 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so22453266ioc.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apIz2+9yoUfuStq5UMu8JP8acA1lx+rNR0oTEq6+/+s=;
        b=PyLaSZFmKclzKXc2mofAeRISHMo3IWIZvYOyzXjwWgiLonnaYcHRnYY5Svxx66yr7f
         jLGOtmtEc53zsMlgG6EdXnP4HHgPAhPlGnNFM8X3Y0V+pcglmBH8kHbl+hSAHmN8gUD2
         H9FpdGXns3IiBm3bbIpeGscEvRwjhxG67Z9nHKF08lQF0ljI6NviuoRo+fmTUOu+ALa1
         FE6W2xv4JWmwA1MJswmHEBnY3KIAo6mAnSdC0eTvFoFw8ltYmc+0W4percxA0OQUEYg1
         XLbIO803hHOeZbjtYia3DefqH70LdH5+s3ihhmc0NF0nTdJbwxybtvvXP5/+CljjgUhR
         O2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apIz2+9yoUfuStq5UMu8JP8acA1lx+rNR0oTEq6+/+s=;
        b=pc1S8et3M5XSYLRcESch5gtWBzrYxH6TwWvdGaYournhJJxGbVe0zt186L9dzLuvfC
         HDIYhkd7w9IIOKCbxnyrVyNMprFNVq41vMcWmfMKb/31oPcGfSQDjjdy3auDQA5et+xP
         CrgDCD4GIRBelSO63Qpe4UT1Vl11/Fk3/t1Rw/UNNj02GwPRvnYk5zt2OX7JboYYRk6n
         vLX4gXJsR5gT7btQ8OLfBV9V3iciQY+diiu0Wn3MvX6Dwmp5fVb5VINIF/VwBPpsIg+s
         bxI6f05dWBNCvnOSn2yigJZ8BDIHnDO7ph32TECsNDzSKkyBA02WOYIRJ9A4idGeTjvU
         OOLA==
X-Gm-Message-State: APjAAAVkpQ0rLZNr4a7FHh2s0PrlARAylToEQaqeBQnHBQMrgM1Jr9sE
        FGWAy03rGYg9QeRNlSIDIv6savm0LtgU1857qmu9cQ==
X-Google-Smtp-Source: APXvYqwEbz/nPKl0Ju6yl68j4LvWHYZBTDI1g6S3NJ2/g8vGUHJa7Caj1TYzBMwRrxOdVH7Rk3i+WPh3WyrLmfJlF2Y=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr30169945jak.10.1579191867085;
 Thu, 16 Jan 2020 08:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal> <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
 <20200116155800.GA18467@unreal>
In-Reply-To: <20200116155800.GA18467@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 16 Jan 2020 17:24:16 +0100
Message-ID: <CAMGffEkLHNPJ3feWhX0vnjr3hasVp3=+Z76wO3-07s9+Te=7Pw@mail.gmail.com>
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
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

On Thu, Jan 16, 2020 at 4:58 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jan 16, 2020 at 04:43:41PM +0100, Jinpu Wang wrote:
> > On Thu, Jan 16, 2020 at 3:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 01:58:56PM +0100, Jack Wang wrote:
> > > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > >
> > > > This is main functionality of rtrs-client module, which manages
> > > > set of RDMA connections for each rtrs session, does multipathing,
> > > > load balancing and failover of RDMA requests.
> > > >
> > > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2967 ++++++++++++++++++++++++
> > > >  1 file changed, 2967 insertions(+)
> > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > new file mode 100644
> > > > index 000000000000..717d19d4d930
> > > > --- /dev/null
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > @@ -0,0 +1,2967 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * RDMA Transport Layer
> > > > + *
> > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > > + *
> > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > > + *
> > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > >
> > > Please no extra lines between Copyright lines.
> > I checked in kernel tree, seems most of Copyright indeed contain no
> > extra line in between
> >
> > >
> > > > + */
> > > > +
> > > > +#undef pr_fmt
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > >
> > > I never understood this pr_fmt() thing, do we really need it?
> > you can custorm the format for print, include modue name and line
> > number in this case, it's quite useful for debugging.
>
> The idea that messages are needed to be unique and don't rely on line
> numbers.
Then you have to check all other message in order to be unique, that
is too much :)
>
> > >
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/rculist.h>
> > > > +#include <linux/blkdev.h> /* for BLK_MAX_SEGMENT_SIZE */
> > > > +
> > > > +#include "rtrs-clt.h"
> > > > +#include "rtrs-log.h"
> > > > +
> > > > +#define RTRS_CONNECT_TIMEOUT_MS 30000
> > > > +
> > > > +MODULE_DESCRIPTION("RDMA Transport Client");
> > > > +MODULE_LICENSE("GPL");
> > > > +
> > > > +static ushort nr_cons_per_session;
> > > > +module_param(nr_cons_per_session, ushort, 0444);
> > > > +MODULE_PARM_DESC(nr_cons_per_session,
> > > > +              "Number of connections per session. (default: nr_cpu_ids)");
> > > > +
> > > > +static int retry_cnt = 7;
> > > > +module_param_named(retry_cnt, retry_cnt, int, 0644);
> > > > +MODULE_PARM_DESC(retry_cnt,
> > > > +              "Number of times to send the message if the remote side didn't respond with Ack or Nack (default: 7, min: "
> > > > +              __stringify(MIN_RTR_CNT) ", max: "
> > > > +              __stringify(MAX_RTR_CNT) ")");
> > > > +
> > > > +static int __read_mostly noreg_cnt;
> > > > +module_param_named(noreg_cnt, noreg_cnt, int, 0444);
> > > > +MODULE_PARM_DESC(noreg_cnt,
> > > > +              "Max number of SG entries when MR registration does not happen (default: 0)");
> > >
> > > We don't like modules in new code.
> > could you elaberate a bit, no module paramters? which one? all?
>
> All of them.
Ok



snip
> > > > +static bool __rtrs_clt_change_state(struct rtrs_clt_sess *sess,
> > > > +                                  enum rtrs_clt_state new_state)
> > > > +{
> > > > +     enum rtrs_clt_state old_state;
> > > > +     bool changed = false;
> > > > +
> > > > +     lockdep_assert_held(&sess->state_wq.lock);
> > > > +
> > > > +     old_state = sess->state;
> > > > +     switch (new_state) {
> > > > +     case RTRS_CLT_CONNECTING:
> > > > +             switch (old_state) {
> > >
> > > Double switch is better to be avoided.
> > what's the better way to do it?
>
> Rewrite function to be more readable.
Frankly I think it's easy to read, depends on old_state change to new state.
see also scsi_device_set_state

Thanks
