Return-Path: <linux-rdma+bounces-1850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF7F89C6E5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E27F1C238E0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B88614C;
	Mon,  8 Apr 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cnuqG0At"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB258593C
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586123; cv=none; b=SQKMifpsOCkZPI1F6Jgw26tDwCEZiNL7bWu9Hjm0ANKMFaNu2seSzKxTLN86z0orQdvq1tDaQKBFUpgb9NZp9cqUMVAs441o3FdTciV4dcwuZ5SnaM71EivSugNpG4WibISP79+BZ0+/ITfRc7HmObycj8VSJiuQEU4HZOpI5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586123; c=relaxed/simple;
	bh=qGLzk7xrgZn9WNl1Os+kzc39p4xmGmYE/5Y09GllzVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvQdxwFigNdJYGvJXkLI/2TfIeHhRWzlAZcGq1DDDrVRRabrEUXPBdX96ItijQ1FEcorNkJPLiYW+yhviZEzNqIIeW9UumnCi06aafNrAU6oYQm857NC2Tq1JqO9tVLngZi26BLJ06FvZC8qkLyXhjpTN/8zCTwUUB4tagI/TCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cnuqG0At; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712586118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YBg0KUG7xtW8FBkZMuPW1t6HD5SHDmrOUwLXP4AQ0e8=;
	b=cnuqG0At721TvFPpjkzA7XjnneQz2MtKiW5tOe69bmvyDaCrPmxLFC1pMrXRvidDrnI6gV
	LEFcLrrrwD3KNCkrtPlDzhoEZjhn9FTO30fZqfm5ynUwKDyPeH1LWLXRVcF7z4mSQfKtKc
	EZJlUw6S6cIO20bXz5yDsN4LCdiMrQU=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Return the correct errno
Date: Mon,  8 Apr 2024 16:21:42 +0200
Message-Id: <20240408142142.792413-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the function __rxe_add_to_pool, the function xa_alloc_cyclic is
called. The return value of the function xa_alloc_cyclic is as below:
"
 Return: 0 if the allocation succeeded without wrapping.  1 if the
 allocation succeeded after wrapping, -ENOMEM if memory could not be
 allocated or -EBUSY if there are no free entries in @limit.
"
But now the function __rxe_add_to_pool only returns -EINVAL. All the
returned error value should be returned to the caller.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6215c6de3a84..43ba0277bd7b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -122,8 +122,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 	int err;
 	gfp_t gfp_flags;
 
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem) {
+		err = -EINVAL;
 		goto err_cnt;
+	}
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
@@ -147,7 +149,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 
 err_cnt:
 	atomic_dec(&pool->num_elem);
-	return -EINVAL;
+	return err;
 }
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
-- 
2.34.1


