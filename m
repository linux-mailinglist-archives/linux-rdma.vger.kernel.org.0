Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80D6475063
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 02:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhLOBQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 20:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235181AbhLOBQC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 20:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqzviJpaiD/rtEttdKI7UVGMtsBNr4YqXbAMMdj58jk=;
        b=Dwq2nFiOBXR+ploRnY6ZH5Kvdkk11WSWHdox0JO+LzY62A8Xy6eNQBoNSZvlLR8NQC4bN8
        RcC+ktvcR4PI0tY2kf8XMNYfTupJEvAudCafx1M3ZEq22cy5YeWOeMsKYDeeuZOeXoeZmf
        7iLteZ+h2VnGdjXL4Tz+cGcf7R3xyhE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-APv-5rOiPSWIYPLQKn1Y3Q-1; Tue, 14 Dec 2021 20:16:00 -0500
X-MC-Unique: APv-5rOiPSWIYPLQKn1Y3Q-1
Received: by mail-pl1-f200.google.com with SMTP id l14-20020a170903120e00b00143cc292bc3so5873377plh.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Dec 2021 17:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqzviJpaiD/rtEttdKI7UVGMtsBNr4YqXbAMMdj58jk=;
        b=RsR65AQoMMy1crCEc6aENbkgsq4/BCYjcYiDxKETfqIP06K4/o3ooSTF8iyPJga9gz
         8ZISxGjdezQnKNJGAyB3uyKwHDnfxxx1tkPXx2BqnH5OyiTtzQLnA59X7XXVpgejtcCt
         VxuH31jY829sTW4YSOqGE16NnxUyjWTJg2qRtVe5qZcQjkfkWHQthkJMq94QCfB9CHL8
         pfbf/WD2C2iCdwjYVTtdykroNpXM8rCXKldSYNF8rsRkx2ONDniWs7c3BGSq0xHQXlJe
         f0uiBzUl0/HINGlD6BwGEwWs8x5BP6AVtvMWonty/mkDjpjzNqGqtW4eZRdHh1W82zZG
         l+PQ==
X-Gm-Message-State: AOAM533OIVpzAhofWl0bCrnhMItnIvTUQBRgo/7cPJW/Wxmn0qT4E0C1
        KF0Te6fDKuB+JYmsvAqe+jaFJhTKbFv5tTr5iB64YAdg2+3HW6GRVVPqhs2Rivt2DaI1id/h442
        UigE3gr9cio/bCYJxXgmAvWhSV/TfV7hzV8/D5A==
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id 2-20020a170902c20200b001422441aa25mr9294403pll.68.1639530958943;
        Tue, 14 Dec 2021 17:15:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCCN7LeRD3RsPAMydc2U/oekyRRH6c8j5ls98a+NL4Bsd8+iIKWIk7JTXsqge+RgLRVwN6pTzCJQVOfVaIs6I=
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id
 2-20020a170902c20200b001422441aa25mr9294388pll.68.1639530958657; Tue, 14 Dec
 2021 17:15:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me> <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me> <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me> <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
In-Reply-To: <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 15 Dec 2021 09:15:47 +0800
Message-ID: <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
> >
> >>>> Hi Sagi
> >>>> It is still reproducible with the change, here is the log:
> >>>>
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real    0m12.973s
> >>>> user    0m0.000s
> >>>> sys     0m0.006s
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real    1m15.606s
> >>>> user    0m0.000s
> >>>> sys     0m0.007s
> >>>
> >>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> >> Yes, with -i 4, it has stablee 1.3s
> >> # time nvme reset /dev/nvme0
> >
> > So it appears that destroying a qp takes a long time on
> > IB for some reason...
> >
> >> real 0m1.225s
> >> user 0m0.000s
> >> sys 0m0.007s
> >>
> >>>
> >>>>
> >>>> # dmesg | grep nvme
> >>>> [  900.634877] nvme nvme0: resetting controller
> >>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
> >>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>> [  917.600993] nvme nvme0: resetting controller
> >>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> >>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> >>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
> >>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>
> >>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
> >>>
> >>> Then I think that we need the rdma folks to help here...
> >
> > Max?
>
> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
>
> Can you try repro with latest versions please ?
>
> Or give the exact scenario ?

Yeah, both target and client are using Mellanox Technologies MT27700
Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
first time reset will take 12s, and it always can be reproduced at the
second reset operation.

>
>


-- 
Best Regards,
  Yi Zhang

