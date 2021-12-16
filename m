Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F56477923
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 17:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhLPQcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 11:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232915AbhLPQcg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Dec 2021 11:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639672355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C7ArIo8h9UoMuRriGPBMYknw6EihK0lWHm8P8wXkcbI=;
        b=TJ2UWn+vta1L4U6r6bFezKPT8Ltg9duBbxcJtouwdSmcMvcaEHb83g0nGW2jsRFhF37zW5
        vR4NNhm2TxX6mRyWdAQsZ+kKcTpaX0gzo+qYrzE7Uy6oD9KKJDYLoShL88FcSW20aJnwoG
        39us1stUENJXaJdbfi4gUjrdRF6ue0c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-_BUXBbocN4CBJZitw9e0zA-1; Thu, 16 Dec 2021 11:32:32 -0500
X-MC-Unique: _BUXBbocN4CBJZitw9e0zA-1
Received: by mail-pl1-f200.google.com with SMTP id f16-20020a170902ce9000b001436ba39b2bso8174594plg.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 08:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7ArIo8h9UoMuRriGPBMYknw6EihK0lWHm8P8wXkcbI=;
        b=wJo6ku6hz5v04m0/V4GYZFrq5voFcq1dGemzCcH44NfVUyMRMSSk0dSmC7ukqQ2zZU
         oI/Lnj2raT3MVUcX2fNeW2FVBMNpBSD2IcC5LDGwbNwAMbdqtkTQ3qPO5TYZR1TXTaWV
         5li9KHv5Gsp+7VjNdPYQurGrADwH+BLO17S5Fs46oi5FRi7/+Jh3L5DGPbwHB9Bdy9xi
         7XLT7IwOSBoq1p5rT7IoWpqTdw3bxhTNrfiqHMMUjbsF6VbHMJXxuVTdcc3IFZfL26C+
         +nTd4IusCryShIxHBcQVpOErLwCqraPdY4xFWHMg0sJVA53T7Db8CoApjLisegeYl0RB
         TrWA==
X-Gm-Message-State: AOAM53378BRAiBzLNW+0vdt/1opkz5tOSdB9PLowkp/AKJDQinJ6iOo/
        y5VKF/z24TslCAFvXjhjcSboOR8hdSYFGz6nI/9srCtit3dTFyAx1rlFIQbmMM4wa7mSRVbjOvv
        TNim+NXyuSnjB11gwH6iJcchuIPc9N1lJjRUlTg==
X-Received: by 2002:a17:902:9b98:b0:148:ae04:9c78 with SMTP id y24-20020a1709029b9800b00148ae049c78mr7458771plp.88.1639672351135;
        Thu, 16 Dec 2021 08:32:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjMWOR+5VbDN2r+R/4Bl4r8LyNK9McDW1Qxcc+7MnSB67QEuS7c7r/O8U/gzM7UmRZLKwOrex6Cz5z1af1wvE=
X-Received: by 2002:a17:902:9b98:b0:148:ae04:9c78 with SMTP id
 y24-20020a1709029b9800b00148ae049c78mr7458750plp.88.1639672350782; Thu, 16
 Dec 2021 08:32:30 -0800 (PST)
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
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
In-Reply-To: <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 17 Dec 2021 00:32:15 +0800
Message-ID: <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 9:21 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 12/16/2021 4:18 AM, Yi Zhang wrote:
> > On Wed, Dec 15, 2021 at 8:10 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 12/15/2021 3:15 AM, Yi Zhang wrote:
> >>> On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
> >>>>>>>> Hi Sagi
> >>>>>>>> It is still reproducible with the change, here is the log:
> >>>>>>>>
> >>>>>>>> # time nvme reset /dev/nvme0
> >>>>>>>>
> >>>>>>>> real    0m12.973s
> >>>>>>>> user    0m0.000s
> >>>>>>>> sys     0m0.006s
> >>>>>>>> # time nvme reset /dev/nvme0
> >>>>>>>>
> >>>>>>>> real    1m15.606s
> >>>>>>>> user    0m0.000s
> >>>>>>>> sys     0m0.007s
> >>>>>>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> >>>>>> Yes, with -i 4, it has stablee 1.3s
> >>>>>> # time nvme reset /dev/nvme0
> >>>>> So it appears that destroying a qp takes a long time on
> >>>>> IB for some reason...
> >>>>>
> >>>>>> real 0m1.225s
> >>>>>> user 0m0.000s
> >>>>>> sys 0m0.007s
> >>>>>>
> >>>>>>>> # dmesg | grep nvme
> >>>>>>>> [  900.634877] nvme nvme0: resetting controller
> >>>>>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
> >>>>>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>>>>> [  917.600993] nvme nvme0: resetting controller
> >>>>>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> >>>>>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> >>>>>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
> >>>>>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>>>>>
> >>>>>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
> >>>>>>> Then I think that we need the rdma folks to help here...
> >>>>> Max?
> >>>> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
> >>>>
> >>>> Can you try repro with latest versions please ?
> >>>>
> >>>> Or give the exact scenario ?
> >>> Yeah, both target and client are using Mellanox Technologies MT27700
> >>> Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
> >>> first time reset will take 12s, and it always can be reproduced at the
> >>> second reset operation.
> >> I created a target with 1 namespace backed by null_blk and connected to
> >> it from the same server in loopback rdma connection using the ConnectX-4
> >> adapter.
> > Could you share your loop.json file so I can try it on my environment?
>
> {
>    "hosts": [],
>    "ports": [
>      {
>        "addr": {
>          "adrfam": "ipv4",
>          "traddr": "<ip>",
>          "treq": "not specified",
>          "trsvcid": "4420",
>          "trtype": "rdma"
>        },
>        "portid": 1,
>        "referrals": [],
>        "subsystems": [
>          "testsubsystem_0"
>        ]
>      }
>    ],
>    "subsystems": [
>      {
>        "allowed_hosts": [],
>        "attr": {
>          "allow_any_host": "1",
>          "cntlid_max": "65519",
>          "cntlid_min": "1",
>          "model": "Linux",
>          "serial": "3d83c78b76623f1d",
>          "version": "1.3"
>        },
>        "namespaces": [
>          {
>            "device": {
>              "nguid": "5b722b05-e9b6-542d-ba80-62010b57775d",
>              "path": "/dev/nullb0",
>              "uuid": "26ffc8ce-73b4-321d-9685-7d7a9872c460"
>            },
>            "enable": 1,
>            "nsid": 1
>          }
>        ],
>        "nqn": "testsubsystem_0"
>      }
>    ]
> }

Thanks, I reproduced it with your json file on one server with
loopback rdma connection:
# time nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testsubsystem_0

real 0m4.557s
user 0m0.000s
sys 0m0.005s
# time nvme reset /dev/nvme0

real 0m13.176s
user 0m0.000s
sys 0m0.007s
# time nvme reset /dev/nvme0

real 1m16.577s
user 0m0.002s
sys 0m0.005s
# time nvme disconnect -n testsubsystem_0

NQN:testsubsystem_0 disconnected 1 controller(s)

real 1m11.541s
user 0m0.000s
sys 0m0.187s

#dmesg
[96600.362827] nvmet: creating nvm controller 1 for subsystem
testsubsystem_0 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4d10-8030-b7c04f393432.
[96600.363038] nvme nvme0: creating 40 I/O queues.
[96604.905514] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[96604.909161] nvme nvme0: new ctrl: NQN "testsubsystem_0", addr
172.31.0.202:4420
[96614.270825] nvme nvme0: Removing ctrl: NQN "testsubsystem_0"
[96659.268006] nvmet: creating nvm controller 1 for subsystem
testsubsystem_0 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4d10-8030-b7c04f393432.
[96659.268215] nvme nvme0: creating 40 I/O queues.
[96663.801929] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[96663.805589] nvme nvme0: new ctrl: NQN "testsubsystem_0", addr
172.31.0.202:4420
[96673.130986] nvme nvme0: resetting controller
[96681.761992] nvmet: creating nvm controller 1 for subsystem
testsubsystem_0 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4d10-8030-b7c04f393432.
[96681.762133] nvme nvme0: creating 40 I/O queues.
[96686.302544] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[96688.850272] nvme nvme0: resetting controller
[96697.336217] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[96697.361231] nvmet: ctrl 1 fatal error occurred!
[96760.824363] nvme nvme0: I/O 25 QID 0 timeout
[96760.847531] nvme nvme0: Property Set error: 881, offset 0x14
[96760.885731] nvmet: creating nvm controller 1 for subsystem
testsubsystem_0 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4d10-8030-b7c04f393432.
[96760.885879] nvme nvme0: creating 40 I/O queues.
[96765.423099] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[96808.112730] nvme nvme0: Removing ctrl: NQN "testsubsystem_0"
[96816.632485] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[96816.657537] nvmet: ctrl 1 fatal error occurred!
[96879.608632] nvme nvme0: I/O 12 QID 0 timeout
[96879.632104] nvme nvme0: Property Set error: 881, offset 0x14>
>
> >
> > And can you try it with two servers that both have CX-4? This should
> > be easier to reproduce it.
>
> I did this experiment. I have only a setup with 12 cores so I created 12
> nvmf queues.
>
> The reset took 4 seconds. The test did 100 loops of "nvme reset".
>
> I saw that you also complained on the disconnect flow so I assume the
> root cause is the same.

Yeah, I think so

>
> My disconnect took 2 seconds.
>
> My FW version is 12.28.2006.

Yeah, mine is same with yours.
# cat /sys/devices/pci0000\:00/0000\:00\:02.0/0000\:04\:00.0/infiniband/mlx5_0/fw_ver
12.28.2006


>
> >> I run a loop with the "nvme reset" command and it took me 4-5 secs to
> >> reset each time..
> >>
> >>
> >
>


-- 
Best Regards,
  Yi Zhang

