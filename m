Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D541B5481
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 08:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWGB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 02:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWGB3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 02:01:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937A020781;
        Thu, 23 Apr 2020 06:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587621688;
        bh=zbCWJtPJBVp7+wDG+pleFo1rhFgylWqKIqQSQKk8urQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PX28jdVHBzd6d6ecgiGdraCScAzDfJCG6orSJqgwhNdNFNhwzECJlkgWXFe+Y3S87
         b/dKD4btjvvuIdxb+Qf7o6snpF8UbMFg8/QSOVeXgAyDyopJfWKgr2qqUWKsWZsFXD
         L4tPAH+7F3p8t83ysmNwIoNYExo885YSH6MbAHZg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/core: Fix race between destroy and release FD object
Date:   Thu, 23 Apr 2020 09:01:22 +0300
Message-Id: <20200423060122.6182-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The call to ->lookup_put() was too early and it caused decrease of kref
on FD object and call to FD release function, while the object is still
locked for the write. This caused to the following WARN_ON() to be printed.

[  268.688470] ------------[ cut here ]------------
[  268.689460] WARNING: CPU: 4 PID: 6913 at drivers/infiniband/core/rdma_core.c:768 uverbs_uobject_fd_release+0x202/0x230
[  268.691322] Kernel panic - not syncing: panic_on_warn set ...
[  268.692273] CPU: 4 PID: 6913 Comm: syz-executor.3 Not tainted 5.7.0-rc2 #22
[  268.693456] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[  268.695688] Call Trace:
[  268.696135]  dump_stack+0x94/0xce
[  268.696784]  panic+0x234/0x56f
[  268.697384]  ? __warn+0x1e1/0x1e1
[  268.697942]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[  268.698782]  ? printk+0xb2/0xdd
[  268.699301]  ? __warn+0x1b1/0x1e1
[  268.699946]  ? uverbs_uobject_fd_release+0x202/0x230
[  268.700829]  __warn+0x1cc/0x1e1
[  268.701402]  ? uverbs_uobject_fd_release+0x202/0x230
[  268.702227]  report_bug+0x200/0x310
[  268.702807]  ? uverbs_uobject_fd_release+0x202/0x230
[  268.703618]  fixup_bug.part.11+0x32/0x80
[  268.704260]  do_error_trap+0xd3/0x100
[  268.704898]  do_invalid_op+0x31/0x40
[  268.705581]  ? uverbs_uobject_fd_release+0x202/0x230
[  268.706479]  invalid_op+0x1e/0x30
[  268.707035] RIP: 0010:uverbs_uobject_fd_release+0x202/0x230
[  268.708046] Code: fe 4c 89 e7 e8 af 23 fe ff e9 2a ff ff ff e8 c5 fa 61 fe be 03 00 00 00 4c 89 e7 e8 68 eb f5 fe e9 13 ff ff ff e8 ae fa 61 fe <0f> 0b eb ac e8 e5 aa 3c fe e8 50 2b 86 fe e9 6a fe ff ff e8 46 2b
[  268.711365] RSP: 0018:ffffc90008117d88 EFLAGS: 00010293
[  268.712218] RAX: ffff88810e146580 RBX: 1ffff92001022fb1 RCX: ffffffff82d5b902
[  268.713439] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88811951b040
[  268.714606] RBP: ffff88811951b000 R08: ffffed10232a3609 R09: ffffed10232a3609
[  268.715805] R10: ffff88811951b043 R11: 0000000000000001 R12: ffff888100a7c600
[  268.717119] R13: ffff888100a7c650 R14: ffffc90008117da8 R15: ffffffff82d5b700
[  268.718401]  ? __uverbs_cleanup_ufile+0x270/0x270
[  268.719181]  ? uverbs_uobject_fd_release+0x202/0x230
[  268.720140]  ? uverbs_uobject_fd_release+0x202/0x230
[  268.720967]  ? __uverbs_cleanup_ufile+0x270/0x270
[  268.721758]  ? locks_remove_file+0x282/0x3d0
[  268.722529]  ? security_file_free+0xaa/0xd0
[  268.723224]  __fput+0x2be/0x770
[  268.723743]  task_work_run+0x10e/0x1b0
[  268.724428]  exit_to_usermode_loop+0x145/0x170
[  268.725172]  do_syscall_64+0x2d0/0x390
[  268.725786]  ? prepare_exit_to_usermode+0x17a/0x230
[  268.726580]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  268.727413] RIP: 0033:0x414da7
[  268.728029] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f f3 c3 0f 1f 44 00 00 53 89 fb 48 83 ec 10 e8 f4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 36 fc ff ff 8b 44 24
[  268.731055] RSP: 002b:00007fff39d379d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[  268.732322] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000414da7
[  268.733587] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
[  268.734818] RBP: 00007fff39d37a3c R08: 0000000400000000 R09: 0000000400000000
[  268.736472] R10: 00007fff39d37910 R11: 0000000000000293 R12: 0000000000000001
[  268.737754] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
[  268.738983] Dumping ftrace buffer:
[  268.739601]    (ftrace buffer empty)
[  268.740181] Kernel Offset: disabled
[  268.740770] Rebooting in 1 seconds..

Fix the code by changing the order, first unlock and call
to ->lookup_put() after that.

Fixes: 3832125624b7 ("IB/core: Add support for idr types")
Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 2947f4f83561..177333d8bcda 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -678,7 +678,6 @@ void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 			     enum rdma_lookup_mode mode)
 {
 	assert_uverbs_usecnt(uobj, mode);
-	uobj->uapi_object->type_class->lookup_put(uobj, mode);
 	/*
 	 * In order to unlock an object, either decrease its usecnt for
 	 * read access or zero it in case of exclusive access. See
@@ -695,6 +694,7 @@ void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 		break;
 	}

+	uobj->uapi_object->type_class->lookup_put(uobj, mode);
 	/* Pairs with the kref obtained by type->lookup_get */
 	uverbs_uobject_put(uobj);
 }
--
2.25.3

