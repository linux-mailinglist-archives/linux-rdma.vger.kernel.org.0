Return-Path: <linux-rdma+bounces-857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99E845851
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6827E28A7BD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701786654;
	Thu,  1 Feb 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oWXNMOz2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB178663B
	for <linux-rdma@vger.kernel.org>; Thu,  1 Feb 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792302; cv=none; b=NLb1eX+f76ulvDvgWFrP5vBxsM3m/Zt+5Jvtk7Md2ivx6AzMbP/YPkPyYEfUyCfX0eVubZDch10KtT4ZWGmDq2gyAK8dH11zWgSoYnK2NuBi9ua2wzh8gxRPBFw/zjVSe7F/l8b29ZXEVDRFRNKB1B5tfZ3EYSosktINm3Tj10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792302; c=relaxed/simple;
	bh=D/bE457eiMjYS1TLCkDBtW9flCtWKdg8KZ9hEJVRUWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ftMr/PlvuzKQm1up4mCnrUS6EaZSfM8jQawPTiwGUOZCqWonCdltxIqCg0DFom1heu/9zuXZ06SCiaf9DgIXKks79DqHhNjRL8dJIfVMl9Z4ccCEvM2NNg6rTDS/hTdkOr9RA3YY2sgBSzWYOYuWBJSuLRK3JSr0F9jrWVRiM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oWXNMOz2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706792293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WqK5bmrC6v9q8f+Fv5b3h0sxLLVsfhSzo0+czAyzafg=;
	b=oWXNMOz27y/N8Mb540vwytCT5gRlT+UQ4PWiv0+W3tArqC67TnWN79fKFOTfc9La8TU48X
	gwe+JfIuKp36JNf5JtvSFv47JPecZq0UpXN9FJ2zz8K8dagp0l2gPdj/KK+Mphope6JjsZ
	bkOh+c3HCEluOiBzi8XNCW52jcf8+VA=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user
Date: Thu,  1 Feb 2024 20:57:45 +0800
Message-Id: <20240201125745.21525-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
Use members of generic struct in rxe_mr").

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4d2a8ef52c85..746110898a0e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -59,7 +59,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
-int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
+int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bc81fde696ee..da3dee520876 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -126,7 +126,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
 	return xas_error(&xas);
 }
 
-int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
+int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		     int access, struct rxe_mr *mr)
 {
 	struct ib_umem *umem;
-- 
2.35.3


