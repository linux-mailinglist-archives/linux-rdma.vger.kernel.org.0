Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80D2D8D48
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Dec 2020 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLMNao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Dec 2020 08:30:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394646AbgLMNah (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Dec 2020 08:30:37 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-rc 4/5] RDMA/cma: Don't overwrite sgid_attr after device is released
Date:   Sun, 13 Dec 2020 15:29:39 +0200
Message-Id: <20201213132940.345554-5-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201213132940.345554-1-leon@kernel.org>
References: <20201213132940.345554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

As part of the cma_dev release, that pointer will be set to NULL.
In case it happens in rdma_bind_addr() (part of an error flow),
the next call to addr_handler() will have a call to cma_acquire_dev_by_src_ip()
which will overwrite sgid_attr without releasing it.

WARNING: CPU: 2 PID: 108 at drivers/infiniband/core/cma.c:606 cma_bind_sgid_attr drivers/infiniband/core/cma.c:606 [inline]
WARNING: CPU: 2 PID: 108 at drivers/infiniband/core/cma.c:606 cma_acquire_dev_by_src_ip+0x470/0x4b0 drivers/infiniband/core/cma.c:649
CPU: 2 PID: 108 Comm: kworker/u8:1 Not tainted 5.10.0-rc6+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: ib_addr process_one_req
RIP: 0010:cma_bind_sgid_attr drivers/infiniband/core/cma.c:606 [inline]
RIP: 0010:cma_acquire_dev_by_src_ip+0x470/0&times;4b0 drivers/infiniband/core/cma.c:649
Code: 66 d9 4a ff 4d 8b 6e 10 49 8d bd 1c 08 00 00 e8 b6 d6 4a ff 45 0f b6 bd 1c 08 00 00 41 83 e7 01 e9 49 fd ff ff e8 90 c5 29 ff &lt;0f&gt; 0b e9 80 fe ff ff e8 84 c5 29 ff 4c 89 f7 e8 2c d9 4a ff 4d 8b

RSP: 0018:ffff8881047c7b40 EFLAGS: 00010293
RAX: ffff888104789c80 RBX: 0000000000000001 RCX: ffffffff820b8ef8
RDX: 0000000000000000 RSI: ffffffff820b9080 RDI: ffff88810cd4c998
RBP: ffff8881047c7c08 R08: ffff888104789c80 R09: ffffed10209f4036
R10: ffff888104fa01ab R11: ffffed10209f4035 R12: ffff88810cd4c800
R13: ffff888105750e28 R14: ffff888108f0a100 R15: ffff88810cd4c998
FS:  0000000000000000(0000) GS:ffff888119c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000104e60005 CR4: 0000000000370ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Call Trace:
 addr_handler+0x266/0&times;350 drivers/infiniband/core/cma.c:3190
 process_one_req+0xa3/0&times;300 drivers/infiniband/core/addr.c:645
 process_one_work+0x54c/0&times;930 kernel/workqueue.c:2272
 worker_thread+0x82/0&times;830 kernel/workqueue.c:2418
 kthread+0x1ca/0&times;220 kernel/kthread.c:292
 ret_from_fork+0x1f/0&times;30 arch/x86/entry/entry_64.S:296

Fixes: ff11c6cd521f ("RDMA/cma: Introduce and use cma_acquire_dev_by_src_ip()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index bfdc2eaee351..e17ba841e204 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -491,6 +491,10 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
 	list_del(&id_priv->list);
 	cma_dev_put(id_priv->cma_dev);
 	id_priv->cma_dev = NULL;
+	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
+		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
+		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
+	}
 	mutex_unlock(&lock);
 }

@@ -1877,9 +1881,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,

 	kfree(id_priv->id.route.path_rec);

-	if (id_priv->id.route.addr.dev_addr.sgid_attr)
-		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
-
 	put_net(id_priv->id.route.addr.dev_addr.net);
 	rdma_restrack_del(&id_priv->res);
 	kfree(id_priv);
--
2.29.2

