Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB181435
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2019 10:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfHEIaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Aug 2019 04:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEIaR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Aug 2019 04:30:17 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC4B2067D;
        Mon,  5 Aug 2019 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564993816;
        bh=B0kAIT3BOdhbskDsdQpdYykJgPzpXjnvzPreyxgcUPY=;
        h=From:To:Cc:Subject:Date:From;
        b=KYKrUyGH4hjMGxR5Xa7sG8eh/oBqbI+6nbcmufJA/SP0b6KgerX4tIHJXnxzymAOz
         Xtpe3x7XF91qocz5IeHxefkYDtr9oO3LM0Y3nX0AZ3/EcaLWDwnGCwcGjIAxFAynwO
         GIFwpYrwJ9NMouAfBD5W4HQE3rsmGcgBVaaCXV08=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] IB/mlx5: Fix implicit MR release flow
Date:   Mon,  5 Aug 2019 11:30:10 +0300
Message-Id: <20190805083010.21777-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Once implicit MR is being called to be released by
ib_umem_notifier_release() its leaves were marked as "dying".

However, when dereg_mr()->mlx5_ib_free_implicit_mr()->mr_leaf_free() is
called, it skips running the mr_leaf_free_action (i.e. umem_odp->work)
when those leaves were marked as "dying".

As such ib_umem_release() for the leaves won't be called and their MRs
will be leaked as well.

When an application exits/killed without calling dereg_mr we might hit
the above flow.

This fatal scenario is reported by WARN_ON() upon
mlx5_ib_dealloc_ucontext() as ibcontext->per_mm_list is not empty, the
call trace can be seen below.

Originally the "dying" mark as part of ib_umem_notifier_release() was
introduced to prevent pagefault_mr() from returning a success response
once this happened. However, we already have today the completion
mechanism so no need for that in those flows any more.  Even in case a
success response will be returned the firmware will not find the pages
and an error will be returned in the following call as a released mm
will cause ib_umem_odp_map_dma_pages() to permanently fail
mmget_not_zero().

Fix the above issue by dropping the "dying" from the above flows.  The
other flows that are using "dying" are still needed it for their
synchronization purposes.

WARNING: CPU: 1 PID: 7218 at
drivers/infiniband/hw/mlx5/main.c:2004
               mlx5_ib_dealloc_ucontext+0x84/0x90 [mlx5_ib]
CPU: 1 PID: 7218 Comm: ibv_rc_pingpong Tainted: G     E
            5.2.0-rc6+ #13
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
RIP: 0010:mlx5_ib_dealloc_ucontext+0x84/0x90 [mlx5_ib]
Code: 8d bd e8 09 00 00 48 89 de e8 58 a1 ff ff 48 8b bb
      c8 00 00 00 e8 ec 8b 3a c9 48 8b bb d8 00 00 00 5b 5d 41
      5c e9 dc 8b 3a c9 <0f> 0b eb a0 0f 1f 84 00 00 00 00 00
      66 66 66 66 90 41 57 b9 09 00
RSP: 0018:ffffb8e4c0adbc48 EFLAGS: 00010297
RAX: ffff9e1a791a65b8 RBX: ffff9e1a643c1e00 RCX:
     0000000000000000
RDX: ffff9e1a643c1e40 RSI: 0000000000000246 RDI:
     ffff9e1a643c1e20
RBP: ffff9e1a75b70000 R08: 0000000000000000 R09:
     ffff9e1a643c1e50
R10: 0000000000000000 R11: 0000000000000001 R12:
     ffff9e1a643c1e20
R13: ffff9e1a5da6bc10 R14: ffff9e1a5da6bc70 R15:
     ffff9e1a75b70000
FS:  00007ff61835d740(0000) GS:ffff9e1a7bb00000(0000)
     knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e6ac34000 CR3: 000000011e41e000 CR4:
     00000000000006e0
Call Trace:
uverbs_destroy_ufile_hw+0xb5/0x120 [ib_uverbs]
ib_uverbs_close+0x1f/0x80 [ib_uverbs]
__fput+0xbe/0x250
task_work_run+0x88/0xa0
do_exit+0x2cb/0xc30
? __fput+0x14b/0x250
do_group_exit+0x39/0xb0
get_signal+0x191/0x920
? _raw_spin_unlock_bh+0xa/0x20
? inet_csk_accept+0x229/0x2f0
do_signal+0x36/0x5e0
? put_unused_fd+0x5b/0x70
? __sys_accept4+0x1a6/0x1e0
? inet_hash+0x35/0x40
? release_sock+0x43/0x90
? _raw_spin_unlock_bh+0xa/0x20
? inet_listen+0x9f/0x120
exit_to_usermode_loop+0x5c/0xc6
do_syscall_64+0x182/0x1b0
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff617c807d0
Code: Bad RIP value.
RSP: 002b:00007ffd1f4f7c68 EFLAGS: 00000246 ORIG_RAX:
     000000000000002b
RAX: fffffffffffffe00 RBX: 00007ffd1f4f7dd0 RCX:
     00007ff617c807d0
RDX: 0000000000000000 RSI: 0000000000000000 RDI:
     0000000000000005
RBP: 00007ffd1f4f7fd0 R08: 0000000000000000 R09:
     0000000001327f50
R10: 00007ffd1f4f7830 R11: 0000000000000246 R12:
     0000000001327600
R13: 00007ffd1f4f7e10 R14: 0000000001327fb0 R15:
     0000000000000005
[ end trace 4fa29cb158fefa46 ]

Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c |  4 ----
 drivers/infiniband/hw/mlx5/odp.c   | 23 ++++++++---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 2a75c6f8d827..c0e15db34680 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -112,10 +112,6 @@ static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
 	 * prevent any further fault handling on this MR.
 	 */
 	ib_umem_notifier_start_account(umem_odp);
-	umem_odp->dying = 1;
-	/* Make sure that the fact the umem is dying is out before we release
-	 * all pending page faults. */
-	smp_wmb();
 	complete_all(&umem_odp->notifier_completion);
 	umem_odp->umem.context->invalidate_range(
 		umem_odp, ib_umem_start(umem_odp), ib_umem_end(umem_odp));
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 81da82050d05..d2492a77efb8 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -579,7 +579,6 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 			u32 flags)
 {
 	int npages = 0, current_seq, page_shift, ret, np;
-	bool implicit = false;
 	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	bool prefetch = flags & MLX5_PF_FLAGS_PREFETCH;
@@ -594,7 +593,6 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 		if (IS_ERR(odp))
 			return PTR_ERR(odp);
 		mr = odp->private;
-		implicit = true;
 	} else {
 		odp = odp_mr;
 	}
@@ -682,19 +680,14 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 
 out:
 	if (ret == -EAGAIN) {
-		if (implicit || !odp->dying) {
-			unsigned long timeout =
-				msecs_to_jiffies(MMU_NOTIFIER_TIMEOUT);
-
-			if (!wait_for_completion_timeout(
-					&odp->notifier_completion,
-					timeout)) {
-				mlx5_ib_warn(dev, "timeout waiting for mmu notifier. seq %d against %d. notifiers_count=%d\n",
-					     current_seq, odp->notifiers_seq, odp->notifiers_count);
-			}
-		} else {
-			/* The MR is being killed, kill the QP as well. */
-			ret = -EFAULT;
+		unsigned long timeout =
+			msecs_to_jiffies(MMU_NOTIFIER_TIMEOUT);
+
+		if (!wait_for_completion_timeout(
+				&odp->notifier_completion,
+				timeout)) {
+			mlx5_ib_warn(dev, "timeout waiting for mmu notifier. seq %d against %d. notifiers_count=%d\n",
+				     current_seq, odp->notifiers_seq, odp->notifiers_count);
 		}
 	}
 
-- 
2.20.1

