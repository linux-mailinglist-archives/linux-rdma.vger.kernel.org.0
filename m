Return-Path: <linux-rdma+bounces-14714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5374C7EF9F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 06:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F35434606A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131732BE64C;
	Mon, 24 Nov 2025 05:07:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937D29D29A
	for <linux-rdma@vger.kernel.org>; Mon, 24 Nov 2025 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763960819; cv=none; b=icFLKTn8Sxy/i/7sqizEfxi/cJKdLymPEK4lklfn9a1MekzeRZP6yCMNELXu8TBKNk5MLWQwWzhdnF0UQKD7sL3kR8i7jDFIudBZD/TxerGU3k37RSi2OtZAUwGpP1uGkZv6EeGQdXxaqyLraisUJdUBgGRqQ5c2fTUEN007C8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763960819; c=relaxed/simple;
	bh=RQrlcU22HSYIb3eJyYSCj5kegrI9IQoVqL4sPwlI/BA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ShBHjy7AL8s43+Cpn7zb9r1jLzwCtwB+hW6dwP+FnYaRGmjneXgnP/A3vCVQdeD9ax0UzhGS9xMQ8B2Quw+Mwy8TMjfOAQQ/PW6kvfgvNEq2Y/T3+a6UzHic7EymDgLdOLm/Kajg7BaKkqJ5CFk0hI1GdoIjZ3qgsGNYuc7ai5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<huangjunxian6@hisilicon.com>, <linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v3] RDMA/core: Prevent soft lockup during large user memory region cleanup
Date: Mon, 24 Nov 2025 13:06:21 +0800
Message-ID: <20251124050621.2622-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc8.internal.baidu.com (172.31.3.18) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

When a process exits with numerous large, pinned memory regions consisting
of 4KB pages, the cleanup of the memory region through __ib_umem_release()
may cause soft lockups. This is because unpin_user_page_range_dirty_lock()
is called in a tight loop for unpin and releasing page without yielding the
CPU.

 watchdog: BUG: soft lockup - CPU#44 stuck for 26s! [python3:73464]
 Kernel panic - not syncing: softlockup: hung tasks
 CPU: 44 PID: 73464 Comm: python3 Tainted: G           OEL

 asm_sysvec_apic_timer_interrupt+0x1b/0x20
 RIP: 0010:free_unref_page+0xff/0x190

  ? free_unref_page+0xe3/0x190
  __put_page+0x77/0xe0
  put_compound_head+0xed/0x100
  unpin_user_page_range_dirty_lock+0xb2/0x180
  __ib_umem_release+0x57/0xb0 [ib_core]
  ib_umem_release+0x3f/0xd0 [ib_core]
  mlx5_ib_dereg_mr+0x2e9/0x440 [mlx5_ib]
  ib_dereg_mr_user+0x43/0xb0 [ib_core]
  uverbs_free_mr+0x15/0x20 [ib_uverbs]
  destroy_hw_idr_uobject+0x21/0x60 [ib_uverbs]
  uverbs_destroy_uobject+0x38/0x1b0 [ib_uverbs]
  __uverbs_cleanup_ufile+0xd1/0x150 [ib_uverbs]
  uverbs_destroy_ufile_hw+0x3f/0x100 [ib_uverbs]
  ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
  __fput+0x9c/0x280
  ____fput+0xe/0x20
  task_work_run+0x6a/0xb0
  do_exit+0x217/0x3c0
  do_group_exit+0x3b/0xb0
  get_signal+0x150/0x900
  arch_do_signal_or_restart+0xde/0x100
  exit_to_user_mode_loop+0xc4/0x160
  exit_to_user_mode_prepare+0xa0/0xb0
  syscall_exit_to_user_mode+0x27/0x50
  do_syscall_64+0x63/0xb0

Fix the soft lockup by adding cond_resched() calls in __ib_umem_release, To
minimize performance impact on releasing memory regions, introduce a
RESCHED_THRESHOLD_ON_PAGE, call cond_resched() per it, and cond_resched()
to be called during the very first iteration.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff v2: limit calling cond_resched per 4k

 drivers/infiniband/core/umem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c5b6863..ff540a2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -45,6 +45,8 @@
 
 #include "uverbs.h"
 
+#define RESCHED_LOOP_CNT_THRESHOLD 0x1000
+
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
 	bool make_dirty = umem->writable && dirty;
@@ -55,10 +57,14 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
 					   DMA_BIDIRECTIONAL, 0);
 
-	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
+	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
 		unpin_user_page_range_dirty_lock(sg_page(sg),
 			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
+		if (!(i % RESCHED_LOOP_CNT_THRESHOLD))
+			cond_resched();
+	}
+
 	sg_free_append_table(&umem->sgt_append);
 }
 
-- 
2.9.4


