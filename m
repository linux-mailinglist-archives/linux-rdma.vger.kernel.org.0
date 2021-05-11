Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0382379F50
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 07:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEKFtz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 01:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKFtz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 01:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEB9D61924;
        Tue, 11 May 2021 05:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620712129;
        bh=0vu7TnipIFPap17p6MwNPF0JVPsTGf0Ut//jpNtU+/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9PSsygAnRAAYhp1cbYcbmyjb/SrcHxksFFpUTvtwpYoOm3c/su9AG18QEnYbgLhS
         nA9mS1It7Oi+1YVCEz5gtqTfTVlxFovwJMnsyk0r9k8lAQ3qQYwL4RzgRwIZ1U6DQa
         0DUAePzlqK0GX5fWG/W8K0uLB+uztYLIaFdn8G5jSX5lfticqn7MK1dNgRt+taSTyY
         UPGkIugbS387edXxFHqYq9zM76yzDQFyu2BgUC1uunIzb0/m1YMU67+XWE8m7oKwje
         mENGjLMxAWN4gSTr/uqkCsg+Lr6/dO6ZONZQ44P59xq1ojUgQbb8X15fFq6E9c9iz7
         tg6D9QkDZLV7Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-rc 5/5] RDMA/rxe: Return CQE error if invalid lkey was supplied
Date:   Tue, 11 May 2021 08:48:31 +0300
Message-Id: <11e7b553f3a6f5371c6bb3f57c494bb52b88af99.1620711734.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620711734.git.leonro@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The RXE is missing update of WQE status in LOCAL_WRITE failures.
This caused to the following kernel panic if someone sent atomic
operation with explicitly wrong lkey.

[leonro@vm ~]$ mkt test
test_atomic_invalid_lkey (tests.test_atomic.AtomicTest) ... [   43.860977] ------------[ cut here ]------------
 WARNING: CPU: 5 PID: 263 at drivers/infiniband/sw/rxe/rxe_comp.c:740 rxe_completer+0x1a6d/0x2e30 [rdma_rxe]
 Modules linked in: crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel rdma_ucm rdma_cm ib_umad ib_ipoib iw_cm ib_cm mlx5_ib ib_uverbs ib_core mlx5_core ptp pps_core
 CPU: 5 PID: 263 Comm: python3 Not tainted 5.13.0-rc1+ #2936
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:rxe_completer+0x1a6d/0x2e30 [rdma_rxe]
 Code: 03 0f 8e 65 0e 00 00 3b 93 10 06 00 00 0f 84 82 0a 00 00 4c 89 ff 4c 89 44 24 38 e8 2d 74 a9 e1 4c 8b 44 24 38 e9 1c f5 ff ff <0f> 0b e9 0c e8 ff ff b8 05 00 00 00 41 bf 05 00 00 00 e9 ab e7 ff
 RSP: 0018:ffff8880158af090 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff888016a78000 RCX: ffffffffa0cf1652
 RDX: 1ffff9200004b442 RSI: 0000000000000004 RDI: ffffc9000025a210
 RBP: dffffc0000000000 R08: 00000000ffffffea R09: ffff88801617740b
 R10: ffffed1002c2ee81 R11: 0000000000000007 R12: ffff88800f3b63e8
 R13: ffff888016a78008 R14: ffffc9000025a180 R15: 000000000000000c
 FS:  00007f88b622a740(0000) GS:ffff88806d540000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f88b5a1fa10 CR3: 000000000d848004 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? lock_release+0x1f9/0x6c0
  ? rxe_comp_queue_pkt+0xb0/0xb0 [rdma_rxe]
  ? lock_downgrade+0x6d0/0x6d0
  ? lock_downgrade+0x6d0/0x6d0
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  ? _raw_spin_unlock_irqrestore+0x2d/0x40
  ? rxe_comp_queue_pkt+0xb0/0xb0 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  ? _raw_spin_unlock_irqrestore+0x2d/0x40
  rxe_rcv+0xb11/0x1df0 [rdma_rxe]
  ? rxe_crc32.isra.0+0x120/0x120 [rdma_rxe]
  ? prepare_ack_packet+0x50b/0xa20 [rdma_rxe]
  rxe_loopback+0x157/0x1e0 [rdma_rxe]
  ? rxe_send+0x520/0x520 [rdma_rxe]
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  rxe_responder+0x5532/0x7620 [rdma_rxe]
  ? rxe_resp_queue_pkt+0xa0/0xa0 [rdma_rxe]
  ? lock_downgrade+0x6d0/0x6d0
  ? rxe_crc32.isra.0+0x8e/0x120 [rdma_rxe]
  ? lock_is_held_type+0x98/0x110
  ? find_held_lock+0x2d/0x110
  ? lock_release+0x1f9/0x6c0
  ? rxe_do_task+0xe5/0x230 [rdma_rxe]
  ? lock_downgrade+0x6d0/0x6d0
  ? rxe_resp_queue_pkt+0x19/0xa0 [rdma_rxe]
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  ? _raw_spin_unlock_irqrestore+0x2d/0x40
  ? rxe_resp_queue_pkt+0xa0/0xa0 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_rcv+0x9c8/0x1df0 [rdma_rxe]
  ? __kmalloc_track_caller+0x174/0x390
  ? rxe_crc32.isra.0+0x120/0x120 [rdma_rxe]
  rxe_loopback+0x157/0x1e0 [rdma_rxe]
  ? rxe_send+0x520/0x520 [rdma_rxe]
  rxe_requester+0x1efd/0x58c0 [rdma_rxe]
  ? lock_is_held_type+0x98/0x110
  ? find_held_lock+0x2d/0x110
  ? rnr_nak_timer+0x70/0x70 [rdma_rxe]
  ? lock_release+0x1f9/0x6c0
  ? rxe_do_task+0xe5/0x230 [rdma_rxe]
  ? lock_downgrade+0x6d0/0x6d0
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  ? _raw_spin_unlock_irqrestore+0x2d/0x40
  ? rnr_nak_timer+0x70/0x70 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  ? rxe_poll_cq+0x450/0x450 [rdma_rxe]
  rxe_post_send+0x998/0x1860 [rdma_rxe]
  ? lock_is_held_type+0x98/0x110
  ? lock_is_held_type+0x98/0x110
  ? rdma_lookup_get_uobject+0x22c/0x4a0 [ib_uverbs]
  ? rxe_poll_cq+0x450/0x450 [rdma_rxe]
  ib_uverbs_post_send+0xd5f/0x1220 [ib_uverbs]
  ? lock_acquire+0x1a9/0x6d0
  ? lock_is_held_type+0x98/0x110
  ? ib_uverbs_ex_create_wq+0xb00/0xb00 [ib_uverbs]
  ? lock_release+0x1f9/0x6c0
  ? __might_fault+0xba/0x160
  ? lock_downgrade+0x6d0/0x6d0
  ib_uverbs_write+0x847/0xc80 [ib_uverbs]
  ? ib_uverbs_open+0x810/0x810 [ib_uverbs]
  ? vfs_fileattr_set+0x990/0x990
  ? __up_read+0x1a1/0x7b0
  vfs_write+0x1c5/0x840
  ksys_write+0x176/0x1d0
  ? __x64_sys_read+0xb0/0xb0
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  ? syscall_enter_from_user_mode+0x1d/0x50
  do_syscall_64+0x3f/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f88b64917a7
 Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
 RSP: 002b:00007ffee189e6c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 000055c17c8b2660 RCX: 00007f88b64917a7
 RDX: 0000000000000020 RSI: 00007ffee189e6e0 RDI: 0000000000000003
 RBP: 0000000000000000 R08: 00007f88b5cbbc80 R09: 00007f88b689fdc0
 R10: 00007f88b66a0510 R11: 0000000000000246 R12: 00007f88b6072180
 R13: 0000000000000000 R14: 00007f88b5e6e9d0 R15: 0000000000000008
 irq event stamp: 809719
 hardirqs last  enabled at (809727): [<ffffffff813990c4>] console_unlock+0x434/0x850
 hardirqs last disabled at (809734): [<ffffffff81399279>] console_unlock+0x5e9/0x850
 softirqs last  enabled at (809016): [<ffffffff8129089e>] irq_exit_rcu+0x11e/0x1a0
 softirqs last disabled at (808963): [<ffffffff8129089e>] irq_exit_rcu+0x11e/0x1a0
 ---[ end trace 1e302e4b7857843b ]---

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 2af26737d32d..a6712e373eed 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -346,13 +346,15 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
 			payload_size(pkt), to_mr_obj, NULL);
-	if (ret)
+	if (ret) {
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
+	}
 
 	if (wqe->dma.resid == 0 && (pkt->mask & RXE_END_MASK))
 		return COMPST_COMP_ACK;
-	else
-		return COMPST_UPDATE_COMP;
+
+	return COMPST_UPDATE_COMP;
 }
 
 static inline enum comp_state do_atomic(struct rxe_qp *qp,
@@ -366,10 +368,12 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
 			sizeof(u64), to_mr_obj, NULL);
-	if (ret)
+	if (ret) {
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
-	else
-		return COMPST_COMP_ACK;
+	}
+
+	return COMPST_COMP_ACK;
 }
 
 static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-- 
2.31.1

