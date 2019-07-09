Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3B6353D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfGIL5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 07:57:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38102 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIL5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 07:57:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id h28so8876602lfj.5;
        Tue, 09 Jul 2019 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/XAhcYHwMbTulMxmFEY/uaD2wPcEzXkHjPashXwEZxU=;
        b=rmWohzyeVWX+3UG6zvRtA7OxjSokbHkr8OKqSxty80VSdAxWAZBOBf9nNhTIzC9lWM
         hsXh3XU7KcdPzQNddavF5CoCK42jiZI4HM3enTx53UuzcPS5HkQF5vASJXsPN/Xb6MKp
         7see0R8HjKpzk6Cyl2fGFvGvj6u7mLfFuDst5Pa0kuJjWyCaRdIWjlxuPW/2v95hvoR5
         E0idi2ZDT4eIlUB0RJd7LBA+QYWymeDTQAgRcbxfPOT3gaSoA3qntOuZP63GLiNpg48Q
         YSUzq34alhr1vItyLMA6LGRaS/PMbNlncsjOBAEhLcY4V5BgQzckjm6e0cUJI/4qzb3z
         YKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/XAhcYHwMbTulMxmFEY/uaD2wPcEzXkHjPashXwEZxU=;
        b=ZbTlEfRUGPap5sKjrLk1pa0MniAnQWYyGDYDQRyTo92RGHxtguUJc/d4HpWz1Mo1Qs
         ycr9CeLstsnI8YKLgpXX339d6P2+0d+xFoGe0b/VJgYkQOyZ0FtZCdMtasXaDjFKdrt2
         LqU0UNsGCHnial4WW9QorYpvjdGBrHk4yjNe2InDvZB1y5l1fqkkoM7QEAVR2WTHFjdt
         1yVNwqGsYk7pK/EfXuePIN743vo6PLKqWwyChya3wpAR/UsbbkfTJJZG0Ccc1fCM2SdN
         yrhf7vyuj/FMEn52zWvUdX6juOkxSG+56cwHOf+6YBp/We00vprmfubVW+v4BPOysauF
         f7Kw==
X-Gm-Message-State: APjAAAWdFksJ8zK72vBLRBRrgfgCm4BAqdQDm0HhvxkYmJDIr67RC3A+
        GUaWSxLGZPk8DtGwF4p2nziAR9xZmRsmNNR7wMY=
X-Google-Smtp-Source: APXvYqzN+LsD4JZSMy0GEi5KyXlXVV3dg2xTVlIXCP5IMjmEXjv1UGJgYBKAEaUD6plu/CeaJy9XmLYw/0fn3qZQkFg=
X-Received: by 2002:ac2:5337:: with SMTP id f23mr11678322lfh.15.1562673468580;
 Tue, 09 Jul 2019 04:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com> <20190709111737.GB6719@kroah.com>
In-Reply-To: <20190709111737.GB6719@kroah.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Tue, 9 Jul 2019 13:57:37 +0200
Message-ID: <CAD9gYJ+-XZ-zYMY9sYppKVNV2D2yKTt879FmpZkVaDJqF1eM2g@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 09, 2019 at 02:00:36PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> > >
> > > Could you please provide some feedback to the IBNBD driver and the
> > > IBTRS library?
> > > So far we addressed all the requests provided by the community and
> > > continue to maintain our code up-to-date with the upstream kernel
> > > while having an extra compatibility layer for older kernels in our
> > > out-of-tree repository.
> > > I understand that SRP and NVMEoF which are in the kernel already do
> > > provide equivalent functionality for the majority of the use cases.
> > > IBNBD on the other hand is showing higher performance and more
> > > importantly includes the IBTRS - a general purpose library to
> > > establish connections and transport BIO-like read/write sg-lists over
> > > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. Whil=
e
> > > I believe IBNBD does meet the kernel coding standards, it doesn't hav=
e
> > > a lot of users, while SRP and NVMEoF are widely accepted. Do you thin=
k
> > > it would make sense for us to rework our patchset and try pushing it
> > > for staging tree first, so that we can proof IBNBD is well maintained=
,
> > > beneficial for the eco-system, find a proper location for it within
> > > block/rdma subsystems? This would make it easier for people to try it
> > > out and would also be a huge step for us in terms of maintenance
> > > effort.
> > > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top o=
f
> > > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
> > > near future). Do you think it would make sense to rename the driver t=
o
> > > RNBD/RTRS?
> >
> > It is better to avoid "staging" tree, because it will lack attention of
> > relevant people and your efforts will be lost once you will try to move
> > out of staging. We are all remembering Lustre and don't want to see it
> > again.
>
> That's up to the developers, that had nothing to do with the fact that
> the code was in the staging tree.  If the Lustre developers had actually
> done the requested work, it would have moved out of the staging tree.
>
> So if these developers are willing to do the work to get something out
> of staging, and into the "real" part of the kernel, I will gladly take
> it.
Thanks Greg,

This is encouraging, we ARE willing to do the work to get IBNBD/IBTRS merge=
d to
upstream kernel. We regularly contribute to stable kernel also
upsteam, backport patches, testing
stable rc release etc. We believe in opensource and the power of community.

Sure, we will try to go with so called real kernel, this is also what
we are doing
and did in the past, but since v3, we did not receive any real feedback.

We will see how thing will go.

Thanks again!
Jack Wang @ 1 & 1 IONOS Cloud GmbH


>
> But I will note that it is almost always easier to just do the work
> ahead of time, and merge it in "correctly" than to go from staging into
> the real part of the kernel.  But it's up to the developers what they
> want to do.
>
> thanks,
>
> greg k-h
