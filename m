Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B90202A6A
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgFUMAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 08:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729869AbgFUMAF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 08:00:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245B82480F;
        Sun, 21 Jun 2020 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592740804;
        bh=d3ycEt54SmUgWiOyU7hW9s03woY3XIbzNXSiVvPsR1k=;
        h=From:To:Cc:Subject:Date:From;
        b=zsktmFgmmk0RuqOs66RPQOyTayM6VIYOzM0frww+y56DoH1el3Xi9ym/TcsIwk+4D
         47qndLqi5Zwi8SX1SkjOi2YBE7C/aJGWiKFgxy1si6fMgAkt3wtdDoTXY5m7W59ELl
         ZrYh04oFE2WQcnAXVCffaAQzpXdc1GIN59PE+6Vg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Protect from kernel crash if XRC_TGT doesn't have udata
Date:   Sun, 21 Jun 2020 14:59:59 +0300
Message-Id: <20200621115959.60126-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

[  316.938373] BUG: kernel NULL pointer dereference, address: 0000000000000030
[  316.941956] #PF: supervisor read access in kernel mode
[  316.942692] #PF: error_code(0x0000) - not-present page
[  316.943415] PGD 0 P4D 0
[  316.943820] Oops: 0000 [#1] SMP PTI
[  316.944338] CPU: 2 PID: 1592 Comm: python3 Not tainted 5.7.0-rc6+ #1
[  316.945214] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 0
4/01/2014
[  316.946732] RIP: 0010:create_qp+0x39e/0xae0 [mlx5_ib]
[  316.947443] Code: c0 0d 00 00 bf 10 01 00 00 e8 be a9 e4 e0 48 85 c0 49 89 c2 0f 84 0c 07 00 00 41 8b 85 74 63 01 0
0 0f c8 a9 00 00 00 10 74 0a <41> 8b 46 30 0f c8 41 89 42 14 41 8b 52 18 41 0f b6 4a 1c 0f ca 89
[  316.949880] RSP: 0018:ffffc9000067f8b0 EFLAGS: 00010206
[  316.950681] RAX: 0000000010170000 RBX: ffff888441313000 RCX: 0000000000000000
[  316.951750] RDX: 0000000000000200 RSI: 0000000000000000 RDI: ffff88845b1d4400
[  316.952857] RBP: ffffc9000067fa60 R08: 0000000000000200 R09: ffff88845b1d4200
[  316.953970] R10: ffff88845b1d4200 R11: ffff888441313000 R12: ffffc9000067f950
[  316.955054] R13: ffff88846ac00140 R14: 0000000000000000 R15: ffff88846c2bc000
[  316.956189] FS:  00007faa1a3c0540(0000) GS:ffff88846fd00000(0000) knlGS:0000000000000000
[  316.957478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.958378] CR2: 0000000000000030 CR3: 0000000446dca003 CR4: 0000000000760ea0
[  316.959497] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  316.960609] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  316.961721] PKRU: 55555554
[  316.962221] Call Trace:
[  316.962686]  ? __switch_to_asm+0x40/0x70
[  316.963352]  ? __switch_to_asm+0x34/0x70
[  316.964018]  mlx5_ib_create_qp+0x897/0xfa0 [mlx5_ib]
[  316.964875]  ib_create_qp+0x9e/0x300 [ib_core]
[  316.965657]  create_qp+0x92d/0xb20 [ib_uverbs]
[  316.966397]  ? ib_uverbs_cq_event_handler+0x30/0x30 [ib_uverbs]
[  316.967325]  ? release_resource+0x30/0x30
[  316.968002]  ib_uverbs_create_qp+0xc4/0xe0 [ib_uverbs]
[  316.968834]  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xc8/0xf0 [ib_uverbs]
[  316.970049]  ib_uverbs_run_method+0x223/0x770 [ib_uverbs]
[  316.970925]  ? track_pfn_remap+0xa7/0x100
[  316.971635]  ? uverbs_disassociate_api+0xd0/0xd0 [ib_uverbs]
[  316.972542]  ? remap_pfn_range+0x358/0x490
[  316.973248]  ib_uverbs_cmd_verbs.isra.6+0x19b/0x370 [ib_uverbs]
[  316.974188]  ? rdma_umap_priv_init+0x82/0xe0 [ib_core]
[  316.975035]  ? vm_mmap_pgoff+0xec/0x120
[  316.975695]  ib_uverbs_ioctl+0xc0/0x120 [ib_uverbs]
[  316.976489]  ksys_ioctl+0x92/0xb0
[  316.977098]  __x64_sys_ioctl+0x16/0x20
[  316.977746]  do_syscall_64+0x48/0x130
[  316.978377]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  316.979187] RIP: 0033:0x7faa19012267
[  316.979803] Code: b3 66 90 48 8b 05 19 3c 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 3b 2c 00 f7 d8 64 89 01 48
[  316.982520] RSP: 002b:00007ffc43961e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  316.983771] RAX: ffffffffffffffda RBX: 00007ffc43961e98 RCX: 00007faa19012267
[  316.984905] RDX: 00007ffc43961e80 RSI: 00000000c0181b01 RDI: 0000000000000003
[  316.986037] RBP: 00007ffc43961e60 R08: 0000000000000005 R09: 000055e723996840
[  316.987148] R10: 0000000000001000 R11: 0000000000000246 R12: 000055e723996980
[  316.988277] R13: 00007ffc43961e60 R14: 00007ffc43962158 R15: 00007faa11da3e00
[  316.989396] Modules linked in: ib_srp scsi_transport_srp rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdm
a_cm iw_cm ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core mlx5_core mlxfw
[  316.991910] CR2: 0000000000000030
[  316.992511] ---[ end trace 56565abe20776836 ]---

Fixes: e383085c2425 ("RDMA/mlx5: Set ECE options during QP create")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a7fcb00e37a5..f939c9b769f0 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1862,7 +1862,7 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	if (!in)
 		return -ENOMEM;
 
-	if (MLX5_CAP_GEN(mdev, ece_support))
+	if (MLX5_CAP_GEN(mdev, ece_support) && ucmd)
 		MLX5_SET(create_qp_in, in, ece, ucmd->ece_options);
 	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
 
-- 
2.26.2

