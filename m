Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4094D43C0
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 10:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiCJJty (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Mar 2022 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiCJJty (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Mar 2022 04:49:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D190313549B;
        Thu, 10 Mar 2022 01:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D25B1B823CC;
        Thu, 10 Mar 2022 09:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25545C340E8;
        Thu, 10 Mar 2022 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646905729;
        bh=s3BrDRq5APcnQHpwyGlEOzpxY5t1ApM8pFIOh3G2ZzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUnJoUj7yiQLIlPx2Yjsaku1L4x8eSMRnDRA2bGkOB98r2TubLcZWP/iPOkjuQKw2
         4RfJyOXnD7K9nYG8cDZSSwop+gMsFeSHU9VSxz974q2tgytic9jnTyQK6T95sGOK/N
         hOqsarRUK88EZGAq+lYdmnd47x9XYz7XJokgfdWmM+JBVzdAMGheGGosQUYdLwoiiA
         TXMsSfe+EwdljXlMT0XkjaRLRPglrN4R8kZXn0aLjVUM+ZssHi7hgXSCl7k2ypM0IK
         inxqTvBRxOru4r0oQX5Ikmdx1HEp+YRz7JEe30TwAn1E7pmOqbXYmSCYAwrTaau2xp
         Cl3pdVkizFy8Q==
Date:   Thu, 10 Mar 2022 11:48:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next] Revert "RDMA/core: Fix ib_qp_usecnt_dec()
 called when error"
Message-ID: <YinJfYLOrzzhPykO@unreal>
References: <74c11029adaf449b3b9228a77cc82f39e9e892c8.1646851220.git.leonro@nvidia.com>
 <18cd9e734496d2ab93cbe77d446fd33d@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18cd9e734496d2ab93cbe77d446fd33d@linux.dev>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 10, 2022 at 06:12:54AM +0000, Yajun Deng wrote:
> Hi, Leon.
> Can you test the attached patch?  If revert it, ib_qp_usecnt_dec() would called before ib_qp_usecnt_inc() when 
> create_xrc_qp_user() return error.

This patch brakes all RDMA drivers.

 [  682.237910] ------------[ cut here ]------------
 [  682.239060] WARNING: CPU: 3 PID: 12201 at drivers/infiniband/core/rdma_core.c:940 uverbs_destroy_ufile_hw+0x1f1/0x270 [ib_uverbs]
 [  682.241313] Modules linked in: bonding rdma_ucm mlx5_ib ib_uverbs mlx5_core nf_tables ib_ipoib ip_gre ib_umad ip6_gre gre ip6_tunnel tunnel6 geneve ipip tunnel4 iptable_raw openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink rpcrdma xt_addrtype ib_iser libiscsi scsi_transport_iscsi rdma_cm iptable_nat nf_nat iw_cm br_netfilter ib_cm ib_core overlay fuse [last unloaded: ib_uverbs]
 [  682.248018] CPU: 3 PID: 12201 Comm: ibv_rc_pingpong Not tainted 5.17.0-rc1_rdma_next_mlx_43b963c #1
 [  682.249942] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [  682.252117] RIP: 0010:uverbs_destroy_ufile_hw+0x1f1/0x270 [ib_uverbs]
 [  682.253453] Code: 3c 02 00 0f 85 8a 00 00 00 49 8b 85 10 01 00 00 48 85 c0 0f 84 0f ff ff ff 4c 89 e7 ff d0 e9 05 ff ff ff 0f 0b e9 75 ff ff ff <0f> 0b be 04 00 00 00 48 89 df e8 f0 e7 ff ff e9 a0 fe ff ff 4c 89
 [  682.256929] RSP: 0018:ffff88812779fcf0 EFLAGS: 00010206
 [  682.258058] RAX: ffff88811423b520 RBX: ffff888185d31000 RCX: ffffffffa09d1706
 [  682.259457] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88810cae21c0
 [  682.260838] RBP: 0000000000000001 R08: 0000000000000001 R09: ffff88810cae21c3
 [  682.262282] R10: ffffed102195c438 R11: 00000000ffffffff R12: ffff888185d31198
 [  682.263688] R13: ffffed1030ba6233 R14: ffff888185d310a0 R15: ffff888185d310c0
 [  682.265078] FS:  0000000000000000(0000) GS:ffff8882a3f80000(0000) knlGS:0000000000000000
 [  682.266767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  682.267948] CR2: 00007f715b6a6000 CR3: 0000000004226001 CR4: 0000000000370ea0
 [  682.269346] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [  682.270770] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [  682.272154] Call Trace:
 [  682.272769]  <TASK>
 [  682.273338]  ib_uverbs_close+0x4d/0x250 [ib_uverbs]
 [  682.274422]  __fput+0x1fc/0x8d0
 [  682.275184]  task_work_run+0xc5/0x160
 [  682.276007]  do_exit+0xa33/0x23f0
 [  682.276779]  ? vfs_write+0x3c7/0x8e0
 [  682.277625]  ? mm_update_next_owner+0x6d0/0x6d0
 [  682.278615]  ? ksys_write+0x176/0x1d0
 [  682.279448]  do_group_exit+0xb7/0x2a0
 [  682.280288]  __x64_sys_exit_group+0x3a/0x50
 [  682.281197]  do_syscall_64+0x3d/0x90
 [  682.282055]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [  682.283130] RIP: 0033:0x7f715b941181
 [  682.283949] Code: Unable to access opcode bytes at RIP 0x7f715b941157.
 [  682.285235] RSP: 002b:00007ffcf2b0d508 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
 [  682.286848] RAX: ffffffffffffffda RBX: 00007f715ba38470 RCX: 00007f715b941181
 [  682.288247] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
 [  682.289673] RBP: 0000000000000001 R08: ffffffffffffff80 R09: 0000000000000000
 [  682.291065] R10: 0000000000000002 R11: 0000000000000246 R12: 00007f715ba38470
 [  682.292441] R13: 0000000000000001 R14: 00007f715ba38948 R15: 0000000000000000
 [  682.293859]  </TASK>
 [  682.294450] irq event stamp: 65515
 [  682.295234] hardirqs last  enabled at (65523): [<ffffffff8147c1d7>] __up_console_sem+0x67/0x70
 [  682.296949] hardirqs last disabled at (65530): [<ffffffff8147c1bc>] __up_console_sem+0x4c/0x70
 [  682.298487] ------------[ cut here ]------------

Thanks

> 
> Thanks！
>  -- Yajun
> 
> March 10, 2022 2:42 AM, "Leon Romanovsky" <leon@kernel.org> wrote:
> 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This reverts commit 7c4a539ec38f4ce400a0f3fcb5ff6c940fcd67bb. which
> > causes to the following error in mlx4.
> > 
> > [ 679.401416] ------------[ cut here ]------------
> > [ 679.403542] Destroy of kernel CQ shouldn't fail
> > [ 679.403580] WARNING: CPU: 4 PID: 18064 at include/rdma/ib_verbs.h:3936
> > mlx4_ib_dealloc_xrcd+0x12e/0x1b0 [mlx4_ib]
> > [ 679.406534] Modules linked in: bonding ib_ipoib ip_gre ipip tunnel4 geneve rdma_ucm nf_tables
> > ib_umad mlx4_en mlx4_ib ib_uverbs mlx4_core ip6_gre gre ip6_tunnel tunnel6 iptable_raw openvswitch
> > nsh rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core xt_conntrack
> > xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay
> > fuse [last unloaded: mlx4_core]
> > [ 679.413323] CPU: 4 PID: 18064 Comm: ibv_xsrq_pingpo Not tainted 5.17.0-rc7_master_62c6ecb #1
> > [ 679.415043] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > [ 679.417285] RIP: 0010:mlx4_ib_dealloc_xrcd+0x12e/0x1b0 [mlx4_ib]
> > [ 679.418455] Code: 1e 93 08 00 40 80 fd 01 0f 87 fa f1 04 00 83 e5 01 0f 85 2b ff ff ff 48 c7 c7
> > 20 4f b6 a0 c6 05 fd 92 08 00 01 e8 47 c9 82 e2 <0f> 0b e9 11 ff ff ff 0f b6 2d eb 92 08 00 40 80
> > fd 01 0f 87 b1 f1
> > [ 679.421993] RSP: 0018:ffff8881a4957750 EFLAGS: 00010286
> > [ 679.423047] RAX: 0000000000000000 RBX: ffff8881ac4b6800 RCX: 0000000000000000
> > [ 679.424420] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed103492aedc
> > [ 679.425818] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8884d2e378eb
> > [ 679.427186] R10: ffffed109a5c6f1d R11: 0000000000000001 R12: ffff888132620000
> > [ 679.428553] R13: ffff8881a4957a90 R14: ffff8881aa2d4000 R15: ffff8881a4957ad0
> > [ 679.429939] FS: 00007f0401747740(0000) GS:ffff8884d2e00000(0000) knlGS:0000000000000000
> > [ 679.431548] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 679.432695] CR2: 000055f8ae036118 CR3: 000000012fe94005 CR4: 0000000000370ea0
> > [ 679.434099] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 679.435498] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 679.436914] Call Trace:
> > [ 679.437510] <TASK>
> > [ 679.438042] ib_dealloc_xrcd_user+0xce/0x120 [ib_core]
> > [ 679.439245] ib_uverbs_dealloc_xrcd+0xad/0x210 [ib_uverbs]
> > [ 679.440385] uverbs_free_xrcd+0xe8/0x190 [ib_uverbs]
> > [ 679.441453] destroy_hw_idr_uobject+0x7a/0x130 [ib_uverbs]
> > [ 679.442568] uverbs_destroy_uobject+0x164/0x730 [ib_uverbs]
> > [ 679.443699] uobj_destroy+0x72/0xf0 [ib_uverbs]
> > [ 679.444653] ib_uverbs_cmd_verbs+0x19fb/0x3110 [ib_uverbs]
> > [ 679.445805] ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [ 679.446893] ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
> > [ 679.448037] ? check_chain_key+0x24a/0x580
> > [ 679.448919] ? uverbs_fill_udata+0x540/0x540 [ib_uverbs]
> > [ 679.450040] ? check_chain_key+0x24a/0x580
> > [ 679.450934] ? remove_vma+0xca/0x100
> > [ 679.451736] ? lock_acquire+0x1b1/0x4c0
> > [ 679.452553] ? lock_acquire+0x1b1/0x4c0
> > [ 679.453393] ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
> > [ 679.454438] ? __might_fault+0xb8/0x160
> > [ 679.455267] ? lockdep_hardirqs_on_prepare+0x400/0x400
> > [ 679.456329] ib_uverbs_ioctl+0x169/0x260 [ib_uverbs]
> > [ 679.457384] ? ib_uverbs_ioctl+0x11e/0x260 [ib_uverbs]
> > [ 679.458443] ? ib_uverbs_cmd_verbs+0x3110/0x3110 [ib_uverbs]
> > [ 679.459598] ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> > [ 679.460689] ? mark_held_locks+0x9f/0xe0
> > [ 679.461577] __x64_sys_ioctl+0x856/0x1550
> > [ 679.462439] ? vfs_fileattr_set+0x9f0/0x9f0
> > [ 679.463328] ? __up_read+0x1a3/0x750
> > [ 679.464102] ? up_write+0x4a0/0x4a0
> > [ 679.464865] ? __vm_munmap+0x22e/0x2e0
> > [ 679.465690] ? __x64_sys_brk+0x840/0x840
> > [ 679.466519] ? __cond_resched+0x17/0x80
> > [ 679.467340] ? lockdep_hardirqs_on_prepare+0x286/0x400
> > [ 679.468373] ? syscall_enter_from_user_mode+0x1d/0x50
> > [ 679.469411] do_syscall_64+0x3d/0x90
> > [ 679.470174] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [ 679.471191] RIP: 0033:0x7f040191917b
> > [ 679.471961] Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66
> > 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00
> > f7 d8 64 89 01 48
> > [ 679.475467] RSP: 002b:00007ffce7c4a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [ 679.477014] RAX: ffffffffffffffda RBX: 00007ffce7c4a158 RCX: 00007f040191917b
> > [ 679.478434] RDX: 00007ffce7c4a140 RSI: 00000000c0181b01 RDI: 0000000000000003
> > [ 679.479840] RBP: 00007ffce7c4a120 R08: 000055f8ae02d080 R09: 0000000000000000
> > [ 679.481231] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffce7c4a120
> > [ 679.482630] R13: 00007ffce7c4a110 R14: 000055f8ae02f440 R15: 0000000000000000
> > [ 679.484003] </TASK>
> > [ 679.484535] irq event stamp: 62713
> > [ 679.485313] hardirqs last enabled at (62723): [<ffffffff81480f17>] __up_console_sem+0x67/0x70
> > [ 679.487019] hardirqs last disabled at (62730): [<ffffffff81480efc>] __up_console_sem+0x4c/0x70
> > [ 679.488734] softirqs last enabled at (62220): [<ffffffff8135679f>] __irq_exit_rcu+0x11f/0x170
> > [ 679.490569] softirqs last disabled at (62215): [<ffffffff8135679f>] __irq_exit_rcu+0x11f/0x170
> > [ 679.503168] ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: 7c4a539ec38f ("RDMA/core: Fix ib_qp_usecnt_dec() called when error")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > drivers/infiniband/core/uverbs_cmd.c | 1 +
> > drivers/infiniband/core/uverbs_std_types_qp.c | 1 +
> > drivers/infiniband/core/verbs.c | 3 ++-
> > 3 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 4437f834c0a7..6b6393176b3c 100644
> > --- a/drivers/infiniband/core/uverbs_cmd.c
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -1437,6 +1437,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
> > ret = PTR_ERR(qp);
> > goto err_put;
> > }
> > + ib_qp_usecnt_inc(qp);
> > 
> > obj->uevent.uobject.object = qp;
> > obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
> > diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c
> > b/drivers/infiniband/core/uverbs_std_types_qp.c
> > index 75353e09c6fe..dd1075466f61 100644
> > --- a/drivers/infiniband/core/uverbs_std_types_qp.c
> > +++ b/drivers/infiniband/core/uverbs_std_types_qp.c
> > @@ -254,6 +254,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
> > ret = PTR_ERR(qp);
> > goto err_put;
> > }
> > + ib_qp_usecnt_inc(qp);
> > 
> > if (attr.qp_type == IB_QPT_XRC_TGT) {
> > obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index bc9a83f1ca2d..a9819c40a140 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -1245,7 +1245,6 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
> > if (ret)
> > goto err_security;
> > 
> > - ib_qp_usecnt_inc(qp);
> > rdma_restrack_add(&qp->res);
> > return qp;
> > 
> > @@ -1346,6 +1345,8 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
> > if (IS_ERR(qp))
> > return qp;
> > 
> > + ib_qp_usecnt_inc(qp);
> > +
> > if (qp_init_attr->cap.max_rdma_ctxs) {
> > ret = rdma_rw_init_mrs(qp, qp_init_attr);
> > if (ret)
> > -- 
> > 2.35.1


