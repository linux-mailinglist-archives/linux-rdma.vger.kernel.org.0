Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0868149C06
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 18:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgAZRPH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 12:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZRPH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 12:15:07 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34930206F0;
        Sun, 26 Jan 2020 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580058906;
        bh=B9qqiGn+C4p9+d56messj6R6+u8sRu9tXoN3x2/zSgc=;
        h=From:To:Cc:Subject:Date:From;
        b=BR+5fbc4vHDtgd+x+gFeGZ7nk5Jv3dneHcTDnmt+S8nGBzfUG/kJLRkmqi9DdDLJR
         WHFJg0y3HADseuG7/eUnUofCL5etPrzuRyF75ajR4xrmM/cCSLEb0u9yekVnrdBBeq
         RRmrIP3tzC1F2kt3ytzv/NZ2mop86LeIs+Kj0qiw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Avihai Horon <avihaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Moses Reuben <mosesr@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/core: Fix invalid memory access in spec_filter_size
Date:   Sun, 26 Jan 2020 19:15:00 +0200
Message-Id: <20200126171500.4623-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@mellanox.com>

Add a check that the size specified in the flow spec header doesn't
cause an overflow when calculating the filter size, and thus prevent
access to invalid memory.
The following crash from syzkaller revealed it.

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 17834 Comm: syz-executor.3 Not tainted 5.5.0-rc5 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
RIP: 0010:memchr_inv+0xd3/0x330
Code: 89 f9 89 f5 83 e1 07 0f 85 f9 00 00 00 49 89 d5 49 c1 ed 03 45 85
ed 74 6f 48 89 d9 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 01
00 0f 85 0d 02 00 00 44 0f b6 e5 48 b8 01 01 01 01 01 01
RSP: 0018:ffffc9000a13fa50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 7fff88810de9d820 RCX: 0ffff11021bd3b04
RDX: 000000000000fff8 RSI: 0000000000000000 RDI: 7fff88810de9d820
RBP: 0000000000000000 R08: ffff888110d69018 R09: 0000000000000009
R10: 0000000000000001 R11: ffffed10236267cc R12: 0000000000000004
R13: 0000000000001fff R14: ffff88810de9d820 R15: 0000000000000040
FS:  00007f9ee0e51700(0000) GS:ffff88811b100000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000115ea0006 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 spec_filter_size.part.16+0x34/0x50
 ib_uverbs_kern_spec_to_ib_spec_filter+0x691/0x770
 ib_uverbs_ex_create_flow+0x9ea/0x1b40
 ib_uverbs_write+0xaa5/0xdf0
 __vfs_write+0x7c/0x100
 vfs_write+0x168/0x4a0
 ksys_write+0xc8/0x200
 do_syscall_64+0x9c/0x390
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b49
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9ee0e50c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000465b49
RDX: 00000000000003a0 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9ee0e516bc
R13: 00000000004ca2da R14: 000000000070deb8 R15: 00000000ffffffff
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace c4a9f951e7561ab4 ]---

Fixes: 94e03f11ad1f ("IB/uverbs: Add support for flow tag")
Signed-off-by: Avihai Horon <avihaih@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c8693f5231dd..025933752e1d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2745,12 +2745,6 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 	return 0;
 }
 
-static size_t kern_spec_filter_sz(const struct ib_uverbs_flow_spec_hdr *spec)
-{
-	/* Returns user space filter size, includes padding */
-	return (spec->size - sizeof(struct ib_uverbs_flow_spec_hdr)) / 2;
-}
-
 static ssize_t spec_filter_size(const void *kern_spec_filter, u16 kern_filter_size,
 				u16 ib_real_filter_sz)
 {
@@ -2894,11 +2888,16 @@ int ib_uverbs_kern_spec_to_ib_spec_filter(enum ib_flow_spec_type type,
 static int kern_spec_to_ib_spec_filter(struct ib_uverbs_flow_spec *kern_spec,
 				       union ib_flow_spec *ib_spec)
 {
-	ssize_t kern_filter_sz;
+	size_t kern_filter_sz;
 	void *kern_spec_mask;
 	void *kern_spec_val;
 
-	kern_filter_sz = kern_spec_filter_sz(&kern_spec->hdr);
+	if (check_sub_overflow((size_t)kern_spec->hdr.size,
+			       sizeof(struct ib_uverbs_flow_spec_hdr),
+			       &kern_filter_sz))
+		return -EINVAL;
+
+	kern_filter_sz /= 2;
 
 	kern_spec_val = (void *)kern_spec +
 		sizeof(struct ib_uverbs_flow_spec_hdr);
-- 
2.24.1

