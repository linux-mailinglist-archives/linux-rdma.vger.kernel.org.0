Return-Path: <linux-rdma+bounces-7089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C2A161A8
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456423A5EF2
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBE1D2F53;
	Sun, 19 Jan 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Z3uDtz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8474157A5C
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290313; cv=none; b=ak8Hl/rKfDE+B8RE0izCTvpjo6d+3tsKvt+e+/eDAJhcLcXD1V0BF5NNDr1VnbTy/7Cwabs1gIJlEPKCtBPxQ1bkyKuo+qlNNp1N1Rm+s0t8qczXJcTnXQgu8/78bZMUKyMG4+AiRygqrYF8Fxj8FykMmEhPSh57NCv0rrIWN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290313; c=relaxed/simple;
	bh=/EgBuTR0ltYvcSkVcV4YB74s+4/T4RIDuDSG5LNB06I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuVkn3OFSYuefGR62yREKluZCSZFjh9PGAGmPrgbyfx4UoVVCr4mi0Wz/VWncmJ2/AMYXkBmHA1YWNB+xQo7ZYp5HXrInJ83qmBsVmg2FHCi5OnQbHxUUEoT3yJOSkYSErd2jfBYznZySQ9p/vl/qrbpu9SnvsypFfQuCR175II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Z3uDtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3740C4CED6;
	Sun, 19 Jan 2025 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737290313;
	bh=/EgBuTR0ltYvcSkVcV4YB74s+4/T4RIDuDSG5LNB06I=;
	h=From:To:Cc:Subject:Date:From;
	b=G9Z3uDtz6T5gC0Yc74z+n8szund8Q8lGaU9hoIL1QJVgd4OGVFA3sM+hU3vndKAGn
	 3KftBf4lggTUDApM2iPWeIw98CPi78vUGtD7+bDPa6XXLRc82QLQHwnfYae+EUkWBY
	 p/qO/0Rt4y+j6sS+mhJdlRuOoYhGi58HMIwp4ZYKR5WnYI6LoAA8II9IwmtFA2IURW
	 emOqKSVUZWfcFqxICHMHgRTJD3ODZ2eL89FY2Ncp3Ao8+nfQKwQb0X408r9+yfDefQ
	 /jnqB82Da7w11WFkr2jRIgXfm1fdRM/S7T6wHTjvrB+X0vLwuiIeuTy0B4E8OvX0VF
	 9DPCc0pWFaQUg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with error
Date: Sun, 19 Jan 2025 14:38:25 +0200
Message-ID: <68a1e007c25b2b8fe5d625f238cc3b63e5341f77.1737290229.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

This patch addresses a race condition for an ODP MR that can result in a
CQE with an error on the UMR QP.

During the __mlx5_ib_dereg_mr() flow, the following sequence of calls occurs:
mlx5_revoke_mr()
mlx5r_umr_revoke_mr()
mlx5r_umr_post_send_wait()
At this point, the lkey is freed from the hardware's perspective.

However, concurrently, mlx5_ib_invalidate_range() might be triggered by
another task attempting to invalidate a range for the same freed lkey.

This task will:
Acquire the umem_odp->umem_mutex lock.
Call mlx5r_umr_update_xlt() on the UMR QP.
Since the lkey has already been freed, this can lead to a CQE error,
causing the UMR QP to enter an error state [1].

To resolve this race condition, the umem_odp->umem_mutex lock is now
also acquired as part of the mlx5_revoke_mr() scope.
Upon successful, we set umem_odp->private which points to that MR to
NULL, preventing any further invalidation attempts on its lkey.

[1] From dmesg:

infiniband rocep8s0f0: dump_cqe:277:(pid 0): WC error: 6,
Message: memory bind operation error
cqe_dump: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00
                    00 00 00
cqe_dump: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00
                    00 00 00
cqe_dump: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00
                    00 00 00
cqe_dump: 00000030: 00 00 00 00 08 00 78 06 25 00 11 b9 00
                    0e dd d2
------------[ cut here ]------------
WARNING: CPU: 15 PID: 1506 at
drivers/infiniband/hw/mlx5/umr.c:394
mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
          Modules linked in: ip6table_mangle ip6table_nat
ip6table_filter ip6_tables iptable_mangle xt_conntrack xt_MASQUERADE
nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat
br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma
rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_umad
ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core fuse mlx5_core
CPU: 15 UID: 0 PID: 1506 Comm: ibv_rc_pingpong Not tainted
        6.12.0-rc7+ #1626
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
               rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
Code: 89 c4 e8 19 a9 92 e1 45 85 e4 0f 85 2f 01 00 00 48
8d 7c 24 18 e8 06 a5 92 e1 44 8b 4c 24 10 45 85 c9 74 5c 41 83 f9 05 74
96 <0f> 0b 65 48 8b 05 5c 5b 9f 5f 4c 8d ab 28 07 00 00 b9 8d 01 00 00
RSP: 0018:ffffc900025afac8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff888108fda000 RCX:
     0000000000000006
RDX: 0000000000000000 RSI: 0000000000000000 RDI:
     ffffffff81f6ce64
RBP: 0000000000000001 R08: 0000000000000001 R09:
     0000000000000006
R10: 0000000000000001 R11: 0000000000000000 R12:
     0000000000000000
R13: ffff888108fdb1e8 R14: ffffc900025afbd0 R15:
     00000000001817d6
FS:  00007f2eba488740(0000) GS:ffff88885fbc0000(0000)
     knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007f2eba32efb8 CR3: 0000000109bcc005 CR4:
     0000000000372eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2:
     0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
     0000000000000400
Call Trace:
<TASK>
? __warn+0x84/0x190
? mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
? report_bug+0xf8/0x1c0
? handle_bug+0x55/0x90
? exc_invalid_op+0x13/0x60
? asm_exc_invalid_op+0x16/0x20
? _raw_spin_unlock_irq+0x24/0x40
? mlx5r_umr_post_send_wait+0x15a/0x2b0 [mlx5_ib]
? mlx5r_umr_post_send_wait+0x14a/0x2b0 [mlx5_ib]
? __pfx_mlx5r_umr_done+0x10/0x10 [mlx5_ib]
mlx5r_umr_update_xlt+0x23c/0x3e0 [mlx5_ib]
mlx5_ib_invalidate_range+0x2e1/0x330 [mlx5_ib]
? lock_release+0xc6/0x280
__mmu_notifier_invalidate_range_start+0x1e1/0x240
zap_page_range_single+0xf1/0x1a0
? mas_prev_slot+0x130/0x8e0
madvise_vma_behavior+0x677/0x6e0
? find_vma_prev+0x58/0xa0
do_madvise+0x1a2/0x4b0
__x64_sys_madvise+0x25/0x30
do_syscall_64+0x6b/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f2eba63c47b
Code: c3 66 0f 1f 44 00 00 48 8b 15 19 6a 0c 00 f7 d8 64
89 02 b8 ff ff ff ff eb bc 0f 1f 44 00 00 f3 0f 1e fa b8 1c 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed 69 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd84edc338 EFLAGS: 00000202 ORIG_RAX:
     000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
     00007f2eba63c47b
RDX: 0000000000000004 RSI: 0000000000001000 RDI:
     000000ff00000000
RBP: 000000002855eb90 R08: 0000000000000027 R09:
     00007f2eba32f700
R10: 0000000000400dd7 R11: 0000000000000202 R12:
     00007ffd84edc438
R13: 00000000000003e8 R14: 0000000000000001 R15:
     0000000000000000
</TASK>

Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Artemy Kovalyov <artemyko@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c  | 17 +++++++++++++++--
 drivers/infiniband/hw/mlx5/odp.c |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 45d9dc9c6c8f..bb02b6adbf2c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2021,6 +2021,11 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+	bool is_odp = is_odp_mr(mr);
+	int ret = 0;
+
+	if (is_odp)
+		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
 	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
@@ -2032,7 +2037,7 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-		return 0;
+		goto out;
 	}
 
 	if (ent) {
@@ -2041,7 +2046,15 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mr->mmkey.cache_ent = NULL;
 		spin_unlock_irq(&ent->mkeys_queue.lock);
 	}
-	return destroy_mkey(dev, mr);
+	ret = destroy_mkey(dev, mr);
+out:
+	if (is_odp) {
+		if (!ret)
+			to_ib_umem_odp(mr->umem)->private = NULL;
+		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+	}
+
+	return ret;
 }
 
 static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f2eb940bddc8..f655859eec00 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -268,6 +268,8 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 	if (!umem_odp->npages)
 		goto out;
 	mr = umem_odp->private;
+	if (!mr)
+		goto out;
 
 	start = max_t(u64, ib_umem_start(umem_odp), range->start);
 	end = min_t(u64, ib_umem_end(umem_odp), range->end);
-- 
2.47.1


