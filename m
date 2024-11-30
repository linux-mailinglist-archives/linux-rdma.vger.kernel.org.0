Return-Path: <linux-rdma+bounces-6168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF79DF393
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2024 23:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564CC2815FF
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2024 22:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745F15A864;
	Sat, 30 Nov 2024 22:53:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF412B93;
	Sat, 30 Nov 2024 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733007182; cv=none; b=e2QyQT2PHd+U0nzVK8snJ7gdTWSPk78CW170BlrynzUVj+DGk2iLfgGNhPnovNa3pSPa4Cr1L6Qypfncm5iUBmyWHGlgK05VFRk5J4V2yb8TGsnocxcs6x/8cwZg3CYiw5OBMozk+CavRotcHv+rDIyDejAxBW0zstt4yMNuodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733007182; c=relaxed/simple;
	bh=LEeVOlUYjPThplReczUYZlo3DgovBTAiLD4zPKyjfkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AphXe7HRZKVTCCBqLYd/kFy/HsoCT2lVqXH7MHQ4XcP9O0t3e4SNxznbIU6FaGKX4IpKTTy8ll08LbZfpsnM4ODyD5DtmOAKGDQztLdE6jABWdm6W11tLLbuc3GekbLa0wLQGI+k6q/z7ozBDRryvS0PTFnKucXc+hntRalmE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 1 Dec
 2024 01:52:54 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 1 Dec 2024
 01:52:54 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Doug Ledford
	<dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10] IB/core: Fix ib_cache_setup_one error flow cleanup
Date: Sat, 30 Nov 2024 14:52:49 -0800
Message-ID: <20241130225249.31899-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 1403c8b14765eab805377dd3b75e96ace8747aed ]

When ib_cache_update return an error, we exit ib_cache_setup_one
instantly with no proper cleanup, even though before this we had
already successfully done gid_table_setup_one, that results in
the kernel WARN below.

Do proper cleanup using gid_table_cleanup_one before returning
the err in order to fix the issue.

WARNING: CPU: 4 PID: 922 at drivers/infiniband/core/cache.c:806 gid_table_release_one+0x181/0x1a0
Modules linked in:
CPU: 4 UID: 0 PID: 922 Comm: c_repro Not tainted 6.11.0-rc1+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:gid_table_release_one+0x181/0x1a0
Code: 44 8b 38 75 0c e8 2f cb 34 ff 4d 8b b5 28 05 00 00 e8 23 cb 34 ff 44 89 f9 89 da 4c 89 f6 48 c7 c7 d0 58 14 83 e8 4f de 21 ff <0f> 0b 4c 8b 75 30 e9 54 ff ff ff 48 8    3 c4 10 5b 5d 41 5c 41 5d 41
RSP: 0018:ffffc90002b835b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff811c8527
RDX: 0000000000000000 RSI: ffffffff811c8534 RDI: 0000000000000001
RBP: ffff8881011b3d00 R08: ffff88810b3abe00 R09: 205d303839303631
R10: 666572207972746e R11: 72746e6520444947 R12: 0000000000000001
R13: ffff888106390000 R14: ffff8881011f2110 R15: 0000000000000001
FS:  00007fecc3b70800(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000340 CR3: 000000010435a001 CR4: 00000000003706b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? show_regs+0x94/0xa0
 ? __warn+0x9e/0x1c0
 ? gid_table_release_one+0x181/0x1a0
 ? report_bug+0x1f9/0x340
 ? gid_table_release_one+0x181/0x1a0
 ? handle_bug+0xa2/0x110
 ? exc_invalid_op+0x31/0xa0
 ? asm_exc_invalid_op+0x16/0x20
 ? __warn_printk+0xc7/0x180
 ? __warn_printk+0xd4/0x180
 ? gid_table_release_one+0x181/0x1a0
 ib_device_release+0x71/0xe0
 ? __pfx_ib_device_release+0x10/0x10
 device_release+0x44/0xd0
 kobject_put+0x135/0x3d0
 put_device+0x20/0x30
 rxe_net_add+0x7d/0xa0
 rxe_newlink+0xd7/0x190
 nldev_newlink+0x1b0/0x2a0
 ? __pfx_nldev_newlink+0x10/0x10
 rdma_nl_rcv_msg+0x1ad/0x2e0
 rdma_nl_rcv_skb.constprop.0+0x176/0x210
 netlink_unicast+0x2de/0x400
 netlink_sendmsg+0x306/0x660
 __sock_sendmsg+0x110/0x120
 ____sys_sendmsg+0x30e/0x390
 ___sys_sendmsg+0x9b/0xf0
 ? kstrtouint+0x6e/0xa0
 ? kstrtouint_from_user+0x7c/0xb0
 ? get_pid_task+0xb0/0xd0
 ? proc_fail_nth_write+0x5b/0x140
 ? __fget_light+0x9a/0x200
 ? preempt_count_add+0x47/0xa0
 __sys_sendmsg+0x61/0xd0
 do_syscall_64+0x50/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 1901b91f9982 ("IB/core: Fix potential NULL pointer dereference in pkey cache")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Link: https://patch.msgid.link/79137687d829899b0b1c9835fcb4b258004c439a.1725273354.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[Nikita: minor fix to resolve merge conflict.]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/infiniband/core/cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 7989b7e1d1c0..21b405abb0e1 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1633,8 +1633,10 @@ int ib_cache_setup_one(struct ib_device *device)
 
 	rdma_for_each_port (device, p) {
 		err = ib_cache_update(device, p, true);
-		if (err)
+		if (err) {
+			gid_table_cleanup_one(device);
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.25.1


