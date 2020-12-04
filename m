Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0E12CE83A
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 07:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgLDGmw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 01:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgLDGmw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Dec 2020 01:42:52 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next] RDMA/cm: Fix an attempt to use non-valid pointer when cleaning timewait
Date:   Fri,  4 Dec 2020 08:42:05 +0200
Message-Id: <20201204064205.145795-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

If cm_create_timewait_info() fails, the timewait_info pointer will contain
an error value and will be used in cm_remove_remote() later.

Nullify the cm_id_priv->timewait_info pointer to prevent it.

RDX: 0000000000000120 RSI: 00000000200003c0 RDI: 0000000000000003
RBP: 00007fe1ffcc0c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffe9d7d49e0
general protection fault, probably for non-canonical address 0xdffffc0000000024: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0×0000000000000120-0×0000000000000127]
CPU: 2 PID: 12446 Comm: syz-executor.3 Not tainted 5.10.0-rc5-5d4c0742a60e #27
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:cm_remove_remote.isra.0+0x24/0×170 drivers/infiniband/core/cm.c:978

Code: 84 00 00 00 00 00 41 54 55 53 48 89 fb 48 8d ab 2d 01 00 00 e8 7d bf 4b fe 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 48 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 fc 00 00 00
RSP: 0018:ffff888013127918 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: ffffc9000a18b000
RDX: 0000000000000024 RSI: ffffffff82edc573 RDI: fffffffffffffff4
RBP: 0000000000000121 R08: 0000000000000001 R09: ffffed1002624f1d
R10: 0000000000000003 R11: ffffed1002624f1c R12: ffff888107760c70
R13: ffff888107760c40 R14: fffffffffffffff4 R15: ffff888107760c9c
FS:  00007fe1ffcc1700(0000) GS:ffff88811a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ff21000 CR3: 000000010f504001 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Call Trace:
 cm_destroy_id+0x189/0×15b0 drivers/infiniband/core/cm.c:1155
 cma_connect_ib drivers/infiniband/core/cma.c:4029 [inline]
 rdma_connect_locked+0x1100/0×17c0 drivers/infiniband/core/cma.c:4107
 rdma_connect+0x2a/0×40 drivers/infiniband/core/cma.c:4140
 ucma_connect+0x277/0×340 drivers/infiniband/core/ucma.c:1069
 ucma_write+0x236/0×2f0 drivers/infiniband/core/ucma.c:1724
 vfs_write+0x220/0×830 fs/read_write.c:603
 ksys_write+0x1df/0×240 fs/read_write.c:658
 do_syscall_64+0x33/0×40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

RIP: 0033:0×468899

Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48

RSP: 002b:00007fe1ffcc0c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000007415a0 RCX: 0000000000468899
RDX: 0000000000000120 RSI: 00000000200003c0 RDI: 0000000000000003
RBP: 00007fe1ffcc0c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 000000000076bf00 R15: 00007ffe9d7d49e0

Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Reported-by: Amit Matityahu <mitm@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 167e436ae11d..b046304b4fd5 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1522,6 +1522,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 							    id.local_id);
 	if (IS_ERR(cm_id_priv->timewait_info)) {
 		ret = PTR_ERR(cm_id_priv->timewait_info);
+		cm_id_priv->timewait_info = NULL;
 		goto out;
 	}

@@ -2114,6 +2115,7 @@ static int cm_req_handler(struct cm_work *work)
 							    id.local_id);
 	if (IS_ERR(cm_id_priv->timewait_info)) {
 		ret = PTR_ERR(cm_id_priv->timewait_info);
+		cm_id_priv->timewait_info = NULL;
 		goto destroy;
 	}
 	cm_id_priv->timewait_info->work.remote_id = cm_id_priv->id.remote_id;
--
2.28.0

