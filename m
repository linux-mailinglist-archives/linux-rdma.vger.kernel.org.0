Return-Path: <linux-rdma+bounces-7625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86656A2EB15
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7393E3A291E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402901CB31D;
	Mon, 10 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghL2qOCS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318A1B87F1
	for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187080; cv=none; b=cii7bh8jYAeueIlvBgFMr10Nv637k4kNd+XIE50MWjxGk6r6Bf9BZpUnqbkeD/FsTbOy0PpY+P5LIDhwHf5v1citbkaUXzEqc7Z8y3cSOJ6TjP56szhvg9zSjvJbdeTApfIqELT9YPdQekFRcfo2V1Mob5kq91kbyxtGGkAJNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187080; c=relaxed/simple;
	bh=qsIcbPg+b5rhReCuOmvcNBEywaHib4qwDy+eacFBf0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWP3okg4hofvKgYmBuIVOwZ/CnY9/gbmQJWDPpwgkXLUPT52zQ0g59kIlsJi0xLL7GDRCr2CCOXfy9SaJoYLh+Fc2xFdxvdKPL6wcS6YcpFkKRJZBps5YP6s7T8zEVNK9zjmpgnEBkXrpCMVf3JYuTQu1WBTn/BFIFYU2hGqZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghL2qOCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0142FC4CED1;
	Mon, 10 Feb 2025 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739187079;
	bh=qsIcbPg+b5rhReCuOmvcNBEywaHib4qwDy+eacFBf0k=;
	h=From:To:Cc:Subject:Date:From;
	b=ghL2qOCSL00wGRBzKxb9wHyB7EyKTuOisBBSJhUYZ63aYgc55TSnGt2MbIDJfbsAw
	 /f1VXXK+tshbR3Edg+d8dqAynN0D7Ka2RbiuIOlZBB7aLVR6UbsYzx6loOpupURRFV
	 buyxsoSgPN5dpA/4rudaB2me24cZX4Me0pWjF+JM9osTnN5FwpgZIGsZZle2orhnnu
	 2jrI0DuDdsGpf3DWGXKVYRVlHB1z8kzFeTWxMPSYIUtnNPeb5qFj3Xs+crZN/NG3sp
	 8sF0im4iRpyGqHdPgftnmxWxQpOKT1Kj3OpgVolGTkaUUQlDT0G/NOJWDkysOban1a
	 TrTz8BlI/NXyQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix implicit ODP hang on parent deregistration
Date: Mon, 10 Feb 2025 13:31:11 +0200
Message-ID: <80f2fcd19952dfa7d9981d93fd6359b4471f8278.1739186929.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Fix the destroy_unused_implicit_child_mr() to prevent hanging during
parent deregistration as of below [1].

Upon entering destroy_unused_implicit_child_mr(), the reference count
for the implicit MR parent is incremented using:
refcount_inc_not_zero().

A corresponding decrement must be performed if
free_implicit_child_mr_work() is not called.

The code has been updated to properly manage the reference count that
was incremented.

[1]
INFO: task python3:2157 blocked for more than 120 seconds.
Not tainted 6.12.0-rc7+ #1633
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:python3         state:D stack:0     pid:2157 tgid:2157  ppid:1685   flags:0x00000000
Call Trace:
<TASK>
__schedule+0x420/0xd30
schedule+0x47/0x130
__mlx5_ib_dereg_mr+0x379/0x5d0 [mlx5_ib]
? __pfx_autoremove_wake_function+0x10/0x10
ib_dereg_mr_user+0x5f/0x120 [ib_core]
? lock_release+0xc6/0x280
destroy_hw_idr_uobject+0x1d/0x60 [ib_uverbs]
uverbs_destroy_uobject+0x58/0x1d0 [ib_uverbs]
uobj_destroy+0x3f/0x70 [ib_uverbs]
ib_uverbs_cmd_verbs+0x3e4/0xbb0 [ib_uverbs]
? __pfx_uverbs_destroy_def_handler+0x10/0x10 [ib_uverbs]
? lock_acquire+0xc1/0x2f0
? ib_uverbs_ioctl+0xcb/0x170 [ib_uverbs]
? ib_uverbs_ioctl+0x116/0x170 [ib_uverbs]
? lock_release+0xc6/0x280
ib_uverbs_ioctl+0xe7/0x170 [ib_uverbs]
? ib_uverbs_ioctl+0xcb/0x170 [ib_uverbs]
 __x64_sys_ioctl+0x1b0/0xa70
? kmem_cache_free+0x221/0x400
do_syscall_64+0x6b/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f20f21f017b
RSP: 002b:00007ffcfc4a77c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcfc4a78d8 RCX: 00007f20f21f017b
RDX: 00007ffcfc4a78c0 RSI: 00000000c0181b01 RDI: 0000000000000003
RBP: 00007ffcfc4a78a0 R08: 000056147d125190 R09: 00007f20f1f14c60
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffcfc4a7890
R13: 000000000000001c R14: 000056147d100fc0 R15: 00007f20e365c9d0
</TASK>

Fixes: d3d930411ce3 ("RDMA/mlx5: Fix implicit ODP use after free")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Artemy Kovalyov <artemyko@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 89057faf3bf4..a1f80e03c5d2 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -254,6 +254,7 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
 	    mr) {
 		xa_unlock(&imr->implicit_children);
+		mlx5r_deref_odp_mkey(&imr->mmkey);
 		return;
 	}
 
-- 
2.48.1


