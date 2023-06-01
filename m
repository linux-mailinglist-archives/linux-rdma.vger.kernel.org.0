Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5074C71F2BD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFATR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjFATR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 15:17:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E013E
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 12:17:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so1837491a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 01 Jun 2023 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1685647043; x=1688239043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo1U5HjvaK03DXqrCprpS4VDfzdzOJdKOESiQPKKnX0=;
        b=XQY38fkNEvO13DFa0mEXLSr1W0A1RHjTaldXEmhl6VU/hSG/EwWvXT10372SUhGYzW
         28TCKSN+qlEhRemix+UE7z0Enhn7rTmASR0MYO7inHG4uSdUtwF42Nofiy8WbsfEMafE
         tD0PJhuglXH5PvsoVck4Ouw1qe8ENSb/oh4u6V7IJbcuPR9p3JIzNLBPMgYRXJ3upyvt
         VzUeaWZdeKzjlo4gc2NBSywHBPYzTtl2LH3nhKoYyr3IdqqcAy5g+G3U6J6kLlTFo0uI
         dKn+87DKFR8ad2rriiAKwizn/Xy51LT6y+m8YvM/MIVKbhuOh3ZmTJ8U8B2y7O0WLv8R
         2oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685647043; x=1688239043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo1U5HjvaK03DXqrCprpS4VDfzdzOJdKOESiQPKKnX0=;
        b=SoT46EL/4a4S7Gx54AVAe+VwwQoWHPsQcCEHe3OneSJuJRzzzrkOXn207vJMuLLFw3
         s7Vsx7qW4pD+Wj2TuKeY7WYWqFSFtXM1h9O78+1wQ9xVWb+Kcbc1kW/EuTdxyMQiwh04
         KcqJ4BFlO4hzly25vtVsbhLHqw3fgru1ULeE+nG4fRFHrVD/T7Wpm43Q2NjCoCRoZ6QN
         gkZdCmsrp4CZd7wNTgqB+EjiNkWofNAZ2+6kpuVvmDuPdW/lXXBq2QtUPS64RbOPPU2z
         pl55bzEFsv+rnafTkg9yahc5k8h3tfDBXY607Uvaz6g5z16i1JCRBPVFIUb0LMzJFeWp
         I33g==
X-Gm-Message-State: AC+VfDyDbQdkV1QKfmKEFdWeFl7kU5wVD9aLaezvSDEtyACjRSMLNvaJ
        ij5p0pBSY5rho+ipxNNhw3zIT3uCIXCVPtJcTvikmQ==
X-Google-Smtp-Source: ACHHUZ6jpSm7hcwB9rtx/wDj31i/Wbi5xnvUtAHFVT8aqPvTyQinnaipZgFyngJLcf3gstrju9/SAaB15w1Jfc1B7ek=
X-Received: by 2002:a05:6402:618:b0:514:9284:237f with SMTP id
 n24-20020a056402061800b005149284237fmr569745edv.31.1685647043233; Thu, 01 Jun
 2023 12:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
 <1682384563-2-4-git-send-email-lizhijian@fujitsu.com> <ZHjWTyW3our+RTCw@nvidia.com>
In-Reply-To: <ZHjWTyW3our+RTCw@nvidia.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 1 Jun 2023 21:17:12 +0200
Message-ID: <CAMGffEkttF77x3upyb2FO28FHod7-V81rZAn2N0uQ6uxCDWWwA@mail.gmail.com>
Subject: Re: [PATCH for-next v3 3/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Li Zhijian <lizhijian@fujitsu.com>, haris.iqbal@ionos.com,
        linux-rdma@vger.kernel.org, leon@kernel.org,
        guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 1, 2023 at 7:33=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Apr 25, 2023 at 01:02:43AM +0000, Li Zhijian wrote:
> > In current design:
> > 1. PD and clt_path->s.dev are shared among connections.
> > 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> > 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and
> >    when clt_path->s.dev become zero, it will destroy PD.
> > 4. when con[1] failed to create, con[1] will not take clt_path->s.dev,
> >    but it try to decreased clt_path->s.dev
> >
> > So, in case create_cm(con[0]) succeeds but create_cm(con[1])
> > fails, destroy_con_cq_qp(con[1]) will be called first which will destor=
y
> > the PD while this PD is still taken by con[0].
> >
> > Here, we refactor the error path of create_cm() and init_conns(), so th=
at
> > we do the cleanup in the order they are created.
> >
> > The warning occurs when destroying RXE PD whose reference count is not
> > zero.
> > -----------------------------------------------
> >  rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (acce=
ss_mode: rw, nr_poll_queues: 0)
> >  ------------[ cut here ]------------
> >  WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256=
 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
> >  Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_=
client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdm=
a_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_
> > vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rda=
c scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
> >  CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0=
-rc6-roce-flush+ #53
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0=
-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >  RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
> >  Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 b=
e c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc=
 ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
> >  RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
> >  RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
> >  RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
> >  RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
> >  R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
> >  R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
> >  FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000=
000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  Call Trace:
> >   <TASK>
> >   rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
> >   ib_dealloc_pd_user+0x4b/0x80 [ib_core]
> >   rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
> >   destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
> >   init_path+0x1e7/0x9a0 [rtrs_client]
> >   ? __pfx_autoremove_wake_function+0x10/0x10
> >   ? lock_is_held_type+0xd7/0x130
> >   ? rcu_read_lock_sched_held+0x43/0x80
> >   ? pcpu_alloc+0x3dd/0x7d0
> >   ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
> >   rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
> >   ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
> >   rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]
> >
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > Acked-by: Jack Wang <jinpu.wang@ionos.com>
> > Tested-by: Jack Wang <jinpu.wang@ionos.com>
>
> It would be good to have a fixes line for this?
It should be:
 Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")

Could you amend it  to the commit?
>
> Jason
Thx!
