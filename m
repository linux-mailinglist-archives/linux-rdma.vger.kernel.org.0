Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF17A232EAE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgG3I1g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbgG3I1f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:27:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3D4207F5;
        Thu, 30 Jul 2020 08:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596097654;
        bh=H/8EMuhrXH/h2zIP3avi6Ss+lAtm9ceAZC3EG8SMmdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSXhNo5D3TlVQ97JSbXtnaLVoPKdAwMU8FZ4BR8047ufNAAk5FbHun2pox0FI4Xpd
         sR2u3AU0Tq1SepMoWKyFECIbJH7v1pEzDRfg2oZ9lfp5pOk0gutm9mKiXQbobH6Uqw
         QAV2ohkH2MgGKNzWTMkTVvBPHz0UT0dnyzluAWtE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 1/3] RDMA/mlx5: Initialize QP mutex for the debug kernels
Date:   Thu, 30 Jul 2020 11:27:17 +0300
Message-Id: <20200730082719.1582397-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730082719.1582397-1-leon@kernel.org>
References: <20200730082719.1582397-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

In DCT and RSS RAW QP creation flows, the QP mutex wasn't initialized
and the magic field inside lock was missing. This caused to the following
kernel warning for kernels build with CONFIG_DEBUG_MUTEXES.

 ------------[ cut here ]------------
 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 3 PID: 16261 at kernel/locking/mutex.c:938 __mutex_lock+0x60e/0x940
 Modules linked in: bonding nf_tables ipip tunnel4 geneve ip6_udp_tunnel udp_tunnel ip6_gre ip6_tunnel tunnel6 ip_gre gre ip_tunnel mlx5_ib mlx5_core mlxfw ptp pps_core rdma_ucm ib_uverbs ib_ipoib ib_umad openvswitch nsh xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype xt_conntrack nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay ib_srp scsi_transport_srp rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core [last unloaded: mlxfw]
 CPU: 3 PID: 16261 Comm: ib_send_bw Not tainted 5.8.0-rc4_for_upstream_min_debug_2020_07_08_22_04 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__mutex_lock+0x60e/0x940
 Code: c0 0f 84 6d fa ff ff 44 8b 15 4e 9d ba 00 45 85 d2 0f 85 5d fa ff ff 48 c7 c6 f2 de 2b 82 48 c7 c7 f1 8a 2b 82 e8 d2 4d 72 ff <0f> 0b 4c 8b 4d 88 e9 3f fa ff ff f6 c2 04 0f 84 37 fe ff ff 48 89
 RSP: 0018:ffff88810bb8b870 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: ffff88829f1dd880 RSI: 0000000000000000 RDI: ffffffff81192afa
 RBP: ffff88810bb8b910 R08: 0000000000000000 R09: 0000000000000028
 R10: 0000000000000000 R11: 0000000000003f85 R12: 0000000000000002
 R13: ffff88827d8d3ce0 R14: ffffffffa059f615 R15: ffff8882a4d02610
 FS:  00007f3f6988e740(0000) GS:ffff8882f5b80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000556556158000 CR3: 000000010a63c005 CR4: 0000000000360ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? cmd_exec+0x947/0xe60 [mlx5_core]
  ? __mutex_lock+0x76/0x940
  ? mlx5_ib_qp_set_counter+0x25/0xa0 [mlx5_ib]
  mlx5_ib_qp_set_counter+0x25/0xa0 [mlx5_ib]
  mlx5_ib_counter_bind_qp+0x9b/0xe0 [mlx5_ib]
  __rdma_counter_bind_qp+0x6b/0xa0 [ib_core]
  rdma_counter_bind_qp_auto+0x363/0x520 [ib_core]
  _ib_modify_qp+0x316/0x580 [ib_core]
  ib_modify_qp_with_udata+0x19/0x30 [ib_core]
  modify_qp+0x4c4/0x600 [ib_uverbs]
  ib_uverbs_ex_modify_qp+0x87/0xe0 [ib_uverbs]
  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x129/0x1c0 [ib_uverbs]
  ib_uverbs_cmd_verbs.isra.5+0x5d5/0x11f0 [ib_uverbs]
  ? ib_uverbs_handler_UVERBS_METHOD_QUERY_CONTEXT+0x120/0x120 [ib_uverbs]
  ? lock_acquire+0xb9/0x3a0
  ? ib_uverbs_ioctl+0xd0/0x210 [ib_uverbs]
  ? ib_uverbs_ioctl+0x175/0x210 [ib_uverbs]
  ib_uverbs_ioctl+0x14b/0x210 [ib_uverbs]
  ? ib_uverbs_ioctl+0xd0/0x210 [ib_uverbs]
  ksys_ioctl+0x234/0x7d0
  ? exc_page_fault+0x202/0x640
  ? do_syscall_64+0x1f/0x2e0
  __x64_sys_ioctl+0x16/0x20
  do_syscall_64+0x59/0x2e0
  ? asm_exc_page_fault+0x8/0x30
  ? rcu_read_lock_sched_held+0x52/0x60
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f3f683be267
 Code: Bad RIP value.
 RSP: 002b:00007ffe3bd0bd08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007ffe3bd0bd98 RCX: 00007f3f683be267
 RDX: 00007ffe3bd0bd80 RSI: 00000000c0181b01 RDI: 0000000000000003
 RBP: 00007ffe3bd0bd60 R08: 0000000000000005 R09: 00007f3f6985c010
 R10: 0000000000001000 R11: 0000000000000246 R12: 00007f3f6985c150
 R13: 00007ffe3bd0bd60 R14: 00007ffe3bd0c098 R15: 0000000000000070
 irq event stamp: 17737
 hardirqs last  enabled at (17737): [<ffffffff812e93e2>] kfree+0x142/0x2d0
 hardirqs last disabled at (17736): [<ffffffff812e936c>] kfree+0xcc/0x2d0
 softirqs last  enabled at (16718): [<ffffffff81e002c9>] __do_softirq+0x2c9/0x436
 softirqs last disabled at (16709): [<ffffffff81c00f0f>] asm_call_on_stack+0xf/0x20
 ---[ end trace b82d36d6a8e5bff9 ]---

Fixes: b4aaa1f0b415 ("IB/mlx5: Handle type IB_QPT_DRIVER when creating a QP")
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 42620f88e393..1225b8d77510 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1852,8 +1852,6 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	u32 *in;
 	int err;
 
-	mutex_init(&qp->mutex);
-
 	if (attr->sq_sig_type == IB_SIGNAL_ALL_WR)
 		qp->sq_signal_bits = MLX5_WQE_CTRL_CQ_UPDATE;
 
@@ -1937,7 +1935,6 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	u32 *in;
 	int err;
 
-	mutex_init(&qp->mutex);
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 
@@ -2128,7 +2125,6 @@ static int create_kernel_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	u32 *in;
 	int err;
 
-	mutex_init(&qp->mutex);
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 
@@ -2969,6 +2965,7 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 		goto free_ucmd;
 	}
 
+	mutex_init(&qp->mutex);
 	qp->type = type;
 	if (udata) {
 		err = process_vendor_flags(dev, qp, params.ucmd, attr);
-- 
2.26.2

