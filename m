Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060EB7979DA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Sep 2023 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjIGRXG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Sep 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbjIGRXE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Sep 2023 13:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2AE6F
        for <linux-rdma@vger.kernel.org>; Thu,  7 Sep 2023 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694107262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gk6MXf3ULpOoBijUGrtxX0AOS2palQAzPrBX0rmGfSY=;
        b=efSfIf0mNCYmb0rJdCVLA1eDt6wPrtlHbWEA2bNzWbquVwaPXWfsMYH8BQn5M5B6PymGYY
        DeDnPt21qazEIGQMofEYmZ0hLncm8GBE4I++QYduD9MrhwdV7NwpC9qdyaivIR4b5Fa0RW
        MbU2NuQ2O8gguvCi8Jsz35cYW/cl0rg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-K7L9XOXIN3iAmLJzfiZmrA-1; Thu, 07 Sep 2023 03:47:17 -0400
X-MC-Unique: K7L9XOXIN3iAmLJzfiZmrA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27359a369ceso845384a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Sep 2023 00:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694072836; x=1694677636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk6MXf3ULpOoBijUGrtxX0AOS2palQAzPrBX0rmGfSY=;
        b=UYC9uV/Uj8Y9sV8Dhnq/AZUc1I6VeoZwjD6yy04vE/R0dgSIqBS1MlVRZy2/mSNj9k
         WoEDzOaIrKbmiv08U74LbI2eirmq1/EI4XAIF8qNxEv9z2c4j/AnXlie7KdFKYvY5oFo
         OD1AKM/zc26rVpio4eMg5m+96Y73N1tV1pjhgqfGTfieZApo53w2Z4Mx59D9aKe+CCGV
         b5nvlSSyQO+hvNP/4gUIcRVqlZeFCZU6NM7AHkUtHgOERhbXnYrZvwtMktfVZmdIYCo1
         1Zp+6K8EE6gz8u2WDjocnleLyBg8QNYEzIw05Pgibxck+Xo4HVAqT7m5dQyoqhyKtXHW
         zZJQ==
X-Gm-Message-State: AOJu0YwuPIPCn8tu6Otp90eOACj9Pq3Yebj91QdnBK4y9M+0z5OidbgW
        q4oi4C5Zw+baT0HXM3K9X3i48GuqNkeNEF9pyqoQ6LtWg5NEpmmFoJFH5JwZA8btJnudr4n4rJY
        PP2sVYRoMJgnmJV4cabgWnBYLSA585EZ+5tpsnQ==
X-Received: by 2002:a17:90a:d817:b0:26d:4312:17e5 with SMTP id a23-20020a17090ad81700b0026d431217e5mr13995717pjv.6.1694072836240;
        Thu, 07 Sep 2023 00:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Vdj6jC8XNvNM/6wkBWy9JIrMEmhN/0ebf/DfEcLQaPqGLZilfwVGJRvFPZtlJh0GamskKTBTr6km1uixVyY=
X-Received: by 2002:a17:90a:d817:b0:26d:4312:17e5 with SMTP id
 a23-20020a17090ad81700b0026d431217e5mr13995706pjv.6.1694072835867; Thu, 07
 Sep 2023 00:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca> <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca> <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca> <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso> <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
In-Reply-To: <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 7 Sep 2023 15:47:03 +0800
Message-ID: <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during cma_iw_handler
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Seems I reproduced this issue[3] when I run [1] on the latest
linux-block/for-next with kernel config[2].

[1]nvme_trtype=3Drdma ./check nvme/

[2] https://pastebin.com/u9fh7dbX

[3]
[  387.880016] run blktests nvme/003 at 2023-09-07 03:31:15
[  388.173979] (null): rxe_set_mtu: Set mtu to 1024
[  388.310460] infiniband eno1_rxe: set active
[  388.310495] infiniband eno1_rxe: added eno1
[  388.708380] loop0: detected capacity change from 0 to 2097152
[  388.767800] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  388.839397] nvmet_rdma: enabling port 0 (10.16.221.26:4420)
[  389.053251] nvmet: creating discovery controller 1 for subsystem
nqn.2014-08.org.nvmexpress.discovery for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  389.061415] nvme nvme2: new ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery", addr 10.16.221.26:4420
[  402.202057] nvme nvme2: Removing ctrl: NQN
"nqn.2014-08.org.nvmexpress.discovery"

[  402.251605] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  402.257782] WARNING: possible circular locking dependency detected
[  402.263963] 6.5.0+ #1 Not tainted
[  402.267280] ------------------------------------------------------
[  402.273459] kworker/5:0/48 is trying to acquire lock:
[  402.278512] ffff88831a9b6450 (&id_priv->handler_mutex){+.+.}-{3:3},
at: rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.288279]
               but task is already holding lock:
[  402.294112] ffffc90000687da0
((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
process_one_work+0x83a/0x1660
[  402.304729]
               which lock already depends on the new lock.

[  402.312903]
               the existing dependency chain (in reverse order) is:
[  402.320380]
               -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
[  402.328561]        __lock_acquire+0xbd6/0x1c00
[  402.333015]        lock_acquire+0x1da/0x5e0
[  402.337203]        process_one_work+0x884/0x1660
[  402.341822]        worker_thread+0x5be/0xef0
[  402.346093]        kthread+0x2f4/0x3d0
[  402.349845]        ret_from_fork+0x30/0x70
[  402.353947]        ret_from_fork_asm+0x1b/0x30
[  402.358391]
               -> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
[  402.365186]        __lock_acquire+0xbd6/0x1c00
[  402.369631]        lock_acquire+0x1da/0x5e0
[  402.373818]        __flush_workqueue+0x101/0x1230
[  402.378524]        nvmet_rdma_queue_connect+0x106/0x4b0 [nvmet_rdma]
[  402.384885]        cma_cm_event_handler+0xf2/0x430 [rdma_cm]
[  402.390562]        cma_ib_req_handler+0x93a/0x1cd0 [rdma_cm]
[  402.396238]        cm_process_work+0x48/0x3b0 [ib_cm]
[  402.401307]        cm_req_handler+0xf9b/0x2610 [ib_cm]
[  402.406465]        cm_work_handler+0x80a/0x1380 [ib_cm]
[  402.411708]        process_one_work+0x955/0x1660
[  402.416326]        worker_thread+0x5be/0xef0
[  402.420600]        kthread+0x2f4/0x3d0
[  402.424351]        ret_from_fork+0x30/0x70
[  402.428450]        ret_from_fork_asm+0x1b/0x30
[  402.432897]
               -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
[  402.439874]        __lock_acquire+0xbd6/0x1c00
[  402.444320]        lock_acquire+0x1da/0x5e0
[  402.448504]        __mutex_lock+0x154/0x1490
[  402.452776]        cma_ib_req_handler+0x4f8/0x1cd0 [rdma_cm]
[  402.458455]        cm_process_work+0x48/0x3b0 [ib_cm]
[  402.463525]        cm_req_handler+0xf9b/0x2610 [ib_cm]
[  402.468681]        cm_work_handler+0x80a/0x1380 [ib_cm]
[  402.473925]        process_one_work+0x955/0x1660
[  402.478543]        worker_thread+0x5be/0xef0
[  402.482817]        kthread+0x2f4/0x3d0
[  402.486570]        ret_from_fork+0x30/0x70
[  402.490668]        ret_from_fork_asm+0x1b/0x30
[  402.495113]
               -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
[  402.501908]        check_prev_add+0x1bd/0x23a0
[  402.506352]        validate_chain+0xb02/0xf30
[  402.510713]        __lock_acquire+0xbd6/0x1c00
[  402.515159]        lock_acquire+0x1da/0x5e0
[  402.519344]        __mutex_lock+0x154/0x1490
[  402.523617]        rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.528774]        nvmet_rdma_free_queue+0x7b/0x380 [nvmet_rdma]
[  402.534790]        nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma]
[  402.541408]        process_one_work+0x955/0x1660
[  402.546029]        worker_thread+0x5be/0xef0
[  402.550303]        kthread+0x2f4/0x3d0
[  402.554054]        ret_from_fork+0x30/0x70
[  402.558153]        ret_from_fork_asm+0x1b/0x30
[  402.562599]
               other info that might help us debug this:

[  402.570599] Chain exists of:
                 &id_priv->handler_mutex --> (wq_completion)nvmet-wq
--> (work_completion)(&queue->release_work)

[  402.584854]  Possible unsafe locking scenario:

[  402.590775]        CPU0                    CPU1
[  402.595307]        ----                    ----
[  402.599839]   lock((work_completion)(&queue->release_work));
[  402.605508]                                lock((wq_completion)nvmet-wq)=
;
[  402.612300]
lock((work_completion)(&queue->release_work));
[  402.620475]   lock(&id_priv->handler_mutex);
[  402.624755]
                *** DEADLOCK ***

[  402.630675] 2 locks held by kworker/5:0/48:
[  402.634860]  #0: ffff8883070c9d48
((wq_completion)nvmet-wq){+.+.}-{0:0}, at:
process_one_work+0x80c/0x1660
[  402.644524]  #1: ffffc90000687da0
((work_completion)(&queue->release_work)){+.+.}-{0:0}, at:
process_one_work+0x83a/0x1660
[  402.655572]
               stack backtrace:
[  402.659933] CPU: 5 PID: 48 Comm: kworker/5:0 Not tainted 6.5.0+ #1
[  402.666110] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.11.4 03/22/2023
[  402.673763] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdm=
a]
[  402.680646] Call Trace:
[  402.683099]  <TASK>
[  402.685205]  dump_stack_lvl+0x60/0xb0
[  402.688879]  check_noncircular+0x2f9/0x3e0
[  402.692982]  ? __pfx_check_noncircular+0x10/0x10
[  402.697609]  ? srso_return_thunk+0x5/0x10
[  402.701635]  ? srso_return_thunk+0x5/0x10
[  402.705649]  ? alloc_chain_hlocks+0x1de/0x520
[  402.710010]  check_prev_add+0x1bd/0x23a0
[  402.713944]  ? mark_lock.part.0+0xca/0xab0
[  402.718054]  validate_chain+0xb02/0xf30
[  402.721909]  ? __pfx_validate_chain+0x10/0x10
[  402.726274]  ? _raw_spin_unlock_irq+0x24/0x50
[  402.730635]  ? lockdep_hardirqs_on+0x79/0x100
[  402.735000]  ? srso_return_thunk+0x5/0x10
[  402.739012]  ? _raw_spin_unlock_irq+0x2f/0x50
[  402.743380]  __lock_acquire+0xbd6/0x1c00
[  402.747321]  lock_acquire+0x1da/0x5e0
[  402.750991]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.755805]  ? __pfx_lock_acquire+0x10/0x10
[  402.759997]  ? do_raw_spin_trylock+0xb5/0x180
[  402.764363]  ? srso_return_thunk+0x5/0x10
[  402.768381]  ? srso_return_thunk+0x5/0x10
[  402.772402]  __mutex_lock+0x154/0x1490
[  402.776159]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.780973]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.785782]  ? __pfx___mutex_lock+0x10/0x10
[  402.789981]  ? srso_return_thunk+0x5/0x10
[  402.793992]  ? rcu_is_watching+0x11/0xb0
[  402.797929]  ? rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.802738]  rdma_destroy_id+0x17/0x20 [rdma_cm]
[  402.807377]  nvmet_rdma_free_queue+0x7b/0x380 [nvmet_rdma]
[  402.812875]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma]
[  402.818972]  process_one_work+0x955/0x1660
[  402.823078]  ? __lock_acquired+0x207/0x7b0
[  402.827177]  ? __pfx_process_one_work+0x10/0x10
[  402.831711]  ? __pfx___lock_acquired+0x10/0x10
[  402.836164]  ? worker_thread+0x15a/0xef0
[  402.840095]  worker_thread+0x5be/0xef0
[  402.843862]  ? __pfx_worker_thread+0x10/0x10
[  402.848134]  kthread+0x2f4/0x3d0
[  402.851366]  ? __pfx_kthread+0x10/0x10
[  402.855121]  ret_from_fork+0x30/0x70
[  402.858704]  ? __pfx_kthread+0x10/0x10
[  402.862459]  ret_from_fork_asm+0x1b/0x30
[  402.866398]  </TASK>
[  403.865323] rdma_rxe: unloaded
[  405.242319] rdma_rxe: loaded
[  405.272491] loop: module loaded
[  405.352101] run blktests nvme/004 at 2023-09-07 03:31:32
[  405.504367] (null): rxe_set_mtu: Set mtu to 1024
[  405.587145] infiniband eno1_rxe: set active
[  405.595981] infiniband eno1_rxe: added eno1
[  405.714913] loop0: detected capacity change from 0 to 2097152
[  405.746602] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  405.784747] nvmet_rdma: enabling port 0 (10.16.221.26:4420)
[  405.876322] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  405.894750] nvme nvme2: creating 16 I/O queues.
[  406.181403] nvme nvme2: mapped 16/0/0 default/read/poll queues.
[  406.216348] nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr
10.16.221.26:4420
[  406.552633] nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
[  407.879250] rdma_rxe: unloaded
[  409.146426] rdma_rxe: loaded
[  409.176282] loop: module loaded
[  409.460211] rdma_rxe: unloaded
[  410.938596] rdma_rxe: loaded
[  410.966908] loop: module loaded


On Wed, Sep 6, 2023 at 7:33=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Sep 06, 2023 / 10:54, Daniel Wagner wrote:
> > On Tue, Sep 05, 2023 at 12:39:38AM +0000, Shinichiro Kawasaki wrote:
> > > Two month ago, the failure had been recreated by repeating the blktes=
ts test
> > > cases nvme/030 and nvme/031 with SIW tranposrt around 30 times. Now I=
 do not see
> > > it when I repeat them 100 times. I suspected some kernel changes betw=
een v6.4
> > > and v6.5 would have fixed the issue, but even when I use both kernel =
versions,
> > > the failure is no longer seen. I reverted nvme-cli and libnvme to old=
er version,
> > > but still do not see the failure. I just guess some change on my test=
 system
> > > affected the symptom (Fedora 38 on QEMU).
> >
> > Maybe the refactoring in blktests could also be the reason the tests ar=
e
> > not working? Just an idea.
>
> That is an idea. I rolled back blktests to the git revision of two months=
 ago,
> but still the failure is not recreated. Hmm.
>


--=20
Best Regards,
  Yi Zhang

