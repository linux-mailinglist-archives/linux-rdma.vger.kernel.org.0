Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D023B6FB6
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 10:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhF2IyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 04:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbhF2IyK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 04:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C58DA61CA2;
        Tue, 29 Jun 2021 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624956703;
        bh=KJN63K8riJbDlFr2P45UgIg7HaVSqdNLwbvovnKR8ng=;
        h=From:To:Cc:Subject:Date:From;
        b=FTuivG5R8i7YnrPmdsOXWGllBirBE9829gQ9RkZYjQUyXpY3urAMl/xJVDzTEdApU
         zZeKr5+MkzcKgzob1a2q7p9Sx2D0QrIkAsbCp5C6B5Acdyb5gpYVlMdc/4JB7Qlskq
         F5i4Td3RtoTxe1wwnRZt2FBs1+OLIa2jDo/bHe7M5VGm7MUuI2ZUvmGI+weDqAJejl
         3x7qtqKgwGRvXc1ey/f4OwApRLhKl5Cbv7FMMcEGMmpZDRX46J/Xmiq7o9DJfBSRgF
         /6B8BuadCVUiLGL7cW4M024HXhOjcVqN+Yalw+DnhbVDjjlr6fInjZYgu6R9p0jr2A
         giFhDJ4OR4wxg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Don't access NULL-cleared mpi pointer
Date:   Tue, 29 Jun 2021 11:51:38 +0300
Message-Id: <899ac1b33a995be5ec0e16a4765c4e43c2b1ba5b.1624956444.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The "dev->port[i].mp.mpi" is set to NULL during mlx5_ib_unbind_slave_port()
execution, however that field is needed to add device to unaffiliated list.

Such flow causes to the following kernel panic while unloading mlx5_ib
module in multi-port mode, hence the device should be added to the list
prior to unbind call.

 RPC: Unregistered rdma transport module.
 RPC: Unregistered rdma backchannel transport module.
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] SMP NOPTI
 CPU: 4 PID: 1904 Comm: modprobe Not tainted 5.13.0-rc7_for_upstream_min_debug_2021_06_24_12_08 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:mlx5_ib_cleanup_multiport_master+0x18b/0x2d0 [mlx5_ib]
 Code: 00 04 0f 85 c4 00 00 00 48 89 df e8 ef fa ff ff 48 8b 83 40 0d 00 00 48 8b 15 b9 e8 05 00 4a 8b 44 28 20 48 89 05 ad e8 05 00 <48> c7 00 d0 57 c5 a0 48 89 50 08 48 89 02 39 ab 88 0a 00 00 0f 86
 RSP: 0018:ffff888116ee3df8 EFLAGS: 00010296
 RAX: 0000000000000000 RBX: ffff8881154f6000 RCX: 0000000000000080
 RDX: ffffffffa0c557d0 RSI: ffff88810b69d200 RDI: 000000000002d8a0
 RBP: 0000000000000002 R08: ffff888110780408 R09: 0000000000000000
 R10: ffff88812452e1c0 R11: fffffffffff7e028 R12: 0000000000000000
 R13: 0000000000000080 R14: ffff888102c58000 R15: 0000000000000000
 FS:  00007f884393a740(0000) GS:ffff8882f5a00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000001249f6004 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  mlx5_ib_stage_init_cleanup+0x16/0xd0 [mlx5_ib]
  __mlx5_ib_remove+0x33/0x90 [mlx5_ib]
  mlx5r_remove+0x22/0x30 [mlx5_ib]
  auxiliary_bus_remove+0x18/0x30
  __device_release_driver+0x177/0x220
  driver_detach+0xc4/0x100
  bus_remove_driver+0x58/0xd0
  auxiliary_driver_unregister+0x12/0x20
  mlx5_ib_cleanup+0x13/0x897 [mlx5_ib]
  __x64_sys_delete_module+0x154/0x230
  ? exit_to_user_mode_prepare+0x104/0x140
  do_syscall_64+0x3f/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f8842e095c7
 Code: 73 01 c3 48 8b 0d d9 48 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 48 2c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffc68f6e758 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 00005638207929c0 RCX: 00007f8842e095c7
 RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000563820792a28
 RBP: 00005638207929c0 R08: 00007ffc68f6d701 R09: 0000000000000000
 R10: 00007f8842e82880 R11: 0000000000000206 R12: 0000563820792a28
 R13: 0000000000000001 R14: 0000563820792a28 R15: 00007ffc68f6fb40
 Modules linked in: xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype xt_conntrack nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay rdma_ucm ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_ipoib ib_cm ib_umad mlx5_ib(-) mlx4_ib ib_uverbs ib_core mlx4_en mlx4_core mlx5_core ptp pps_core [last unloaded: rpcrdma]
 CR2: 0000000000000000
 ---[ end trace a0bb7e20804e9e9b ]---

Fixes: 7ce6095e3bff ("RDMA/mlx5: Don't add slave port to unaffiliated list")
Reviewed-by: Itay Aveksis <itayav@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
This is fix the patch in the for-next.
---
 drivers/infiniband/hw/mlx5/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 90f8a6874cd1..9b8dd7a604c9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3345,9 +3345,10 @@ static void mlx5_ib_cleanup_multiport_master(struct mlx5_ib_dev *dev)
 			} else {
 				mlx5_ib_dbg(dev, "unbinding port_num: %u\n",
 					    i + 1);
-				mlx5_ib_unbind_slave_port(dev, dev->port[i].mp.mpi);
 				list_add_tail(&dev->port[i].mp.mpi->list,
 					      &mlx5_ib_unaffiliated_port_list);
+				mlx5_ib_unbind_slave_port(dev,
+							  dev->port[i].mp.mpi);
 			}
 		}
 	}
-- 
2.31.1

