Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60D83EFCFD
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 08:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhHRGnB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 02:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238164AbhHRGmy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 02:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629268939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3f/VvpnkNZSqXYWa+oKcTrwUzMPqogsGw5YbCjK3vs=;
        b=B8hU5yzM2NPMci+XPv0XwskBkhU9ccqvZ4J6ICfmoqD+39h95weHdXSxbw3OaHqnOhBHkZ
        AGuKVcZkeDa14uiY1G+MDm9y4J8H7tHlrAm1UlQ0XchPBjzYzrY34fw7o2gbq67NB/7L89
        M8NKpT4fmc9EhzViExBQBfsiC0b7dR8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Dp1DpSj_PmaU2vFRDexCaQ-1; Wed, 18 Aug 2021 02:42:18 -0400
X-MC-Unique: Dp1DpSj_PmaU2vFRDexCaQ-1
Received: by mail-yb1-f197.google.com with SMTP id i32-20020a25b2200000b02904ed415d9d84so1891851ybj.0
        for <linux-rdma@vger.kernel.org>; Tue, 17 Aug 2021 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3f/VvpnkNZSqXYWa+oKcTrwUzMPqogsGw5YbCjK3vs=;
        b=UoBJCzilP5vjK2dSjmXisLvJv9Ps0bEVMbeuibmKzaSVBMROX3gjMx5Rr+HBNnMp8O
         redcfVG05MifBxYHSNATPcrO1VmI8f/QplXukuX9mLWHpRxPBiZd4cy4QuKn8jYgDFJI
         MNybNgd3xYDyk5TUqomZuTzwsaVZJ4V9Dp5EyJtHH4I73mOcpJWH67ubPCREzrwG/Gnm
         80Vc1eu/NKE4st8Cl3gyy2d0puskirUoA/u74gDKaS140D23tq6+e9AQP9SeGcaVbFeD
         CAjKiHlXOOnbYqJManGnPvnIjL6PI/FPI13/HTEzX3eNSSUPCDiu1/6MdXXzlU+MIEx4
         cutg==
X-Gm-Message-State: AOAM53039waqo5Ta5eIePu0+qWpRi9JdYaE0yHv/wXo/6c7tgKASQHAO
        /xHuair7pOWLgpnZrypT+P9U3qFFS5+5xeKEPsBLg5HS5/Jz7ccBl+Xep15He0hKqjxCoKTRFLQ
        9z8rC997JgNnU3YuWy5clf84GRQdRpdOLNAwQQg==
X-Received: by 2002:a05:6902:134c:: with SMTP id g12mr9103930ybu.251.1629268938005;
        Tue, 17 Aug 2021 23:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt6DSeMVEWmZkPr+JwXnqnfF9y1RGHu23or4TgKrwyA9RaRBrszd5acbOoV7uzWNxU3hy2kITKuNNjj8NeDOw=
X-Received: by 2002:a05:6902:134c:: with SMTP id g12mr9103916ybu.251.1629268937783;
 Tue, 17 Aug 2021 23:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_M_PJ-7U3QdUxG5=Ce56mBP+WUwko2JqBO6gu_3CqJwQ@mail.gmail.com>
 <CAD=hENeOwY-EgELJox7WkrJEdR-4tTS5VvFULWibxbRSB9OWww@mail.gmail.com> <CAD=hENfMKGEJHQvkpDtE4-Z0thT5rK2QuRksoN_O679umhRdEw@mail.gmail.com>
In-Reply-To: <CAD=hENfMKGEJHQvkpDtE4-Z0thT5rK2QuRksoN_O679umhRdEw@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 18 Aug 2021 14:42:05 +0800
Message-ID: <CAHj4cs-szqzM4s9YPdWJ29JMjJCu1HDDWcpohUgtgZSy2RBzRg@mail.gmail.com>
Subject: Re: [bug report] rdma_rxe doesn't work with blktests on 5.14.0-rc6
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-nvme@lists.infradead.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 1:30 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Wed, Aug 18, 2021 at 1:09 PM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 12:57 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > >
> > > Hello
> > >
> > > I found rdma_rxe doesn't work with blktests on the latest upstream, is
> > > it a known issue, feel free to let me know if you need any info/test
> > > for it, thanks.
> > >
> > > # nvme_trtype=rdma ./check nvme/008
> > > nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
> > >     runtime  0.323s  ...  0.329s
> > >     --- tests/nvme/008.out 2021-08-18 00:18:35.380345954 -0400
> > >     +++ /root/blktests/results/nodev/nvme/008.out.bad 2021-08-18
> > > 00:35:11.126723074 -0400
> > >     @@ -1,5 +1,7 @@
> > >      Running nvme/008
> > >     -91fdba0d-f87b-4c25-b80f-db7be1418b9e
> > >     -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> > >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> > >     +Failed to write to /dev/nvme-fabrics: Cannot allocate memory
> > >     +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
> > >     +cat: /sys/block/n1/uuid: No such file or directory
> > >     ...
> > >     (Run 'diff -u tests/nvme/008.out
> > > /root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)
> > >
> > >
> > > [  981.382774] run blktests nvme/008 at 2021-08-18 00:33:21
> > > [  981.470796] rdma_rxe: loaded
> > > [  981.474338] infiniband eno1_rxe: set active
> > > [  981.474340] infiniband eno1_rxe: added eno1
> > > [  981.476737] eno2 speed is unknown, defaulting to 1000
> > > [  981.481803] eno2 speed is unknown, defaulting to 1000
> > > [  981.486865] eno2 speed is unknown, defaulting to 1000
> > > [  981.492862] infiniband eno2_rxe: set down
> > > [  981.492864] infiniband eno2_rxe: added eno2
> > > [  981.492904] eno2 speed is unknown, defaulting to 1000
> > > [  981.497957] eno2 speed is unknown, defaulting to 1000
> > > [  981.504338] eno2 speed is unknown, defaulting to 1000
> > > [  981.510442] eno3 speed is unknown, defaulting to 1000
> > > [  981.515509] eno3 speed is unknown, defaulting to 1000
> > > [  981.520580] eno3 speed is unknown, defaulting to 1000
> > > [  981.526600] infiniband eno3_rxe: set down
> > > [  981.526601] infiniband eno3_rxe: added eno3
> > > [  981.526640] eno3 speed is unknown, defaulting to 1000
> > > [  981.531693] eno3 speed is unknown, defaulting to 1000
> > > [  981.538052] eno2 speed is unknown, defaulting to 1000
> > > [  981.543115] eno3 speed is unknown, defaulting to 1000
> > > [  981.549088] eno4 speed is unknown, defaulting to 1000
> > > [  981.554149] eno4 speed is unknown, defaulting to 1000
> > > [  981.559211] eno4 speed is unknown, defaulting to 1000
> > > [  981.565201] infiniband eno4_rxe: set down
> > > [  981.565203] infiniband eno4_rxe: added eno4
> > > [  981.565242] eno4 speed is unknown, defaulting to 1000
> > > [  981.570306] eno4 speed is unknown, defaulting to 1000
> > > [  981.576724] eno2 speed is unknown, defaulting to 1000
> > > [  981.581785] eno3 speed is unknown, defaulting to 1000
> > > [  981.586848] eno4 speed is unknown, defaulting to 1000
> > > [  981.599312] loop0: detected capacity change from 0 to 2097152
> > > [  981.612261] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [  981.614215] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
> > > [  981.622586] nvmet: creating controller 1 for subsystem
> > > blktests-subsystem-1 for NQN
> > > nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
> > > [  981.622830] nvme nvme0: creating 32 I/O queues.
> > > [  981.634860] nvme nvme0: failed to initialize MR pool sized 128 for
> > > QID 32         ----------------------- failed here
> >
> > Recently a lot of commits are merged into linux upstream, can you let
> > us know the kernel version
> > on which this problem occurs?
>
> I mean, the earliest kernel version on which this problem occurs.

It should be 5.14.-rc5, and from 5.14.0-0.rc4, the tests failed with
another failure log as below, and 5.13 doesn't have these issues.

[  196.022199] run blktests nvme/008 at 2021-08-18 02:06:48
[  196.107611] TECH PREVIEW: Soft-RoCE Transport Driver may not be
fully supported.
               Please review provided documentation for limitations.
[  196.121123] rdma_rxe: loaded
[  196.127604] infiniband eno1_rxe: set active
[  196.127606] infiniband eno1_rxe: added eno1
[  196.130061] eno2 speed is unknown, defaulting to 1000
[  196.135131] eno2 speed is unknown, defaulting to 1000
[  196.140197] eno2 speed is unknown, defaulting to 1000
[  196.146175] infiniband eno2_rxe: set down
[  196.146176] infiniband eno2_rxe: added eno2
[  196.146225] eno2 speed is unknown, defaulting to 1000
[  196.151338] Loading iSCSI transport class v2.0-870.
[  196.152607] eno2 speed is unknown, defaulting to 1000
[  196.158580] eno3 speed is unknown, defaulting to 1000
[  196.163661] eno3 speed is unknown, defaulting to 1000
[  196.168724] eno3 speed is unknown, defaulting to 1000
[  196.168783] iscsi: registered transport (iser)
[  196.174702] infiniband eno3_rxe: set down
[  196.174703] infiniband eno3_rxe: added eno3
[  196.174744] eno3 speed is unknown, defaulting to 1000
[  196.180953] eno2 speed is unknown, defaulting to 1000
[  196.186033] eno3 speed is unknown, defaulting to 1000
[  196.191511] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  196.191546] db_root: cannot open: /etc/target
[  196.192018] eno4 speed is unknown, defaulting to 1000
[  196.200971] eno4 speed is unknown, defaulting to 1000
[  196.206033] eno4 speed is unknown, defaulting to 1000
[  196.212008] infiniband eno4_rxe: set down
[  196.212010] infiniband eno4_rxe: added eno4
[  196.212050] eno4 speed is unknown, defaulting to 1000
[  196.218428] eno2 speed is unknown, defaulting to 1000
[  196.223494] eno3 speed is unknown, defaulting to 1000
[  196.228562] eno4 speed is unknown, defaulting to 1000
[  196.240599] eno2 speed is unknown, defaulting to 1000
[  196.245656] eno3 speed is unknown, defaulting to 1000
[  196.250719] eno4 speed is unknown, defaulting to 1000
[  196.255853] loop: module loaded
[  196.272763] RPC: Registered rdma transport module.
[  196.272765] RPC: Registered rdma backchannel transport module.
[  196.277249] loop0: detected capacity change from 0 to 2097152
[  196.286992] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  196.289632] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
[  196.299378] nvmet_rdma: post_recv cmd failed
[  196.303666] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue
failed (-22).
[  196.325813] rdma_rxe: invalid mask or state for qp
[  196.330608] nvme nvme0: Connect rejected: status 28 (consumer
defined) nvme status 6 (resource not found).
[  196.340259] nvme nvme0: rdma connection establishment failed (-104)
[  196.450004] eno2 speed is unknown, defaulting to 1000
[  196.455067] eno3 speed is unknown, defaulting to 1000
[  196.460132] eno4 speed is unknown, defaulting to 1000
[  196.475683] rdma_rxe: unloaded

