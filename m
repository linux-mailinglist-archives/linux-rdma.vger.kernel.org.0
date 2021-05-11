Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E7C379F51
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 07:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhEKFt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 01:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhEKFt6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 01:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B50A61925;
        Tue, 11 May 2021 05:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620712132;
        bh=A1Rr/mANg8aAmK5AqWEso8c/Kurxmovs7lIcwuTQpt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6vazm7wqeegQNNLHyEV0tIyHtCXdTx4J3JemufV7x2SMXDTB3GXONkYY++pjJp71
         XfHxzwt5ugZPPu6tsQ/dUnB6PpGkCZNinq3iVcTLqauidGARJZ+tIBIUgmVGqNvG0w
         n8VZCMtaHFt2Do1m6p0BDHaMJD7FG9Zld07ARfUppBOKdlZln+D0aA662XNzlkgXRE
         QG2y4P+JiuT5Bu6URjwsA/0XP8A9s0D/e99ZfG3AEly/LV14WRzPRnqsw4LGWqcJZT
         Mf3bMQlAx3+KK1UNAYUL+/DT8yfMN884GZvQL9wY/5x1GByaMStI7Jx1kRrgDOZBhP
         jl99VQvVBbZYQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-rc 2/5] RDMA/core: Don't access cm_id after its destruction
Date:   Tue, 11 May 2021 08:48:28 +0300
Message-Id: <3352ee288fe34f2b44220457a29bfc0548686363.1620711734.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620711734.git.leonro@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

The idea that restrack needs asymmetrical delete routine was proven as
wrong. It caused to try and access ib_device after it was already
disconnected from the cma_dev.

As a solution, move rdma_restrack_del() to be before id_priv destruction.

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
 drivers/infiniband/core/cma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc21cbc4..ab148a696c0c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -473,6 +473,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
 	list_del(&id_priv->list);
 	cma_dev_put(id_priv->cma_dev);
 	id_priv->cma_dev = NULL;
+	id_priv->id.device = NULL;
 	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
 		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
 		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
@@ -1860,6 +1861,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 				iw_destroy_cm_id(id_priv->cm_id.iw);
 		}
 		cma_leave_mc_groups(id_priv);
+		rdma_restrack_del(&id_priv->res);
 		cma_release_dev(id_priv);
 	}
 
@@ -1873,7 +1875,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 	kfree(id_priv->id.route.path_rec);
 
 	put_net(id_priv->id.route.addr.dev_addr.net);
-	rdma_restrack_del(&id_priv->res);
 	kfree(id_priv);
 }
 
@@ -3774,7 +3775,7 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 	}
 
 	id_priv->backlog = backlog;
-	if (id->device) {
+	if (id_priv->cma_dev) {
 		if (rdma_cap_ib_cm(id->device, 1)) {
 			ret = cma_ib_listen(id_priv);
 			if (ret)
-- 
2.31.1

