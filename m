Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7AA6369A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfGINQA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 09:16:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41371 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGINQA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 09:16:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so20970934wrm.8
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2019 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DR+iw3jiOls1ly6DI3iEvDPkfswNzVapBNDYht5pgmA=;
        b=W6clf6hWXguUz8IzAQlguZY19CAOUBYkS4gU7d4So0nFjvwHKPDd0k05x5RPs15U/Q
         472untSuJDGB3sfOZFzH497MGWBiqU68iHXn2eZwZZxx2QLoTWEMQfUYeYBpkPM3OKx/
         oNI0hOP+WiWQNzcNkEmDOMgZZkvITKZqk7VJbO5xO8JG3wfCFe+ZyOPsUAnSyvvSzHoS
         jO1RP3bqCG0fxe+V8yKn3HhJNmJ9Ub9bYtH0mMhRVF1O4u9NV1rcoVC/x8prMYWFbtnT
         e+/eoRkqP+tnvH7KPNJicM8l6y31wFAoNvsnOrMubTZPE0y8J3EG0rwi5gIgq/oJkn8a
         5ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DR+iw3jiOls1ly6DI3iEvDPkfswNzVapBNDYht5pgmA=;
        b=Z20JMON0WZrRuTEPGSGMFW3TnF19CRc5gxjPHv3HNKdpNS0uLuqulOgeCI4etrK1SA
         PvfrLT7hxkHUObzUCwUyfBz/KrlAemxqjlTp1RGNZ+XP1y3kAJKGvXk5hnrLz2rV5wk9
         xTJnyd4MhCqB6hve6hTKGjjz7h1q6N/8V6XML2lKKFAJoXHibmvxp8EtT0rzmGbh9ZkI
         dFeFUm+tUYh/qixM1lPYSJLQBh9xuAIVFapaPL4UY2e7qdjbU90fStlAbANWZUh/moDP
         U6KXYc+NAQTBvzctdtA+wMA3UL53Wkw9ujhW7X5RmJXDxFaCveqTaJ4JjMxe+Nk7tHgE
         sSIA==
X-Gm-Message-State: APjAAAW4zGV3Ujot9xkAF1IOdRFrB4EH4slrhtrAmmYeFpAjjPgl0Ybw
        W0rOUn5sSTYMBnK88L2qFv8GX/oLkwN74NSx7MMPcw==
X-Google-Smtp-Source: APXvYqw+XYqKJTPx3Mr7LNQ8uTaqhN0ca7Mtfo3k+JQ4GsSUk9od0CRL1Q8ePqHdoGJHYT85+mMjOFplTode8RkqR1Q=
X-Received: by 2002:adf:8069:: with SMTP id 96mr4885118wrk.74.1562678157805;
 Tue, 09 Jul 2019 06:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com> <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
 <20190709120606.GB3436@mellanox.com>
In-Reply-To: <20190709120606.GB3436@mellanox.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 9 Jul 2019 15:15:46 +0200
Message-ID: <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jinpu Wang <jinpuwang@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 9, 2019 at 2:06 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, Jul 09, 2019 at 01:37:39PM +0200, Jinpu Wang wrote:
> > Leon Romanovsky <leon@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:00=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > > > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> > > >
> > > > Could you please provide some feedback to the IBNBD driver and the
> > > > IBTRS library?
> > > > So far we addressed all the requests provided by the community and
> > > > continue to maintain our code up-to-date with the upstream kernel
> > > > while having an extra compatibility layer for older kernels in our
> > > > out-of-tree repository.
> > > > I understand that SRP and NVMEoF which are in the kernel already do
> > > > provide equivalent functionality for the majority of the use cases.
> > > > IBNBD on the other hand is showing higher performance and more
> > > > importantly includes the IBTRS - a general purpose library to
> > > > establish connections and transport BIO-like read/write sg-lists ov=
er
> > > > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. Wh=
ile
> > > > I believe IBNBD does meet the kernel coding standards, it doesn't h=
ave
> > > > a lot of users, while SRP and NVMEoF are widely accepted. Do you th=
ink
> > > > it would make sense for us to rework our patchset and try pushing i=
t
> > > > for staging tree first, so that we can proof IBNBD is well maintain=
ed,
> > > > beneficial for the eco-system, find a proper location for it within
> > > > block/rdma subsystems? This would make it easier for people to try =
it
> > > > out and would also be a huge step for us in terms of maintenance
> > > > effort.
> > > > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top=
 of
> > > > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in th=
e
> > > > near future). Do you think it would make sense to rename the driver=
 to
> > > > RNBD/RTRS?
> > >
> > > It is better to avoid "staging" tree, because it will lack attention =
of
> > > relevant people and your efforts will be lost once you will try to mo=
ve
> > > out of staging. We are all remembering Lustre and don't want to see i=
t
> > > again.
> > >
> > > Back then, you was asked to provide support for performance superiori=
ty.
> > > Can you please share any numbers with us?
> > Hi Leon,
> >
> > Thanks for you feedback.
> >
> > For performance numbers,  Danil did intensive benchmark, and create
> > some PDF with graphes here:
> > https://github.com/ionos-enterprise/ibnbd/tree/master/performance/v4-v5=
.2-rc3
> >
> > It includes both single path results also different multipath policy re=
sults.
> >
> > If you have any question regarding the results, please let us know.
>
> I kind of recall that last time the perf numbers were skewed toward
> IBNBD because the invalidation model for MR was wrong - did this get
> fixed?
>
> Jason

Thanks Jason for feedback.
Can you be  more specific about  "the invalidation model for MR was wrong"

I checked in the history of the email thread, only found
"I think from the RDMA side, before we accept something like this, I'd
like to hear from Christoph, Chuck or Sagi that the dataplane
implementation of this is correct, eg it uses the MRs properly and
invalidates at the right time, sequences with dma_ops as required,
etc.
"
And no reply from any of you since then.

Thanks,
Jack
