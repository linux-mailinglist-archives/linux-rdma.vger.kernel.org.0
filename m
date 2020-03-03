Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD81777D4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgCCNwb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 08:52:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44161 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgCCNwb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 08:52:31 -0500
Received: by mail-io1-f68.google.com with SMTP id u17so3568972iog.11
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsaB7aI6JfGPKibl7BIAvnspwpP++p9kooMzUODQUoU=;
        b=Aw0IQZ282cXDa/7NVHMaW5GXYynSdjwNWJ1g6TxIAtd6jqb02tOEiT3R/RtPU4hXlJ
         Li35BUERNyKcBlmNMszm7PvGJO/jj4wzrCRAnvUBR4kVPu2poKiqnWKxU9+M2Ea8JDI0
         1BFd3lwr4hg3mH+XpPyiEg965popPd0igO4fp3/wPDlaqAArYjsEqchSGYRWeubNprc0
         OAgrEJE2zWEHweKyFDRavueGSU4Zn3OMvZELZRWkwSMiA1kACZL+sTLuzAZ6gQZEKDLM
         bAeWbWOJ5x8dv4aEWtcScPcKbP7eKk9hGWJ1zFjhd6qaLAl31tgBwVc+GNaUx+cr5oYu
         FnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsaB7aI6JfGPKibl7BIAvnspwpP++p9kooMzUODQUoU=;
        b=R4HkFaGURB/ZLgDDsP3f/HG90MBBKw2dwLBXwbAhBT8PcyTkSKf42Xc3c9gA+g8/nz
         z8KpeKeJ0hkxoy5cWACVnF+VpJvm8jjdiW/fV1m9iAGHgGhDCTmAxOcluczrqEa5KoDX
         SuhhsDNSb3ZKLqMykk8gtVfme3gs0bvYe+ryJJaHLlJ9IbNTo/HBzEQG4tfQc6kWj2ov
         d7xewj1V2NxO73cgFwbvYfovx5Fsv1ZTnqp7eJllQLPNtHhUeCOx4x81BUNT+1uKDy58
         nPH+w63q/e4N+2AybeQ6QHWwa8beYMOZWa73B7I8oeL5GX+hTwHsbmF9DZj87xkYPWT+
         O8mA==
X-Gm-Message-State: ANhLgQ0Rkatvy/gyLKd63AOApf9WuOxLGAOP88fOi/Izpr5M7UmfabWt
        6JQCQnahVKHiKwPaXNKucaPdZ6BmdfEF3SCOfCVzZQ==
X-Google-Smtp-Source: ADFU+vuE72M8zReWyu2gq7IKzot41hiIfMb4AtsvCptUtp9qi1c/BPKPknDhsk0Doi26liWD/gMUlJfyUfRTXPgmyec=
X-Received: by 2002:a02:cd83:: with SMTP id l3mr4157186jap.10.1583243550517;
 Tue, 03 Mar 2020 05:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-4-jinpuwang@gmail.com>
 <20200303094516.GJ121803@unreal>
In-Reply-To: <20200303094516.GJ121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 14:52:19 +0100
Message-ID: <CAMGffEmHB2z=JHG=92Ki_TaBZ8JXv6r0iZr7QF-pKyuRo=C9cA@mail.gmail.com>
Subject: Re: [PATCH v9 03/25] RDMA/rtrs: private headers with rtrs protocol
 structs and helpers
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

On Tue, Mar 3, 2020 at 10:45 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:46:59AM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > These are common private headers with rtrs protocol structures,
> > logging, sysfs and other helper functions, which are used on
> > both client and server sides.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-log.h |  28 ++
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 401 +++++++++++++++++++++++++
> >  2 files changed, 429 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-log.h b/drivers/infiniband/ulp/rtrs/rtrs-log.h
> > new file mode 100644
> > index 000000000000..53c785b992f2
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-log.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * RDMA Transport Layer
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +#ifndef RTRS_LOG_H
> > +#define RTRS_LOG_H
> > +
> > +#define rtrs_log(fn, obj, fmt, ...)                          \
> > +     fn("<%s>: " fmt, obj->sessname, ##__VA_ARGS__)
> > +
> > +#define rtrs_err(obj, fmt, ...)      \
> > +     rtrs_log(pr_err, obj, fmt, ##__VA_ARGS__)
> > +#define rtrs_err_rl(obj, fmt, ...)   \
> > +     rtrs_log(pr_err_ratelimited, obj, fmt, ##__VA_ARGS__)
> > +#define rtrs_wrn(obj, fmt, ...)      \
> > +     rtrs_log(pr_warn, obj, fmt, ##__VA_ARGS__)
> > +#define rtrs_wrn_rl(obj, fmt, ...) \
> > +     rtrs_log(pr_warn_ratelimited, obj, fmt, ##__VA_ARGS__)
> > +#define rtrs_info(obj, fmt, ...) \
> > +     rtrs_log(pr_info, obj, fmt, ##__VA_ARGS__)
> > +#define rtrs_info_rl(obj, fmt, ...) \
> > +     rtrs_log(pr_info_ratelimited, obj, fmt, ##__VA_ARGS__)
> > +
> > +#endif /* RTRS_LOG_H */
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > new file mode 100644
> > index 000000000000..aecf01a7d8dc
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > @@ -0,0 +1,401 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * RDMA Transport Layer
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +
> > +#ifndef RTRS_PRI_H
> > +#define RTRS_PRI_H
> > +
> > +#include <linux/uuid.h>
> > +#include <rdma/rdma_cm.h>
> > +#include <rdma/ib_verbs.h>
> > +#include <rdma/ib.h>
> > +
> > +#include "rtrs.h"
> > +
> > +#define RTRS_PROTO_VER_MAJOR 2
> > +#define RTRS_PROTO_VER_MINOR 0
>
> I think that Jason once said that new submission starts from "1".
> There is no RTRS_PROTO_VER_MAJOR == 1 in the wild.
sorry, v2 protocol is already in our production, we can simple change back to v1


> > +#define STAT_ATTR(type, stat, print, reset)                          \
> > +STAT_STORE_FUNC(type, stat, reset)                                   \
> > +STAT_SHOW_FUNC(type, stat, print)                                    \
> > +static struct kobj_attribute stat##_attr = __ATTR_RW(stat)
>
> It is very strange that you needed to implement _store()/_show() primitives.
> Why is that?
We define the MICRO to save some line of code when implementing the
stats like rdma/reconects/etc, sess rtrs-clt-sysfs.c/srts-srv-sysfs.c

Thanks!
