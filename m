Return-Path: <linux-rdma+bounces-7088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D08A161A7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94421161DBC
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142181BD017;
	Sun, 19 Jan 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amQYombb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A9157A5C
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290185; cv=none; b=XHhFzUwikb+LluMQoouxarY+Tp2+J7q1D/RavxuFNTnChtjSjjIKhfqcdNoTE+43tq2Kqs6WThiG28PzBjHtAfPmDRH9PL9LZ0ucA8ioeD46vTode1ZH+LRrt82iYlDmSr0gDCn+2kZ9i6QMMZtO3oRxMJKLRNTFu0XI5+q5U5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290185; c=relaxed/simple;
	bh=ShTgWkCAVBpAA0mH5LXAS6EJhh9b2YCQZxoGCPDFjeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoWqjQ6dHCE0RNv1pG0wDpurLQWpuFYS/7WQddPLpeWc7d2pwFOW7qTwH+jXbFfOvEop7M7ie0kteHG6rF3Zzu2TH/Vn6XHOSTzgvwM3qPiHBBL7JqyBL4RaKDB/xCCw1eCvDGxjMYwlOCoi7KjVj8fdv+ihAk0ympiOtGQDzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amQYombb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B97C4CED6;
	Sun, 19 Jan 2025 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737290185;
	bh=ShTgWkCAVBpAA0mH5LXAS6EJhh9b2YCQZxoGCPDFjeA=;
	h=From:To:Cc:Subject:Date:From;
	b=amQYombbjt37Ixjl4aeNo0vwGeOfhkVRSY6KPYVltfrqDulosGdIr2fsLBhwaE03O
	 0hvw0UOodlx1+l1ulTNIH7O09Jss6Xq0JYtlynR/tTIL9L7+JVZsfHbvSpZzCWJd0q
	 1XjbTaNqlOewcESIFqHVltr2nbS4j05MovC+n3Y5B/AVMgINhmFZQLd6dflabUfQ4s
	 93D6zNaYzgy1TVOuGSr+4/nUkeYQ2E6sN9nke1Y6s+caCePML0PMB5YaWm17MJNtMB
	 cSmsxEfbcq6QPsLgRLu/IuSlDize/Kr3eAMusobAZLDTmzU5alq6QOIyBb+fTrf9Vo
	 eyA81z3xvplDQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Aharon Landau <aharonl@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix the recovery flow of the UMR QP
Date: Sun, 19 Jan 2025 14:36:13 +0200
Message-ID: <27b51b92ec42dfb09d8096fcbd51878f397ce6ec.1737290141.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

This patch addresses an issue in the recovery flow of the UMR QP,
ensuring tasks do not get stuck, as highlighted by the call trace [1].

During recovery, before transitioning the QP to the RESET state, the
software must wait for all outstanding WRs to complete.

Failing to do so can cause the firmware to skip sending some flushed
CQEs with errors and simply discard them upon the RESET, as per the IB
specification.

This race condition can result in lost CQEs and tasks becoming stuck.

To resolve this, the patch sends a final WR which serves only as a
barrier before moving the QP state to RESET.

Once a CQE is received for that final WR, it guarantees that no
outstanding WRs remain, making it safe to transition the QP to RESET and
subsequently back to RTS, restoring proper functionality.

Note:
For the barrier WR, we simply reuse the failed and ready WR.
Since the QP is in an error state, it will only receive
IB_WC_WR_FLUSH_ERR. However, as it serves only as a barrier we don't
care about its status.

[1]
INFO: task rdma_resource_l:1922 blocked for more than 120 seconds.
Tainted: G        W          6.12.0-rc7+ #1626
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rdma_resource_l state:D stack:0  pid:1922 tgid:1922  ppid:1369
     flags:0x00004004
Call Trace:
<TASK>
__schedule+0x420/0xd30
schedule+0x47/0x130
schedule_timeout+0x280/0x300
? mark_held_locks+0x48/0x80
? lockdep_hardirqs_on_prepare+0xe5/0x1a0
wait_for_completion+0x75/0x130
mlx5r_umr_post_send_wait+0x3c2/0x5b0 [mlx5_ib]
? __pfx_mlx5r_umr_done+0x10/0x10 [mlx5_ib]
mlx5r_umr_revoke_mr+0x93/0xc0 [mlx5_ib]
__mlx5_ib_dereg_mr+0x299/0x520 [mlx5_ib]
? _raw_spin_unlock_irq+0x24/0x40
? wait_for_completion+0xfe/0x130
? rdma_restrack_put+0x63/0xe0 [ib_core]
ib_dereg_mr_user+0x5f/0x120 [ib_core]
? lock_release+0xc6/0x280
destroy_hw_idr_uobject+0x1d/0x60 [ib_uverbs]
uverbs_destroy_uobject+0x58/0x1d0 [ib_uverbs]
uobj_destroy+0x3f/0x70 [ib_uverbs]
ib_uverbs_cmd_verbs+0x3e4/0xbb0 [ib_uverbs]
? __pfx_uverbs_destroy_def_handler+0x10/0x10 [ib_uverbs]
? __lock_acquire+0x64e/0x2080
? mark_held_locks+0x48/0x80
? find_held_lock+0x2d/0xa0
? lock_acquire+0xc1/0x2f0
? ib_uverbs_ioctl+0xcb/0x170 [ib_uverbs]
? __fget_files+0xc3/0x1b0
ib_uverbs_ioctl+0xe7/0x170 [ib_uverbs]
? ib_uverbs_ioctl+0xcb/0x170 [ib_uverbs]
__x64_sys_ioctl+0x1b0/0xa70
do_syscall_64+0x6b/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f99c918b17b
RSP: 002b:00007ffc766d0468 EFLAGS: 00000246 ORIG_RAX:
     0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc766d0578 RCX:
     00007f99c918b17b
RDX: 00007ffc766d0560 RSI: 00000000c0181b01 RDI:
     0000000000000003
RBP: 00007ffc766d0540 R08: 00007f99c8f99010 R09:
     000000000000bd7e
R10: 00007f99c94c1c70 R11: 0000000000000246 R12:
     00007ffc766d0530
R13: 000000000000001c R14: 0000000040246a80 R15:
     0000000000000000
</TASK>

Fixes: 158e71bb69e3 ("RDMA/mlx5: Add a umr recovery flow")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 83 +++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index d7fa94ab23cf..5be4426a2884 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -231,30 +231,6 @@ void mlx5r_umr_cleanup(struct mlx5_ib_dev *dev)
 	ib_dealloc_pd(dev->umrc.pd);
 }
 
-static int mlx5r_umr_recover(struct mlx5_ib_dev *dev)
-{
-	struct umr_common *umrc = &dev->umrc;
-	struct ib_qp_attr attr;
-	int err;
-
-	attr.qp_state = IB_QPS_RESET;
-	err = ib_modify_qp(umrc->qp, &attr, IB_QP_STATE);
-	if (err) {
-		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
-		goto err;
-	}
-
-	err = mlx5r_umr_qp_rst2rts(dev, umrc->qp);
-	if (err)
-		goto err;
-
-	umrc->state = MLX5_UMR_STATE_ACTIVE;
-	return 0;
-
-err:
-	umrc->state = MLX5_UMR_STATE_ERR;
-	return err;
-}
 
 static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 			       struct mlx5r_umr_wqe *wqe, bool with_data)
@@ -302,6 +278,61 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 	return err;
 }
 
+static int mlx5r_umr_recover(struct mlx5_ib_dev *dev, u32 mkey,
+			     struct mlx5r_umr_context *umr_context,
+			     struct mlx5r_umr_wqe *wqe, bool with_data)
+{
+	struct umr_common *umrc = &dev->umrc;
+	struct ib_qp_attr attr;
+	int err;
+
+	mutex_lock(&umrc->lock);
+	/* Preventing any further WRs to be sent now */
+	if (umrc->state != MLX5_UMR_STATE_RECOVER) {
+		mlx5_ib_warn(dev, "UMR recovery encountered an unexpected state=%d\n",
+			     umrc->state);
+		umrc->state = MLX5_UMR_STATE_RECOVER;
+	}
+	mutex_unlock(&umrc->lock);
+
+	/* Sending a final/barrier WR (the failed one) and wait for its completion.
+	 * This will ensure that all the previous WRs got a completion before
+	 * we set the QP state to RESET.
+	 */
+	err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context->cqe, wqe,
+				  with_data);
+	if (err) {
+		mlx5_ib_warn(dev, "UMR recovery post send failed, err %d\n", err);
+		goto err;
+	}
+
+	/* Since the QP is in an error state, it will only receive
+	 * IB_WC_WR_FLUSH_ERR. However, as it serves only as a barrier
+	 * we don't care about its status.
+	 */
+	wait_for_completion(&umr_context->done);
+
+	attr.qp_state = IB_QPS_RESET;
+	err = ib_modify_qp(umrc->qp, &attr, IB_QP_STATE);
+	if (err) {
+		mlx5_ib_warn(dev, "Couldn't modify UMR QP to RESET, err=%d\n", err);
+		goto err;
+	}
+
+	err = mlx5r_umr_qp_rst2rts(dev, umrc->qp);
+	if (err) {
+		mlx5_ib_warn(dev, "Couldn't modify UMR QP to RTS, err=%d\n", err);
+		goto err;
+	}
+
+	umrc->state = MLX5_UMR_STATE_ACTIVE;
+	return 0;
+
+err:
+	umrc->state = MLX5_UMR_STATE_ERR;
+	return err;
+}
+
 static void mlx5r_umr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct mlx5_ib_umr_context *context =
@@ -366,9 +397,7 @@ static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
 		mlx5_ib_warn(dev,
 			"reg umr failed (%u). Trying to recover and resubmit the flushed WQEs, mkey = %u\n",
 			umr_context.status, mkey);
-		mutex_lock(&umrc->lock);
-		err = mlx5r_umr_recover(dev);
-		mutex_unlock(&umrc->lock);
+		err = mlx5r_umr_recover(dev, mkey, &umr_context, wqe, with_data);
 		if (err)
 			mlx5_ib_warn(dev, "couldn't recover UMR, err %d\n",
 				     err);
-- 
2.47.1


