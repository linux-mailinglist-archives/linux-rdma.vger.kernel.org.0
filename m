Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB22356968
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhDGKXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhDGKXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 06:23:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE2C061756
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 03:23:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r9so4234772ejj.3
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MxD6iPSjOr3BdGNmeFoUcDadE+94LhsZFbyNeo0Uec=;
        b=SibeO4Su5hwlqnlTXsiugvx14xRRKhmj6d9pR5WOmrftVvHSrJLkUZGkdbtmWHtlNW
         2TEmWcEyp+B53wB5kDqgrxx+IFI4K96IUyB6v++0EgFF0DuM5pkSGkotT1NjdlNF6Udf
         ufwN8npqky3nidegfhbicWzKzdu628voHRAC8pUqgKixemJYJWtmUEQkwOWlGOu1PP7r
         UKV0qUFod4O5TLx16JNfSrks70MY2L3svHCVo74ngd1FAvQq3mnd/SLypA1uOhhLqgDx
         hZEmHSqaEqjMEXSFBulSwVfiIAfOwA2GYbObqVj7ND+rzFNcFjTiB561mgNDC5o7wX2g
         mexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MxD6iPSjOr3BdGNmeFoUcDadE+94LhsZFbyNeo0Uec=;
        b=bO46+c7CSkHB69S5BXBN1BWBvmuw217Zu6hZ+nfnaapbH0PAxuNVcg9a0a+mV6xcgB
         pB2tOWBL1Y2PwfF0LGvKvrcydjJGjd/XU5n0xn1G5KCAFbh+4ofXv8JA81eaxWquuoIo
         zmtni1a5fj7RAYdkhJ8MKCwIDrsSAUGcJEJoI50/dPMZ6NrRihjFYCjrmq6GFC4uH6PN
         LbyUAU+b9M+7e+Xu7M9Ku2OLpd3fR3/r8BX72HdaWNAhBzGQSuGshvMAdATYW8Vly+JI
         hlTt9RynOGOQVlhj6+jEXMMiCBcQycjIcnKkqMge996AZwXZHfDhHlHgz44CvgysjAWP
         7RDg==
X-Gm-Message-State: AOAM5323d2CK0RwetnYv3HUvVaHG9MAxhFxutXeqBiulHwXFBtTS1gfX
        SQus96ypfW+KkysfKMJ/rDf9Zv0yqC9F0gyTYjJyjg==
X-Google-Smtp-Source: ABdhPJy8ZnCmbpHHn2qZjo0m2N1zm271j5CT/NSlVE0aOtlgi17eRso7h+7IT/RIK4yr4MR+H0GD0HijoZc3Yja7WLo=
X-Received: by 2002:a17:906:190d:: with SMTP id a13mr2885784eje.330.1617791019783;
 Wed, 07 Apr 2021 03:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210406120553.197848-1-gi-oh.kim@ionos.com> <20210406120553.197848-2-gi-oh.kim@ionos.com>
 <CAMGffEn47V33+EwLXyDiKcZ6zMvD-QufAAfPcVgHNGveKrkR+A@mail.gmail.com>
In-Reply-To: <CAMGffEn47V33+EwLXyDiKcZ6zMvD-QufAAfPcVgHNGveKrkR+A@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Wed, 7 Apr 2021 12:23:04 +0200
Message-ID: <CAJX1YtbD-Jy6zQZ-KMcSJNqj7wibBn+TosNF9Ynq6-NTDiRrHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] RDMA/rtrs-clt: Add a minimum latency multipath policy
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 7, 2021 at 11:23 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Tue, Apr 6, 2021 at 2:06 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > This patch adds new multipath policy: min-latency.
> > Client checks the latency of each path when it sends the heart-beat.
> > And it sends IO to the path with the minimum latency.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 18 +++++--
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 57 +++++++++++++++++++-
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  2 +
> >  drivers/infiniband/ulp/rtrs/rtrs.c           |  3 ++
> >  5 files changed, 77 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > index c502dcbae9bb..bc46b7a99ba0 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > @@ -101,6 +101,8 @@ static ssize_t mpath_policy_show(struct device *dev,
> >         case MP_POLICY_MIN_INFLIGHT:
> >                 return sysfs_emit(page, "min-inflight (MI: %d)\n",
> >                                   clt->mp_policy);
> > +       case MP_POLICY_MIN_LATENCY:
> > +               return sprintf(page, "min-latency (ML: %d)\n", clt->mp_policy);
> sysfs_emit should be used here, Gioh please fix it.
>
> Thanks

Sure, I will fix and send v2.
