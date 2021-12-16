Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9A4767CA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 03:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhLPCSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 21:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhLPCSj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 21:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639621118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJEqaZnwaqHIDBttaQK32cmu4xFKEuoEEBTEJJb0tbo=;
        b=D4RfD8hckENY+pQQjxksqDpcoElQOz5VPV7+FOYGqyMaSCJqWH0vkXRAPpFM9L48INpUad
        F5cxniNPjAAnaQkFMa17gGJvjJM93z3Anuuro9X9fJx995a0gdJobUOwVdFxgwC5yrsdxn
        jHZgCsDuVhYkr1KtQxBedQ8LCYzJzgA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-SmEzprgeNcSlE1D6PC11nA-1; Wed, 15 Dec 2021 21:18:36 -0500
X-MC-Unique: SmEzprgeNcSlE1D6PC11nA-1
Received: by mail-pj1-f71.google.com with SMTP id pg9-20020a17090b1e0900b001a689204b52so684453pjb.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Dec 2021 18:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJEqaZnwaqHIDBttaQK32cmu4xFKEuoEEBTEJJb0tbo=;
        b=j2H4w0O2AVlOXaZc5qpYOGVWs6mnPVwrEHxXpjVKyDdaXGvtem6dGUENvnAdjrjmbM
         vtwK8jIrphZzucDXMTQIhT7UYKIydyHwAMgMOO23GDpOSV2zE8+yZKdtTBRCkeWxpA7k
         mAvzFYKKnZhL42KtUSCSrk+X/0O2lyr5pW0pT8uDXaMfVxzF/bEEl7IP2JARaLFoVCDb
         nqBUP++0+NRoGhLetvAcJ3Ae0Om7OhAgeijBO7WEqhznAtdOp1qr6PdE/kdxgkk4wn9K
         gV3lo0kZgDrFZSax9MFYJoAvKDtJsMaPsrVSDPzrWsgj/VoPPpAuB+D13buM7Qas2c31
         BsKg==
X-Gm-Message-State: AOAM530cpjACSDJ62IfzV5jyYDWBoLbZ6/0wx//uyOaxc790SMnhARSw
        i2GjKU0Gr6LtmGEZMHkDhujZBNqbKta3LEVQ0kHFz5z5YKO1n7KZOmiwlSINQn7MJvdjAZbUA96
        1ktHNoT2RZbaehPt307SrqAx6Q1/vBKZCCTiU9g==
X-Received: by 2002:a63:d811:: with SMTP id b17mr10022730pgh.562.1639621115490;
        Wed, 15 Dec 2021 18:18:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTVTrHKuXk9QF8yS4tD1ghF4iafol+pBJGEpf7dAgfVW8fm3L4m5qCHScVjeqrtQbMWWL1MoQ23XhWUQr1tZM=
X-Received: by 2002:a63:d811:: with SMTP id b17mr10022704pgh.562.1639621115230;
 Wed, 15 Dec 2021 18:18:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me> <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me> <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me> <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com> <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
In-Reply-To: <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 16 Dec 2021 10:18:23 +0800
Message-ID: <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 8:10 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 12/15/2021 3:15 AM, Yi Zhang wrote:
> > On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
> >>>>>> Hi Sagi
> >>>>>> It is still reproducible with the change, here is the log:
> >>>>>>
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real    0m12.973s
> >>>>>> user    0m0.000s
> >>>>>> sys     0m0.006s
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real    1m15.606s
> >>>>>> user    0m0.000s
> >>>>>> sys     0m0.007s
> >>>>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> >>>> Yes, with -i 4, it has stablee 1.3s
> >>>> # time nvme reset /dev/nvme0
> >>> So it appears that destroying a qp takes a long time on
> >>> IB for some reason...
> >>>
> >>>> real 0m1.225s
> >>>> user 0m0.000s
> >>>> sys 0m0.007s
> >>>>
> >>>>>> # dmesg | grep nvme
> >>>>>> [  900.634877] nvme nvme0: resetting controller
> >>>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
> >>>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>>> [  917.600993] nvme nvme0: resetting controller
> >>>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> >>>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> >>>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
> >>>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>>>
> >>>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
> >>>>> Then I think that we need the rdma folks to help here...
> >>> Max?
> >> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
> >>
> >> Can you try repro with latest versions please ?
> >>
> >> Or give the exact scenario ?
> > Yeah, both target and client are using Mellanox Technologies MT27700
> > Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
> > first time reset will take 12s, and it always can be reproduced at the
> > second reset operation.
>
> I created a target with 1 namespace backed by null_blk and connected to
> it from the same server in loopback rdma connection using the ConnectX-4
> adapter.

Could you share your loop.json file so I can try it on my environment?

And can you try it with two servers that both have CX-4? This should
be easier to reproduce it.

>
> I run a loop with the "nvme reset" command and it took me 4-5 secs to
> reset each time..
>
>
> >
> >>
> >
>


-- 
Best Regards,
  Yi Zhang

