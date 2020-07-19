Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3413224FF8
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 08:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSG5y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 02:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSG5y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 02:57:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252222073A;
        Sun, 19 Jul 2020 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595141873;
        bh=s8Mbd5O8z1gU8GHLVOyKwcucsT2fjW2CbDSO+QJbhbU=;
        h=From:To:Cc:Subject:Date:From;
        b=wtlCedrjo9HyOoc3cckEyLFxF+TKhbArkoPugo/Vhpzaxg73U5uUevqXRmhZJ/+Oi
         Qi7Lx19H6teDSBlM9nrPxihyY/c86V2DpGNo2rNEIid/fXVsiDs9S9NEI0SKjej8ht
         7SjROSE6hXSsJOlTlCrY7Ca+6SIwUthWAqqcQwik=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Add missing srcu_read_lock in ODP implicit flow
Date:   Sun, 19 Jul 2020 09:57:47 +0300
Message-Id: <20200719065747.131157-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

According to the locking scheme, mlx5_ib_update_xlt should be called
with srcu_read_lock().
This fixes the below LOCKDEP trace.

[  861.917222] WARNING: CPU: 1 PID: 1130 at
drivers/infiniband/hw/mlx5/odp.c:132 mlx5_odp_populate_xlt+0x175/0x180
[mlx5_ib]
[  861.921080] Modules linked in: xt_conntrack xt_MASQUERADE
nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay ib_srp
scsi_transport_srp rpcrdma rdma_ucm ib_iser libiscsi
scsi_transport_iscsi rdma_cm iw_cm ib_umad ib_ipoib ib_cm mlx5_ib
ib_uverbs ib_core mlx5_core mlxfw ptp pps_core
[  861.930133] CPU: 1 PID: 1130 Comm: kworker/u16:11 Tainted: G        W
5.8.0-rc5_for_upstream_debug_2020_07_13_11_04 #1
[  861.932034] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[  861.933801] Workqueue: events_unbound mlx5_ib_prefetch_mr_work
[mlx5_ib]
[  861.934933] RIP: 0010:mlx5_odp_populate_xlt+0x175/0x180 [mlx5_ib]
[  861.935954] Code: 08 e2 85 c0 0f 84 65 ff ff ff 49 8b 87 60 01 00 00
be ff ff ff ff 48 8d b8 b0 39 00 00 e8 93 e0 50 e1 85 c0 0f 85 45 ff ff
ff <0f> 0b e9 3e ff ff ff 0f 0b eb c7 0f 1f 44 00 00 48 8b 87 98 0f 00
[  861.938855] RSP: 0018:ffff88840f44fc68 EFLAGS: 00010246
[  861.939707] RAX: 0000000000000000 RBX: ffff88840cc9d000 RCX:
ffff88840efcd940
[  861.940788] RDX: 0000000000000000 RSI: ffff88844871b9b0 RDI:
ffff88840efce100
[  861.941880] RBP: ffff88840cc9d040 R08: 0000000000000040 R09:
0000000000000001
[  861.943020] R10: ffff88846ced3068 R11: 0000000000000000 R12:
00000000000156ec
[  861.944133] R13: 0000000000000004 R14: 0000000000000004 R15:
ffff888439941000
[  861.945228] FS:  0000000000000000(0000) GS:ffff88846fa80000(0000)
knlGS:0000000000000000
[  861.946557] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  861.947512] CR2: 00007f8536d12430 CR3: 0000000437a5e006 CR4:
0000000000360ea0
[  861.948609] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  861.949684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  861.950804] Call Trace:
[  861.951300]  mlx5_ib_update_xlt+0x37c/0x7c0 [mlx5_ib]
[  861.952145]  pagefault_mr+0x315/0x440 [mlx5_ib]
[  861.952895]  mlx5_ib_prefetch_mr_work+0x56/0xa0 [mlx5_ib]
[  861.953763]  process_one_work+0x215/0x5c0
[  861.954477]  worker_thread+0x3c/0x380
[  861.955127]  ? process_one_work+0x5c0/0x5c0
[  861.955851]  kthread+0x133/0x150
[  861.956426]  ? kthread_park+0x90/0x90
[  861.957061]  ret_from_fork+0x1f/0x30
[  861.957686] irq event stamp: 199569
[  861.958318] hardirqs last  enabled at (199577): [<ffffffff8119bf39>]
console_unlock+0x439/0x590
[  861.959720] hardirqs last disabled at (199584): [<ffffffff8119bb81>]
console_unlock+0x81/0x590
[  861.961080] softirqs last  enabled at (199600): [<ffffffff81e00293>]
__do_softirq+0x293/0x47e
[  861.971725] softirqs last disabled at (199613): [<ffffffff81c00f0f>]
asm_call_on_stack+0xf/0x20
[  861.973142] ---[ end trace e6f026aa6012c21e ]---

Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
It is not really need to go to -rc, not urgent.
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 2 +-
 drivers/infiniband/core/verbs.c               | 3 +++
 drivers/infiniband/hw/mlx5/odp.c              | 9 +++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 62f58ad56afd..9b22bb553e8b 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -69,7 +69,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_ADVISE_MR)(

 	num_sge = uverbs_attr_ptr_get_array_size(
 		attrs, UVERBS_ATTR_ADVISE_MR_SGE_LIST, sizeof(struct ib_sge));
-	if (num_sge < 0)
+	if (num_sge <= 0)
 		return num_sge;

 	sg_list = uverbs_attr_get_alloced_ptr(attrs,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 73f3ea8af714..674949233d21 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2073,6 +2073,9 @@ int ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
 	if (!pd->device->ops.advise_mr)
 		return -EOPNOTSUPP;

+	if (!num_sge)
+		return 0;
+
 	return pd->device->ops.advise_mr(pd, advice, flags, sg_list, num_sge,
 					 NULL);
 }
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index aa6f08ad0d03..4f1e46733830 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -816,6 +816,7 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);

+	lockdep_assert_held(&mr->dev->odp_srcu);
 	if (unlikely(io_virt < mr->mmkey.iova))
 		return -EFAULT;

@@ -1765,10 +1766,17 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 {
 	struct prefetch_mr_work *work =
 		container_of(w, struct prefetch_mr_work, work);
+	struct mlx5_ib_dev *dev;
 	u32 bytes_mapped = 0;
+	int srcu_key;
 	int ret;
 	u32 i;

+	/* We rely on IB/core that work is executed if we have num_sge != 0 only. */
+	WARN_ON(!work->num_sge);
+	dev = work->frags[0].mr->dev;
+	/* SRCU should be held when calling to mlx5_odp_populate_xlt() */
+	srcu_key = srcu_read_lock(&dev->odp_srcu);
 	for (i = 0; i < work->num_sge; ++i) {
 		ret = pagefault_mr(work->frags[i].mr, work->frags[i].io_virt,
 				   work->frags[i].length, &bytes_mapped,
@@ -1777,6 +1785,7 @@ static void mlx5_ib_prefetch_mr_work(struct work_struct *w)
 			continue;
 		mlx5_update_odp_stats(work->frags[i].mr, prefetch, ret);
 	}
+	srcu_read_unlock(&dev->odp_srcu, srcu_key);

 	destroy_prefetch_work(work);
 }
--
2.26.2

