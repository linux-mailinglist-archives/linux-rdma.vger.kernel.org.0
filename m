Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822651DD570
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgEUR7u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 13:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgEUR7u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 May 2020 13:59:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF36B20759;
        Thu, 21 May 2020 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083989;
        bh=XUkt723noMCabretrHSgM7zZ5aVfQCZhLfj+LRvUyt8=;
        h=From:To:Cc:Subject:Date:From;
        b=DeFZNIAAr7zfc/tuqfltrC+LBmtJP+97Kt9VMVBY6V2WZYa9x/4yCeCJD0xuwf68O
         nfl501sDJiggE961NgNNvp0koS3ZfCoyKh9tRMvWMZsRzD4HK8dWBYbt5ioStZ47l+
         ambwbnWKBKnTcD3R+vduEJnE3jW8AoVQHbDSy1Z8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix NULL pointer dereference in destroy_prefetch_work
Date:   Thu, 21 May 2020 10:25:04 +0300
Message-Id: <20200521072504.567406-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

q_deferred_work isn't initialized when user create an explicit ODP
memory region. It could lead to NULL pointer dereference when user
performs asynchronous prefetch MR.
Fix it by initialize q_deferred_work for explicit ODP.

[ 2360.844536] BUG: kernel NULL pointer dereference, address:
0000000000000000
[ 2360.855944] #PF: supervisor read access in kernel mode
[ 2360.858276] #PF: error_code(0x0000) - not-present page
[ 2360.860600] PGD 0 P4D 0
[ 2360.861636] Oops: 0000 [#1] SMP PTI
[ 2360.862781] CPU: 4 PID: 6074 Comm: kworker/u16:6 Not tainted
5.7.0-rc1-for-upstream-perf-2020-04-17_07-03-39-64 #1
[ 2360.865369] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[ 2360.868090] Workqueue: events_unbound mlx5_ib_prefetch_mr_work
[mlx5_ib]
[ 2360.869641] RIP: 0010:__wake_up_common+0x49/0x120
[ 2360.870906] Code: 04 89 54 24 0c 89 4c 24 08 74 0a 41 f6 01 04 0f 85
8e 00 00 00 48 8b 47 08 48 83 e8 18 4c 8d 67 08 48 8d 50 18 49 39 d4 74
66 <48> 8b 70 18 31 db 4c 8d 7e e8 eb 17 49 8b 47 18 48 8d 50 e8 49 8d
[ 2360.875211] RSP: 0000:ffffc9000097bd88 EFLAGS: 00010082
[ 2360.876594] RAX: ffffffffffffffe8 RBX: ffff888454cd9f90 RCX:
0000000000000000
[ 2360.878261] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
ffff888454cd9f90
[ 2360.879930] RBP: ffffc9000097bdd0 R08: 0000000000000000 R09:
ffffc9000097bdd0
[ 2360.881593] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff888454cd9f98
[ 2360.883291] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000003
[ 2360.884970] FS:  0000000000000000(0000) GS:ffff88846fd00000(0000)
knlGS:0000000000000000
[ 2360.887231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2360.888656] CR2: 0000000000000000 CR3: 000000044c19e002 CR4:
0000000000760ee0
[ 2360.890269] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 2360.891881] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 2360.893489] PKRU: 55555554
[ 2360.894504] Call Trace:
[ 2360.895484]  __wake_up_common_lock+0x7a/0xc0
[ 2360.896728]  destroy_prefetch_work+0x5a/0x60 [mlx5_ib]
[ 2360.898106]  mlx5_ib_prefetch_mr_work+0x64/0x80 [mlx5_ib]
[ 2360.899525]  process_one_work+0x15b/0x360
[ 2360.900726]  worker_thread+0x49/0x3d0
[ 2360.901879]  kthread+0xf5/0x130
[ 2360.902961]  ? rescuer_thread+0x310/0x310
[ 2360.904172]  ? kthread_bind+0x10/0x10
[ 2360.905334]  ret_from_fork+0x1f/0x30

Fixes: de5ed007a03d ("IB/mlx5: Fix implicit ODP race")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a401931189b7..44683073be0c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1439,6 +1439,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	if (is_odp_mr(mr)) {
 		to_ib_umem_odp(mr->umem)->private = mr;
+		init_waitqueue_head(&mr->q_deferred_work);
 		atomic_set(&mr->num_deferred_work, 0);
 		err = xa_err(xa_store(&dev->odp_mkeys,
 				      mlx5_base_mkey(mr->mmkey.key), &mr->mmkey,
-- 
2.26.2

