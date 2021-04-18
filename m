Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681E73635C3
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhDRN4b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhDRN4a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:56:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FFCA6134F;
        Sun, 18 Apr 2021 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618754162;
        bh=qQ1yd2ryIzr37VFuu7iTWK3GnvRzPLu5wRht3JxBvg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tB/IsoP0SHbRgtFgFDK7cjzmbmdqMgPb1DBCnBKiJCwopyb9O7xQ27Vo2xUF3YQ41
         mN+FgEeLNYlqvuqeP20w6TUoWabD5jTVZ4GcrEcvDR85T0gQU8qYFytzcwZnEUWY2c
         spOR6/USVHERc4KrupVood0Wqe0EgRVZW6V2P+NH82ZGpwU1EC80eS+LfeeTEpdcaW
         FG7a0whhaYFqw9GzA9PZ6LiUfaUHQ19UGxBJWsBsgwYSCP1RPezhNiQNLb3tUHCz1K
         Ay8VE6WJ52/OlAgdByHKcXV1ObSPvBGniAoTtTfQxPvfm+VHYSWjwXJOmrNfpjLFP5
         I43CFZsMD4GDw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in rdma_listen()
Date:   Sun, 18 Apr 2021 16:55:53 +0300
Message-Id: <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753862.git.leonro@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

rdma_listen() checks if device already attached to rdma_id_priv,
based on the response the its decide to what to listen, however
this is different when the listeners are canceled.

This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
according to the cma_cancel_operation().

Found by syzcaller:
BUG: KASAN: wild-memory-access in __list_del include/linux/list.h:112 [inline]
BUG: KASAN: wild-memory-access in __list_del_entry include/linux/list.h:135 [inline]
BUG: KASAN: wild-memory-access in list_del include/linux/list.h:146 [inline]
BUG: KASAN: wild-memory-access in cma_cancel_listens drivers/infiniband/core/cma.c:1767 [inline]
BUG: KASAN: wild-memory-access in cma_cancel_operation drivers/infiniband/core/cma.c:1795 [inline]
BUG: KASAN: wild-memory-access in cma_cancel_operation+0x1f4/0x4b0 drivers/infiniband/core/cma.c:1783
Write of size 8 at addr dead000000000108 by task syz-executor716/334

CPU: 0 PID: 334 Comm: syz-executor716 Not tainted 5.11.0+ #271
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xbe/0xf9 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:400 [inline]
 kasan_report.cold+0x5f/0xd5 mm/kasan/report.c:413
 __list_del include/linux/list.h:112 [inline]
 __list_del_entry include/linux/list.h:135 [inline]
 list_del include/linux/list.h:146 [inline]
 cma_cancel_listens drivers/infiniband/core/cma.c:1767 [inline]
 cma_cancel_operation drivers/infiniband/core/cma.c:1795 [inline]
 cma_cancel_operation+0x1f4/0x4b0 drivers/infiniband/core/cma.c:1783
 _destroy_id+0x29/0x460 drivers/infiniband/core/cma.c:1862
 ucma_close_id+0x36/0x50 drivers/infiniband/core/ucma.c:185
 ucma_destroy_private_ctx+0x58d/0x5b0 drivers/infiniband/core/ucma.c:576
 ucma_close+0x91/0xd0 drivers/infiniband/core/ucma.c:1797
 __fput+0x169/0x540 fs/file_table.c:280
 task_work_run+0xb7/0x100 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0x7da/0x17f0 kernel/exit.c:825
 do_group_exit+0x9e/0x190 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x2d/0x30 kernel/exit.c:931
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44a326
Code: Unable to access opcode bytes at RIP 0x44a2fc.
RSP: 002b:00007ffd14306748 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000006c4490 RCX: 000000000044a326
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffffc0
R10: bb1414ac000000c2 R11: 0000000000000246 R12: 00000000006c4490
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
==================================================================

Fixes: 255d0c14b375 ("RDMA/cma: rdma_bind_addr() leaks a cma_dev reference count")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2dc302a83014..cc990adaf2b5 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3768,7 +3768,7 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 	}
 
 	id_priv->backlog = backlog;
-	if (id->device) {
+	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id->device, 1)) {
 			ret = cma_ib_listen(id_priv);
 			if (ret)
-- 
2.30.2

