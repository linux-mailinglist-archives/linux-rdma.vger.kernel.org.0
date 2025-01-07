Return-Path: <linux-rdma+bounces-6882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994BA03EDF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4BD1604DF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666641E47C4;
	Tue,  7 Jan 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC0MTv2B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272051E377E
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251983; cv=none; b=OCKrJK3V6r4LYYghfeQKsk5RK8TfruTm27XLivRLqMJl+uJ9ZC9HxPp6U0LmzT61UF2xJ4rAe5bvpH7RaoZEHNIfWzxsPUCd6W+HgP6TFI3lqd45RAwojC0NsrJ/Vbh/WJxgztMRkVftqcvnXct9r9ltJDEiCt9IJ70nw36y95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251983; c=relaxed/simple;
	bh=0YUwdJkknUpFMsc2iCLhedZOtbp5WspDWetZMbB79gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4TajrV02cQer5eNyUtMjIZPSnG3FkmOFW0i0zM1RsBtmjDBYyCNUb0Pmyz51SOrCwEy6Ul9pRJgUnlqSjy1WUsZfdryfedrxElDdm+MXS7gMdzSzBDKvnvTDOucEuChhjCT5lqWqTLbI1lgq4mCcaGtDypkNE+AdWZDaoBitQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC0MTv2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3580EC4CED6;
	Tue,  7 Jan 2025 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251982;
	bh=0YUwdJkknUpFMsc2iCLhedZOtbp5WspDWetZMbB79gs=;
	h=From:To:Cc:Subject:Date:From;
	b=BC0MTv2BpjwGfep1rblWnz0/KZKcc1+7J8SAisnAv4tD1+QR4eTc9LjbX8eZifnZB
	 5xJG+gEFzGyW5GJXpZkv3e4GseUoki2SdLyCYt1Zitg6qzaDO8507IyE28+fpTMzIA
	 i2llfEctOc4Zq71vyRn2TwCOeFF2hl4kpH9qs7ZoU8GAntROkz4LVbgfOhiL2YB/rm
	 6EvKcinlqgeunqES7ZjOsZ2VSmJHr2oV2bJQWx6LMxIlFeGpFz41PJ0dJpRHngC7iA
	 CHYMh6SXvx3jqQJrtg8CjrpxAu6hwhqRGkFl2JrBNcJwoSQMoRBGsg7w/++noo97+b
	 Xq1RV1klYtEfg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix implicit ODP use after free
Date: Tue,  7 Jan 2025 14:12:53 +0200
Message-ID: <84ecb15d9f251dd760377e53da0de9eb385ea65c.1736251907.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Prevent double queueing of implicit ODP mr destroy work by adding a bit
to the MR indicating if this MR is already queued for destruction.

Without this bit, we could try to invalidate this mr twice, which in
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
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 ++
 drivers/infiniband/hw/mlx5/odp.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a0138bdfa3894..696f48d871bda 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -687,6 +687,8 @@ struct mlx5_ib_mr {
 	/* The mr is data direct related */
 	u8 data_direct :1;
 
+	u8 implicit_destroy_queued :1;
+
 	union {
 		/* Used only by kernel MRs (umem == NULL) */
 		struct {
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 513023075c612..b65c3c431ddbe 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -240,6 +240,9 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *imr = mr->parent;
 
+	if (mr->implicit_destroy_queued)
+		return;
+
 	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
 		return;
 
@@ -248,6 +251,7 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
 			 mlx5_base_mkey(mr->mmkey.key));
 
+	mr->implicit_destroy_queued = 1;
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
 	queue_work(system_unbound_wq, &mr->odp_destroy.work);
-- 
2.47.1


