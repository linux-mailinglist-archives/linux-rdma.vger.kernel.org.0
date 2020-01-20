Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA1142CD3
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATOIM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 09:08:12 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46324 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgATOIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 09:08:12 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so27319587ilm.13
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jan 2020 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5hSL60LdZGKQtvyhR3VUcG6oxpc8PtdSJlAQB1hYco=;
        b=KCBWcrM8hDzs0DR0hFis0NRPgcSBb1ktNCuErjGESSSKyhx23aLvXV6GcI07iuxqW3
         iYpbc43a6pX4T+kGlpGT3whM9k4soRxnfcdkovprYPDzY3bhpUOmr5VGRRtRtsijnUCd
         AI45LzBgCx/l37+AtGxkSuwVyNbAwjrQICdKUkwhD4+D3nr5KmSz7XGl6lb6Fh35vePN
         k0yjaJEFyJ1R0QeQZU0BZLBVi+8vvE773jMVjDrJYbal1C0qybqd/wKpeO72Pe9IOgAR
         pDS35+85Vl3UrnHRZkHwfSRfrm7m5FcbviTahw6AToze6Yp8x401jeRx9rigsdn+mhMX
         0hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5hSL60LdZGKQtvyhR3VUcG6oxpc8PtdSJlAQB1hYco=;
        b=jtZ0PdAlCYzgGeRxu4NlVoFzvl9tU2/iiBM18TRq5kX+zx2bGcDM/UDdJOHymYNNhR
         yi9+i5qrelK9R4sCz84r9fhCC9kqtmldlVQDHp0b7TRKMLIVgb21T/yi5PJH+UhZXNjJ
         GDDBL0McEX5SYTJ06U8Fyu5ZTHhLzOu7u0zZLuoE0SkttoqHKlgjIKJZL715nYxzsTAH
         qK9XCVJ/pP/B0E2gElHWkSeG/fxCNw7claeGN5sXlaI2nW1SHldcyNVHyfNwCr1cKo1o
         yAqeRDL1j7h584D25E7QqzsL3ls3q5lHyqmWbxcnBrkU0/Q8tSZpep2gT+1YoROsx545
         2Tnw==
X-Gm-Message-State: APjAAAVi1bgFo4q/bjxhFLUZP/w1d/VL7ypG6Ytf9Yd1a/HYWBF9596l
        uaZfJZmwwa+vSwfDj7CnGw7TS7Zx7iitcRPbKpr5Fw==
X-Google-Smtp-Source: APXvYqzWFzRC394EaVcab9GedauvlaKCw3FfVNMTu/oo39WxmNhoR0xeIupZqjN6XpXZpL/kyMREhwXuqy+u8NAf7xo=
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr10701631ilj.298.1579529290979;
 Mon, 20 Jan 2020 06:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-5-jinpuwang@gmail.com>
 <20200119144837.GE51881@unreal> <CAMGffEn-_hbuXBSp=xV+uZa3ZJ21PNvCuedVLHKUPLf+QxbL7w@mail.gmail.com>
 <20200120133006.GG51881@unreal>
In-Reply-To: <20200120133006.GG51881@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Jan 2020 15:08:00 +0100
Message-ID: <CAMGffE=2OZLkBsaANFvcy80Se8rbs+s0VTL3=2WKpiQP-LxiuA@mail.gmail.com>
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

On Mon, Jan 20, 2020 at 2:30 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jan 20, 2020 at 12:32:00PM +0100, Jinpu Wang wrote:
> > On Sun, Jan 19, 2020 at 3:48 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 01:58:54PM +0100, Jack Wang wrote:
> > > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > >
> > > > This is a set of library functions existing as a rtrs-core module,
> > > > used by client and server modules.
> > > >
> > > > Mainly these functions wrap IB and RDMA calls and provide a bit higher
> > > > abstraction for implementing of RTRS protocol on client or server
> > > > sides.
> > > >
> > > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs.c | 597 +++++++++++++++++++++++++++++
> > > >  1 file changed, 597 insertions(+)
> > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > new file mode 100644
> > > > index 000000000000..7b84d76e2a67
> > > > --- /dev/null
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > > @@ -0,0 +1,597 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * RDMA Transport Layer
> > > > + *
> > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > > + *
> > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > > + *
> > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > > + */
> > > > +#undef pr_fmt
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/inet.h>
> > > > +
> > > > +#include "rtrs-pri.h"
> > > > +#include "rtrs-log.h"
> > > > +
> > > > +MODULE_DESCRIPTION("RDMA Transport Core");
> > > > +MODULE_LICENSE("GPL");
> > > > +
> > > > +struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
> > > > +                           struct ib_device *dma_dev,
> > > > +                           enum dma_data_direction dir,
> > > > +                           void (*done)(struct ib_cq *cq, struct ib_wc *wc))
> > > > +{
> > > > +     struct rtrs_iu *ius, *iu;
> > > > +     int i;
> > > > +
> > > > +     WARN_ON(!queue_size);
> > > > +     ius = kcalloc(queue_size, sizeof(*ius), gfp_mask);
> > > > +     if (unlikely(!ius))
> > > > +             return NULL;
> > >
> > > Let's do not add useless WARN_ON() and unlikely to every error path.
> > I can remove the WARN_ON, but the unlikey for error case seems normal to use,
> > small size memory allocation is unlikely to fail.
>
> The unlikely() makes sense in data-path only and mostly it doesn't give
> any performance advantage, kcalloc() in this function means that this
> function is not performance oriented.
>

Thanks for the clarification, it is not in the data path, sure can be
removed, we will review the usage
and remove the unnecessary ones.
