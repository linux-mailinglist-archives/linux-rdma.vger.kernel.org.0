Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B513A258F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFJHgi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 03:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhFJHgf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 03:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7AB261359;
        Thu, 10 Jun 2021 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623310479;
        bh=FaWBJoAHnQ/3iETug4WaCr2lvUOXErWFq6SMOd6MG6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgQJoqmKum74BCUwb+S8Wn7W/n21FJd86v9YESvmvXLr4jn6O+T2rgLnEnlt0TQZa
         DEUNY5bgHun2VIhUW8sSW9gCuX9HJ+sgLfwXAAIUZ7Ut/LUAr1JBFZK0jv2iCWb0JT
         nnbu7nyIaf4tWxtmB+WmHZZuHZhwhuM48jzC1iQi0+YfZq6sOChYha7irHso2WOv3z
         wshFUH0V4B+pGpRo7cMY9jj6F9nhsTFCqwctMCEjtVqop9AL0phF71+c5WrUbq5Rhf
         U1wT9WlDJXE854ZvHM6ELaS4Uko5FdSkcMTK9OrC/g3UBOW7r+MpSEskd+CkdQ6Qh6
         4JGVZ+tp9Kbcw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, Alaa Hleihel <alaa@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 2/3] RDMA/mlx5: Delete right entry from MR signature database
Date:   Thu, 10 Jun 2021 10:34:26 +0300
Message-Id: <f3f585ea0db59c2a78f94f65eedeafc5a2374993.1623309971.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623309971.git.leonro@nvidia.com>
References: <cover.1623309971.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

The value mr->sig is stored in the entry upon mr allocation, however, ibmr
is entered here as "old", therefore, xa_cmpxchg() does not replace the
entry with NULL, which leads to the following trace:

 WARNING: CPU: 28 PID: 2078 at drivers/infiniband/hw/mlx5/main.c:3643 mlx5_ib_stage_init_cleanup+0x4d/0x60 [mlx5_ib]
 Modules linked in: nvme_rdma nvme_fabrics nvme_core 8021q garp mrp bonding bridge stp llc rfkill rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_tad
 CPU: 28 PID: 2078 Comm: reboot Tainted: G               X --------- ---  5.13.0-0.rc2.19.el9.x86_64 #1
 Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 2.9.1 12/07/2018
 RIP: 0010:mlx5_ib_stage_init_cleanup+0x4d/0x60 [mlx5_ib]
 Code: 8d bb 70 1f 00 00 be 00 01 00 00 e8 9d 94 ce da 48 3d 00 01 00 00 75 02 5b c3 0f 0b 5b c3 0f 0b 48 83 bb b0 20 00 00 00 74 d5 <0f> 0b eb d1 4
 RSP: 0018:ffffa8db06d33c90 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffff97f890a44000 RCX: ffff97f900ec0160
 RDX: 0000000000000000 RSI: 0000000080080001 RDI: ffff97f890a44000
 RBP: ffffffffc0c189b8 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000001 R11: 0000000000000300 R12: ffff97f890a44000
 R13: ffffffffc0c36030 R14: 00000000fee1dead R15: 0000000000000000
 FS:  00007f0d5a8a3b40(0000) GS:ffff98077fb80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000555acbf4f450 CR3: 00000002a6f56002 CR4: 00000000001706e0
 Call Trace:
  mlx5r_remove+0x39/0x60 [mlx5_ib]
  auxiliary_bus_remove+0x1b/0x30
  __device_release_driver+0x17a/0x230
  device_release_driver+0x24/0x30
  bus_remove_device+0xdb/0x140
  device_del+0x18b/0x3e0
  mlx5_detach_device+0x59/0x90 [mlx5_core]
  mlx5_unload_one+0x22/0x60 [mlx5_core]
  shutdown+0x31/0x3a [mlx5_core]
  pci_device_shutdown+0x34/0x60
  device_shutdown+0x15b/0x1c0
  __do_sys_reboot.cold+0x2f/0x5b
  ? vfs_writev+0xc7/0x140
  ? handle_mm_fault+0xc5/0x290
  ? do_writev+0x6b/0x110
  do_syscall_64+0x40/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f0d5b5132e7
 Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 8
 RSP: 002b:00007ffd7c7b8388 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0d5b5132e7
 RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
 RBP: 00007ffd7c7b83d0 R08: 000000000000000a R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
 R13: 00007ffd7c7b8578 R14: 0000564da83690bd R15: 000000000000000

Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 9662cd39c7ff..425423dfac72 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1940,8 +1940,8 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		mlx5r_deref_wait_odp_mkey(&mr->mmkey);
 
 	if (ibmr->type == IB_MR_TYPE_INTEGRITY) {
-		xa_cmpxchg(&dev->sig_mrs, mlx5_base_mkey(mr->mmkey.key), ibmr,
-			   NULL, GFP_KERNEL);
+		xa_cmpxchg(&dev->sig_mrs, mlx5_base_mkey(mr->mmkey.key),
+			   mr->sig, NULL, GFP_KERNEL);
 
 		if (mr->mtt_mr) {
 			rc = mlx5_ib_dereg_mr(&mr->mtt_mr->ibmr, NULL);
-- 
2.31.1

