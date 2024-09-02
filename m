Return-Path: <linux-rdma+bounces-4705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93017968915
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C951C21B0C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612520124A;
	Mon,  2 Sep 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqhb24RZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833918028
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284581; cv=none; b=snZr86wHbICD5F2NtqNP0bXraPtPpYvKBbNERStnGjJvoGT19uYZYULIIqA5HSkJU1FSsSel9EFOuBL4GjRjcCi+KdqUf2ITw1cve5v9SLly0tt9x/Zm54LpgDhqSPRxKqp4xgEr2HUiGGdLlvZLim/O48Qe7F1IzwOpudbz8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284581; c=relaxed/simple;
	bh=VhBJQ7y7MwbWFPweqn5EjtBncsk7b9YXztdgUYS2/Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txcHJxVBEdFA3rSDJS6YbkVS7oMhDM991jOcn3HRw0Xz5Ix8Ezd9wdxmkgxirfv0GhrsQ0jnAvDuLenU+zzPQ0+AOsdhJ7RO+qDjCdiKYk5HqO4J+tQGH1xmJRf1xjDibqk2nD5h8Wj+3hEay8vpAiEgVFpGsVQkmpTahB9SheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqhb24RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8D0C4CEC2;
	Mon,  2 Sep 2024 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725284581;
	bh=VhBJQ7y7MwbWFPweqn5EjtBncsk7b9YXztdgUYS2/Jw=;
	h=From:To:Cc:Subject:Date:From;
	b=qqhb24RZlQmnqobw3wtbMHnh7gZD87ndqVvVbW4Yl2+Tl4I3nSLdgoUbeLKbExlfy
	 wxsCHvJ1i4nZ7ZoEZHUeexRFyu6sL1gGYC70PWk6zTEzZN8ekp3B6Tes5T1VPZoplT
	 Wc/6NdY7h0PhMqsZUKSr57Evcsjeq5v/RcJ3fnvzA+HOT2vIWTkqIGSiOYB50youjQ
	 KDOrWmYRmtu88v5Zqrp8z+4dmJwGvT+kGTZIFYi8NumVpNAQXqaYJd2lqTMZ4Di3Rq
	 QDspOPVZoLgRUUvSeHnU1RNeqGV6zsoiwkYzHQLTHZc1UpqW778VbL0OmAT10wDSWc
	 0zM8cf4VGD6RQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
Subject: [PATCH rdma-next] RDMA/core: Skip initialized but not leaked GID entries
Date: Mon,  2 Sep 2024 16:42:52 +0300
Message-ID: <7cce156160c4da8062e3cc8c5e9d5b7880feaafd.1725284500.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Failure in driver initialization can lead to a situation where the GID
entries are set but not used yet. In this case, the kref will be equal to 1,
which will trigger a false positive leak detection.

For example, these messages are printed during the driver initialization
and followed by release_gid_table() call:

 infiniband syz1: ib_query_port failed (-19)
 infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
------------[ cut here ]------------
 GID entry ref leak for dev syz1 index 0 ref=1
 WARNING: CPU: 0 PID: 19837 at drivers/infiniband/core/cache.c:806 gid_table_release_one+0x387/0x4b0
 Modules linked in:
 CPU: 0 UID: 0 PID: 19837 Comm: syz.1.3934 Not tainted 6.11.0-rc5-syzkaller-00079-g928f79a188aa #0
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:gid_table_release_one+0x387/0x4b0
 Code: 78 07 00 00 48 85 f6 74 2a 48 89 74 24 38
e8 b0 0a 76 f9 48 8b 74 24 38 44 89 f9 89 da 48 c7 c7 c0 69 51 8c e8 5a
c3 38 f9 90 <0f> 0b 90 90 e9 6f fe ff ff e8 8b 0a 76 f9 49 8d bc 24 28
07 00 00
 RSP: 0018:ffffc900042b7080 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002811e000
 RDX: 0000000000040000 RSI: ffffffff814dd406 RDI: 0000000000000001
 RBP: ffff88807ebaaf00 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000001 R11: 0000000000000000 R12: ffff888051860000
 R13: dffffc0000000000 R14: ffffed100fd755fb R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:00000000f56c6b40
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 000000002effcff8 CR3: 0000000060c5e000 CR4: 0000000000350ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
 Call Trace:
  <TASK>
  ? show_regs+0x8c/0xa0
  ? __warn+0xe5/0x3c0
  ? gid_table_release_one+0x387/0x4b0
  ? report_bug+0x3c0/0x580
  ? handle_bug+0x3d/0x70
  ? exc_invalid_op+0x17/0x50
  ? asm_exc_invalid_op+0x1a/0x20
  ? __warn_printk+0x1a6/0x350
  ? gid_table_release_one+0x387/0x4b0
  ib_device_release+0xef/0x1e0
  ? __pfx_ib_device_release+0x10/0x10
  device_release+0xa1/0x240
  kobject_put+0x1e4/0x5a0
  put_device+0x1f/0x30
  rxe_net_add+0xe0/0x110
  rxe_newlink+0x70/0x190
  nldev_newlink+0x373/0x5e0
  ? __pfx_nldev_newlink+0x10/0x10
  ? aa_get_newest_label+0x376/0x680
  ? __pfx_lock_acquire+0x10/0x10
  ? __pfx_aa_get_newest_label+0x10/0x10
  ? __pfx_rwsem_read_trylock+0x10/0x10
  ? __pfx___might_resched+0x10/0x10
  ? apparmor_capable+0x114/0x1d0
  ? ns_capable+0xd7/0x110
  ? __pfx_nldev_newlink+0x10/0x10
  rdma_nl_rcv_msg+0x388/0x6e0
  ? __pfx_rdma_nl_rcv_msg+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  ? find_held_lock+0x2d/0x110
  rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450
  ? __pfx_rdma_nl_rcv_skb.constprop.0.isra.0+0x10/0x10
  ? netlink_deliver_tap+0x1ae/0xcf0
  netlink_unicast+0x53c/0x7f0
  ? __pfx_netlink_unicast+0x10/0x10
  ? __phys_addr_symbol+0x30/0x80
  ? __check_object_size+0x497/0x720
  netlink_sendmsg+0x8b8/0xd70
  ? __pfx_netlink_sendmsg+0x10/0x10
  ? bpf_lsm_socket_sendmsg+0x9/0x10
  ____sys_sendmsg+0x9b4/0xb50
  ? __pfx_____sys_sendmsg+0x10/0x10
  ? get_compat_msghdr+0x11b/0x170
  ? __pfx___lock_acquire+0x10/0x10
  ? try_to_wake_up+0xc08/0x13e0
  ___sys_sendmsg+0x135/0x1e0
  ? __pfx____sys_sendmsg+0x10/0x10
  ? __fget_light+0x173/0x210
  __sys_sendmsg+0x117/0x1f0
  ? __pfx___sys_sendmsg+0x10/0x10
  ? __ia32_sys_futex_time32+0x1da/0x460
  __do_fast_syscall_32+0x73/0x120
  do_fast_syscall_32+0x32/0x80
  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
 RIP: 0023:0xf7f20579
 Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01
10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5
0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00
00 00 00
 RSP: 002b:00000000f56c656c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
 RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00000000200003c0
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
SYZFAIL: failed to recv rpc fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
 Kernel panic - not syncing: kernel: panic_on_warn set ...

In order to fix it, don't print kern

Fixes: a92fbeac7e94 ("RDMA/cache: Release GID table even if leak is detected")
Reported-by: syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000d70eed06211ac86b@google.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index b7c078b7f7cf..c6aec2e04d4c 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -800,13 +800,15 @@ static void release_gid_table(struct ib_device *device,
 		return;
 
 	for (i = 0; i < table->sz; i++) {
+		int gid_kref;
+
 		if (is_gid_entry_free(table->data_vec[i]))
 			continue;
 
-		WARN_ONCE(true,
+		gid_kref = kref_read(&table->data_vec[i]->kref);
+		WARN_ONCE(gid_kref > 1,
 			  "GID entry ref leak for dev %s index %d ref=%u\n",
-			  dev_name(&device->dev), i,
-			  kref_read(&table->data_vec[i]->kref));
+			  dev_name(&device->dev), i, gid_kref);
 	}
 
 	mutex_destroy(&table->lock);
-- 
2.46.0


