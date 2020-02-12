Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59C915A2D3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 09:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgBLIFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 03:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgBLIFv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:51 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF5020661;
        Wed, 12 Feb 2020 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581494750;
        bh=o1HCkRXKH5HXw3Y9v32TUGvK841iFaD3DHMlwkO4fkI=;
        h=From:To:Cc:Subject:Date:From;
        b=0SYE6IyVymf3JKCrOd06k5f3573oZODPshL1nU2KrYYSO5UMaSCdOJw0F06pZ8tQn
         bru26D4/p6xeHYbxwtTSdWEV4aunGISDpJ7PlSDdsLNgAnqVqFVfZVyxLahR58QJ3B
         MgnQRMsaDjgkR6vsUtM7bernBcuhM2SYp+vcHS00=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/core: Fix protection fault in ib_mr_pool_destroy
Date:   Wed, 12 Feb 2020 10:07:44 +0200
Message-Id: <20200212080744.686787-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Fix NULL pointer dereference in the error flow of ib_create_qp_user
when accessing to uninitialized list pointers - rdma_mrs and sig_mrs.
The following crash from syzkaller revealed it.

kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 23167 Comm: syz-executor.1 Not tainted 5.5.0-rc5 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
RIP: 0010:ib_mr_pool_destroy+0x81/0x1f0
Code: 00 00 fc ff df 49 c1 ec 03 4d 01 fc e8 a8 ea 72 fe 41 80 3c 24 00
0f 85 62 01 00 00 48 8b 13 48 89 d6 4c 8d 6a c8 48 c1 ee 03 <42> 80 3c
3e 00 0f 85 34 01 00 00 48 8d 7a 08 4c 8b 02 48 89 fe 48
RSP: 0018:ffffc9000951f8b0 EFLAGS: 00010046
RAX: 0000000000040000 RBX: ffff88810f268038 RCX: ffffffff82c41628
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000951f850
RBP: ffff88810f268020 R08: 0000000000000004 R09: fffff520012a3f0a
R10: 0000000000000001 R11: fffff520012a3f0a R12: ffffed1021e4d007
R13: ffffffffffffffc8 R14: 0000000000000246 R15: dffffc0000000000
FS:  00007f54bc788700(0000) GS:ffff88811b100000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000116920002 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rdma_rw_cleanup_mrs+0x15/0x30
 ib_destroy_qp_user+0x674/0x7d0
 ib_create_qp_user+0xb01/0x11c0
 create_qp+0x1517/0x2130
 ib_uverbs_create_qp+0x13e/0x190
 ib_uverbs_write+0xaa5/0xdf0
 __vfs_write+0x7c/0x100
 vfs_write+0x168/0x4a0
 ksys_write+0xc8/0x200
 do_syscall_64+0x9c/0x390
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b49
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54bc787c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000465b49
RDX: 0000000000000040 RSI: 0000000020000540 RDI: 0000000000000003
RBP: 00007f54bc787c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f54bc7886bc
R13: 00000000004ca2ec R14: 000000000070ded0 R15: 0000000000000005
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 54a28a9b6f83c561 ]---

Fixes: a060b5629ab06 ("IB/core: generic RDMA READ/WRITE API")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 3ebae3b65c28..90c72f0e7388 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1181,10 +1181,6 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	if (IS_ERR(qp))
 		return qp;

-	ret = ib_create_qp_security(qp, device);
-	if (ret)
-		goto err;
-
 	qp->qp_type    = qp_init_attr->qp_type;
 	qp->rwq_ind_tbl = qp_init_attr->rwq_ind_tbl;

@@ -1195,6 +1191,10 @@ struct ib_qp *ib_create_qp_user(struct ib_pd *pd,
 	INIT_LIST_HEAD(&qp->sig_mrs);
 	qp->port = 0;

+	ret = ib_create_qp_security(qp, device);
+	if (ret)
+		goto err;
+
 	if (qp_init_attr->qp_type == IB_QPT_XRC_TGT) {
 		struct ib_qp *xrc_qp =
 			create_xrc_qp_user(qp, qp_init_attr, udata);
--
2.24.1

