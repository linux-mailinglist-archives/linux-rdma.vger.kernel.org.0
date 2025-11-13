Return-Path: <linux-rdma+bounces-14458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91AC56C5A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 11:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED8414E3B2E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786022DFA32;
	Thu, 13 Nov 2025 10:08:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614B29BDB0
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028531; cv=none; b=W0Z8rYRqGLt+d6FdBC290Fy8k9nHv0OBOhRgimfbzhIOAZzrRWLnIg5x4Vb0WZlMvbUb/cNvZ5RBRvXaUw5azrjb2b/rNXOp2lDInNSxoFIyYoDGrY8IqDnQSadpkomKbiX5zRODOqA7a0SpI5SnmbjK0okTtKeeCInn+QCGo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028531; c=relaxed/simple;
	bh=yJJ7q8UpGgg4dF6SkduOZFBuaS8tRM53eL2pwsc+igE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3EqeS/TvG7UfQoEbJJIZD896InrRK892WM7eS8MEY+cGl9Yt0XuHPYGUenwvRyAxhOYhGPN6gp8HAhm20FIhvIshpKajkEkmi8uu+0k3nSpW06sE9dvvkV5mNnTmUJ4LuXVlM3LTX1/knwx8Qr/qdoXg4XxQYiaMsCvSwoBO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<huangjunxian6@hisilicon.com>, <linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] RDMA/core: Prevent soft lockup during large user memory region cleanup
Date: Thu, 13 Nov 2025 17:53:17 +0800
Message-ID: <20251113095317.2628-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc14.internal.baidu.com (172.31.51.14) To
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

Fix soft lockup issues by incorporating cond_resched() calls within
__ib_umem_release(), and this SG entries are typically grouped in 2MB
chunks on x86_64, adding cond_resched() should has minimal performance
impact.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff v1: move the cond_sched into loop, add the calling trace to change log

 drivers/infiniband/core/umem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c5b6863..8fd84aa 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -55,9 +55,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 		ib_dma_unmap_sgtable_attrs(dev, &umem->sgt_append.sgt,
 					   DMA_BIDIRECTIONAL, 0);
 
-	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i)
+	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
 		unpin_user_page_range_dirty_lock(sg_page(sg),
 			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
+		cond_resched();
+	}
 
 	sg_free_append_table(&umem->sgt_append);
 }
-- 
2.9.4


