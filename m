Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5298216B0F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGGLG3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 07:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGGLG2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 07:06:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FCF1206B6;
        Tue,  7 Jul 2020 11:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594119988;
        bh=b7WDKRjNkakS1u4iZFmax3C/oGwnReHH2/V2YDOLkGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVu7UIdxALIAUa8p5SzvgganCufgkeydetBc2p5Kwg7HAxV9nhvsaZsL2FBq4tftO
         WwmHsgQhsRe7QYRKev0bnLfxPhU+JVm4Dd1OBIFi9seSzdgdhPX15dJ6KNx50XTRZD
         IGmS8BUqH0Y8pZXFndTAkeG2o+F8xoTZ6FeGESU4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 3/3] RDMA/mlx5: Set PD pointers for the error flow unwind
Date:   Tue,  7 Jul 2020 14:06:12 +0300
Message-Id: <20200707110612.882962-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707110612.882962-1-leon@kernel.org>
References: <20200707110612.882962-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

ib_pd is accessed internally during destroy of the TIR/TIS, but PD
can be not set yet. This leading to the following kernel panic.

BUG: kernel NULL pointer dereference, address: 0000000000000074
PGD 8000000079eaa067 P4D 8000000079eaa067 PUD 7ae81067 PMD 0 Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 709 Comm: syz-executor.0 Not tainted 5.8.0-rc3 #41 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
RIP: 0010:destroy_raw_packet_qp_tis drivers/infiniband/hw/mlx5/qp.c:1189 [inline]
RIP: 0010:destroy_raw_packet_qp drivers/infiniband/hw/mlx5/qp.c:1527 [inline]
RIP: 0010:destroy_qp_common+0x2ca/0x4f0 drivers/infiniband/hw/mlx5/qp.c:2397
Code: 00 85 c0 74 2e e8 56 18 55 ff 48 8d b3 28 01 00 00 48 89 ef e8 d7 d3 ff ff 48 8b 43 08 8b b3 c0 01 00 00 48 8b bd a8 0a 00 00 <0f> b7 50 74 e8 0d 6a fe ff e8 28 18 55 ff 49 8d 55 50 4c 89 f1 48
RSP: 0018:ffffc900007bbac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807949e800 RCX: 0000000000000998
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88807c180140
RBP: ffff88807b50c000 R08: 000000000002d379 R09: ffffc900007bba00
R10: 0000000000000001 R11: 000000000002d358 R12: ffff888076f37000
R13: ffff88807949e9c8 R14: ffffc900007bbe08 R15: ffff888076f37000
FS:  00000000019bf940(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000074 CR3: 0000000076d68004 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mlx5_ib_create_qp+0xf36/0xf90 drivers/infiniband/hw/mlx5/qp.c:3014
 _ib_create_qp drivers/infiniband/core/core_priv.h:333 [inline]
 create_qp+0x57f/0xd20 drivers/infiniband/core/uverbs_cmd.c:1443
 ib_uverbs_create_qp+0xcf/0x100 drivers/infiniband/core/uverbs_cmd.c:1564
 ib_uverbs_write+0x5fa/0x780 drivers/infiniband/core/uverbs_main.c:664
 __vfs_write+0x3f/0x90 fs/read_write.c:495
 vfs_write+0xc7/0x1f0 fs/read_write.c:559
 ksys_write+0x5e/0x110 fs/read_write.c:612
 do_syscall_64+0x3e/0x70 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x466479
Code: Bad RIP value.
RSP: 002b:00007ffd057b62b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000466479
RDX: 0000000000000070 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00000000019bf8fc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000bf6 R14: 00000000004cb859 R15: 00000000006fefc0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000074
---[ end trace d1e9f6724bb6ea83 ]---
RIP: 0010:destroy_raw_packet_qp_tis drivers/infiniband/hw/mlx5/qp.c:1189 [inline]
RIP: 0010:destroy_raw_packet_qp drivers/infiniband/hw/mlx5/qp.c:1527 [inline]
RIP: 0010:destroy_qp_common+0x2ca/0x4f0 drivers/infiniband/hw/mlx5/qp.c:2397
Code: 00 85 c0 74 2e e8 56 18 55 ff 48 8d b3 28 01 00 00 48 89 ef e8 d7 d3 ff ff 48 8b 43 08 8b b3 c0 01 00 00 48 8b bd a8 0a 00 00 <0f> b7 50 74 e8 0d 6a fe ff e8 28 18 55 ff 49 8d 55 50 4c 89 f1 48
RSP: 0018:ffffc900007bbac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807949e800 RCX: 0000000000000998
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88807c180140
RBP: ffff88807b50c000 R08: 000000000002d379 R09: ffffc900007bba00
R10: 0000000000000001 R11: 000000000002d358 R12: ffff888076f37000
R13: ffff88807949e9c8 R14: ffffc900007bbe08 R15: ffff888076f37000
FS:  00000000019bf940(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000074 CR3: 0000000076d68004 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 3f5efb458639 ("RDMA/mlx5: Don't access ib_qp fields in internal destroy QP path")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index b316c9cafbc5..e050eade97a1 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3005,11 +3005,12 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attr,
 		mlx5_ib_destroy_dct(qp);
 	} else {
 		/*
-		 * The two lines below are temp solution till QP allocation
+		 * These lines below are temp solution till QP allocation
 		 * will be moved to be under IB/core responsiblity.
 		 */
 		qp->ibqp.send_cq = attr->send_cq;
 		qp->ibqp.recv_cq = attr->recv_cq;
+		qp->ibqp.pd = pd;
 		destroy_qp_common(dev, qp, udata);
 	}
 
-- 
2.26.2

