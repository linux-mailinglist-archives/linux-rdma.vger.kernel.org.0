Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0614720FB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Dec 2021 07:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhLMGMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Dec 2021 01:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232132AbhLMGMj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Dec 2021 01:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639375958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5eyy1HO+IU7Y6V2b9JJ2wD73RzINwwNXz7T1ohguGw8=;
        b=eOwaysn6lVGCkmQ6n4jwH2ufNctPUTP1n4gaJdPPDVDZdgnRevKJMl7FvqKGaYUQeO17O9
        qRDwv05QbmxPvwnnKz/oOokVT1HDeJVwizTtrmdswo/gcvOSp2FtbhSfYDOww0JQypW434
        WkJJPspjJNxqDYSudc4Zzk51YnS82oU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-sCOCiXydOym1ct-tTJe3ng-1; Mon, 13 Dec 2021 01:12:37 -0500
X-MC-Unique: sCOCiXydOym1ct-tTJe3ng-1
Received: by mail-pj1-f69.google.com with SMTP id hg9-20020a17090b300900b001a6aa0b7d8cso9623042pjb.2
        for <linux-rdma@vger.kernel.org>; Sun, 12 Dec 2021 22:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eyy1HO+IU7Y6V2b9JJ2wD73RzINwwNXz7T1ohguGw8=;
        b=oPr0/yifd3Y8ndMH7AZHPx4mO8NFALW0uji64N/Kal06jJhqFTobDdnLRMr3rjkZB4
         9T9UdIAc1V4w/7ITt+/ZD7S10grveYXuo9nXJUaP658R6PA/p06BbKySzhUm2crVI+Xz
         xQCc2/FWZ/kK0ZvI6fHFXAixbz7irOkkiOMtfBO6c7bZv5Ohb1E0e9izHDSt2fROVBfN
         QpWAc0j9xVqWcyHmYoAmrr9RT4eaVHHGPRD/lVHAhWKL5ieRoSJxq9s5hKs8Iza818x8
         I74f9Az2FmMf7bYNJwNy3OKALTImMgdQb6fDSGvazwO/kkow/8au3VewBLUtWDaGgcW4
         ZCBA==
X-Gm-Message-State: AOAM530vX0KM4D6XRoO1YoMGuT+Jmx7UpCFLsXfR8veGppKu/fZiv7Rk
        OKgkD16QMwRbEIp5WC5mVaTcnlc8/AMViXGzRUKg3Jf7EV6VWpjmBIXVpsqoTOxkzQc7oo/4EgE
        QJ7bW/7XW1Qz52Z7d0Natoom0sUbXfrcDJmDE3A==
X-Received: by 2002:a17:902:c206:b0:142:631:5ffc with SMTP id 6-20020a170902c20600b0014206315ffcmr94516314pll.38.1639375956419;
        Sun, 12 Dec 2021 22:12:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUlwGd2f7ZhIQhO5WmZ4p3+5f1C9vaFZ+q2l6rAWIfgqz+p2EgTGre6Ig4y4MlhIVCCLqzx6ujWsY66nnoCQ4=
X-Received: by 2002:a17:902:c206:b0:142:631:5ffc with SMTP id
 6-20020a170902c20600b0014206315ffcmr94516278pll.38.1639375956088; Sun, 12 Dec
 2021 22:12:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com> <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
In-Reply-To: <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 13 Dec 2021 14:12:24 +0800
Message-ID: <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 12, 2021 at 5:45 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 12/11/21 5:01 AM, Yi Zhang wrote:
> > On Fri, Jun 25, 2021 at 12:14 AM Yi Zhang <yi.zhang@redhat.com> wrote:
> >>
> >> On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>>
> >>>
> >>>> Hello
> >>>>
> >>>> Gentle ping here, this issue still exists on latest 5.13-rc7
> >>>>
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m12.636s
> >>>> user 0m0.002s
> >>>> sys 0m0.005s
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m12.641s
> >>>> user 0m0.000s
> >>>> sys 0m0.007s
> >>>
> >>> Strange that even normal resets take so long...
> >>> What device are you using?
> >>
> >> Hi Sagi
> >>
> >> Here is the device info:
> >> Mellanox Technologies MT27700 Family [ConnectX-4]
> >>
> >>>
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 1m16.133s
> >>>> user 0m0.000s
> >>>> sys 0m0.007s
> >>>
> >>> There seems to be a spurious command timeout here, but maybe this
> >>> is due to the fact that the queues take so long to connect and
> >>> the target expires the keep-alive timer.
> >>>
> >>> Does this patch help?
> >>
> >> The issue still exists, let me know if you need more testing for it. :)
> >
> > Hi Sagi
> > ping, this issue still can be reproduced on the latest
> > linux-block/for-next, do you have a chance to recheck it, thanks.
>
> Can you check if it happens with the below patch:

Hi Sagi
It is still reproducible with the change, here is the log:

# time nvme reset /dev/nvme0

real    0m12.973s
user    0m0.000s
sys     0m0.006s
# time nvme reset /dev/nvme0

real    1m15.606s
user    0m0.000s
sys     0m0.007s

# dmesg | grep nvme
[  900.634877] nvme nvme0: resetting controller
[  909.026958] nvme nvme0: creating 40 I/O queues.
[  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  917.600993] nvme nvme0: resetting controller
[  988.562230] nvme nvme0: I/O 2 QID 0 timeout
[  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
[  988.608181] nvme nvme0: creating 40 I/O queues.
[  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.

BTW, this issue cannot be reproduced on my NVME/ROCE environment.

> --
> diff --git a/drivers/nvme/target/fabrics-cmd.c
> b/drivers/nvme/target/fabrics-cmd.c
> index f91a56180d3d..6e5aadfb07a0 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -191,6 +191,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl
> *ctrl, struct nvmet_req *req)
>                  }
>          }
>
> +       /*
> +        * Controller establishment flow may take some time, and the
> host may not
> +        * send us keep-alive during this period, hence reset the
> +        * traffic based keep-alive timer so we don't trigger a
> +        * controller teardown as a result of a keep-alive expiration.
> +        */
> +       ctrl->reset_tbkas = true;
> +
>          return 0;
>
>   err:
> --
>


-- 
Best Regards,
  Yi Zhang

