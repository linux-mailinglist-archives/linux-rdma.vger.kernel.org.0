Return-Path: <linux-rdma+bounces-14778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC5EC87DE7
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 03:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D44E33CB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338CD29B8D3;
	Wed, 26 Nov 2025 02:52:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849323ABBD
	for <linux-rdma@vger.kernel.org>; Wed, 26 Nov 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125547; cv=none; b=tulCSOAsILTIuN4miVb+Mf0aA8EKLI5c56lzPlfoadopODhHvO0rDVxnkJuP8mv42hBsZnrGLe4FxlBuD2xEfaMLzFbERJh5CebRL5dyfegIAusgulwECMhVCiQHjx5d8N54yzziWhhols/i9Cx7gTo2HYnHithMjbLSi0moeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125547; c=relaxed/simple;
	bh=r8Q6jUMwpTLhYlsKQEcJPaJNckBoJQVf7uRZiVjoB5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aekz3VkUggodBr3Gx8R6ui7lmlwMsCCyUOudWudbFVcujf1hYpScA9wDUVCvwZHhcIULbgsyldFzZTm+yczZfUFEZDntcH0+FcQrHoFnTYP1xtpuavpJdBAYJtfnhafFp0VhgQu28fqldD/fZxvDZ8ENczqxOka4SGC2J0QHRHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<huangjunxian6@hisilicon.com>, <linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] RDMA/core: Reduce cond_resched() frequency in __ib_umem_release
Date: Wed, 26 Nov 2025 10:51:47 +0800
Message-ID: <20251126025147.2627-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The current implementation calls cond_resched() for every SG entry
in __ib_umem_release(), which can increase needless overhead.

This patch introduces RESCHED_LOOP_CNT_THRESHOLD (0x1000) to limit
how often cond_resched() is called. The function now yields the CPU
once every 4096 iterations, and yield at the very first iteration
for lots of small umem case, to reduce scheduling overhead.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/infiniband/core/umem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 8fd84aa..ff540a2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -45,6 +45,8 @@
 
 #include "uverbs.h"
 
+#define RESCHED_LOOP_CNT_THRESHOLD 0x1000
+
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
 	bool make_dirty = umem->writable && dirty;
@@ -58,7 +60,9 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 	for_each_sgtable_sg(&umem->sgt_append.sgt, sg, i) {
 		unpin_user_page_range_dirty_lock(sg_page(sg),
 			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
-		cond_resched();
+
+		if (!(i % RESCHED_LOOP_CNT_THRESHOLD))
+			cond_resched();
 	}
 
 	sg_free_append_table(&umem->sgt_append);
-- 
2.9.4


