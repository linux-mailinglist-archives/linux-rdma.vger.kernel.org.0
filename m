Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3972E177BA8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgCCQNo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 11:13:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37992 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgCCQNn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 11:13:43 -0500
Received: by mail-io1-f68.google.com with SMTP id s24so4186158iog.5
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 08:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeRpQ6jFz28A02Hu1WZ+mFWINs3Ftsi4z7RA95+XxW4=;
        b=OyL1hjmfbl4yBa1iOiCXw/1t45UESSed0w6tUSSEJ7jaVK6nxDeyFEz35I0JIEiWZz
         uyXS8o8yMpCP0qYqn6H7vup49HZqWUzjShewWS4E11QFEE7IUoRCAl9ufRC7JRS9ldEI
         +svzo2lkXZ5mg9tPXedB6ww6qz/tzWt6USt9RGQxorAVSvim+8daF+ibbNBod05OdDeI
         5/ITAuaszctsIUMQUfy1F27qu2K02dbzvSEwImwiaq7keoOQrR05pnzcwbrcMsz/9XXO
         kMTxyb7ILF7LlgwgCStgWO58s4aMtNHDjAhkTawa18lPPpKcmngO+CYgXMKoN2AbQogf
         4j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeRpQ6jFz28A02Hu1WZ+mFWINs3Ftsi4z7RA95+XxW4=;
        b=lNLjBnigPNW3CvG3gLrpXRE9epiQ5vrbDpngVr9EmJRzrtgPp9DQ3ckFCCkK1brrk5
         2e+Eb4igg24EUXPBseBHz8K9eHtpB//wsSOpfvtpTRpZqtgTjys/YlSJWjSwOuJgCvMJ
         4tNefHc1prSCTDKt9/XpmtlMF/6syq0wY/1RWbyEnGrklyJ/EcO6xyUIZH6SNTydTEYV
         9n1CqBRFT/xzyURr3xE3da501lAw3cvvIfHWJQHvtFCNubDokJO52nSSpvmlOitKqU0k
         5/Uw5NJswq3Qou4eBTVUgi9otlncVVDAkyYix13nSVrwGZe+SvLr33erc6W3lsGTpYg7
         KK8w==
X-Gm-Message-State: ANhLgQ2TsCQV7TynY/DFwn1O3VAQSytcnEpvKsWvWy2dAuHFK2nMiDmq
        a3LWWD2XQGWK4Mnmg9/uNpobXCj6hrK5WsghI+y4tQ==
X-Google-Smtp-Source: ADFU+vvv//GJjpWx3Y2wfaa53Z05LsP6S85z8Q/auOLq004jXlUBLLlFO7BahZGZkg6XfGGY33D8Fshin2VVNCtr7fE=
X-Received: by 2002:a02:cd83:: with SMTP id l3mr4762915jap.10.1583252023065;
 Tue, 03 Mar 2020 08:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-4-jinpuwang@gmail.com>
 <20200303094516.GJ121803@unreal> <CAMGffEmHB2z=JHG=92Ki_TaBZ8JXv6r0iZr7QF-pKyuRo=C9cA@mail.gmail.com>
 <20200303140553.GC31668@ziepe.ca>
In-Reply-To: <20200303140553.GC31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 17:13:32 +0100
Message-ID: <CAMGffEnhdnP4sq9fAfAZhwnNhVLcT+rackgCm0tpdaTJ35zLdg@mail.gmail.com>
Subject: Re: [PATCH v9 03/25] RDMA/rtrs: private headers with rtrs protocol
 structs and helpers
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 3:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Mar 03, 2020 at 02:52:19PM +0100, Jinpu Wang wrote:
> > On Tue, Mar 3, 2020 at 10:45 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Feb 21, 2020 at 11:46:59AM +0100, Jack Wang wrote:
> > > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > >
> > > > These are common private headers with rtrs protocol structures,
> > > > logging, sysfs and other helper functions, which are used on
> > > > both client and server sides.
> > > >
> > > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > >  drivers/infiniband/ulp/rtrs/rtrs-log.h |  28 ++
> > > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 401 +++++++++++++++++++++++++
> > > >  2 files changed, 429 insertions(+)
> > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
> > > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-log.h b/drivers/infiniband/ulp/rtrs/rtrs-log.h
> > > > new file mode 100644
> > > > index 000000000000..53c785b992f2
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-log.h
> > > > @@ -0,0 +1,28 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > +/*
> > > > + * RDMA Transport Layer
> > > > + *
> > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > > + */
> > > > +#ifndef RTRS_LOG_H
> > > > +#define RTRS_LOG_H
> > > > +
> > > > +#define rtrs_log(fn, obj, fmt, ...)                          \
> > > > +     fn("<%s>: " fmt, obj->sessname, ##__VA_ARGS__)
> > > > +
> > > > +#define rtrs_err(obj, fmt, ...)      \
> > > > +     rtrs_log(pr_err, obj, fmt, ##__VA_ARGS__)
> > > > +#define rtrs_err_rl(obj, fmt, ...)   \
> > > > +     rtrs_log(pr_err_ratelimited, obj, fmt, ##__VA_ARGS__)
> > > > +#define rtrs_wrn(obj, fmt, ...)      \
> > > > +     rtrs_log(pr_warn, obj, fmt, ##__VA_ARGS__)
> > > > +#define rtrs_wrn_rl(obj, fmt, ...) \
> > > > +     rtrs_log(pr_warn_ratelimited, obj, fmt, ##__VA_ARGS__)
> > > > +#define rtrs_info(obj, fmt, ...) \
> > > > +     rtrs_log(pr_info, obj, fmt, ##__VA_ARGS__)
> > > > +#define rtrs_info_rl(obj, fmt, ...) \
> > > > +     rtrs_log(pr_info_ratelimited, obj, fmt, ##__VA_ARGS__)
> > > > +
> > > > +#endif /* RTRS_LOG_H */
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > > new file mode 100644
> > > > index 000000000000..aecf01a7d8dc
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > > @@ -0,0 +1,401 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > +/*
> > > > + * RDMA Transport Layer
> > > > + *
> > > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > > + */
> > > > +
> > > > +#ifndef RTRS_PRI_H
> > > > +#define RTRS_PRI_H
> > > > +
> > > > +#include <linux/uuid.h>
> > > > +#include <rdma/rdma_cm.h>
> > > > +#include <rdma/ib_verbs.h>
> > > > +#include <rdma/ib.h>
> > > > +
> > > > +#include "rtrs.h"
> > > > +
> > > > +#define RTRS_PROTO_VER_MAJOR 2
> > > > +#define RTRS_PROTO_VER_MINOR 0
> > >
> > > I think that Jason once said that new submission starts from "1".
> > > There is no RTRS_PROTO_VER_MAJOR == 1 in the wild.
> > sorry, v2 protocol is already in our production, we can simple change back to v1
>
Hi Jason,

> You should arrange this so you can use it in your production, if you
> use something else then we are we upstreaming it?
We do have the plan to use upstream once we are in upstream, and
that's the reason why we spend the effort to push it upstream,
and we sure would like to see it been used outside of our company, so
more users could benefit.
>
> As a community we have had bad experience with companies upstreaming
> something that they ultimately do not use.

That's the part we are doing now, we want to discuss with the
community to get to a win-win situation.
For myself I joined the community for more than 10 years now, started
from upstream a SAS adapter driver called pm8001, I'm still
maintaining it,
reviewing patches and so on. For RNBD/RTRS, I sure will do the same.

Thanks!
