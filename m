Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D7454665
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 13:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhKQMaJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 07:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhKQMaJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Nov 2021 07:30:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E36FE61544;
        Wed, 17 Nov 2021 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637152030;
        bh=k1QE0zqCuN95jMbGvnJu6nhX4UWTJyWyVkQQHpoy7lU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ge+ZAroaW5+yC1C/HZKJ1ImFu+Di6l32wlzmnNJCpA+ZhdvJ9waVuOhSkkAUpJZ5w
         snfvtEkERS3LeRyBp9CXPC+v1BTz42CrvYsEKiQlmdlzx3C6yXOCFbfhtMvc7+cadb
         GTKWTFLlim36kdcZ8n0VKCo35XGERhvOAyQ1aGQ+lbvSE36+1a4MYLbIrh159ZbvnX
         bAtLtwsRvgM+uzjEeoDqmqt/y0sgDJ/9cfumktM+qmusXpC4Mn05YuRXX1/ecrd/Zz
         1Oz19emlfV9UhUt6GhZ5Qw4uArctHx1E4maW/fHqA8G+aLsTs/YTCWZL7nCcu1idFZ
         ew/W3PP6VtJkA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        syzbot+9111d2255a9710e87562@syzkaller.appspotmail.com
Subject: [PATCH rdma-rc] RDMA/nldev: Check stat attribute before accessing it
Date:   Wed, 17 Nov 2021 14:27:04 +0200
Message-Id: <b21967c366f076ff1988862f9c8a1aa0244c599f.1637151999.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The access to non-existent netlink attribute causes to the following
kernel panic. Fix it by checking existence before trying to read it.

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 6744 Comm: syz-executor.0 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:nla_get_u32 include/net/netlink.h:1554 [inline]
RIP: 0010:nldev_stat_set_mode_doit drivers/infiniband/core/nldev.c:1909 [inline]
RIP: 0010:nldev_stat_set_doit+0x578/0x10d0 drivers/infiniband/core/nldev.c:2040
Code: fa 4c 8b a4 24 f8 02 00 00 48 b8 00 00 00 00 00 fc ff df c7 84 24 80 00 00 00 00 00 00 00 49 8d 7c 24 04 48 89
fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 02
RSP: 0018:ffffc90004acf2e8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90002b94000
RDX: 0000000000000000 RSI: ffffffff8684c5ff RDI: 0000000000000004
RBP: ffff88807cda4000 R08: 0000000000000000 R09: ffff888023fb8027
R10: ffffffff8684c5d7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888041024280 R15: ffff888031ade780
FS:  00007eff9dddd700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ef24000 CR3: 0000000036902000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7effa0867ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff9dddd188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007effa097af60 RCX: 00007effa0867ae9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007effa08c1f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc008a753f R14: 00007eff9dddd300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace bacb470dc6c820de ]---
RIP: 0010:nla_get_u32 include/net/netlink.h:1554 [inline]
RIP: 0010:nldev_stat_set_mode_doit drivers/infiniband/core/nldev.c:1909 [inline]
RIP: 0010:nldev_stat_set_doit+0x578/0x10d0 drivers/infiniband/core/nldev.c:2040
Code: fa 4c 8b a4 24 f8 02 00 00 48 b8 00 00 00 00 00 fc ff df c7 84 24 80 00 00 00 00 00 00 00 49 8d 7c 24 04 48 89
fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 02
RSP: 0018:ffffc90004acf2e8 EFLAGS: 00010247
RIP: 0010:nldev_stat_set_mode_doit drivers/infiniband/core/nldev.c:1909 [inline]
RIP: 0010:nldev_stat_set_doit+0x578/0x10d0 drivers/infiniband/core/nldev.c:2040
Code: fa 4c 8b a4 24 f8 02 00 00 48 b8 00 00 00 00 00 fc ff df c7 84 24 80 00 00 00 00 00 00 00 49 8d 7c 24 04 48 89
fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 02
RSP: 0018:ffffc90004acf2e8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90002b94000
RDX: 0000000000000000 RSI: ffffffff8684c5ff RDI: 0000000000000004
RBP: ffff88807cda4000 R08: 0000000000000000 R09: ffff888023fb8027
R10: ffffffff8684c5d7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888041024280 R15: ffff888031ade780
FS:  00007eff9dddd700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ef24000 CR3: 0000000036902000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 822cf785ac6d ("RDMA/nldev: Split nldev_stat_set_mode_doit out of nldev_stat_set_doit")
Reported-by: syzbot+9111d2255a9710e87562@syzkaller.appspotmail.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index fedc0fa6ebf9..f5aacaf7fb8e 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1906,7 +1906,8 @@ static int nldev_stat_set_mode_doit(struct sk_buff *msg,
 	int ret;
 
 	/* Currently only counter for QP is supported */
-	if (nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_RES]) != RDMA_NLDEV_ATTR_RES_QP)
+	if (!tb[RDMA_NLDEV_ATTR_STAT_RES] ||
+	    nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_RES]) != RDMA_NLDEV_ATTR_RES_QP)
 		return -EINVAL;
 
 	mode = nla_get_u32(tb[RDMA_NLDEV_ATTR_STAT_MODE]);
-- 
2.33.1

