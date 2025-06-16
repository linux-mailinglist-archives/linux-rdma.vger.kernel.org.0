Return-Path: <linux-rdma+bounces-11330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707CADAA85
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F99E3B3FC7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD226E16C;
	Mon, 16 Jun 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIeFcMFB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85B26E16A
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061827; cv=none; b=KXPa/KHDrtN5ndau3zckktoNIeohsFvqcFJOApYYKfDq1mNsYazZEiGRsYh/W4GeaWJWAnw4tSSvRjDynsHfljbW/ZylR0bK2yJB93NJhMPJ16eQSMjSoGeNYZQ4I+ESFnEx1C9YvyyVM5TLit7TTcEPc/iCfcamev9LTD+QXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061827; c=relaxed/simple;
	bh=pjnZOR5H4QicXkfdwGaidajcPKKcBY+4vvAMRn9yMvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkDTYraLwZ9cGAcz/fmPC+Symcjgjyz0rnLJLwzpYqPVzr7IcSdVKTfMCOUPsjCiGSVSMr6hbgCj6t9pqd6xiFZvyDOit67Vclyh/eM6PpnEJSPhQoLvi/t0KQX5tJtDXg+gT/cJuP3JEbOYzO1puYWwGyeAgYvsJ7plFNFl4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIeFcMFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B555C4CEEA;
	Mon, 16 Jun 2025 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750061826;
	bh=pjnZOR5H4QicXkfdwGaidajcPKKcBY+4vvAMRn9yMvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZIeFcMFBTswJEO8wg2QYht4OmOANnlL3lZzd6xcmlAyARzK0ZSaG+mbuGIgKaU6VQ
	 3XcjO4zbw/me+YvIM7m0puCffS9L84p4ach41izYaf6XTfLo3Q680LroNYkimIa7OQ
	 pAcqFlIoFt4cYqGo34IKmmtgyOiLFDhbPIMb7E85RiBKZjG0Ed3HjG3/goF4Ygbmlx
	 n4opbuCqgi3j+MpMGHQUR/InLIh03GDMNldAe7IEWGOSBVXj2SMsA6SShmp9eCuz+q
	 24gPzg4+vRp7znerpU5Vy2NIR/LjMGrx1ee1J+0jbbWH8hvaUjIYBoJyEZKpB/Ri6B
	 uyK9ImAsLqtxw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix unsafe xarray access in implicit ODP handling
Date: Mon, 16 Jun 2025 11:17:01 +0300
Message-ID: <a85ddd16f45c8cb2bc0a188c2b0fcedfce975eb8.1750061791.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

__xa_store() and __xa_erase() were used without holding the proper lock,
which led to a lockdep warning due to unsafe RCPU usage.
This patch replaces them with xa_store() and xa_erase(), which perform
the necessary locking internally.

=============================
WARNING: suspicious RCPU usage
6.14.0-rc7_for_upstream_debug_2025_03_18_15_01 #1 Not tainted
-----------------------------
./include/linux/xarray.h:1211 suspicious rcu_dereference_protected()
usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u136:0/219:
    at: process_one_work+0xbe4/0x15f0
    process_one_work+0x75c/0x15f0
    pagefault_mr+0x9a5/0x1390 [mlx5_ib]

stack backtrace:
CPU: 14 UID: 0 PID: 219 Comm: kworker/u136:0 Not tainted
6.14.0-rc7_for_upstream_debug_2025_03_18_15_01 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action [mlx5_ib]
Call Trace:
 dump_stack_lvl+0xa8/0xc0
 lockdep_rcu_suspicious+0x1e6/0x260
 xas_create+0xb8a/0xee0
 xas_store+0x73/0x14c0
 __xa_store+0x13c/0x220
 ? xa_store_range+0x390/0x390
 ? spin_bug+0x1d0/0x1d0
 pagefault_mr+0xcb5/0x1390 [mlx5_ib]
 ? _raw_spin_unlock+0x1f/0x30
 mlx5_ib_eqe_pf_action+0x3be/0x2620 [mlx5_ib]
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? mlx5_ib_invalidate_range+0xcb0/0xcb0 [mlx5_ib]
 process_one_work+0x7db/0x15f0
 ? pwq_dec_nr_in_flight+0xda0/0xda0
 ? assign_work+0x168/0x240
 worker_thread+0x57d/0xcd0
 ? rescuer_thread+0xc40/0xc40
 kthread+0x3b3/0x800
 ? kthread_is_per_cpu+0xb0/0xb0
 ? lock_downgrade+0x680/0x680
 ? do_raw_spin_lock+0x12d/0x270
 ? spin_bug+0x1d0/0x1d0
 ? finish_task_switch.isra.0+0x284/0x9e0
 ? lockdep_hardirqs_on_prepare+0x284/0x400
 ? kthread_is_per_cpu+0xb0/0xb0
 ret_from_fork+0x2d/0x70
 ? kthread_is_per_cpu+0xb0/0xb0
 ret_from_fork_asm+0x11/0x20

Fixes: d3d930411ce3 ("RDMA/mlx5: Fix implicit ODP use after free")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index eaa2f9f5f3a9..f6abd64f07f7 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -259,8 +259,8 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	}
 
 	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
-		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
-			   mlx5_base_mkey(mr->mmkey.key));
+		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			 mlx5_base_mkey(mr->mmkey.key));
 	xa_unlock(&imr->implicit_children);
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
@@ -532,8 +532,8 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	}
 
 	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
-		ret = __xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-				 &mr->mmkey, GFP_KERNEL);
+		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			       &mr->mmkey, GFP_KERNEL);
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
 			__xa_erase(&imr->implicit_children, idx);
-- 
2.49.0


