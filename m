Return-Path: <linux-rdma+bounces-9387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1ABA86BB1
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 09:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767C69A0672
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0713918BC1D;
	Sat, 12 Apr 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDLxOlG6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F4155330
	for <linux-rdma@vger.kernel.org>; Sat, 12 Apr 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744444651; cv=none; b=ug3rLSfBtH59+H17TEwrWifA4S7BnGfFgTgSOplQys/Da/paSYRICmh6ft6o08SYBJldoOkNOZ9pwUrcf82VH/et+sLgD9Rt9oYPBfs35fF2kBQ1RzCoEcisu9D18hYPGCsxQETsBvO8RW0gtXvN4JnHX/E1WfLFrKP+KJGdM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744444651; c=relaxed/simple;
	bh=nQcUS4h9lbtbOz7m22c/gKv9EUlOYa3sUCQ1VGbLa7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFt+8G1rZwxz3ITJwspereOEjsgZUtn0LtEwpQ25Q/4tUtRW/z9bnPJSRjNATaPaL/fD9VVgUsJDU4c0e/uoqWipNC56vL5dFr7HJj+oBI18zUxn9AWOwQDsBn395e5HaM87W7D1jKZAp0Z4L1j6RWpBevYeEezJ/4Gi1yNuFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDLxOlG6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744444646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O3bAlFNjBVx3cL0kbmfw0XYYFUQ6mtDKs1ZdaNV62AU=;
	b=sDLxOlG6faRvWzKnNd3ZAHceTIa02lyGevxmnR71Tw/7akxSDspRxsAjSIwEy85RoObMRw
	3Ro0bRKvN19DLWuUwGkAzTEm8CLki5M3AurGRUp00zhqS0K1vUnpF6URMjN/b56je4Kysv
	TLNyzLOBYQpv7Yaeqbhe/XZGb405QR8=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	liuyi <liuy22@mails.tsinghua.edu.cn>
Subject: [PATCH 1/1] RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug
Date: Sat, 12 Apr 2025 09:57:14 +0200
Message-Id: <20250412075714.3257358-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7d/0xa0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcf/0x610 mm/kasan/report.c:489
 kasan_report+0xb5/0xe0 mm/kasan/report.c:602
 rxe_queue_cleanup+0xd0/0xe0 drivers/infiniband/sw/rxe/rxe_queue.c:195
 rxe_cq_cleanup+0x3f/0x50 drivers/infiniband/sw/rxe/rxe_cq.c:132
 __rxe_cleanup+0x168/0x300 drivers/infiniband/sw/rxe/rxe_pool.c:232
 rxe_create_cq+0x22e/0x3a0 drivers/infiniband/sw/rxe/rxe_verbs.c:1109
 create_cq+0x658/0xb90 drivers/infiniband/core/uverbs_cmd.c:1052
 ib_uverbs_create_cq+0xc7/0x120 drivers/infiniband/core/uverbs_cmd.c:1095
 ib_uverbs_write+0x969/0xc90 drivers/infiniband/core/uverbs_main.c:679
 vfs_write fs/read_write.c:677 [inline]
 vfs_write+0x26a/0xcc0 fs/read_write.c:659
 ksys_write+0x1b8/0x200 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

In the function rxe_create_cq, when rxe_cq_from_init fails, the function
rxe_cleanup will be called to handle the allocated resources. In fact,
some memory resources have already been freed in the function
rxe_cq_from_init. Thus, this problem will occur.

The solution is to let rxe_cleanup do all the work.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://paste.ubuntu.com/p/tJgC42wDf6/
Tested-by: liuyi <liuy22@mails.tsinghua.edu.cn>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fec87c9030ab..fffd144d509e 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -56,11 +56,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata,
 			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
-	if (err) {
-		vfree(cq->queue->buf);
-		kfree(cq->queue);
+	if (err)
 		return err;
-	}
 
 	cq->is_user = uresp;
 
-- 
2.34.1


