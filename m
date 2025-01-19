Return-Path: <linux-rdma+bounces-7080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B398A160E2
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 09:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB2107A30C0
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADD19B59C;
	Sun, 19 Jan 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dby3Nh38"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CF42A92
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737274912; cv=none; b=ffDldI0enNNBikykv2DIGVfKY13lJM67Kz8RfZiwNYAx7DdTkl7wsu678sOVnZfH7dZbqWGuQ588doKTCSAuX3m4Y79AlcrfHQxb9d06QSaj5JZh+9UdiKmdDF6PLZEVvtGOn1GeIfbcwdSChLX3OsKx0g37A7sd+fGg/YUxPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737274912; c=relaxed/simple;
	bh=Hlm2OfSKa1CCILt0NxR5HndxJyBhf8y2a9qR8zb7p8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNON4J3lSUlb8uFvOlpxlFnKDJ8oh5Ce1uV+36izcYbUlOuv/fFeEDwTv0iu9mM4YBFoTUZXOgKVdYbg34CrI50RLDKzBd5T72udACM77Y7RDA5L8UxqKR0s+PHTJg/DV4eaGLKOqCgUMjJjowxWk+DRW9rBi+XrCFM6V4dnm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dby3Nh38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D8C4CED6;
	Sun, 19 Jan 2025 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737274912;
	bh=Hlm2OfSKa1CCILt0NxR5HndxJyBhf8y2a9qR8zb7p8I=;
	h=From:To:Cc:Subject:Date:From;
	b=dby3Nh38AbP8o2IZ1uru9wF/BB640TfLv3bSZuPLJgOr8B4SRNcW8y9R3OQK5E1PG
	 hMp7q3tn4ozsxZS5bxn7Fwam7wOGVbH9VTZi7jlYReLpw2TpmRR8Iv+C/vRJ9ARtG9
	 9Nh6yr7ESUZ0ieR/X3JjBSIZ2xJmJ6nxMtAp2WlOlBjs+jxnHhgmlPrQGfg+dX0WVq
	 WPaVtC9lpYHa9nPVMCt9vcIMp17xinFhXW1IuCwfLjHs8fCq85hmRsNasnrwTItnD/
	 pDFvBQHLZl+IYej4KzNr6RcUKxWHUibSTSqEeqGZHkUUO77iLhZrDdboYyBcMCJf8Y
	 g1eyn7vMtzQDg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1] RDMA/mlx5: Fix implicit ODP use after free
Date: Sun, 19 Jan 2025 10:21:41 +0200
Message-ID: <c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Prevent double queueing of implicit ODP mr destroy work by using
__xa_cmpxchg() to make sure, this is the first and last time we are
destroying this specific mr.

Without this change, we could try to invalidate this mr twice, which in
turn could result in queuing a MR work destroy twice, and eventually the
second work could execute after the MR was freed due to the first work,
causing a user after free and trace below.

refcount_t: underflow; use-after-free.
WARNING: CPU: 2 PID: 12178 at lib/refcount.c:28 refcount_warn_saturate+0x12b/0x130
Modules linked in: bonding ib_ipoib vfio_pci ip_gre geneve nf_tables ip6_gre gre ip6_tunnel tunnel6 ipip tunnel4 ib_umad rdma_ucm mlx5_vfio_pci vfio_pci_core vfio_iommu_type1 mlx5_ib vfio ib_uverbs mlx5_core iptable_raw openvswitch nsh rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc fuse [last unloaded: ib_uverbs]
CPU: 2 PID: 12178 Comm: kworker/u20:5 Not tainted 6.5.0-rc1_net_next_mlx5_58c644e #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound free_implicit_child_mr_work [mlx5_ib]
RIP: 0010:refcount_warn_saturate+0x12b/0x130
Code: 48 c7 c7 38 95 2a 82 c6 05 bc c6 fe 00 01 e8 0c 66 aa ff 0f 0b 5b c3 48 c7 c7 e0 94 2a 82 c6 05 a7 c6 fe 00 01 e8 f5 65 aa ff <0f> 0b 5b c3 90 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 13 8d 50 ff
RSP: 0018:ffff8881008e3e40 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
RDX: ffff88852c91b5c8 RSI: 0000000000000001 RDI: ffff88852c91b5c0
RBP: ffff8881dacd4e00 R08: 00000000ffffffff R09: 0000000000000019
R10: 000000000000072e R11: 0000000063666572 R12: ffff88812bfd9e00
R13: ffff8881c792d200 R14: ffff88810011c005 R15: ffff8881002099c0
FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5694b5e000 CR3: 00000001153f6003 CR4: 0000000000370ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn+0x79/0x120
 ? refcount_warn_saturate+0x12b/0x130
 ? report_bug+0x17c/0x190
 ? handle_bug+0x3c/0x60
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0x12b/0x130
 free_implicit_child_mr_work+0x180/0x1b0 [mlx5_ib]
 ? try_to_wake_up+0x5d/0x450
 ? destroy_sched_domains_rcu+0x30/0x30
 process_one_work+0x1cc/0x3c0
 worker_thread+0x218/0x3c0
 ? process_one_work+0x3c0/0x3c0
 kthread+0xc6/0xf0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>
---[ end trace 0000000000000000 ]---

Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1: Used code suggestion from Jason
v0: https://lore.kernel.org/all/84ecb15d9f251dd760377e53da0de9eb385ea65c.1736251907.git.leon@kernel.org
---
 drivers/infiniband/hw/mlx5/odp.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index da7b4d6ad2c3..f4cd50a3693c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -240,13 +240,20 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *imr = mr->parent;
 
-	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
+	xa_lock(&imr->implicit_children);
+	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
+	    mr) {
+		xa_unlock(&imr->implicit_children);
 		return;
+	}
 
-	xa_erase(&imr->implicit_children, idx);
 	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
-		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
-			 mlx5_base_mkey(mr->mmkey.key));
+		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			   mlx5_base_mkey(mr->mmkey.key));
+	xa_unlock(&imr->implicit_children);
+
+	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
+		return;
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
@@ -513,18 +520,18 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		refcount_inc(&ret->mmkey.usecount);
 		goto out_lock;
 	}
-	xa_unlock(&imr->implicit_children);
 
 	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
-		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-			       &mr->mmkey, GFP_KERNEL);
+		ret = __xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+				 &mr->mmkey, GFP_KERNEL);
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
-			xa_erase(&imr->implicit_children, idx);
-			goto out_mr;
+			__xa_erase(&imr->implicit_children, idx);
+			goto out_lock;
 		}
 		mr->mmkey.type = MLX5_MKEY_IMPLICIT_CHILD;
 	}
+	xa_unlock(&imr->implicit_children);
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
-- 
2.47.1


