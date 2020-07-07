Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C48216D8A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 15:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGNP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 09:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNP6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 09:15:58 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640742075B;
        Tue,  7 Jul 2020 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594127758;
        bh=MaphCiqMCAcv/7HIRD7elKhsP5r80jyqeJ2IlQWWTYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eKJ1KBo9rcnB7ZHCv/YbR7F2zJoeGIxXC74OHL/aQy/qQgWmdPvEucoHCv+GRaboT
         iaRo8F88VyQYdL1w2Twl4kzL2Aovfr2TSyJLy3O5R65wAzd/JsCgQbd/82xoXM5QiN
         lb+71WRbqtsIlNatLLbZrh3iYAtjzxm06f0jLaFw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH rdma-rc v1] RDMA/mlx5: Use xa_lock_irq when access to SRQ table
Date:   Tue,  7 Jul 2020 16:15:51 +0300
Message-Id: <20200707131551.1153207-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

SRQ table is accessed both from interrupt and process context,
therefore we must use xa_lock_irq.

 [ 9878.321379] --------------------------------
 [ 9878.322349] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
 [ 9878.323667] kworker/u17:9/8573 [HC0[0]:SC0[0]:HE1:SE1] takes:
 [ 9878.324894] ffff8883e3503d30 (&xa->xa_lock#13){?...}-{2:2}, at:
mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
 [ 9878.326816] {IN-HARDIRQ-W} state was registered at:
 [ 9878.327905]   lock_acquire+0xb9/0x3a0
 [ 9878.328720]   _raw_spin_lock+0x25/0x30
 [ 9878.329475]   srq_event_notifier+0x2b/0xc0 [mlx5_ib]
 [ 9878.330433]   notifier_call_chain+0x45/0x70
 [ 9878.331393]   __atomic_notifier_call_chain+0x69/0x100
 [ 9878.332530]   forward_event+0x36/0xc0 [mlx5_core]
 [ 9878.333558]   notifier_call_chain+0x45/0x70
 [ 9878.334418]   __atomic_notifier_call_chain+0x69/0x100
 [ 9878.335498]   mlx5_eq_async_int+0xc5/0x160 [mlx5_core]
 [ 9878.336543]   notifier_call_chain+0x45/0x70
 [ 9878.337354]   __atomic_notifier_call_chain+0x69/0x100
 [ 9878.338337]   mlx5_irq_int_handler+0x19/0x30 [mlx5_core]
 [ 9878.339369]   __handle_irq_event_percpu+0x43/0x2a0
 [ 9878.340382]   handle_irq_event_percpu+0x30/0x70
 [ 9878.341252]   handle_irq_event+0x34/0x60
 [ 9878.342020]   handle_edge_irq+0x7c/0x1b0
 [ 9878.342788]   do_IRQ+0x60/0x110
 [ 9878.343482]   ret_from_intr+0x0/0x2a
 [ 9878.344251]   default_idle+0x34/0x160
 [ 9878.344996]   do_idle+0x1ec/0x220
 [ 9878.345682]   cpu_startup_entry+0x19/0x20
 [ 9878.346511]   start_secondary+0x153/0x1a0
 [ 9878.347328]   secondary_startup_64+0xa4/0xb0
 [ 9878.348226] irq event stamp: 20907
 [ 9878.348953] hardirqs last  enabled at (20907): [<ffffffff819f0eb4>]
_raw_spin_unlock_irq+0x24/0x30
 [ 9878.350599] hardirqs last disabled at (20906): [<ffffffff819f0cbf>]
_raw_spin_lock_irq+0xf/0x40
 [ 9878.352300] softirqs last  enabled at (20746): [<ffffffff81c002c9>]
__do_softirq+0x2c9/0x436
 [ 9878.353859] softirqs last disabled at (20681): [<ffffffff81139543>]
irq_exit+0xb3/0xc0
 [ 9878.355365]
 [ 9878.355365] other info that might help us debug this:
 [ 9878.356703]  Possible unsafe locking scenario:
 [ 9878.356703]
 [ 9878.357941]        CPU0
 [ 9878.358522]        ----
 [ 9878.359109]   lock(&xa->xa_lock#13);
 [ 9878.359875]   <Interrupt>
 [ 9878.360504]     lock(&xa->xa_lock#13);
 [ 9878.361315]
 [ 9878.361315]  *** DEADLOCK ***
 [ 9878.361315]
 [ 9878.362632] 2 locks held by kworker/u17:9/8573:
 [ 9878.374883]  #0: ffff888295218d38
((wq_completion)mlx5_ib_page_fault){+.+.}-{0:0}, at:
process_one_work+0x1f1/0x5f0
 [ 9878.376728]  #1: ffff888401647e78
((work_completion)(&pfault->work)){+.+.}-{0:0}, at:
process_one_work+0x1f1/0x5f0
 [ 9878.378550]
 [ 9878.378550] stack backtrace:
 [ 9878.379489] CPU: 0 PID: 8573 Comm: kworker/u17:9 Tainted: G
O      5.7.0_for_upstream_min_debug_2020_06_14_11_31_46_41 #1
 [ 9878.381730] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
 [ 9878.383940] Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action
[mlx5_ib]
 [ 9878.385239] Call Trace:
 [ 9878.385822]  dump_stack+0x71/0x9b
 [ 9878.386519]  mark_lock+0x4f2/0x590
 [ 9878.387263]  ? print_shortest_lock_dependencies+0x200/0x200
 [ 9878.388362]  __lock_acquire+0xa00/0x1eb0
 [ 9878.389133]  lock_acquire+0xb9/0x3a0
 [ 9878.389854]  ? mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
 [ 9878.390796]  _raw_spin_lock+0x25/0x30
 [ 9878.391533]  ? mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
 [ 9878.392455]  mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
 [ 9878.393351]  mlx5_ib_eqe_pf_action+0x257/0xa30 [mlx5_ib]
 [ 9878.394337]  ? process_one_work+0x209/0x5f0
 [ 9878.395150]  process_one_work+0x27b/0x5f0
 [ 9878.395939]  ? __schedule+0x280/0x7e0
 [ 9878.396683]  worker_thread+0x2d/0x3c0
 [ 9878.397424]  ? process_one_work+0x5f0/0x5f0
 [ 9878.398249]  kthread+0x111/0x130
 [ 9878.398926]  ? kthread_park+0x90/0x90
 [ 9878.399709]  ret_from_fork+0x24/0x30

Fixes: b02a29eb8841 ("mlx5: Convert mlx5_srq_table to XArray")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Changelog:
v1:
 * I left Fixes as before to make sure that it is taken properly to stable@.
 * xa_lock_irqsave -> xa_lock_irq
v0: https://lore.kernel.org/linux-rdma/20200707110612.882962-2-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/srq_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index 6f5eadc4d183..11699c1f7ba0 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -83,11 +83,11 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
 	struct mlx5_srq_table *table = &dev->srq_table;
 	struct mlx5_core_srq *srq;

-	xa_lock(&table->array);
+	xa_lock_irq(&table->array);
 	srq = xa_load(&table->array, srqn);
 	if (srq)
 		refcount_inc(&srq->common.refcount);
-	xa_unlock(&table->array);
+	xa_unlock_irq(&table->array);

 	return srq;
 }
@@ -655,11 +655,11 @@ static int srq_event_notifier(struct notifier_block *nb,
 	eqe = data;
 	srqn = be32_to_cpu(eqe->data.qp_srq.qp_srq_n) & 0xffffff;

-	xa_lock(&table->array);
+	xa_lock_irq(&table->array);
 	srq = xa_load(&table->array, srqn);
 	if (srq)
 		refcount_inc(&srq->common.refcount);
-	xa_unlock(&table->array);
+	xa_unlock_irq(&table->array);

 	if (!srq)
 		return NOTIFY_OK;
--
2.26.2

