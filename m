Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74517783D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 15:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgCCOF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 09:05:58 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40511 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgCCOF6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 09:05:58 -0500
Received: by mail-qv1-f67.google.com with SMTP id ea1so1678127qvb.7
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 06:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdCrKeFJ6CcwyYZYW0fpsDyd7QH4/nwIaa61cnbfVCk=;
        b=Zx8knPSPDSt0ovM03uyf+puFVnjuvoQY4BFQjsLCvZW/PMfC8F5H1kj+ICDcd8HHtw
         ucfUzACdBb48FG0r/Zfd59ibtgxPXehN/Qy6wW+ajrYKPPhNF4uRBoXGeRbX6HQma2sB
         3XTi5D+svyHUuREuk3PJKn1+CJTB6IkfLuh8SzA47gJILXfV1oJOrHKTGTgyKB4s1c8e
         5Sa7ScCUThYVcXQ75CbzCA/An4yhdUthygZj723goIQJMuNliIge2PymB+/5crjDLeac
         aoUknJuwUtEdMwp4qP/p2dVluNxjQhw+bn2g+fNSaG709dWrzl2DMjfKW7DmCoRxy9Wt
         1yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdCrKeFJ6CcwyYZYW0fpsDyd7QH4/nwIaa61cnbfVCk=;
        b=QM7GhhiP2PvSE9N7hAvTjWNoyjUcRGfo3p2IK/IOKNPhgUsBlBOf01YashDfa4n2lc
         GvA8x+d8+c9zoy1qO/EOeCeyWBQ0HJeR75lZtvMPCCADVlk98CvwenNC4SVgZnr6y2Ot
         kr7vDvfMIcqqzK+Q1HHrv3Q50xCLWFfu3pmVRRQhj9nAAKPbL4IFES8SDCo/oEMx5EWq
         i5ASe0JPmVb0qlqpOk3Al0/amaAnprWCDrsMPBo3p0TqBRfA53Ln/59k1/k/ZJxHOOnu
         pX+4snj21Sg/kKmsF4y40hjvcKV1+OD3beqLmqMbcinGymPrah+HgDsuCKL3maKYpndQ
         s0bw==
X-Gm-Message-State: ANhLgQ0MwitZ+XyyC5QTS2H+YdEZ9kUSmPt0viA1Kkzrrn7Apq/o6X+4
        /dvbI6fzcZwuB0KulqZgp/HWlw==
X-Google-Smtp-Source: ADFU+vtEgCR4fL7vD8Tp7vyuiJNVrCCRTZPiuscX0cg91j3JqANWyGguMNLi5rPPRyndwVubLWZSFg==
X-Received: by 2002:a05:6214:b23:: with SMTP id w3mr4141836qvj.181.1583244355647;
        Tue, 03 Mar 2020 06:05:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w21sm13161650qth.17.2020.03.03.06.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 06:05:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j98BG-00063r-0c; Tue, 03 Mar 2020 10:05:54 -0400
Date:   Tue, 3 Mar 2020 10:05:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
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
Subject: Re: [PATCH v9 03/25] RDMA/rtrs: private headers with rtrs protocol
 structs and helpers
Message-ID: <20200303140553.GC31668@ziepe.ca>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-4-jinpuwang@gmail.com>
 <20200303094516.GJ121803@unreal>
 <CAMGffEmHB2z=JHG=92Ki_TaBZ8JXv6r0iZr7QF-pKyuRo=C9cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmHB2z=JHG=92Ki_TaBZ8JXv6r0iZr7QF-pKyuRo=C9cA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 03, 2020 at 02:52:19PM +0100, Jinpu Wang wrote:
> On Tue, Mar 3, 2020 at 10:45 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Feb 21, 2020 at 11:46:59AM +0100, Jack Wang wrote:
> > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >
> > > These are common private headers with rtrs protocol structures,
> > > logging, sysfs and other helper functions, which are used on
> > > both client and server sides.
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >  drivers/infiniband/ulp/rtrs/rtrs-log.h |  28 ++
> > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 401 +++++++++++++++++++++++++
> > >  2 files changed, 429 insertions(+)
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-log.h b/drivers/infiniband/ulp/rtrs/rtrs-log.h
> > > new file mode 100644
> > > index 000000000000..53c785b992f2
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-log.h
> > > @@ -0,0 +1,28 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * RDMA Transport Layer
> > > + *
> > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > + */
> > > +#ifndef RTRS_LOG_H
> > > +#define RTRS_LOG_H
> > > +
> > > +#define rtrs_log(fn, obj, fmt, ...)                          \
> > > +     fn("<%s>: " fmt, obj->sessname, ##__VA_ARGS__)
> > > +
> > > +#define rtrs_err(obj, fmt, ...)      \
> > > +     rtrs_log(pr_err, obj, fmt, ##__VA_ARGS__)
> > > +#define rtrs_err_rl(obj, fmt, ...)   \
> > > +     rtrs_log(pr_err_ratelimited, obj, fmt, ##__VA_ARGS__)
> > > +#define rtrs_wrn(obj, fmt, ...)      \
> > > +     rtrs_log(pr_warn, obj, fmt, ##__VA_ARGS__)
> > > +#define rtrs_wrn_rl(obj, fmt, ...) \
> > > +     rtrs_log(pr_warn_ratelimited, obj, fmt, ##__VA_ARGS__)
> > > +#define rtrs_info(obj, fmt, ...) \
> > > +     rtrs_log(pr_info, obj, fmt, ##__VA_ARGS__)
> > > +#define rtrs_info_rl(obj, fmt, ...) \
> > > +     rtrs_log(pr_info_ratelimited, obj, fmt, ##__VA_ARGS__)
> > > +
> > > +#endif /* RTRS_LOG_H */
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > new file mode 100644
> > > index 000000000000..aecf01a7d8dc
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > @@ -0,0 +1,401 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * RDMA Transport Layer
> > > + *
> > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > > + */
> > > +
> > > +#ifndef RTRS_PRI_H
> > > +#define RTRS_PRI_H
> > > +
> > > +#include <linux/uuid.h>
> > > +#include <rdma/rdma_cm.h>
> > > +#include <rdma/ib_verbs.h>
> > > +#include <rdma/ib.h>
> > > +
> > > +#include "rtrs.h"
> > > +
> > > +#define RTRS_PROTO_VER_MAJOR 2
> > > +#define RTRS_PROTO_VER_MINOR 0
> >
> > I think that Jason once said that new submission starts from "1".
> > There is no RTRS_PROTO_VER_MAJOR == 1 in the wild.
> sorry, v2 protocol is already in our production, we can simple change back to v1

I think my comment in the past was about the verb ABI number

You should arrange this so you can use it in your production, if you
use something else then we are we upstreaming it?

As a community we have had bad experience with companies upstreaming
something that they ultimately do not use.

Jason
