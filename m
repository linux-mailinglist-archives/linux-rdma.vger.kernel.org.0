Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB9D492066
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 08:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbiARHf3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 02:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245361AbiARHf0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 02:35:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCBC06173E;
        Mon, 17 Jan 2022 23:35:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C49E8CE180A;
        Tue, 18 Jan 2022 07:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25922C00446;
        Tue, 18 Jan 2022 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491323;
        bh=efdlDNR9gQzR/4u6XD/07+ZdHx953OfVA+epBG2sCLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYz7PA0/TS62UBsSOSpe1FmNrmnS+lMrFEYp1CxnJ80MFUtmdWoUM4BwLDQDYvlRX
         jyeJA0e8dAoq1C0V9i4Qu9uiX60evIA/o3r6I8+aU9NjsbB0qqD0GmJ7N0Lf/l9kwY
         0uLPaE47WVdAET0E6IRlag18VwHAELnYqUGK3IiqeN9bpbPzb6qN8/9lFDYopV5lUN
         +TPb4cqBNkV9ZSrt0/n2rYx/IGKYWkarGhRZ4HvFnrWCBQ9b47+uKlcewltQrM610f
         IK0utYFkr4iiMFsJuJip/7qUVPPS0oYkti7THEQkfbyJQIUzxBbIphHuVdqkhXeGUF
         SoPwtVrycNs+w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com
Subject: [PATCH rdma-next 2/3] RDMA/ucma: Protect mc during concurrent multicast leaves
Date:   Tue, 18 Jan 2022 09:35:01 +0200
Message-Id: <1cda5fabb1081e8d16e39a48d3a4f8160cea88b8.1642491047.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642491047.git.leonro@nvidia.com>
References: <cover.1642491047.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Partially revert the commit mentioned in the Fixes line to make sure
that allocation and erasing multicast struct are locked.

==================================================================
BUG: KASAN: use-after-free in ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
BUG: KASAN: use-after-free in ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
Read of size 8 at addr ffff88801bb74b00 by task syz-executor.1/25529

CPU: 0 PID: 25529 Comm: syz-executor.1 Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
 ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
 ucma_destroy_id+0x1e6/0x280 drivers/infiniband/core/ucma.c:614
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2fcd207e99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2fcbb7d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2fcd31af60 RCX: 00007f2fcd207e99
RDX: 0000000000000018 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007f2fcd261ff1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff66a135bf R14: 00007f2fcbb7d300 R15: 0000000000022000
 </TASK>

Fixes: 95fe51096b7a ("RDMA/ucma: Remove mc_list and rely on xarray")
Reported-by: syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/ucma.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 2b72c4fa9550..9d6ac9dff39a 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -95,6 +95,7 @@ struct ucma_context {
 	u64			uid;
 
 	struct list_head	list;
+	struct list_head	mc_list;
 	struct work_struct	close_work;
 };
 
@@ -105,6 +106,7 @@ struct ucma_multicast {
 
 	u64			uid;
 	u8			join_state;
+	struct list_head	list;
 	struct sockaddr_storage	addr;
 };
 
@@ -198,6 +200,7 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
 
 	INIT_WORK(&ctx->close_work, ucma_close_id);
 	init_completion(&ctx->comp);
+	INIT_LIST_HEAD(&ctx->mc_list);
 	/* So list_del() will work if we don't do ucma_finish_ctx() */
 	INIT_LIST_HEAD(&ctx->list);
 	ctx->file = file;
@@ -484,19 +487,19 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 
 static void ucma_cleanup_multicast(struct ucma_context *ctx)
 {
-	struct ucma_multicast *mc;
-	unsigned long index;
+	struct ucma_multicast *mc, *tmp;
 
-	xa_for_each(&multicast_table, index, mc) {
-		if (mc->ctx != ctx)
-			continue;
+	xa_lock(&multicast_table);
+	list_for_each_entry_safe(mc, tmp, &ctx->mc_list, list) {
+		list_del(&mc->list);
 		/*
 		 * At this point mc->ctx->ref is 0 so the mc cannot leave the
 		 * lock on the reader and this is enough serialization
 		 */
-		xa_erase(&multicast_table, index);
+		__xa_erase(&multicast_table, mc->id);
 		kfree(mc);
 	}
+	xa_unlock(&multicast_table);
 }
 
 static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
@@ -1469,12 +1472,16 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mc->uid = cmd->uid;
 	memcpy(&mc->addr, addr, cmd->addr_size);
 
-	if (xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
+	xa_lock(&multicast_table);
+	if (__xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
 		     GFP_KERNEL)) {
 		ret = -ENOMEM;
 		goto err_free_mc;
 	}
 
+	list_add_tail(&mc->list, &ctx->mc_list);
+	xa_unlock(&multicast_table);
+
 	mutex_lock(&ctx->mutex);
 	ret = rdma_join_multicast(ctx->cm_id, (struct sockaddr *)&mc->addr,
 				  join_state, mc);
@@ -1500,8 +1507,11 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mutex_unlock(&ctx->mutex);
 	ucma_cleanup_mc_events(mc);
 err_xa_erase:
-	xa_erase(&multicast_table, mc->id);
+	xa_lock(&multicast_table);
+	list_del(&mc->list);
+	__xa_erase(&multicast_table, mc->id);
 err_free_mc:
+	xa_unlock(&multicast_table);
 	kfree(mc);
 err_put_ctx:
 	ucma_put_ctx(ctx);
@@ -1569,15 +1579,17 @@ static ssize_t ucma_leave_multicast(struct ucma_file *file,
 		mc = ERR_PTR(-EINVAL);
 	else if (!refcount_inc_not_zero(&mc->ctx->ref))
 		mc = ERR_PTR(-ENXIO);
-	else
-		__xa_erase(&multicast_table, mc->id);
-	xa_unlock(&multicast_table);
 
 	if (IS_ERR(mc)) {
+		xa_unlock(&multicast_table);
 		ret = PTR_ERR(mc);
 		goto out;
 	}
 
+	list_del(&mc->list);
+	__xa_erase(&multicast_table, mc->id);
+	xa_unlock(&multicast_table);
+
 	mutex_lock(&mc->ctx->mutex);
 	rdma_leave_multicast(mc->ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&mc->ctx->mutex);
-- 
2.34.1

