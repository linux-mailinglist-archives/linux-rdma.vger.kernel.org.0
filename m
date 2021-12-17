Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFB47855A
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 08:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhLQHDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Dec 2021 02:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232286AbhLQHDd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Dec 2021 02:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639724612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcmUI++gZ87Hh1xQ5ZhSxD4mpwzG6GJmxf6WlYNYf/0=;
        b=gyKz8IJELHvnxMC9PpmX3janCl4AfkVWxr+/ASBjf6jr0MN9sDitWAgtZXvhUSbzbwsBX5
        C66jPogn0GXxqa/fkJY+JjAovxm5hlEVBNe1kwr0U/d/1T9WxW50DS+fjKSoCFqnTVT6On
        o8U7lH4bPSM4lS9+BX1RPORO2vgAwKI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-ks6cYE7CN5mEledZLprvAg-1; Fri, 17 Dec 2021 02:03:31 -0500
X-MC-Unique: ks6cYE7CN5mEledZLprvAg-1
Received: by mail-pg1-f198.google.com with SMTP id r9-20020a63d909000000b003312e182b9cso930211pgg.16
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 23:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hcmUI++gZ87Hh1xQ5ZhSxD4mpwzG6GJmxf6WlYNYf/0=;
        b=lGvwOgsiZd+D4mSE0K4wJWA/Xm9cXXwOJFWwq0u00mjFWMeS0wxUPp08SBfAKCWfOv
         wurXetBDSo4qc7sTSQfH2NmWrBY0sg5CGi0eUClvhKsXBiHwya1M+yzsZmY9Rg4w/j4K
         MtTipvLJa4LHA1XlZcEbV9E3qkIDqNIrpDxB/+nRqxYPKOxAmMZ5Z+A11srGmGOJLGtm
         Jqkaqa3NP0DL2fi/FT6VJ2FF3HxaHULFZS/DZ0gDf7SCAN/A/nQtcDbwlYor52U20HBy
         MaEDKgOIgbExUEvMh0VtwuEtHsQwxI60Ga80+9jBu5gIk5ou2Q3B7s8974NG3/j/tumL
         fYUw==
X-Gm-Message-State: AOAM532p18WuRtf86PPpXus4Q9snUC++MkBYfGyDSTDH/phDi8+n0wlr
        zS4Blmvz300rfDjc8WTKhuyokjkUFQepJnnxVywZvY8KYGwbdbh43Ogyn47oienVAYbniEh6i3e
        HFlMjgyU60sJaB7WJ73KaISA08d5yVP1HNw8iKg==
X-Received: by 2002:a65:558c:: with SMTP id j12mr1705549pgs.373.1639724609911;
        Thu, 16 Dec 2021 23:03:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiNGatiUJqEL3yMNqlXoJRTx39uHq1fe/W9ApaxCoPkTOPTYob2Zdz/6mhaiklbgZXUuSLP1ezW9c4h7uGPHo=
X-Received: by 2002:a65:558c:: with SMTP id j12mr1705534pgs.373.1639724609610;
 Thu, 16 Dec 2021 23:03:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me> <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me> <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me> <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com> <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com> <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
In-Reply-To: <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 17 Dec 2021 15:03:17 +0800
Message-ID: <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 17, 2021 at 1:34 AM Haakon Bugge <haakon.bugge@oracle.com> wrot=
e:
>
>
>
> > On 16 Dec 2021, at 17:32, Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > On Thu, Dec 16, 2021 at 9:21 PM Max Gurtovoy <mgurtovoy@nvidia.com> wro=
te:
> >>
> >>
> >> On 12/16/2021 4:18 AM, Yi Zhang wrote:
> >>> On Wed, Dec 15, 2021 at 8:10 PM Max Gurtovoy <mgurtovoy@nvidia.com> w=
rote:
> >>>>
> >>>> On 12/15/2021 3:15 AM, Yi Zhang wrote:
> >>>>> On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com>=
 wrote:
> >>>>>> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
> >>>>>>>>>> Hi Sagi
> >>>>>>>>>> It is still reproducible with the change, here is the log:
> >>>>>>>>>>
> >>>>>>>>>> # time nvme reset /dev/nvme0
> >>>>>>>>>>
> >>>>>>>>>> real    0m12.973s
> >>>>>>>>>> user    0m0.000s
> >>>>>>>>>> sys     0m0.006s
> >>>>>>>>>> # time nvme reset /dev/nvme0
> >>>>>>>>>>
> >>>>>>>>>> real    1m15.606s
> >>>>>>>>>> user    0m0.000s
> >>>>>>>>>> sys     0m0.007s
> >>>>>>>>> Does it speed up if you use less queues? (i.e. connect with -i =
4) ?
> >>>>>>>> Yes, with -i 4, it has stablee 1.3s
> >>>>>>>> # time nvme reset /dev/nvme0
> >>>>>>> So it appears that destroying a qp takes a long time on
> >>>>>>> IB for some reason...
> >>>>>>>
> >>>>>>>> real 0m1.225s
> >>>>>>>> user 0m0.000s
> >>>>>>>> sys 0m0.007s
> >>>>>>>>
> >>>>>>>>>> # dmesg | grep nvme
> >>>>>>>>>> [  900.634877] nvme nvme0: resetting controller
> >>>>>>>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
> >>>>>>>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll que=
ues.
> >>>>>>>>>> [  917.600993] nvme nvme0: resetting controller
> >>>>>>>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> >>>>>>>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x1=
4
> >>>>>>>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
> >>>>>>>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll que=
ues.
> >>>>>>>>>>
> >>>>>>>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environme=
nt.
> >>>>>>>>> Then I think that we need the rdma folks to help here...
> >>>>>>> Max?
> >>>>>> It took me 12s to reset a controller with 63 IO queues with 5.16-r=
c3+.
> >>>>>>
> >>>>>> Can you try repro with latest versions please ?
> >>>>>>
> >>>>>> Or give the exact scenario ?
> >>>>> Yeah, both target and client are using Mellanox Technologies MT2770=
0
> >>>>> Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", =
the
> >>>>> first time reset will take 12s, and it always can be reproduced at =
the
> >>>>> second reset operation.
> >>>> I created a target with 1 namespace backed by null_blk and connected=
 to
> >>>> it from the same server in loopback rdma connection using the Connec=
tX-4
> >>>> adapter.
> >>> Could you share your loop.json file so I can try it on my environment=
?
> >>
> >> {
> >>   "hosts": [],
> >>   "ports": [
> >>     {
> >>       "addr": {
> >>         "adrfam": "ipv4",
> >>         "traddr": "<ip>",
> >>         "treq": "not specified",
> >>         "trsvcid": "4420",
> >>         "trtype": "rdma"
> >>       },
> >>       "portid": 1,
> >>       "referrals": [],
> >>       "subsystems": [
> >>         "testsubsystem_0"
> >>       ]
> >>     }
> >>   ],
> >>   "subsystems": [
> >>     {
> >>       "allowed_hosts": [],
> >>       "attr": {
> >>         "allow_any_host": "1",
> >>         "cntlid_max": "65519",
> >>         "cntlid_min": "1",
> >>         "model": "Linux",
> >>         "serial": "3d83c78b76623f1d",
> >>         "version": "1.3"
> >>       },
> >>       "namespaces": [
> >>         {
> >>           "device": {
> >>             "nguid": "5b722b05-e9b6-542d-ba80-62010b57775d",
> >>             "path": "/dev/nullb0",
> >>             "uuid": "26ffc8ce-73b4-321d-9685-7d7a9872c460"
> >>           },
> >>           "enable": 1,
> >>           "nsid": 1
> >>         }
> >>       ],
> >>       "nqn": "testsubsystem_0"
> >>     }
> >>   ]
> >> }
> >
> > Thanks, I reproduced it with your json file on one server with
> > loopback rdma connection:
> > # time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testsubsystem_0
> >
> > real 0m4.557s
> > user 0m0.000s
> > sys 0m0.005s
> > # time nvme reset /dev/nvme0
> >
> > real 0m13.176s
> > user 0m0.000s
> > sys 0m0.007s
> > # time nvme reset /dev/nvme0
> >
> > real 1m16.577s
> > user 0m0.002s
> > sys 0m0.005s
> > # time nvme disconnect -n testsubsystem_0
>
> What does:
>
> # rdma res show qp | grep -c ERR
>
> say, when it is slow?

Hi Haakon
Here is the output during the reset operation:

38
33
28
24
19
14
9
4
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
0
0
0

>
>
>
> Thxs, H=C3=A5kon
>



--=20
Best Regards,
  Yi Zhang

